//
//  HolderTextView.swift
//  HolderTextViewTest
//
//  Created by 陈鲲鹏 on 15/3/1.
//  Copyright (c) 2015年 陈鲲鹏. All rights reserved.
//

import UIKit

@objc protocol HolderTextViewDelegate {
    optional func holderTextViewDidChange(textView:HolderTextView)
}

class HolderTextView: UITextView {
    
    private var placeHolderView : UITextView!
    private var initFlag : Bool = false
    var maxLength : Int = 140
    weak var holderTextViewDelegate: HolderTextViewDelegate?
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
    
    //针对语音输入和直接赋值 或者用 kvo实现
    override var text: String! {
        didSet{
            limitTextLength(self)
//            if text.isEmpty {
//                placeHolderView.hidden = false
//            }else{
//                placeHolderView.hidden = true
//            }
//            
//            var toBeString = text as NSString
//            
//            if (toBeString.length > maxLength) {
//                text = toBeString.substringToIndex(maxLength)
//            }
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
    
    private func limitTextLength(textView: UITextView){
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

//MARK: -Notifications
extension HolderTextView:UITextViewDelegate{
    func textViewDidChange(textView: UITextView){
        limitTextLength(textView)
        holderTextViewDelegate?.holderTextViewDidChange!(textView as HolderTextView)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool{
        if (textView.text as NSString).length >= maxLength && range.length == 0 { //是输入模式，并且等于最大字数
            return false
        }
        return true
    }
}
