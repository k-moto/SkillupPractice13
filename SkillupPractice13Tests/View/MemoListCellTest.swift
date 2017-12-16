//
//  MemoListCellTest.swift
//  SkillupPractice13
//
//  Created by k_motoyama on 2017/12/16.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation

import Foundation
import XCTest
import STV_Extensions

@testable import SkillupPractice13

class MemoListCellTest: XCTestCase {
    
    var today: Date?
    let dataSource = FakeDataSource()
    
    var tableView: UITableView!
    var cell: MemoListCell!
    
    
    override func setUp() {
        super.setUp()
        let vc = MemoListViewController.createInstance()
        _ = vc.view
        
        tableView = vc.memoTable
        tableView?.dataSource = dataSource
        
        today = Date().now()
        
        cell = tableView?.dequeueReusableCell(
            withIdentifier: "MemoListCell",
            for: IndexPath(row: 0, section: 0)) as! MemoListCell
        
    }
    
    override func tearDown() {
        super.tearDown()
        
    }
    
    func testSetTitleLabel(){
        
        let updateDate = "2016/01/01 18:30"
        let format = "yyyy/MM/dd HH:mm"
        
        let memo = MemoModel()
        memo.title = "memoTitle"
        memo.updateDate = updateDate.toDate(dateFormat: format)
        cell.setData(memoModel: memo)
        
        XCTAssertEqual(cell.memoTitle.text, "memoTitle")
        
    }
    
    func testSetMemoTextLabel(){
        
        let updateDate = "2016/01/01 18:30"
        let format = "yyyy/MM/dd HH:mm"
        
        let memo = MemoModel()
        memo.title = "memoTitle"
        memo.updateDate = updateDate.toDate(dateFormat: format)
        memo.text = "memoText"
        cell.setData(memoModel: memo)
        
        XCTAssertEqual(cell.memoText.text, "memoText")
        
    }
    
    func testSetMemoTextLabelNothing(){
        
        let updateDate = "2016/01/01 18:30"
        let format = "yyyy/MM/dd HH:mm"
        
        let memo = MemoModel()
        memo.title = "memoTitle"
        memo.updateDate = updateDate.toDate(dateFormat: format)
        cell.setData(memoModel: memo)
        
        XCTAssertEqual(cell.memoText.text, "")
        
    }
    
    func testSetDateLabelToday(){
        
        guard let todayDate = today else {
            XCTAssert(false, "today is nil")
            return
        }
        
        let format = "yyyy/MM/dd HH:mm"
        let updateDate = todayDate.toStr(dateFormat: format)
        
        let memo = MemoModel()
        memo.title = "memoTitle"
        memo.updateDate = updateDate.toDate(dateFormat: format)
        
        cell.setData(memoModel: memo)
        
        XCTAssertEqual(cell.memoUpdateDate.text, todayDate.toStr(dateFormat: "HH:mm"))
        
    }
    
    func testSetDateLabelStartToday(){
        
        guard let todayDate = today else {
            XCTAssert(false, "today is nil")
            return
        }
        
        let format = "yyyy/MM/dd HH:mm"
        let startToday = replaceTime(to: todayDate, hour: 0)
        let updateDate = startToday.toStr(dateFormat: format)
        
        let memo = MemoModel()
        memo.title = "memoTitle"
        memo.updateDate = updateDate.toDate(dateFormat: format)
        
        cell.setData(memoModel: memo)
        
        XCTAssertEqual(cell.memoUpdateDate.text, startToday.toStr(dateFormat: "HH:mm"))
        
    }
    
    func testSetDateLabelEndToday(){
        
        guard let todayDate = today else {
            XCTAssert(false, "today is nil")
            return
        }
        
        let format = "yyyy/MM/dd HH:mm"
        let endToday = replaceTime(to: todayDate, hour: 23, minute: 59)
        let updateDate = endToday.toStr(dateFormat: format)
        
        let memo = MemoModel()
        memo.title = "memoTitle"
        memo.updateDate = updateDate.toDate(dateFormat: format)
        
        cell.setData(memoModel: memo)
        
        XCTAssertEqual(cell.memoUpdateDate.text, endToday.toStr(dateFormat: "HH:mm"))
        
    }
    
    func testSetDateLabelStartThisYear(){
        
        guard let todayDate = today else {
            XCTAssert(false, "today is nil")
            return
        }
        
        let format = "yyyy/MM/dd HH:mm"
        let startThisYear = replaceMonthAndDay(to: todayDate, month: 1, day: 1)
        let updateDate = startThisYear.toStr(dateFormat: format)
        
        let memo = MemoModel()
        memo.title = "memoTitle"
        memo.updateDate = updateDate.toDate(dateFormat: format)
        
        cell.setData(memoModel: memo)
        
        XCTAssertEqual(cell.memoUpdateDate.text, startThisYear.toStr(dateFormat: "MM/dd"))
        
    }
    
    func testSetDateLabelEndThisYear(){
        
        guard let todayDate = today else {
            XCTAssert(false, "today is nil")
            return
        }
        
        let format = "yyyy/MM/dd HH:mm"
        let endThisYear = replaceMonthAndDay(to: todayDate, month: 1, day: 1)
        let updateDate = endThisYear.toStr(dateFormat: format)
        
        let memo = MemoModel()
        memo.title = "memoTitle"
        memo.updateDate = updateDate.toDate(dateFormat: format)
        
        cell.setData(memoModel: memo)
        
        XCTAssertEqual(cell.memoUpdateDate.text, endThisYear.toStr(dateFormat: "MM/dd"))
        
    }
    
    func testSetDateLabelNextYear(){
        
        guard let todayDate = today else {
            XCTAssert(false, "today is nil")
            return
        }
        
        let format = "yyyy/MM/dd HH:mm"
        let nextYear = addYear(to: todayDate, addValue: 1)
        let startNextYear = replaceMonthAndDay(to: nextYear, month: 1, day: 1)
        let updateDate = startNextYear.toStr(dateFormat: format)
        
        let memo = MemoModel()
        memo.title = "memoTitle"
        memo.updateDate = updateDate.toDate(dateFormat: format)
        
        cell.setData(memoModel: memo)
        
        XCTAssertEqual(cell.memoUpdateDate.text, startNextYear.toStr(dateFormat: "yyyy/MM/dd"))
        
    }
    
    // MARK:- テスト補助
    private func replaceTime(to date: Date, hour: Int, minute: Int = 0) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        var comp = calendar.dateComponents( [.year, .month, .day, .hour, .minute], from: date)
        comp.hour = hour
        comp.minute = minute
        
        return calendar.date(from: comp)!
    }
    
    private func replaceMonthAndDay(to date: Date, month: Int, day: Int) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        var comp = calendar.dateComponents( [.year, .month, .day, .hour, .minute], from: date)
        comp.month = month
        comp.day = day
        comp.hour = 0
        comp.minute = 0
        
        return calendar.date(from: comp)!
        
    }
    
    private func addYear(to date: Date, addValue: Int) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(byAdding: .year, value: addValue, to: date)!
        
    }
    
}

extension MemoListCellTest {
    
    class FakeDataSource: NSObject, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView,
                       numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
