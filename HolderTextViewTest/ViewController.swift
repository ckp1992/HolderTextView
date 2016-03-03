//
//  ViewController.swift
//  HolderTextViewTest
//
//  Created by 陈鲲鹏 on 15/3/1.
//  Copyright (c) 2015年 陈鲲鹏. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    @IBOutlet weak var holderTextView: HolderTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        holderTextView.placeHolder = "阿迪发送到发送到"
//        holderTextView.maxLength = 8
//        
//        var h = HolderTextView(frame: CGRectMake(0, 0, 0, 0))
        //HolderTextView.maxLength = 8
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func click(sender: AnyObject) {
        let vc = TextViewController(nibName: "TextViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

