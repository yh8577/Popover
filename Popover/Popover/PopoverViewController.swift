//
//  PopoverViewController.swift

//  Created by jyh on 2017/11/30.
//  Copyright © 2017年 jyh. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {

    let presentFrame = ViewController().presentFrame
    
    
    let popoview = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let w : CGFloat = 200
        let h : CGFloat = 200
        let x : CGFloat = (UIScreen.main.bounds.width - w) * 0.5
        let y : CGFloat = 100
        
        popoview.frame = CGRect(x: x, y: y, width: w, height: h)

        popoview.backgroundColor = UIColor.orange
        
        view.addSubview(popoview)

    }

    

}
