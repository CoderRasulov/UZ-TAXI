//
//  HomeViewController.swift
//  UzTaxi
//
//  Created by Asliddin Rasulov on 26/01/20.
//

import UIKit
import Mapbox
import MapboxMobileEvents

class HomeViewController: UIViewController {
    
    private var mapView: MGLMapView!
    
    private let titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let burgerButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 3
        button.setImage(#imageLiteral(resourceName: "burger"), for: .normal)
        button.layer.borderColor = #colorLiteral(red: 0.2666666667, green: 0.02745098039, blue: 0.3411764706, alpha: 0.1047991822)
        
        button.addTarget(
            self, action: #selector(didTapBurgerButton), for: .touchUpInside
        )
        return button
    }()
    
    private let weatherButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 3
        button.setImage(#imageLiteral(resourceName: "notification"), for: .normal)
        button.layer.borderColor = #colorLiteral(red: 0.2666666667, green: 0.02745098039, blue: 0.3411764706, alpha: 0.1047991822)
        return button
    }()
    
    private let currentAddressLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "cheking the adress..."
        label.textColor = color
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .secondarySystemBackground
        
        addSubviews()
        checkRootVC()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        titleView.frame = CGRect(
            x: 0, y: 0, width: view.width, height: view.height / 7
        )
        burgerButton.frame = CGRect(
            x: 20, y: view.safeAreaInsets.top + 20,
            width: 50, height: 50
        )
        weatherButton.frame = CGRect(
            x: view.width - 70, y: view.safeAreaInsets.top + 20,
            width: 50, height: 50
        )
        currentAddressLabel.centerY(inView: burgerButton)
        currentAddressLabel.anchor(
            left: burgerButton.rightAnchor, right: weatherButton.leftAnchor,
            paddingLeft: 20, paddingRight: 20
        )
    }
    
    @objc private func didTapBurgerButton() {
        let vc = LabelPlacementExample()
        present(vc, animated: true, completion: nil)
    }
    
    public func checkRootVC() {
        DispatchQueue.main.async {
            if UserDefaults.standard.bool(forKey: "logged") {
                    self.configure()
            } else {
                let launchVC = LaunchViewController()
                launchVC.modalTransitionStyle = .crossDissolve
                launchVC.modalPresentationStyle = .fullScreen
                self.present(launchVC, animated: false, completion: nil)
            }
        }
    }
    
    private func addSubviews() {
        view.addSubview(titleView)
        titleView.addSubview(burgerButton)
        titleView.addSubview(weatherButton)
        view.addSubview(currentAddressLabel)
    }
    
    public func configure() {
        configureMapBox()
        configureCardView()
    }
    
    private func configureCardView() {
        
        let cardView = CardView()

        cardView.frame = CGRect(
            x: 0, y: view.height,
            width: view.width, height: view.height
        )
        
        UIView.animate(withDuration: 0.5) {
            cardView.frame.origin.y = self.view.height - 250
        }
        
        cardView.addShadow()
        view.addSubview(cardView)
    }
    
    private func configureMapBox() {
        mapView = MGLMapView(frame: view.bounds, styleURL: MGLStyle.lightStyleURL)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
    
//        mapView.setCenter(
//            CLLocationCoordinate2D(
//                latitude: mapView.userLocation!.coordinate.latitude,
//                longitude: mapView.userLocation!.coordinate.longitude
//            ), zoomLevel: 15, animated: false
//        )
        view.insertSubview(mapView, at: 0)
    }
}


extension HomeViewController: MGLMapViewDelegate {
}
