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

extension AlertPresentable {
    func presentAlert(context: UIViewController) {
        let alertController = UIAlertController(title: alertContent.title, message: alertContent.description, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        context.presentViewController(alertController, animated: true, completion: nil)
    }
}