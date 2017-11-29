//
//  ViewController.swift
//  Popover
//
//  Created by jyh on 2017/11/30.
//  Copyright © 2017年 jyh. All rights reserved.
//

import UIKit

let PopoverManagerDidPresented = "PopoverManagerDidPresented"
let PopoverManagerDidDismissed = "PopoverManagerDidDismissed"

class ViewController: UIViewController {

    var presentFrame = CGRect.zero
    
    // MARK: - 懒加载
    fileprivate lazy var animatorManager: PopoverManager = {
        let manager = PopoverManager()
        manager.presentFrame.origin = self.presentFrame.origin
        return manager
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

        
    @IBAction func btnclick(_ sender: Any) {
  
        let menuView = PopoverViewController()
        
        // 2.显示菜单
        // 2.1创建菜单
        // 自定义专场动画
        // 设置转场代理
        menuView.transitioningDelegate = animatorManager
        // 设置转场动画样式
        menuView.modalPresentationStyle = UIModalPresentationStyle.custom
        
        // 2.2弹出菜单
        present(menuView, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

