import SwiftUI

struct AddEventView: View {
    @EnvironmentObject var store: EventStore
    @EnvironmentObject var categoryStore: CategoryStore
    @Environment(\.presentationMode) var presentationMode

    var event: Event?

    @State private var selectedCategory: EventCategory
    @State private var selectedEvent: String
    @State private var newOption: String = ""
    @State private var note: String
    @State private var date: Date

    init(event: Event? = nil) {
        self.event = event
        _selectedCategory = State(initialValue: event?.category ?? .food)
        _selectedEvent = State(initialValue: event?.name ?? EventCategory.food.defaultEvents.first ?? "")
        _note = State(initialValue: event?.note ?? "")
        _date = State(initialValue: event?.date ?? Date())
    }

    var body: some View {
        Form {
            Picker("Category", selection: $selectedCategory) {
                ForEach(EventCategory.allCases) { category in
                    Text(category.rawValue.capitalized).tag(category)
                }
            }
            Picker("Event", selection: $selectedEvent) {
                ForEach(categoryStore.events(for: selectedCategory), id: \.self) { event in
                    Text(event).tag(event)
                }
            }
            HStack {
                TextField("New option", text: $newOption)
                Button("Add") {
                    let trimmed = newOption.trimmingCharacters(in: .whitespaces)
                    guard !trimmed.isEmpty else { return }
                    categoryStore.add(event: trimmed, to: selectedCategory)
                    selectedEvent = trimmed
                    newOption = ""
                }
            }
            TextField("Note", text: $note)
            DatePicker("Time", selection: $date)
            Button("Save") {
                var updated = Event(category: selectedCategory, name: selectedEvent, note: note, date: date)
                if let existing = event {
                    updated.id = existing.id
                    store.update(updated)
                } else {
                    store.add(updated)
                }
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationTitle(event == nil ? "Add Event" : "Edit Event")
        .onChange(of: selectedCategory) { newValue in
            selectedEvent = categoryStore.events(for: newValue).first ?? ""
        }
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddEventView()
                .environmentObject(EventStore())
                .environmentObject(CategoryStore())
        }
    }
}
