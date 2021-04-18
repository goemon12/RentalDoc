import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var rentalData = RentalData(id: UUID().uuidString, title: "", stat: 0, date: Date(), photo: Image(systemName: "photo"))
    @ObservedObject var allData: AllData
    
    var dateFormatter: DateFormatter {
        let f = DateFormatter()
        f.dateStyle = .short
        f.timeStyle = .short
        f.locale = Locale(identifier: "ja_JP")
        return f
    }

    func statText(stat: Int) -> String {
        var text = ""
        switch rentalData.stat {
        case 1:
            text = "貸出中"
        case 2:
            text = "返却済"
        default:
            text = "保管中"
        }
        return text
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("品名").font(.title)
                TextField("品名を入力ください", text: $rentalData.title)
            }
            VStack {
                Text("状態").font(.title)
                Picker(selection: $rentalData.stat, label: Text("Picker")) {
                    Text("未選択").tag(0)
                    Text("貸出中").tag(1)
                    Text("返却済").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            VStack(spacing: 10) {
                Text("写真").font(.title)
                Text(dateFormatter.string(from: rentalData.date))
                rentalData.photo
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                
                HStack(spacing: 10.0) {
                    Spacer()
                    Button(action: {
                    }) {
                        VStack {
                            Image(systemName: "camera")
                                .resizable()
                                .scaledToFit()
                            Text("撮影")
                        }
                    }.frame(width: 80)
                    Spacer()
                    Button(action: {
                    }) {
                        VStack {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                            Text("アルバム")
                        }
                    }.frame(width: 80)
                    Spacer()
                }

            }
        }
        .padding(.all, 10)
        
        .navigationBarTitle("新規登録")
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.backward")
            Text("戻る")
        }, trailing: Button(action: {
            rentalData.date = Date()
            allData.rentanData.append(rentalData)

            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "folder.badge.plus")
            Text("登録")
        })
        .navigationBarBackButtonHidden(true)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(allData: AllData())
    }
}
