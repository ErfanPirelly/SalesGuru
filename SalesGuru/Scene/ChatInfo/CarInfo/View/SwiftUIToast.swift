import SwiftUI

enum ToastType {
    case error(message: String)
    case warning(message: String)
    case custom(message: String, duration: TimeInterval, backgroundColor: Color)
    
    var text: String {
        switch self {
        case .error(let message), .warning(let message), .custom(let message, _, _):
            return message
        }
    }
    
    var duration: TimeInterval {
        switch self {
        case .error:
            return 3.0
        case .warning:
            return 2.5
        case .custom(_, let duration, _):
            return duration
        }
    }
}

class SwiftUIToastManager: ObservableObject {
    @Published var toasts: [ToastView] = []

    func addToast(_ toast: ToastView) {
        toasts.append(toast)
        DispatchQueue.main.asyncAfter(deadline: .now() + toast.type.duration) {
            self.removeToast(toast)
        }
    }

    private func removeToast(_ toast: ToastView) {
        if let index = toasts.firstIndex(where: { $0.id == toast.id }) {
            withAnimation {
                toasts.remove(at: index)
            }
        }
    }
}


import SwiftUI

struct ToastView: View, Identifiable, Equatable {
    static func == (lhs: ToastView, rhs: ToastView) -> Bool {
        lhs.id == rhs.id
    }
    var id = UUID()
    let type: ToastType

    var body: some View {
        VStack {
            Text(type.text)
                .foregroundColor(.white)
                .padding()
                .background(color(for: type))
                .cornerRadius(8)
                .padding(.bottom, 45)
                .onAppear {
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                }
        }
    }
    
    func color(for type: ToastType) -> Color {
        switch type {
        case .error:
            return Color.red
        case .warning:
            return Color.orange
        case .custom(_, _, let color):
            return color
        }
    }
}

extension View {
    func withToasts(toastManager: SwiftUIToastManager) -> some View {
        ZStack(alignment: .bottom) {
            self
            ZStack(alignment: .bottom) {
                ForEach(toastManager.toasts, id: \.id) { toast in
                    toast.transition(.move(edge: .bottom))
                }
            }.padding(.bottom, 45)
        }
    }
}
