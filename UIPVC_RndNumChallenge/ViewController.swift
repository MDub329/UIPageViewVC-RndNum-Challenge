//
//  ViewController.swift
//  UIPVC_RndNumChallenge
//
//  Created by Matthew Wells on 10/2/18.
//  Copyright © 2018 Matthew Wells. All rights reserved.
//

import UIKit

class ProjectorPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    let imageNames = ["toys_retro_0","toys_retro_1","toys_retro_2","toys_retro_3","toys_retro_4","toys_retro_5"]
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        dataSource = self
        setUpRotater()
    }
    
    func setUpRotater() {
        let frameUIPageVC = UIPageVC()
        frameUIPageVC.imageName = imageNames.first
        let viewController = [frameUIPageVC]
        setViewControllers(viewController, direction: .forward, animated: true, completion: nil)
        view.addSubview(randomButton)
        randomButton.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 20, right: 0), size: .init(width: 100, height: 50))
        
        randomButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    let randomButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Random", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(ProjectorPageViewController.rndButtonClick), for: .touchUpInside)
        btn.layer.cornerRadius = 5
        btn.layer.borderColor = UIColor.darkGray.cgColor
        btn.layer.borderWidth = 2
        btn.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return btn
    }()
    
    @objc func rndButtonClick() {
        let rndNum = Int.random(in: 0...5)
        let framePageVC = UIPageVC()
        framePageVC.imageName = imageNames[rndNum]
        let frameViewController1 = [framePageVC]
        setViewControllers(frameViewController1, direction: .forward, animated: true, completion: nil)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentImageName = (viewController as! UIPageVC).imageName
        let currentIndex = imageNames.index(of: currentImageName!)
        
        if currentIndex! > 0{
            let frameViewController = UIPageVC()
            frameViewController.imageName = imageNames[currentIndex! - 1]
            return frameViewController
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let currentImageName = (viewController as! UIPageVC).imageName
        let currentIndex = imageNames.index(of: currentImageName!)
        
        if currentIndex! < imageNames.count - 1{
            let frameViewController = UIPageVC()
            frameViewController.imageName = imageNames[currentIndex! + 1]
            return frameViewController
        }
        
        return nil
    }
    
}

class UIPageVC: UIViewController {
    var imageName: String? {
        didSet{
            imageView.image = UIImage(named: imageName!)
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        //iv.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        return iv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        
        view.addSubview(imageView)
        
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }


}

