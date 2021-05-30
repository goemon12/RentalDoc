import SwiftUI

class RentData: Identifiable, ObservableObject {
    @Published var id = UUID()
    @Published var title: String
    @Published var stat: Int
    @Published var date: Date
    @Published var photo: Image
    
    init(
        title: String,
        stat: Int,
        date: Date,
        photo: Image
    ) {
        self.title = title
        self.stat = stat
        self.date = date
        self.photo = photo
    }
}

class AllData: ObservableObject {
    @Published var rentData: [RentData] = [
        RentData(title: "A", stat: 0, date: Date(), photo: Image(systemName: "person"))
    ]
}

var imgCap: UIImage?
