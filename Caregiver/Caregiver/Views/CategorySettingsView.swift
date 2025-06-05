import SwiftUI

struct CategorySettingsView: View {
    @EnvironmentObject var categoryStore: CategoryStore
    @EnvironmentObject var store: EventStore

    var body: some View {
        List {
            ForEach(EventCategory.allCases.sorted(by: { $0.rawValue < $1.rawValue })) { category in
                NavigationLink(category.rawValue.capitalized) {
                    EventOptionsView(category: category)
                        .environmentObject(store)
                }
            }
        }
        .navigationTitle("Categories")
    }
}

struct EventOptionsView: View {
    @EnvironmentObject var categoryStore: CategoryStore
    @EnvironmentObject var store: EventStore
    var category: EventCategory
    @State private var newOption = ""

    var body: some View {
        Form {
            Section(header: Text("Options")) {
                let options = categoryStore.events(for: category)
                ForEach(options, id: \.self) { option in
                    if store.events.contains(where: { $0.category == category && $0.name == option }) {
                        HStack {
                            Text(option)
                            Spacer()
                            Text("In Use").foregroundColor(.secondary)
                        }
                    } else {
                        NavigationLink(option) {
                            EditOptionView(category: category, option: option)
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                if let idx = options.firstIndex(of: option) {
                                    categoryStore.remove(atOffsets: IndexSet(integer: idx), from: category)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            Section(header: Text("Add Option")) {
                HStack {
                    TextField("New option", text: $newOption)
                    Button("Add") {
                        let trimmed = newOption.trimmingCharacters(in: .whitespaces)
                        guard !trimmed.isEmpty else { return }
                        categoryStore.add(event: trimmed, to: category)
                        newOption = ""
                    }
                }
            }
        }
        .navigationTitle(category.rawValue.capitalized)
    }
}

struct CategorySettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategorySettingsView()
                .environmentObject(CategoryStore())
                .environmentObject(EventStore())
        }
    }
}
