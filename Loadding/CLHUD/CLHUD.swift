//
//  GiFHUD.swift
//  Loadding
//
//  Created by darren on 2017/11/27.
//  Copyright © 2017年 陈亮陈亮. All rights reserved.
//

import UIKit

public class CLHUD: NSObject {
    
    public static let share = CLHUD()
    
    // 是否正在显示
    var isShow: Bool = false
    // 宽度
    var hudW: CGFloat = 90
    // 高度
    var hudH: CGFloat = 90
    // hud 出现时长
    let fadeDuration: CGFloat = 0.3
    
    lazy var gifView: GifView = {
        let img = GifView.init(frame: CGRect(x: 25, y:  25, width: 40, height: 40))
        return img
    }()
    lazy var coverView: UIView = {
        let cover = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        cover.alpha = 0
        return cover
    }()
    lazy var bottomView: UIView = {
        let bottom = UIView()
        bottom.frame = CGRect(x: 0.5*(UIScreen.main.bounds.width-self.hudW), y: 0.5*(UIScreen.main.bounds.height-self.hudH), width: 90, height: 90)
        return bottom
    }()
    override init() {
        super.init()
        
        self.bottomView.alpha = 0.8
        self.bottomView.clipsToBounds = true
        self.bottomView.backgroundColor = UIColor.clear
        self.bottomView.layer.cornerRadius = 10
        self.bottomView.layer.masksToBounds = true
        
        // 初始化所有的view，app启动期间view的结构只初始化一次
        self.bottomView.addSubview(self.gifView)
        UIApplication.shared.keyWindow?.addSubview(self.coverView)
        UIApplication.shared.keyWindow?.addSubview(self.bottomView)
    }
    
    private func setGifWithImageName() {
        self.gifView.showGIFImageWithLocalName(name: "Lodging", completionClosure: {
            // 做动画执行后的操作
        })
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 展示
    public static func show(dismissTimer: CGFloat? = nil) {
        CLHUD.share.begin(dismissTimer: dismissTimer, coverHidden: true)
    }
    
    // 消失
    public static func dismiss() {
        CLHUD.share.hiddenHud()
    }
    // 展示遮罩层
    public static func showWithOverlay(dismissTimer: CGFloat? = nil) {
        CLHUD.share.begin(dismissTimer: dismissTimer, coverHidden: false)
    }
    
    func begin(dismissTimer: CGFloat? = nil,coverHidden: Bool) {
        // 1.防止重复出现
        if self.isShow {
            self.hiddenHud()
        }
        // 2.重新设置view的位置
        self.bottomView.alpha = 1
        self.bottomView.isHidden = false
        
        if coverHidden {
            self.coverView.isHidden = true
            UIApplication.shared.keyWindow?.bringSubview(toFront: self.bottomView)
        } else {
            self.coverView.isHidden = false
            UIApplication.shared.keyWindow?.bringSubview(toFront: self.coverView)
            UIApplication.shared.keyWindow?.bringSubview(toFront: self.bottomView)
        }
        // 3.标识已经展示
        self.isShow = true
        // 4.动画展示
        self.fadeIn()
        // 5.设置自动消失
        if dismissTimer != nil {
            self.perform(#selector(self.hiddenHud), with: nil, afterDelay: TimeInterval(dismissTimer!))
        }
    }
    
    @objc func hiddenHud() {
        self.coverView.isHidden = true
        self.fadeOut()
    }
    
    // 动画出现
    private func fadeIn() {
        self.setGifWithImageName()

        UIView.animate(withDuration: TimeInterval(self.fadeDuration), animations: {
            self.bottomView.alpha = 1
        }) { (finish) in
            self.bottomView.isHidden = false
        }
    }
    private func fadeOut() {
        UIView.animate(withDuration: TimeInterval(self.fadeDuration), animations: {
            self.coverView.alpha = 0
            self.bottomView.alpha = 0
        }) { (finish) in
            self.isShow = false
            self.gifView.stopAnimation()
            self.bottomView.isHidden = true
            self.coverView.isHidden = true
        }
    }
}


