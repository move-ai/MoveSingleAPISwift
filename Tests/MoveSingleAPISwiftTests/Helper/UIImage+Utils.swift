//
//  UIImage+Utils.swift
//  
//
//  Created by Move.ai on 03/08/2023.
//

import UIKit

extension UIImage {
	static func imageWithColor(color: UIColor,
							   size: CGSize = CGSize(width: 100, height: 100)
	) -> UIImage {
		let rect = CGRect(origin: .zero, size: size)
		UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
		color.setFill()
		UIRectFill(rect)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return image!
	}
}
