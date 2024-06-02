import SwiftUI

enum SettingsOptionsViewModel: Int, CaseIterable, Identifiable {
    case Appearance,
         Language,
         Notification
    
    var title: String {
        switch self {
        case .Language: NSLocalizedString("Language", comment: "")
        case .Appearance: NSLocalizedString("Appearance", comment: "")
        case .Notification: NSLocalizedString("Notification", comment: "")
        }
    }
    
    var icon: String {
        switch self {
        case .Language: "globe"
        case .Appearance: "pencil.and.scribble"
        case .Notification: "message.fill"
        }
    }
    
    var destinationView: some View {
        switch self {
        case .Appearance:
            AnyView(AppearanceView())
        case .Language:
            AnyView(ChangeLaungeView())
        case .Notification:
            AnyView(EmptyView())
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .Appearance:
                .green
        case .Language:
                .yellow
        case .Notification:
                .red
        }
    }
    var id: Int { self.rawValue }
}
