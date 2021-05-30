//
//  RentView.swift
//  RentalDoc
//
//  Created by Tadahiro Kato on 2021/05/23.
//

import SwiftUI

struct RentView: View {
    @Binding var title: String
    @Binding var stat: Int
    @Binding var date: Date
    @Binding var photo: Image
    
    @State var flgPhoto = false
    @State var srcPhoto = UIImagePickerController.SourceType.photoLibrary
    @State var flgActivity = false
    @State var rect = CGRect.zero
    
    var dateF: DateFormatter {
        let f = DateFormatter()
        f.dateStyle = .short
        f.timeStyle = .short
        f.locale = Locale(identifier: "ja_JP")
        return f
    }
    
    var body: some View {
        GeometryReader {geometry2 in
            VStack {
                GeometryReader {geometry1 in
                    VStack {
                        Text("品名").font(.title)
                        TextField("", text: $title)
                        
                        Text("状態").font(.title)
                        Picker(selection: $stat, label: Text("状態")) {
                            Text("未選択").tag(0)
                            Text("貸出中").tag(1)
                            Text("返却済").tag(2)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Text("日時").font(.title)
                        Text(dateF.string(from: date))
                        
                        Text("写真").font(.title)
                        photo
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                    .onAppear {
                        rect = geometry1.frame(in: .local)
                    }
                }
                HStack(alignment: .bottom, spacing: 20.0) {
                    Button(action: {
                        srcPhoto = UIImagePickerController.SourceType.camera
                        flgPhoto = true
                    }) {
                        VStack {
                            Image(systemName: "camera")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 65)
                            Text("撮影する").font(.subheadline)
                        }
                    }
                    Button(action: {
                        srcPhoto = UIImagePickerController.SourceType.photoLibrary
                        flgPhoto = true
                    }) {
                        VStack {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 65)
                            Text("アルバム選択").font(.subheadline)
                        }
                    }
                    Button(action: {
                        let tmp = capture(rect: geometry2.frame(in: .global))
                        imgCap = cropImage(with: tmp, rect: rect)
                        flgActivity = true
                    }) {
                        VStack {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 75)
                            Text("共有する").font(.subheadline)
                        }
                    }
                }
                
                Spacer()
                    .sheet(isPresented: $flgPhoto) {
                        ImagePicker(image: $photo, date: $date, isPick: $flgPhoto, source: $srcPhoto)
                    }
                
                Spacer()
                    .sheet(isPresented: $flgActivity) {
                        ActivityView(activityItems: [imgCap!], applicationActivities: nil)
                        
                    }
            }
        }
    }
}

extension UIView {
    var renderedImage: UIImage {
        let rect = self.bounds
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        self.layer.render(in: context)
        let capturedImgae: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return capturedImgae
    }
}

extension RentView {
    func capture(rect: CGRect) -> UIImage {
        let window = UIWindow(frame: CGRect(origin: rect.origin, size: rect.size))
        let hosting = UIHostingController(rootView: self.body)
        hosting.view.frame = window.frame
        window.addSubview(hosting.view)
        window.makeKeyAndVisible()
        return hosting.view.renderedImage
    }
    
    private func cropImage(with image: UIImage, rect: CGRect) -> UIImage? {
        let ajustRect = CGRect(x: rect.origin.x * image.scale, y: rect.origin.y * image.scale, width: rect.width * image.scale, height: rect.height * image.scale)
        guard let img = image.cgImage?.cropping(to: ajustRect) else { return nil }
        let croppedImage = UIImage(cgImage: img, scale: image.scale, orientation: image.imageOrientation)
        return croppedImage
    }
}

struct RentView_Previews: PreviewProvider {
    static var previews: some View {
        RentView(title: .constant("AAA"), stat: .constant(0), date: .constant(Date()), photo: .constant(Image(systemName: "photo")))
    }
}
