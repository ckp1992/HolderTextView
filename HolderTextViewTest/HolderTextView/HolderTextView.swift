//
//  HolderTextView.swift
//  HolderTextViewTest
//
//  Created by 陈鲲鹏 on 15/3/1.
//  Copyright (c) 2015年 陈鲲鹏. All rights reserved.
//

import UIKit

class HolderTextView: UITextView {

    private var placeHolderView : UITextView!
    private var initFlag : Bool = false
    var maxLength : Int = 140
    
    var placeHolder : String = "" {
        didSet{
            placeHolderView.text = placeHolder
        }
    }
    
    override var font: UIFont! {
        didSet{
            if let holderView = placeHolderView {
                placeHolderView.font = font
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initPlacHolderView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !initFlag {
            placeHolderView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
            self.contentOffset = CGPointZero
            initFlag = true
        }
    }
}

//MARK: -类方法
extension HolderTextView {
    func initPlacHolderView() {
        placeHolderView = UITextView()
        placeHolderView.text = placeHolder
        placeHolderView.textColor = UIColor.lightGrayColor()
        placeHolderView.backgroundColor = UIColor.clearColor()
        placeHolderView.userInteractionEnabled = false
        placeHolderView.font = self.font
        self.delegate = self
        self.addSubview(placeHolderView)
    }
}

//MARK: -UITextViewDelegate
extension HolderTextView : UITextViewDelegate{
    
    func textViewDidChange(textView: UITextView){
        if textView.text.isEmpty {
            placeHolderView.hidden = false
        }else{
             placeHolderView.hidden = true
        }
        
        var toBeString = textView.text as NSString
        
        if (toBeString.length > maxLength) {
            textView.text = toBeString.substringToIndex(maxLength)
        }
    }
}
