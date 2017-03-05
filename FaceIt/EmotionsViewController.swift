//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by H Hugo Falkman on 2017-03-04.
//  Copyright © 2017 H Hugo Falkman. All rights reserved.
//

import UIKit

class EmotionsViewController: VCLLoggingViewController {

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let faceVC = segue.destination.contentViewController as? FaceViewController,
            let id = segue.identifier,
            let expression = emotionalFaces[id] {
                faceVC.expression = expression
                faceVC.navigationItem.title = (sender as? UIButton)?.currentTitle
        }
    }
    
    private let emotionalFaces = [
        "sad": FacialExpression(eyes: .closed, mouth: .frown),
        "happy": FacialExpression(eyes: .open, mouth: .smile),
        "worried": FacialExpression(eyes: .open, mouth: .smirk)
    ]
}

extension UIViewController {
    var contentViewController: UIViewController {
        if let navCon = self as? UINavigationController {
            return navCon.visibleViewController ?? self
        } else {
            return self
        }
    }
}
