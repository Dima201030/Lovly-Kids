//
//  Extansion.swift
//  Tinkoff
//
//  Created by Дима Кожемякин on 12.04.2024.
//

import TipKit

extension UIImage {
    func cropToCenter(square: CGFloat) -> UIImage {
        let offsetX = (size.width - square) / 2
        let offsetY = (size.height - square) / 2
        
        let rect = CGRect(x: offsetX, y: offsetY, width: square, height: square)
        
        if let imageRef = cgImage?.cropping(to: rect) {
            return UIImage(cgImage: imageRef, scale: 0, orientation: imageOrientation)
        }
        
        return self
    }
}

extension UIImage {
    var getAverageColour: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        
        let extentVector = CIVector(x: inputImage.extent.size.width * 0.5, y: inputImage.extent.size.height * 0.5)
        let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: CIVector(cgRect: inputImage.extent)])!
        let outputImage = filter.outputImage!.cropped(to: CGRect(origin: CGPoint.zero, size: CGSize(width: 1, height: 1)))
        var bitmap = [UInt8](repeating: 0, count: 4)
        CIContext().render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(origin: .zero, size: CGSize(width: 1, height: 1)), format: .RGBA8, colorSpace: nil)
        
        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}
@available(iOS 17, *)
struct PopoverTipModifier<TipType: Tip>: ViewModifier {
    let tip: TipType?
    @Binding var isTipVisible: Bool
    
    func body(content: Content) -> some View {
        if let tip = tip, isTipVisible {
            content.popoverTip(tip)
        } else {
            content
        }
    }
}

@available(iOS 17, *)
extension View {
    func conditionalPopoverTip<TipType: Tip>(_ tip: TipType?, isTipVisible: Binding<Bool>) -> some View {
        self.modifier(PopoverTipModifier(tip: tip, isTipVisible: isTipVisible))
    }
}
