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
    
    @State var r1: CGRect = .zero
    @State var r2: CGRect = .zero
    
    var dateF: DateFormatter {
        let f = DateFormatter()
        f.dateStyle = .short
        f.timeStyle = .short
        f.locale = Locale(identifier: "ja_JP")
        return f
    }
    
    var body: some View {
        GeometryReader {geo1 in
            VStack {
                GeometryReader {geo2 in
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
                        r2 = geo2.frame(in: .local)
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
                        let tmp = capture(rect: r1)
                        imgCap = cropImage(with: tmp, rect: r2)
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
                        ImagePicker(image: $photo, date: $date, isPicking: $flgPhoto, soruce: $srcPhoto)
                    }
                
                Spacer()
                    .sheet(isPresented: $flgActivity) {
                        ActivityView(activityItems: [imgCap!], applicationActivities: nil)
                        
                    }
            }
            .onAppear {
                r1 = geo1.frame(in: .global)
            }
        }
    }
}

struct RentView_Previews: PreviewProvider {
    static var previews: some View {
        RentView(title: .constant("AAA"), stat: .constant(0), date: .constant(Date()), photo: .constant(Image(systemName: "photo")))
    }
}
