import SwiftUI

struct EditView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var rentData: RentData
    
    @State var title: String = ""
    @State var stat: Int = 0
    @State var date: Date = Date()
    @State var photo: Image = Image(systemName: "photo")
    
    var body: some View {
        RentView(title: $title, stat: $stat, date: $date, photo: $photo)
            .padding(.all, 10)
            .onAppear {
                title = rentData.title
                stat = rentData.stat
                date = rentData.date
                photo = rentData.photo
            }
            
            .navigationBarTitle("変更", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.backward")
                Text("戻る")
            }, trailing: Button(action: {
                rentData.title = title
                rentData.stat = stat
                rentData.date = date
                rentData.photo = photo                
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "folder.badge.plus")
                Text("登録")
            })
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(rentData: RentData(title: "A", stat: 0, date: Date(), photo: Image(systemName: "photo")))
    }
}
