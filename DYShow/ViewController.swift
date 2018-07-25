//
//  ViewController.swift
//  DYShow
//
//  Created by 侯佳男 on 2018/7/25.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import Each

class DYConfig {
    static let plistName: String = "chuai"
    
    static let backColor: UIColor = UIColor.white
    
    static let tableViewColor: UIColor = UIColor.clear
    static let tableViewCellColor: UIColor = UIColor.clear
    
    static let kInterval: String = "interval"
    static let kText: String = "text"
    
    static let currentFont: UIFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
    static let font: UIFont = UIFont.systemFont(ofSize: 14)
    static let currentColor: UIColor = UIColor.darkText
    static let color: UIColor = UIColor.darkText
    
    static let backImage: String = ""
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBAction func resetAction(_ sender: Any) {
        if (currentCount == dataSource.count) {
            currentCount = 0
            tableView.reloadData()
            tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: UITableViewScrollPosition.middle, animated: true)
            
            start()
        }
    }
    
    var dataSource: [[String : Any]] = []
    var currentCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        initData()
        initTableView()
        start()
    }
    
    func initViews() {
        self.view.backgroundColor = DYConfig.backColor
        
        if DYConfig.backImage.isEmpty {
            backImageView.isHidden = true
            backImageView.image = UIImage(named: DYConfig.backImage)
        }
    }
    
    func initData() {
        let path = Bundle.main.path(forResource: DYConfig.plistName, ofType: "plist")
        dataSource = NSArray.init(contentsOf: URL(fileURLWithPath: path!)) as! [[String : Any]]
    }
    
    func initTableView() {
        tableView.register(UINib(nibName: DYTextCell.identifier, bundle: nil), forCellReuseIdentifier: DYTextCell.identifier)
        self.view.addSubview(tableView)
    }
    
    func start() {
        let second = TimeInterval(dataSource[currentCount][DYConfig.kInterval] as! Int)
        Each(second).seconds.perform { [weak self] in
            if let weakSelf = self {
                guard let _ = self else { return .stop }
                
                if (weakSelf.currentCount == weakSelf.dataSource.count) {
                    return .stop
                }
                
                weakSelf.tableView.reloadData()
                weakSelf.tableView.scrollToRow(at: IndexPath(item: weakSelf.currentCount, section: 0), at: UITableViewScrollPosition.middle, animated: true)
                weakSelf.currentCount += 1
            }
            return .continue
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: UITableViewScrollPosition.middle, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    lazy var tableView: UITableView = {
        let t = UITableView()
        t.frame = self.view.bounds
        t.backgroundColor = DYConfig.tableViewColor
        t.delegate = self
        t.dataSource = self
        //        t.isScrollEnabled = false
        t.separatorStyle = .none
        let footerView = UIView()
        footerView.frame = self.view.bounds
        footerView.backgroundColor = DYConfig.tableViewColor
        t.tableFooterView = footerView
        
        let headerView = UIView()
        headerView.frame = self.view.bounds
        headerView.backgroundColor = DYConfig.tableViewColor
        t.tableHeaderView = headerView
        return t
    }()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DYTextCell.identifier, for: indexPath) as! DYTextCell
        cell.backgroundColor = DYConfig.tableViewCellColor
        if indexPath.row == currentCount {
            cell.myTextLabel.font = DYConfig.currentFont
            cell.myTextLabel.textColor = DYConfig.currentColor
        } else {
            cell.myTextLabel.font = DYConfig.font
            cell.myTextLabel.textColor = DYConfig.color
        }
        cell.myTextLabel.text = dataSource[indexPath.row][DYConfig.kText] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DYTextCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}


