//
//  MemoListCell.swift
//  SkillupPractice13
//
//  Created by k_motoyama on 2017/05/27.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import UIKit

final class MemoListCell: UITableViewCell {
    
    @IBOutlet weak var memoTitle: UILabel!
    @IBOutlet weak var memoUpdateDate: UILabel!
    @IBOutlet weak var memoText: UILabel!
    
    static var identifier: String {
        get {
            return String(describing: self)
        }
    }
    
    func setData(memoModel: MemoModel) {
        memoTitle.text = memoModel.title
        memoText.text = memoModel.text
        
        memoUpdateDate.text = memoModel.updateDate.dateStyle()
        
    }
}
