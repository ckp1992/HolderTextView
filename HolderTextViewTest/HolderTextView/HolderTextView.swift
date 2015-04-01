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
        
        var toBeString = textView.text as NSString
        if (toBeString.length > maxLength) {
            textView.text = toBeString.substringToIndex(maxLength)
        }
    }
}

//MARK: -Notifications
extension HolderTextView:UITextViewDelegate{
    func textViewDidChange(textView: UITextView){
        if textView.text.isEmpty {
            placeHolderView.hidden = false
        }else{
            placeHolderView.hidden = true
        }
        var language = textView.textInputMode?.primaryLanguage
        println("language:\(language)")
        if let lang = language {
            if lang == "zh-Hans" ||  lang == "zh-Hant" || lang == "ja-JP"{ //如果是中文简体,或者繁体输入,或者是日文这种带默认带高亮的输入法
                
                //获取高亮部分
                var selectedRange = textView.markedTextRange
                var position : UITextPosition?
                if let range = selectedRange {
                    position = textView.positionFromPosition(range.start, offset: 0)
                }
                //系统默认中文输入法会导致英文高亮部分进入输入统计，对输入完成的时候进行字数统计
                if position == nil {
                    println("没有高亮，输入完毕")
                    limitTextLength(textView)
                    self.holderTextViewDelegate?.holderTextViewDidChange!(textView as HolderTextView)
                }
            }else{//非中文输入法
                limitTextLength(textView)
                self.holderTextViewDelegate?.holderTextViewDidChange!(textView as HolderTextView)
            }
        }
    }
}
