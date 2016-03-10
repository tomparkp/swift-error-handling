//
//  ViewController.swift
//  DeepBlueApp
//
//  Created by Tom Piarulli on 2/11/16.
//  Copyright © 2016 Tom Piarulli. All rights reserved.
//

import UIKit

class DeepBlueController: UIViewController {
    let tmdbClient = TMDBClient()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.hidden = true
        overviewLabel.hidden = true
    }

    @IBAction func refreshButtonTapped(sender: AnyObject) {
        titleLabel.hidden = true
        overviewLabel.hidden = true
        loadingIndicator.hidden = false

        let deepBlueSea = TMDBMovieRequest(id: 8914)
        tmdbClient.request(deepBlueSea) { [weak self] result in
            if let controller = self {
                controller.loadingIndicator.hidden = true

                switch result {
                case .Success(let movie):
                    print("Movie loaded successfully: \(movie.title)")
                    controller.titleLabel.text = movie.title
                    controller.overviewLabel.text = movie.overview
                    controller.overviewLabel.hidden = false
                    controller.titleLabel.hidden = false

                case .Failure(let error):
                    print(error)
                    error.report()
                    controller.presentAlertWithError(error)
                }
            }
        }
    }
}

