//
//  OnBoardingViewController.swift
//  DatingApp
//
//  Created by Baruch Zitserman on 15.05.2023.
//

import Foundation
import UIKit

class OnBoardingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    let collectionView: UICollectionView
    let pageControl = UIPageControl()
    let signInButton = UIButton()
    let signUpButton = UIButton()
    
    
    var currentPage = 0 {
        didSet {
            self.pageControl.currentPage = currentPage
        }
    }
    
    struct CarouselItem {
        let title: String
        let description: String
        let imageName: String
    }
    
    let carouselData = [
        CarouselItem(title: "Hello1", description: "desc1", imageName: "photo"),
        CarouselItem(title: "Hello2", description: "desc2", imageName: "photo2"),
        CarouselItem(title: "Hello3", description: "desc3", imageName: "photo3")
    ]
    
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // MARK - collectionView configuration
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CarouselCell.self, forCellWithReuseIdentifier: "CarouselCell")
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
        // MARK - configure pageControl
        pageControl.numberOfPages = carouselData.count
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black        // MARK - configure signInButton
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.backgroundColor = #colorLiteral(red: 0.9504604936, green: 0.7617421746, blue: 0.2787858248, alpha: 1)
        //        #colorLiteral(red: 1, green: 1, blue: 1, alpha: )
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        
        
        // MARK - configure signUpButton
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.backgroundColor =  .clear
        signUpButton.setTitleColor(UIColor(#colorLiteral(red: 0.9504604936, green: 0.7617421746, blue: 0.2787858248, alpha: 1)), for: .normal)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.layer.cornerRadius = 15
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        
        
        
        
        
        // Subviews
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        
        
        
        // Constraints
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 500),
            
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signInButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 20),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signUpButton.heightAnchor.constraint(equalToConstant: 56),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
    }
    @objc func didTapSignIn() {
        print("sing in button tapped")
    }
    
    @objc func didTapSignUp() {
        print("sing up button tapped")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
    func getCurrentPage() -> Int {

            let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            if let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) {
                return visibleIndexPath.row
            }

            return currentPage
        }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carouselData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as! CarouselCell
        
        
        cell.configure(with: carouselData[indexPath.item])
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    
}



class CarouselCell: UICollectionViewCell {
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imageView)
        
        
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(descriptionLabel)
        
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 400),
            imageView.heightAnchor.constraint(equalToConstant: 360),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: OnBoardingViewController.CarouselItem)
    {
        imageView.image = UIImage(named: item.imageName)
        titleLabel.text = item.title
        descriptionLabel.text = item.description
    }
    
}


//class CarouselLayout: UICollectionViewFlowLayout {
//    override func prepare() {
//        super.prepare()
//
//        guard let collectionView = collectionView else {return}
//
//        itemSize = CGSize(width: collectionView.bounds.width / 2, height: collectionView.bounds.height)
//        scrollDirection = .horizontal
//        minimumLineSpacing = 10
//
//        sectionInset = UIEdgeInsets(top: 0, left: (collectionView.bounds.width - itemSize.width) / 2, bottom: 0, right: (collectionView.bounds.width - itemSize.width) / 2)
//    }
//
//    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//        return true
//    }
//
//}
