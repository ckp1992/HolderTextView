//
//  TextViewController.swift
//  HolderTextViewTest
//
//  Created by 陈鲲鹏 on 15/3/1.
//  Copyright (c) 2015年 陈鲲鹏. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {

    @IBOutlet weak var holderTextView: HolderTextView!
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        holderTextView.placeHolder = "阿迪发送到发送到"
        holderTextView.maxLength = 1
        holderTextView.font = UIFont.systemFontOfSize(20)
        holderTextView.holderTextViewDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TextViewController : HolderTextViewDelegate{
    func holderTextViewDidChange(textView:HolderTextView){
//        println("\(textView)")
    }
}
