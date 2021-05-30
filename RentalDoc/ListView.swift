import SwiftUI

struct ListView: View {
    @ObservedObject var rentData: RentData
    
    var dateFormatter: DateFormatter {
        let f = DateFormatter()
        f.dateStyle = .short
        f.timeStyle = .short
        f.locale = Locale(identifier: "ja_JP")
        return f
    }

    var body: some View {
        HStack {
            Text(rentData.title)
            Text(rentData.stat == 0 ? "未選択" : (rentData.stat == 1 ? "貸出中" : "返却済"))
            Text(dateFormatter.string(from: rentData.date))
            rentData.photo
                .resizable()
                .scaledToFit()
        }
        .frame(height: 100)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(rentData: RentData(title: "品名A", stat: 0, date: Date(), photo: Image(systemName: "car")))
    }
}
