//
//  ClinicInfoViewTransition.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 14/08/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

enum State{
    case fullyExpanded
    case middle
    case fullyCollapsed
    case closed
}

class ClinicInfoViewTransition {
    
    var delegate: HandleDelegate?
    
    var currentExpandedState: State = .closed
    
    var minimalYPositionImageView:CGFloat!
    var maximalYPositionImageView:CGFloat!
    
    var minimalYPositionInfoView: CGFloat!
    var maximalYPositionInfoView: CGFloat!
    
    var stopOnTop :Bool = false
    
    let imageView: ClinicTransitionableView
    let infoView: ClinicTransitionableView
    
    
    init(imageView: ClinicTransitionableView, infoView: ClinicTransitionableView) {
        self.imageView = imageView
        self.infoView = infoView
//        self.imageView.delegate = self
//        self.infoView.delegate = self
        infoView.isUserInteractionEnabled = true
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.isHidden = true
        
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        
        minimalYPositionInfoView = 0
        maximalYPositionInfoView = UIWindow().frame.height / 1.30
        
        minimalYPositionImageView = 0
        maximalYPositionImageView = UIWindow().frame.height / 1.65
    }
}

extension ClinicInfoViewTransition: HandleDelegate {
    func handlePan(sender: UIPanGestureRecognizer){
        if sender.state == .ended{
            
            ///algorithm for info
            let toTopDistanceInfo = infoView.toTopDistance(minimalYPosition: minimalYPositionInfoView)
            let toBottomDistanceInfo = infoView.toBottomDistance(maximalYPosition: maximalYPositionInfoView)
            let toCenterDistanceInfo = infoView.toCenterDistance(maximalYPosition: maximalYPositionInfoView, minimalYPosition: minimalYPositionInfoView)
            let sortedDistancesInfo = [toTopDistanceInfo,toBottomDistanceInfo,toCenterDistanceInfo].sorted()
            
            //algorithm for image
            let toTopDistanceImage = imageView.toTopDistance(minimalYPosition: minimalYPositionImageView)
            let toBottomDistanceImage = imageView.toBottomDistance(maximalYPosition: maximalYPositionImageView)
            let toCenterDistanceImage = imageView.toCenterDistance(maximalYPosition: maximalYPositionImageView, minimalYPosition: minimalYPositionImageView)
            let sortedDistancesImage = [toTopDistanceImage,toBottomDistanceImage,toCenterDistanceImage].sorted()
            
            
            
            if sortedDistancesInfo[0] == toTopDistanceInfo{
                toggleExpandInfo(.fullyExpanded)
            }else if sortedDistancesInfo[0] == toBottomDistanceInfo{
                toggleExpandInfo(.fullyCollapsed)
            }else{
                toggleExpandInfo(.middle)
            }
            
            if sortedDistancesImage[0] == toTopDistanceImage{
                toggleExpandImage(.fullyExpanded)
            }else if sortedDistancesImage[0] == toBottomDistanceImage{
                toggleExpandImage(.fullyCollapsed)
            }else{
                toggleExpandImage(.middle)
            }
            
        }else{
            
            let translationInfoView = sender.translation(in: infoView)
            var translationImageView = sender.translation(in: imageView)
            
            translationImageView.y = translationImageView.y * 1.5
            
            let centrInfo = (self.minimalYPositionInfoView + self.maximalYPositionInfoView)/2
            
            var destinationYInfoView = infoView.frame.origin.y + translationInfoView.y
            var destinationYImageView = imageView.frame.origin.y + translationImageView.y
            
            if destinationYInfoView < minimalYPositionInfoView {
                
                destinationYInfoView = minimalYPositionInfoView
                // destinationYImageView = minimalYPositionImageView
            }else if destinationYInfoView > maximalYPositionInfoView{
                destinationYInfoView = maximalYPositionInfoView
                //destinationYImageView = maximalYPositionImageView
            }
            
            if (imageView.toTopDistance(minimalYPosition: minimalYPositionImageView) == 0){
                self.stopOnTop = true
            }else{
                self.stopOnTop = false
            }
            
            if centrInfo > destinationYInfoView && stopOnTop == true{
                destinationYImageView = minimalYPositionImageView
            }else if destinationYImageView < minimalYPositionImageView {
                destinationYImageView = minimalYPositionImageView
            }else if destinationYImageView > maximalYPositionImageView{
                destinationYImageView = maximalYPositionImageView
            }
            
            infoView.frame.origin.y = destinationYInfoView
            imageView.frame.origin.y = destinationYImageView
            sender.setTranslation(CGPoint.zero, in: infoView)
            sender.setTranslation(CGPoint.zero, in: imageView)
            
        }
        
    }
    
    func toggleExpandInfo(_ state: State){
        infoView.isHidden = false
        UIView.animate(withDuration: 0.4) {
            switch state{
            case .fullyExpanded:
                self.infoView.frame.origin.y = 0
            case .middle:
                self.infoView.frame.origin.y = (self.minimalYPositionInfoView + self.maximalYPositionInfoView)/2
            case .fullyCollapsed:
                self.infoView.frame.origin.y = self.maximalYPositionInfoView
            case .closed:
                self.infoView.frame.origin.y = self.maximalYPositionInfoView + 1000
            }
        }
        self.currentExpandedState = state
    }
    
    func toggleExpandImage(_ state: State){
        imageView.isHidden = false
        UIView.animate(withDuration: 0.4) {
            switch state{
            case .fullyExpanded:
                self.imageView.frame.origin.y = 0
            case .middle:
                if(self.infoView.frame.origin.y > (self.minimalYPositionInfoView + self.maximalYPositionInfoView)/2){
                    self.imageView.frame.origin.y = self.maximalYPositionImageView
                }else{
                    self.imageView.frame.origin.y = 0
                }
                
            case .fullyCollapsed:
                self.imageView.frame.origin.y = self.maximalYPositionImageView
            case .closed:
                self.imageView.frame.origin.y = self.minimalYPositionImageView + 1000
            }
        }
        self.currentExpandedState = state
    }

}

extension UIView{
    
    var currentYPosition: CGFloat{
        return self.frame.origin.y
    }
    
    func toTopDistance(minimalYPosition: CGFloat) ->Int32{
        return abs(Int32(currentYPosition - minimalYPosition))
    }
    
    func toBottomDistance(maximalYPosition: CGFloat) ->Int32{
        return abs(Int32(currentYPosition  - maximalYPosition))
    }
    
    func toCenterDistance(maximalYPosition: CGFloat, minimalYPosition: CGFloat) ->Int32{
        return abs(Int32(currentYPosition - (minimalYPosition + maximalYPosition) / 2))
    }
    
}



