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
    optional func returnButtonDidClick(textView:HolderTextView)
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
    
    override var font: UIFont? {
        didSet{
            if let _ = placeHolderView {
                placeHolderView.font = font
            }
        }
    }
    
    //针对语音输入或者直接赋值
    override var text: String! {
        didSet{
            self.textViewDidChange(self)
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
        placeHolderView.textColor = UIColor(white: 0.8, alpha: 1)//UIColor.lightGrayColor()
        placeHolderView.backgroundColor = UIColor.clearColor()
        placeHolderView.userInteractionEnabled = false
        placeHolderView.font = self.font
        self.delegate = self
        self.addSubview(placeHolderView)
        
    }
    
    private func limitTextLength(textView: UITextView){
        
        let toBeString = textView.text as NSString
        print("tobeString：\(toBeString)")
        
        if (toBeString.length > maxLength) {
            textView.text = toBeString.substringToIndex(maxLength)
        }
    }
}

//MARK: -UITextViewDelegate
extension HolderTextView:UITextViewDelegate{
    func textViewDidChange(textView: UITextView){
        if textView.text.isEmpty {
            placeHolderView.hidden = false
        }else{
            placeHolderView.hidden = true
        }
        let language = textView.textInputMode?.primaryLanguage
        //        FLOG("language:\(language)")
        if let lang = language {
            if lang == "zh-Hans" ||  lang == "zh-Hant" || lang == "ja-JP"{ //如果是中文简体,或者繁体输入,或者是日文这种带默认带高亮的输入法
                let selectedRange = textView.markedTextRange
                var position : UITextPosition?
                if let range = selectedRange {
                    position = textView.positionFromPosition(range.start, offset: 0)
                }
                //系统默认中文输入法会导致英文高亮部分进入输入统计，对输入完成的时候进行字数统计
                if position == nil {
                    //                    FLOG("没有高亮，输入完毕")
                    limitTextLength(textView)
                    if let delegate = self.holderTextViewDelegate where delegate.holderTextViewDidChange != nil {
                        delegate.holderTextViewDidChange!(textView as! HolderTextView)
                    }
                }
            }else{//非中文输入法
                limitTextLength(textView)
                if let delegate = self.holderTextViewDelegate where delegate.holderTextViewDidChange != nil {
                    delegate.holderTextViewDidChange!(textView as! HolderTextView)
                }
            }
        }
        
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool{
//        println("text:,range：\(text),\(range)")
        //如果returnKey为确认，则returnfalse
        if let delegate = self.holderTextViewDelegate where delegate.returnButtonDidClick != nil {
            if text == "\n" {
                delegate.returnButtonDidClick!(textView as! HolderTextView)
                return !(textView.returnKeyType == .Done)
            }
        }
        return true
    }
}
