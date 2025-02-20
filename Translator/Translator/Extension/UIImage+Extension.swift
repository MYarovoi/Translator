//
//  UIImage+Extension.swift
//  Translator
//
//  Created by Mykyta Yarovoi on 20.02.2025.
//

import UIKit

extension UIImage {
    func resized(toWidth width: CGFloat) -> UIImage? {
        let scale = width / size.width
        let newHeight = size.height * scale
        let newSize = CGSize(width: width, height: newHeight)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
