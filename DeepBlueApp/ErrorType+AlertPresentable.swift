//
//  ErrorType+AlertPresentable.swift
//  DeepBlueApp
//
//  Created by Tom Piarulli on 2/11/16.
//  Copyright © 2016 Tom Piarulli. All rights reserved.
//

import UIKit

/*
    The AlertPresentable protocol provides a common interface for
    presenting error alerts from a UIViewController.

    All we need to do is make our error conform to AlertPresentable and
    we can easily present it using `self.presentAlertWithError(error)`
    thanks to a handy UIViewController extension.
*/
protocol AlertPresentable: ErrorType {
    var alertContent: (title: String, description: String) { get }
}

extension UIViewController {
    func presentAlertWithError(error: AlertPresentable) {
        let content = error.alertContent
        let alertController = UIAlertController(title: content.title, message: content.description, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}