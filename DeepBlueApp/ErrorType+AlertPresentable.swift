//
//  ErrorType+AlertPresentable.swift
//  DeepBlueApp
//
//  Created by Tom Piarulli on 2/11/16.
//  Copyright © 2016 Tom Piarulli. All rights reserved.
//

import UIKit

protocol AlertPresentable {
    var alertContent: (title: String, description: String) { get }
}

extension UIViewController {
    func presentAlertWithError(error: AlertPresentable) {
        let alertController = UIAlertController(title: error.alertContent.title, message: error.alertContent.description, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}