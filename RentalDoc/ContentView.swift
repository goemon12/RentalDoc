import SwiftUI

class RentalData: Identifiable, ObservableObject {
    @Published var id: String
    @Published var title: String
    @Published var stat: Int
    @Published var date: Date
    @Published var photo: Image
    
    init(
        id: String = UUID().uuidString,
        title: String = "",
        stat: Int = 0,
        date: Date = Date(),
        photo: Image = Image(systemName: "photo")
    ) {
        self.id = id
        self.title = title
        self.stat = stat
        self.date = date
        self.photo = photo
    }
}

class AllData: ObservableObject {
    @Published var rentanData: [RentalData] = [
        RentalData(id: UUID().uuidString, title: "品名A", stat: 0, date: Date(), photo: Image(systemName: "car")),
        RentalData(id: UUID().uuidString, title: "品名B", stat: 1, date: Date(), photo: Image(systemName: "photo"))
    ]
}

struct ContentView: View {
    @ObservedObject var allData = AllData()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                ForEach(allData.rentanData) {data in
                    ListView(rentalData: data)
                }
                Spacer()
            }
            .padding(.all, 10)
            .font(.system(size: 20, weight: .regular, design: .monospaced))
            
            .navigationBarTitle("レンタル管理")
            .navigationBarItems(trailing: NavigationLink(destination: DetailView(allData: allData)) {
                Text("新規登録")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
