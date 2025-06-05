import SwiftUI

struct CategorySettingsView: View {
    @EnvironmentObject var categoryStore: CategoryStore

    var body: some View {
        List {
            ForEach(EventCategory.allCases) { category in
                NavigationLink(category.rawValue.capitalized) {
                    EventOptionsView(category: category)
                }
            }
        }
        .navigationTitle("Categories")
    }
}

struct EventOptionsView: View {
    @EnvironmentObject var categoryStore: CategoryStore
    var category: EventCategory
    @State private var newOption = ""

    var body: some View {
        Form {
            Section(header: Text("Options")) {
                ForEach(categoryStore.events(for: category), id: \.self) { option in
                    Text(option)
                }
                .onDelete { indexSet in
                    categoryStore.remove(atOffsets: indexSet, from: category)
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
        }
    }
}
