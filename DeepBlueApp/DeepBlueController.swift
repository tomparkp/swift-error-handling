//
//  ViewController.swift
//  DeepBlueApp
//
//  Created by Tom Piarulli on 2/11/16.
//  Copyright © 2016 Tom Piarulli. All rights reserved.
//

import UIKit

/// A basic view controller that fetches a single movie from TMDB ()
/// with a loading indicator and error alerts.
class DeepBlueController: UIViewController {
    let APIClient = TMDBClient()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        presentEmptyState()
    }

    @IBAction func refreshButtonTapped(sender: AnyObject) {
        toggleLoading(true)

        let deepBlueSea = TMDBMovieRequest(id: 8914)
        APIClient.request(deepBlueSea) { [weak self] result in
            
            // We use [weak self] and unwrap self as "controller" to prevent a crash
            // in the event the user moves away and this VC is deallocated before
            // the request completes and this closure is called.
            if let controller = self {
                controller.toggleLoading(false)

                switch result {
                case .Success(let movie):
                    // Thanks to Generics we get back an already strongly typed object
                    print("Movie loaded successfully: \(movie.title)")
                    controller.titleLabel.text = movie.title
                    controller.overviewLabel.text = movie.overview

                case .Failure(let error):
                    // Protocols + Extensions make error handling clean and easy.
                    print(error)
                    error.report()
                    controller.presentAlertWithError(error)
                }
            }
        }
    }

    // MARK: - View Helpers

    func toggleLoading(loading: Bool) {
        if loading {
            presentEmptyState()
        }

        loadingIndicator.hidden = !loading
    }

    func presentEmptyState() {
        titleLabel.text = ""
        overviewLabel.text = ""
    }
}

