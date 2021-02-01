//
//  LaunchViewController.swift
//  UzTaxi
//
//  Created by Asliddin Rasulov on 25/01/20.
//

import UIKit

class LaunchViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        return collectionView
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = color
        progressView.setProgress(0.25, animated: true)
        return progressView
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.addTarget(
            self, action: #selector(didTapNextButton), for: .touchUpInside
        )
        button.backgroundColor = color
        button.setImage(
            #imageLiteral(resourceName: "nextButtonImage"), for: .normal
        )
        return button
    }()
    
    private let launchData = LaunchModel().launchModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureCollectionView()
        
        view.addSubview(progressView)
        view.addSubview(nextButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = CGRect(
            x: 0, y: 0, width: view.width, height: view.height * 0.7
        )
        progressView.frame = CGRect(
            x: collectionView.width * 0.25, y: collectionView.bottom + view.width * 0.1,
            width: collectionView.width * 0.5, height: 10
        )
        nextButton.frame = CGRect(
            x: 0.4 * view.width, y: progressView.bottom + view.width * 0.05,
            width: view.width * 0.2, height: view.width * 0.2
        )
        nextButton.layer.cornerRadius = nextButton.height / 2
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
    
        layout.itemSize = CGSize(width: view.width, height : view.height * 0.7)
        collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: layout
        )
        
        collectionView.register(
            LaunchCollectionViewCell.self,
            forCellWithReuseIdentifier: LaunchCollectionViewCell.identifire
        )
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.bounces = false
        collectionView.bouncesZoom = false
        collectionView.isScrollEnabled = false
        
        view.addSubview(collectionView)
    }
    
    @objc private func didTapNextButton() {
        
        let rowIndex = Int(collectionView.contentOffset.x / collectionView.width)
        
        if rowIndex == 3 {
            let loginVC = LogInViewController()
            loginVC.modalTransitionStyle = .crossDissolve
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
        } else {
            progressView.setProgress(
                Float((rowIndex + 2)) * 0.25, animated: true
            )
            collectionView.scrollToItem(
                at: IndexPath(row: rowIndex + 1, section: 0), at: .left, animated: true
            )
        }
    }
}


extension LaunchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return launchData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: LaunchCollectionViewCell.identifire, for: indexPath
        ) as! LaunchCollectionViewCell
        cell.configure(data: launchData[indexPath.row])
        return cell
    }
}
