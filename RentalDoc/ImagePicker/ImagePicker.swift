//
//  ImagePicker.swift
//  CameraApp
//
//  Created by 高橋京介 on 2020/06/07.
//  Copyright © 2020 高橋京介. All rights reserved.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var image: Image
    @Binding var date: Date
    @Binding var isPicking: Bool
    @Binding var soruce: UIImagePickerController.SourceType
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = soruce
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: Context) {
    }
}
