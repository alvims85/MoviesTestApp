//
//  LoadingView.swift
//  GrabilityTestiOS
//
//  Created by Alvaro Mendoza on 1/20/20.
//  Copyright © 2020 Alvaro. All rights reserved.
//

import UIKit
import Lottie

class LoadingView: UIView {

    let background = UIView()
    let animationView = AnimationView(name: "loading-rainbow")
    override init(frame: CGRect) {
          super.init(frame: frame)
          setupView()
      }

      required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
          setupView()
      }
    
    
    func setupView()
    {
        background.backgroundColor = .black
        background.alpha = 0.3
        self.addSubview(background)
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        background.frame = self.frame
        animationView.frame = CGRect(x: self.frame.size.width/2 - 50, y: self.frame.size.height/2 - 50, width: 100, height: 100)
    }
    
    public func showLoading()
    {
        animationView.loopMode = .loop
        animationView.play()
        self.addSubview(animationView)
    }
    
    public func removeLoadingView()
    {
        animationView.stop()
        self.removeFromSuperview()
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
