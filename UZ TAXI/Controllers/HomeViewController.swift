//
//  HomeViewController.swift
//  UzTaxi
//
//  Created by Asliddin Rasulov on 26/01/20.
//

import UIKit
//import Mapbox

class HomeViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .secondarySystemBackground
        
//        let url = URL(string: "mapbox://styles/mapbox/streets-v11")
//        let mapView = MGLMapView(frame: view.bounds, styleURL: url)
//        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        mapView.setCenter(CLLocationCoordinate2D(latitude: 41.34, longitude: 69.3), zoomLevel: 9, animated: false)
//        view.addSubview(mapView)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkRootVC()
    }
    
    private func checkRootVC() {
        if UserDefaults.standard.bool(forKey: "logged") {
            configureCardView()
        } else {
            let launchVC = LaunchViewController()
            launchVC.modalTransitionStyle = .crossDissolve
            launchVC.modalPresentationStyle = .fullScreen
            present(launchVC, animated: false, completion: nil)
        }
    }
    
    private func configureCardView() {
        
        let cardView = CardView()

        cardView.frame = CGRect(
            x: 0, y: view.height,
            width: view.width, height: view.height
        )
        
        UIView.animate(withDuration: 0.5) {
            cardView.frame.origin.y = self.view.height - 300
        }
        
        cardView.addShadow()
        view.addSubview(cardView)
    }
}
