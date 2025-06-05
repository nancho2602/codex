import SwiftUI

struct AddEventView: View {
    @EnvironmentObject var store: EventStore
    @Environment(\.presentationMode) var presentationMode

    @State private var selectedCategory: EventCategory = .food
    @State private var selectedEvent: String = EventCategory.food.events.first ?? ""
    @State private var note: String = ""
    @State private var date: Date = Date()

    var body: some View {
        Form {
            Picker("Category", selection: $selectedCategory) {
                ForEach(EventCategory.allCases) { category in
                    Text(category.rawValue.capitalized).tag(category)
                }
            }
            Picker("Event", selection: $selectedEvent) {
                ForEach(selectedCategory.events, id: \.self) { event in
                    Text(event).tag(event)
                }
            }
            TextField("Note", text: $note)
            DatePicker("Time", selection: $date)
            Button("Save") {
                let newEvent = Event(category: selectedCategory, name: selectedEvent, note: note, date: date)
                store.add(newEvent)
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationTitle("Add Event")
        .onChange(of: selectedCategory) { newValue in
            selectedEvent = newValue.events.first ?? ""
        }
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddEventView()
                .environmentObject(EventStore())
        }
    }
}
