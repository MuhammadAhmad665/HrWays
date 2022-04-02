//
//  UIImageView.swift
//  Fans Belong
//
//  Created by Ahmed on 10/06/2021.
//  Copyright © 2021 aqib. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import AVFoundation

extension UIImageView{
    /**Make Image Round**/
    func makeRounded() {
            self.layer.borderWidth = 1
            self.layer.masksToBounds = false
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.cornerRadius = self.frame.height / 2
            self.clipsToBounds = true
        }
    
    /**Check Image is Empty or not **/
    /**if true means empty and false means self has image**/
    var isEmpty: Bool { image == nil }
    // Download Image from URL
    func downloadImage(imageUrl : String!)
    {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = self.center
        self.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        let url = URL(string: Apis.imageBaseURL + imageUrl)
        
        self.sd_setImage(with: url, completed: { (image, err, type,url) in
            
            if err != nil
            {
                self.sd_imageIndicator?.stopAnimatingIndicator()
                print("Failed to download image",err?.localizedDescription as Any)
            }
            self.sd_imageIndicator?.stopAnimatingIndicator()
            activityIndicator.stopAnimating()
        })
    }

    func downloadImageWithoutBaseURL(imageUrl : String!)
    {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = self.center
        self.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        let url = URL(string: imageUrl)
        
        self.sd_setImage(with: url, completed: { (image, err, type,url) in
            
            if err != nil
            {
                self.sd_imageIndicator?.stopAnimatingIndicator()
                print("Failed to download image",err?.localizedDescription as Any)
            }
            self.sd_imageIndicator?.stopAnimatingIndicator()
            activityIndicator.stopAnimating()
        })
    }

    
    func setThumbnail(url: URL) {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = self.center
        self.addSubview(activityIndicator)
        
        DispatchQueue.global().async { //1
            let asset = AVAsset(url: url) //2
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
            avAssetImageGenerator.appliesPreferredTrackTransform = true //4
            let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
                let thumbImage = UIImage(cgImage: cgThumbImage) //7
                DispatchQueue.main.async { //8
                    activityIndicator.stopAnimating()
                    self.image = thumbImage //9
                }
            } catch {
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                }
                print(error.localizedDescription) //10
                DispatchQueue.main.async {
                    self.image = nil //11
                }
            }
        }
    }
    
    func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        DispatchQueue.global().async { //1
            let asset = AVAsset(url: url) //2
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
            avAssetImageGenerator.appliesPreferredTrackTransform = true //4
            let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
                let thumbImage = UIImage(cgImage: cgThumbImage) //7
                DispatchQueue.main.async { //8
                    completion(thumbImage) //9
                }
            } catch {
                print(error.localizedDescription) //10
                DispatchQueue.main.async {
                    completion(nil) //11
                }
            }
        }
    }
    
    
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.alpha = 0.99
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
    func removeBlurEffect() {
        let blurredEffectViews = self.subviews.filter{$0 is UIVisualEffectView}
        blurredEffectViews.forEach{ blurView in
            blurView.removeFromSuperview()
        }
    }
}
