import SwiftUI
import TipKit

enum SettingsOptionsViewModel: Int, CaseIterable, Identifiable {
    case Appearance, Language, Notification
    
    var title: Text {
        switch self {
        case .Language: return Text("Language")
        case .Appearance: return Text("Appearance")
        case .Notification: return Text("Notification")
        }
    }
    
    var icon: String {
        switch self {
        case .Language: return "globe"
        case .Appearance: return "pencil.and.scribble"
        case .Notification: return "message.fill"
        }
    }
    
    var destinationView: some View {
        switch self {
        case .Appearance:
            return AnyView(AppearanceView())
        case .Language:
            return AnyView(ChangeLaungeView())
        case .Notification:
            return AnyView(EmptyView())
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .Appearance:
            return .green
        case .Language:
            return .yellow
        case .Notification:
            return .red
        }
    }
    
    var tip: HintTipSettigns {
        switch self {
        case .Appearance:
            return HintTipSettigns(titleWeite: "Here's another one...", messageWrite: "And here you can customize the application for yourself", imageString: "pencil.and.scribble")
        case .Language:
            return HintTipSettigns(titleWeite: "And here...", messageWrite: "And here you can change the language", imageString: "globe")
        case .Notification:
            return HintTipSettigns(titleWeite: "When is when???", messageWrite: "To avoid being disturbed by trifles, set up notifications as well", imageString: "message.fill")
        }
    }
    
    var id: Int { self.rawValue }
}

