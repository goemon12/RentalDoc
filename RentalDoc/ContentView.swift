import SwiftUI

struct ContentView: View {
    @ObservedObject var allData = AllData()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(allData.rentData) {data in
                    NavigationLink(destination: EditView(rentData: data)) {
                        ListView(rentData: data)
                    }
                }
            }
            .navigationTitle("レンタル管理")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: NavigationLink(destination: NewView(allData: allData)) {
                Image(systemName: "square.and.pencil")
                Text("新規")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
