//
//  Transition.swift
//  VK
//
//  Created by Denis Dmitriev on 14.07.2020.
//  Copyright © 2020 Denis Dmitriev. All rights reserved.
//

import UIKit

class Transition: NSObject, UIViewControllerTransitioningDelegate {
    
    var startView: UIImageView?
    var endView: UIImageView?


    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animation(type: .present, startView: startView, endView: endView)
    }


    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animation(type: .dissmis, startView: startView, endView: endView)
    }
    

}

