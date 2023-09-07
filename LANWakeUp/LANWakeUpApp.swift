import SwiftUI

@main
struct LANWakeUpApp: App {
    private let computer = Computer()
    var body: some Scene {
        WindowGroup {
            LANWakeUpView(computer: computer)
                .frame(width: 400)
        }
        .windowResizabilityContentSize()
    }
}

extension Scene {
    func windowResizabilityContentSize() -> some Scene {
        if #available(macOS 13.0, *) {
            return windowResizability(.contentSize)
        } else {
            return self
        }
    }
}