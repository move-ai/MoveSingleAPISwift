//
//  AVDepthDataMock.swift
//  
//
//  Created by Move.ai on 03/08/2023.
//

import UIKit
import AVFoundation

extension AVDepthData {
	static var mock: AVDepthData = {
		let info: [AnyHashable: Any] = [kCGImagePropertyPixelFormat: kCVPixelFormatType_DisparityFloat32,
											  kCGImagePropertyWidth: 100,
											 kCGImagePropertyHeight: 100,
										kCGImagePropertyBytesPerRow: 8]
		
		let image = UIImage.imageWithColor(color: .red, size: CGSize(width: 100, height: 100))
		let imageData = image.jpegData(compressionQuality: 1.0)
		
		let metadata = generateMetadata(image: image)
		let dic: [AnyHashable: Any] = [kCGImageAuxiliaryDataInfoDataDescription: info,
												  kCGImageAuxiliaryDataInfoData: imageData! as CFData,
											  kCGImageAuxiliaryDataInfoMetadata: metadata]
		return try! AVDepthData(fromDictionaryRepresentation: dic)
	}()
	
	private static func generateMetadata(image: UIImage) -> CGImageMetadata {
		let metadata = CGImageMetadataCreateMutable()
		
		let fxy = max(image.size.width, image.size.height)
		let cx = image.size.width/2
		let cy = image.size.height/2
		
		addMetadataTag(metadata, key: "Filtered", value: true)
		addMetadataTag(metadata, key: "Quality", value: "high")
		addMetadataTag(metadata, key: "Accuracy", value: "relative")
		addMetadataTag(metadata, key: "DepthDataVersion", value: 65538)
		addMetadataTag(metadata, key: "PixelSize", value: 0.001000)
		
		
		addMetadataTag(metadata, key: "LensDistortionCoefficients", value: [0,0,0,0,0,0,0,0])
		addMetadataTag(metadata, key: "InverseLensDistortionCoefficients", value: [0,0,0,0,0,0,0,0])
		
		addMetadataTag(metadata, key: "IntrinsicMatrixReferenceWidth", value: image.size.width)
		addMetadataTag(metadata, key: "IntrinsicMatrixReferenceHeight", value: image.size.height)
		addMetadataTag(metadata, key: "LensDistortionCenterOffsetX", value: cx)
		addMetadataTag(metadata, key: "LensDistortionCenterOffsetY", value: cy)
		addMetadataTag(metadata, key: "ExtrinsicMatrix", value: [1,0,0,
																 0,1,0,
																 0,0,1,
																 0,0,0])
		
		addMetadataTag(metadata, key: "IntrinsicMatrix", value: [fxy,0,0,
																 0,fxy,0,
																 cx,cy,1])
		
		addMetadataTag(metadata, type: .depthBlur, key: "SimulatedAperture", value: 4.5)
		addMetadataTag(metadata, type: .depthBlur, key: "RenderingParameters", value: "UkVORAEAAAAwAAAAAgAAAJqZmT4K1yM8F0iSOTVeuj0zM7M/DdXOOwAAAD+amRk+")

		return metadata
	}
	
	enum MetadataType {
		case depth, depthBlur
	}
	
	@discardableResult
	private static func addMetadataTag(
		_ metadata: CGMutableImageMetadata,
		type: MetadataType = .depth,
		key: String,
		value: Any
	) -> Bool {
		let namespace: String
		let prefix: String
		switch type {
		case .depth:
			namespace = "http://ns.apple.com/depthData/1.0/"
			prefix = "depthData"
		case .depthBlur:
			namespace = "http://ns.apple.com/depthBlurEffect/1.0/"
			prefix = "depthBlurEffect"
		}
		guard let metadataTag = CGImageMetadataTagCreate(namespace as CFString, prefix as CFString, key as CFString, .default, value as CFTypeRef)
		else { return false }
		
		return CGImageMetadataSetTagWithPath(metadata, nil, ("xmp:"+key) as CFString, metadataTag)
	}
}
