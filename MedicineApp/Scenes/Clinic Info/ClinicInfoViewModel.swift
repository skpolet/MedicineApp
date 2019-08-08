//
//  ClinicInfoViewModel.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 06/08/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import UIKit

public enum ClinicState{
    case fullyExpanded
    case middle
    case fullyCollapsed
    case closed
}

class ClinicInfoViewModel: NSObject {
    
    public var fastExpandingTime:Double = 0.25
    public var slowExpandingTime:Double = 1
    public var minimalYPosition:CGFloat = 0
    private var maximalYPosition:CGFloat = 0
    private let paddingFromTop:CGFloat = 8
    public var currentExpandedState: ClinicState = .fullyCollapsed
    private var startedDraggingOnImageClinic = false
    
    var clinic = ClinicInfoBuilder()
    let currentVC = UIApplication.getTopViewController()
    var visualEffectView:UIVisualEffectView!
    
    let cardHeight:CGFloat = 600
    let cardHandleAreaHeight:CGFloat = 65
    
    var cardVisible = false
//    var nextState: ClinicState {
//        return cardVisible ? .collapsed : .expanded
//    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0

    public func openClinic() {
//        name : String, rating : String, adres: String, workTime: String, countVoites : String, countOfViews : String
        setupCard()
    }
    
    func setupCard() {
        
        let windowFrame = UIWindow().frame
        let visibleHeight:CGFloat = 56 + paddingFromTop + 50
        let frame = CGRect(
            x: 0, y: windowFrame.height - visibleHeight,
            width: windowFrame.width, height: windowFrame.height * CGFloat(0.8))
        self.minimalYPosition = windowFrame.height - frame.height
        self.maximalYPosition = frame.origin.y
//        visualEffectView = UIVisualEffectView()
//        visualEffectView.frame = self.view.frame
//        self.view.addSubview(visualEffectView)
        
        //currentVC?.addChild(clinic.vc!)
        currentVC?.view.addSubview(clinic.vc!.view)
        clinic.vc!.view.frame = CGRect(x: 50, y: 55, width: 200, height: 200)
        //clinic.vc!.view.frame = CGRect(x: 0, y: (currentVC?.view.frame.height)! - cardHandleAreaHeight, width: (currentVC?.view.bounds.width)!, height: cardHeight)
        clinic.vc!.view.clipsToBounds = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(userDidTan))
        //let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ClinicInfoViewModel.userDidPan(recognizer:)))
        let dragGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(userDidPan))
        dragGestureRecognizer.delegate = self
        tapGestureRecognizer.delegate = self

        clinic.vc!.view.addGestureRecognizer(tapGestureRecognizer)
        clinic.vc!.view.addGestureRecognizer(dragGestureRecognizer)
        
        
    }
    
    @objc private func userDidTan(_ sender: UITapGestureRecognizer){
        print("any")
    }
    
    @objc private func userDidPan(_ sender: UIPanGestureRecognizer){
        let senderView = sender.view
        let loc = sender.location(in: senderView)
        let tappedView = senderView?.hitTest(loc, with: nil)
        
        print("rabotaet")
        if sender.state == .began{
            var viewToCheck:UIView? = tappedView
            while viewToCheck != nil {
                if viewToCheck is UIImageView{
                    startedDraggingOnImageClinic = true
                    break
                }
                viewToCheck = viewToCheck?.superview
            }
        }
        
        if sender.state == .ended{
            startedDraggingOnImageClinic = false
            let currentYPosition = clinic.vc!.view.frame.origin.y
            let toTopDistance = abs(Int32(currentYPosition - minimalYPosition))
            let toBottomDistance = abs(Int32(currentYPosition  - maximalYPosition))
            let toCenterDistance = abs(Int32(currentYPosition - (minimalYPosition + maximalYPosition) / 2))
            let sortedDistances = [toTopDistance,toBottomDistance,toCenterDistance].sorted()
            if sortedDistances[0] == toTopDistance{
                toggleExpand(.fullyExpanded,fast:true)
            }else if sortedDistances[0] == toBottomDistance{
                toggleExpand(.fullyCollapsed,fast:true)
            }else{
                toggleExpand(.middle,fast:true)
            }
        }else{

            let translation = sender.translation(in: clinic.vc!.view)
            
            var destinationY = clinic.vc!.view.frame.origin.y + translation.y
            if destinationY < minimalYPosition {
                destinationY = minimalYPosition
            }else if destinationY > maximalYPosition {
                destinationY = maximalYPosition
            }
            clinic.vc!.view.frame.origin.y = destinationY
            
            sender.setTranslation(CGPoint.zero, in: clinic.vc!.view)
        }
    }
    
    private func animationDuration(fast:Bool) -> Double {
        if fast {
            return fastExpandingTime
        }else{
            return slowExpandingTime
        }
    }
    
    public func toggleExpand(_ state: ClinicState, fast:Bool = false){
        let duration = animationDuration(fast: fast)
        UIView.animate(withDuration: duration) {
            switch state{
            case .fullyExpanded:
                self.clinic.vc!.view.frame.origin.y = self.minimalYPosition
            case .middle:
                self.clinic.vc!.view.frame.origin.y = (self.minimalYPosition + self.maximalYPosition)/2
            case .fullyCollapsed:
                self.clinic.vc!.view.frame.origin.y = self.maximalYPosition
            case .closed:
                self.clinic.vc!.view.frame.origin.y = self.maximalYPosition + 100
            }
        }
        self.currentExpandedState = state
    }
    
//    @objc
//    func handleCardPan (recognizer:UIPanGestureRecognizer) {
//        switch recognizer.state {
//        case .began:
//            startInteractiveTransition(state: nextState, duration: 0.9)
//        case .changed:
//            let translation = recognizer.translation(in: clinic.vc!.view)
//            var fractionComplete = translation.y / cardHeight
//            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
//            updateInteractiveTransition(fractionCompleted: fractionComplete)
//        case .ended:
//            continueInteractiveTransition()
//        default:
//            break
//        }
//
//    }
    
//    func animateTransitionIfNeeded (state: ClinicState, duration:TimeInterval) {
//        if runningAnimations.isEmpty {
//            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
//                switch state {
//                case .expanded:
//                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
//                case .collapsed:
//                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
//                }
//            }
//
//            frameAnimator.addCompletion { _ in
//                self.cardVisible = !self.cardVisible
//                self.runningAnimations.removeAll()
//            }
//
//            frameAnimator.startAnimation()
//            runningAnimations.append(frameAnimator)
//
//
////            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
////                switch state {
////                case .expanded:
////                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
////                case .collapsed:
////                    self.visualEffectView.effect = nil
////                }
////            }
////
////            blurAnimator.startAnimation()
////            runningAnimations.append(blurAnimator)
//
//        }
//    }
    
//    func startInteractiveTransition(state:ClinicState, duration:TimeInterval) {
//        if runningAnimations.isEmpty {
//            animateTransitionIfNeeded(state: state, duration: duration)
//        }
//        for animator in runningAnimations {
//            animator.pauseAnimation()
//            animationProgressWhenInterrupted = animator.fractionComplete
//        }
//    }
//
//    func updateInteractiveTransition(fractionCompleted:CGFloat) {
//        for animator in runningAnimations {
//            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
//        }
//    }
//
//    func continueInteractiveTransition (){
//        for animator in runningAnimations {
//            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
//        }
//    }
    
}

extension ClinicInfoViewModel:  UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
