//
//  MemoListViewController.swift
//  SkillupPractice13
//
//  Created by k_motoyama on 2017/05/26.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import UIKit
import STV_Extensions

class MemoListViewController: UIViewController {
    
    @IBOutlet weak var memoTable: UITableView!
    @IBOutlet weak var memoCountLabel: UIBarButtonItem!
    @IBOutlet weak var addMemoButton: UIBarButtonItem!
    
    let memoList = MemoList()
    var memoData: [MemoModel] = []
    
    static func createInstance() -> MemoListViewController {
        
        let vc = UIStoryboard.viewController(storyboardName: "MemoList",
                                             identifier: self.className)
        
        return vc as! MemoListViewController
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTable.dataSource = memoList
        memoTable.delegate = self
        
        self.navigationItem.title = "メモ"
        self.navigationItem.rightBarButtonItem = editButtonItem
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        memoData = MemoDao.findAll().sorted(by: { $0.updateDate > $1.updateDate })
        
        memoList.add(dataList: memoData)
        memoList.addMemoCountLabel(memoCountLabel: memoCountLabel)
        memoList.setMemoCountLabel(dataCount: memoData.count)
        
        memoTable.reloadData()
        
    }
    

    @IBAction func pushAddMemo(_ sender: UIBarButtonItem) {
        
        if !memoTable.isEditing {
            pushMemoVC()
            return
            
        }
        
        let alert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet)
        
        
        alert.addAction(UIAlertAction(title: "すべて削除",
                                      style: .destructive,
                                      handler: { action in
            MemoDao.deleteAll()
            self.memoList.add(dataList: [])
            self.memoList.setMemoCountLabel(dataCount: 0)
            self.memoTable.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "キャンセル",
                                      style: .cancel))
        
        self.present(alert, animated: true,
                     completion: nil)
        
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        addMemoButton.title =  editing ? "すべて削除" : "メモ追加"
        memoTable.setEditing(editing, animated: animated)
        
    }
    
    fileprivate func pushMemoVC(id: Int? = nil) {
        let memo =  MemoViewController.createInstance(id: id)
        
        self.navigationController?.pushViewController(memo, animated: true)
        
    }

}

extension MemoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectId = memoData[indexPath.row].id
        pushMemoVC(id: selectId)
        
    }
    
    
}

