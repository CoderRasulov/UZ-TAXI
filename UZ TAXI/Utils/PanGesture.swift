//
//  PullSwipeExUtil.swift
//  MMPullSwipeDismiss
//
//  Created by Mukesh on 04/11/17.
//  Copyright © 2017 Mad Apps. All rights reserved.
//

import UIKit

extension CardView {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isAtTop {
            contentOffsetY = true
        } else {
            contentOffsetY = false
        }
    }
    
    @objc func pan(recognizer : UIPanGestureRecognizer) {
        guard let panView = recognizer.view else { return }
        
        let transition = recognizer.translation(in: self)
    
        if cardTableView.isAtBottom {
            progressBool = false
        }
        
        if cardTableView.isAtTop {
            progressBool = true
            cardTableView.bounces = false
        }
        
        if contentOffsetY {
            recognizer.setTranslation(.zero, in: self)
            contentOffsetY = false
        } else {
            if progressBool {
                panView.frame.origin.y = frame.height - constHeight + transition.y
                if panView.frame.origin.y <= 0.15 * frame.height {
                    panView.frame.origin.y = 0.15 * frame.height
                }
            }
        }
        
        if recognizer.state == .changed {
            if panView.frame.origin.y <= frame.height * 0.15 {
                cardTableView.isScrollEnabled = true
            } else {
                cardTableView.isScrollEnabled = false
            }
        }
        
        if recognizer.state == .ended {
            if panView.frame.origin.y <= 0.4 * frame.height {
                UIView.animate(withDuration: 0.3) {
                    self.constHeight = self.frame.height * 0.85
                    panView.frame.origin.y = 0.15 * self.frame.height
                    self.cardTableView.isScrollEnabled = true
                    self.progressBool = false
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.constHeight = 250
                    panView.frame.origin.y = self.frame.height - 250
                    self.cardTableView.selectRow(
                        at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top
                    )
                    self.cardTableView.isScrollEnabled = false
                    self.progressBool = false
                }
            }
        }
    }
}

