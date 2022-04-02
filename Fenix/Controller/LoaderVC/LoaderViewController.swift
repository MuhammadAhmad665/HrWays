//
//  LoaderViewController.swift
//  Afrosdate
//
//  Created by Abdul Samad butt on 08/10/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class LoaderViewController: UIViewController {
    
    var activityView: UIActivityIndicatorView?
    let container: UIView = UIView()
    let loadingView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        showActivityIndicatory(uiView: self.view)
    }

    // MARK: Show Loader
    func showActivityIndicatory(uiView: UIView) {
        loadingView.frame = CGRect(x: 0, y: 0, width: 125, height: 110)
        let loadingLabel = UILabel(frame: CGRect(x: 15, y: 70 , width: loadingView.frame.width, height: 20))
        loadingLabel.text = WaitingMessage.processing
        loadingLabel.font = UIFont(name: "Flexo-Regular", size: 17)
        loadingLabel.textColor = UIColor.black
        
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor.white
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        loadingView.addSubview(loadingLabel)
        
        
        activityView?.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
        if #available(iOS 13.0, *) {
            activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        } else {
            // Fallback on earlier versions
            activityView = UIActivityIndicatorView(style: .whiteLarge)
        }
        activityView?.color = .black
        activityView?.center = CGPoint(x: loadingView.frame.size.width / 2,
                                       y: loadingView.frame.size.height / 2.5);
        loadingView.addSubview(activityView!)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        activityView?.startAnimating()
    }

    func stopActivityIndicatory()
    {
        if (activityView != nil)
        {
            container.removeFromSuperview()
            activityView?.stopAnimating()
            loadingView.removeFromSuperview()
        }
    }
}
