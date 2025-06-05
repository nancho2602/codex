import SwiftUI

struct SplashView: View {
    @State private var active = false

    var body: some View {
        if active {
            ContentView()
        } else {
            VStack {
                Spacer()
                Image(systemName: "calendar")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                Text("Welcome to Caregiver")
                    .font(.title)
                    .padding(.top)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor.systemBackground))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation { active = true }
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
            .environmentObject(EventStore())
            .environmentObject(CategoryStore())
    }
}
