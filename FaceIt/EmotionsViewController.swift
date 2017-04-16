//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by H Hugo Falkman on 2017-03-04.
//  Copyright © 2017 H Hugo Falkman. All rights reserved.
//

import UIKit

class EmotionsViewController: UITableViewController, UIPopoverPresentationControllerDelegate {

    // MARK: Model
    
    // we changed our Model
    // from a Dictionary with keys = emotion names, values = expressions
    // to this Array of tuples with the (name, expression)
    // we also made it a var so we can add new emotions to it
    private var emotionalFaces: [(name: String, expression: FacialExpression)] = [
        ("Sad", FacialExpression(eyes: .closed, mouth: .frown)),
        ("Happy", FacialExpression(eyes: .open, mouth: .smile)),
        ("Worried", FacialExpression(eyes: .open, mouth: .smirk))
    ]
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emotionalFaces.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Emotion Cell", for: indexPath)
        cell.textLabel?.text = emotionalFaces[indexPath.row].name
        return cell
    }
    
    // MARK: - Navigation
    
    // this is the "special method"
    // we must implement in order to unwind to this MVC
    @IBAction func
        addEmotionalFace(from segue: UIStoryboardSegue) {
        if let editor = segue.source as? ExpressionEditorViewController {
            emotionalFaces.append((editor.name, editor.expression))
            tableView.reloadData()
        }
    }

    // we support two different kinds of segues
    // the first shows a face when one of our rows is touched on
    // the second is a popover that allows editing and adding a new emotion
    // the only thing we need to do for the second is set ourselves as the popover delegate
    // this is so we can control the "adaptation" behavior
    // (i.e. control how the editor appears if the environment it is in isn't appropriate for a popover)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let faceVC = segue.destination.contentViewController as? FaceViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
                faceVC.expression = emotionalFaces[indexPath.row].expression
                faceVC.navigationItem.title = emotionalFaces[indexPath.row].name
        } else if segue.destination.contentViewController is ExpressionEditorViewController {
            if let popoverPC = segue.destination.popoverPresentationController {
                popoverPC.delegate = self
            }
        }
    }
    
    func adaptivePresentationStyle(
        for controller: UIPresentationController,
        traitCollection: UITraitCollection
        ) -> UIModalPresentationStyle {
        if traitCollection.verticalSizeClass == .compact {
            return .none
        } else if traitCollection.horizontalSizeClass == .compact{
            return .overFullScreen
        } else {
            return .none
        }
    }
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
