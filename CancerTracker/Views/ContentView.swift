import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: EventStore

    var body: some View {
        NavigationView {
            List(store.events) { event in
                VStack(alignment: .leading) {
                    Text("\(event.category.rawValue.capitalized): \(event.name)")
                        .font(.headline)
                    Text(event.note)
                    Text(event.date, style: .date)
                        .font(.caption)
                }
            }
            .navigationTitle("Daily Events")
            .toolbar {
                NavigationLink("Add") {
                    AddEventView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(EventStore())
    }
}
