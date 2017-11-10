//
//  objectClass.swift
//  MovingViewsPractice
//
//  Created by Prabhkiran on 02/05/17.
//  Copyright © 2017 iOS-Trainee. All rights reserved.
//

import UIKit

class objectClass: UIImageView, UIGestureRecognizerDelegate {
   
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
                let touch: UITouch = touches.first!
        self.center = touch.location(in: self.superview)
   
    }

}
