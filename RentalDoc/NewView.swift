//
//  NewView.swift
//  RentalDoc
//
//  Created by Xcode2021 on 2021/05/23.
//

import SwiftUI

struct NewView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var allData: AllData
    
    @State var title: String = ""
    @State var stat: Int = 0
    @State var date: Date = Date()
    @State var photo: Image = Image(systemName: "photo")
    
    var body: some View {
        RentView(title: $title, stat: $stat, date: $date, photo: $photo)
            .padding(.all, 10)
            
            .navigationBarTitle("変更", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.backward")
                Text("戻る")
            }, trailing: Button(action: {
                allData.rentData.append(RentData(title: title, stat: stat, date: date, photo: photo))
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "folder.badge.plus")
                Text("登録")
            })
    }
}

struct NewView_Previews: PreviewProvider {
    static var previews: some View {
        NewView(allData: AllData())
    }
}
