//
//  MemoViewController.swift
//  SkillupPractice13
//
//  Created by k_motoyama on 2017/05/27.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import UIKit
import STV_Extensions

class MemoViewController: UIViewController {
    
    @IBOutlet weak var memoText: UITextView!
    
    let separateWord = "\n"
    var selectId = 0
    
    static func createInstance(id: Int?) -> MemoViewController {
        
        let vc = UIStoryboard.viewController(storyboardName: "Memo",
                                               identifier: self.className) as! MemoViewController
        
        // nilなら初期値0
        vc.selectId = id ?? 0
        
        return vc
        
    }
    
    override func viewDidLoad() {
        
        if selectId != 0 {
            let memoData = MemoDao.findByID(id: selectId)
            let dispMemo = memoData!.title + separateWord + memoData!.text
            memoText.text = dispMemo
            
        }
        
        memoText.becomeFirstResponder()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(doneClick))
        self.navigationItem.rightBarButtonItem = doneButton
        
    }
    
    @objc func doneClick(){
        
        if !memoText.text.isEmpty {
            setMemoObject()
            
        }
        
        navigationController!.popViewController(animated: true)
        
    }
    
    private func setMemoObject() {
        let memo = memoText.text ?? ""
        let separateText = memo.components(separatedBy: separateWord)
        let firstText = separateText.first ?? ""
        
        let memoObject = MemoModel()
        
        memoObject.title = firstText
        
        if separateText.count > 1 {
            let titleRow = firstText + separateWord
            memoObject.text = memo.replacingOccurrences(of: titleRow,
                                                        with: "")
            
        }
        
        memoObject.updateDate = Date()
        
        if selectId == 0 {
            memoObject.createDate = Date()
            MemoDao.add(model: memoObject)
            return
            
        }
        
        memoObject.id = selectId
        MemoDao.update(model: memoObject)
        
    }
    
}
