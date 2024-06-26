//
//  File.swift
//  AlgorithmsInSwift
//
//  Created by xlzj on 2024/6/26.
//

import Foundation
import UIKit

extension UIImage {
    func resizeAndCropImage(to targetSize: CGSize, maxRatio: CGFloat) -> UIImage? {
        let originalWidth = self.size.width
        let originalHeight = self.size.height
        
        // 计算原始宽高比
        let originalRatio = originalHeight / originalWidth
        
        // 目标宽高比
        let targetRatio = targetSize.height / targetSize.width
        
        // 如果原始图片长宽都小于或等于目标尺寸，直接返回原图
        guard originalWidth > targetSize.width || originalHeight > targetSize.height else {
            return self
        }
        
        var targetWidth = originalWidth
        var targetHeight = originalHeight
        
        if originalRatio <= maxRatio && 1.0 / originalRatio <= maxRatio {
            // 压缩图片，保持原比例不变
            let widthFactor = originalWidth / targetSize.width
            let heightFactor = originalHeight / targetSize.height
            let resizeFactor = max(widthFactor, heightFactor)
            targetWidth = originalWidth / resizeFactor
            targetHeight = originalHeight / resizeFactor
            return drawImage(targetWidth: targetWidth, targetHeight: targetHeight)
        } else if originalRatio > maxRatio {
            // 对于高图，调整宽度，裁剪高度
            targetWidth = min(originalWidth, targetSize.height / maxRatio)
            targetHeight = originalHeight / (originalWidth / targetWidth)
            let resizedImage = drawImage(targetWidth: targetWidth, targetHeight: targetHeight)
            let cropY = (targetHeight - targetSize.height) / 2
            return resizedImage?.cropImage(targetWidth: targetWidth, targetHeight: targetSize.height, cropX: 0, cropY: cropY)
        } else {
            // 对于宽图，调整高度，裁剪宽度
            targetHeight = min(originalHeight, targetSize.width * maxRatio)
            targetWidth = originalWidth / (originalHeight / targetHeight)
            let resizedImage = drawImage(targetWidth: targetWidth, targetHeight: targetHeight)
            let cropX = (targetWidth - targetSize.width) / 2
            return resizedImage?.cropImage(targetWidth: targetSize.width, targetHeight: targetHeight, cropX: cropX, cropY: 0)
        }
    }
    
    private func drawImage(targetWidth: CGFloat, targetHeight: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: ceil(targetWidth), height: ceil(targetHeight)), false, self.scale)
        defer { UIGraphicsEndImageContext() }
        self.draw(in: CGRect(x: 0, y: 0, width: targetWidth, height: targetHeight))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    private func cropImage(targetWidth: CGFloat, targetHeight: CGFloat, cropX: CGFloat, cropY: CGFloat) -> UIImage? {
        let cropRect = CGRect(x: cropX, y: cropY, width: targetWidth, height: targetHeight).integral
        guard let imageRef = self.cgImage?.cropping(to: cropRect) else { return nil }
        return UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
    }
}
