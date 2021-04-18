import SwiftUI

struct ListView: View {
    @ObservedObject var rentalData: RentalData
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
        HStack(spacing: 10) {
            Text(rentalData.title)
            Text(statText(stat: rentalData.stat))
            Text(dateFormatter.string(from: rentalData.date))
            rentalData.photo
                .resizable()
                .scaledToFit()
                .frame(height: 80)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(rentalData: RentalData(id: UUID().uuidString, title: "品名A", stat: 0, date: Date(), photo: Image(systemName: "car")))
    }
}
