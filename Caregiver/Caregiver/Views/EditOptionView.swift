import SwiftUI

struct EditOptionView: View {
    @EnvironmentObject var categoryStore: CategoryStore
    var category: EventCategory
    var option: String
    @State private var name: String
    @Environment(\.presentationMode) var presentationMode

    init(category: EventCategory, option: String) {
        self.category = category
        self.option = option
        _name = State(initialValue: option)
    }

    var body: some View {
        Form {
            TextField("Option", text: $name)
            Button("Save") {
                let trimmed = name.trimmingCharacters(in: .whitespaces)
                guard !trimmed.isEmpty else { return }
                categoryStore.rename(option: option, to: trimmed, in: category)
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationTitle("Edit Option")
    }
}

struct EditOptionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditOptionView(category: .food, option: "Sample")
                .environmentObject(CategoryStore())
        }
    }
}
