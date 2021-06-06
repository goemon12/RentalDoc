//
//  Coordinator.swift
//  CameraApp
//
//  Created by 高橋京介 on 2020/06/07.
//  Copyright © 2020 高橋京介. All rights reserved.
//

import SwiftUI
class Coordinator: NSObject, UINavigationControllerDelegate,  UIImagePickerControllerDelegate {
    
    var parent:ImagePicker
    
    init(_ parent:ImagePicker){
        self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        parent.image = Image(uiImage: info[.originalImage] as! UIImage)
        parent.date = Date()
        parent.isPicking = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        parent.isPicking = false
    }
}
