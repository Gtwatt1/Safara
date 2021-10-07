//
//  UIImageView+Extension.swift
//  CitizenOnsite
//
//  Created by Godwin Olorunshola on 2021-10-04.
//  Copyright © 2021 gabe. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

    func loadImageUsingCacheWithURLString(_ URLString: String) {

        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            self.image = cachedImage
            return
        }

        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    DispatchQueue.main.async { [weak self] in
                        self?.image =  UIImage(named: "pgroup-placeholder")
                    }
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            self?.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
