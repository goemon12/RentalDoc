import SwiftUI

extension RentView {
    func capture(rect: CGRect) -> UIImage {
        let window = UIWindow(frame: CGRect(origin: rect.origin,
                                            size: rect.size))
        let hosting = UIHostingController(rootView: self.body)
        hosting.view.frame = window.frame
        window.addSubview(hosting.view)
        window.makeKeyAndVisible()
        return hosting.view.renderedImage
    }
    
    func cropImage(with image: UIImage, rect: CGRect) -> UIImage? {
        let ajustRect = CGRect(x: rect.origin.x * image.scale, y: rect.origin.y * image.scale, width: rect.width * image.scale, height: rect.height * image.scale)
        guard let img = image.cgImage?.cropping(to: ajustRect) else { return nil }
        let croppedImage = UIImage(cgImage: img, scale: image.scale, orientation: image.imageOrientation)
        return croppedImage
    }
}
