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
        holderTextView.maxLength = 8
        holderTextView.font = UIFont.systemFontOfSize(20)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
