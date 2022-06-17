//
//  UIImageView+Ext.swift
//  StocksApp
//
//  Created by Abdurahim on 10.06.2022.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(from source: URL?, placeholder: UIImage?) {
        guard let url = source else { return }
        
        kf.setImage(with: .network(url), placeholder: placeholder)
    }
    
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
