//
//  ViewController.swift
//  Loadding
//
//  Created by darren on 2017/11/27.
//  Copyright © 2017年 陈亮陈亮. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var titleArr = ["展示（没有遮罩层）","主动消失","展示3秒后消失","展示（有遮罩层）3秒后消失"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - UITableViewDelegate,UITableViewDataSource
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ID = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: ID)
        }
        cell?.textLabel?.text = self.titleArr[indexPath.row]
        cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            CLHUD.show()
        }
        if indexPath.row == 1 {
            CLHUD.dismiss()
        }
        if indexPath.row == 2 {
            CLHUD.show(dismissTimer: 3)
        }
        if indexPath.row == 3 {
            CLHUD.showWithOverlay(dismissTimer: 6)
        }
    }
}



