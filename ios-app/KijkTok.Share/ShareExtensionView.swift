import SwiftUI

struct ShareExtensionView: View {
	var body: some View {
		NavigationStack{}
	}
	
	func close() {
		NotificationCenter.default.post(name: NSNotification.Name("close"), object: nil)
	}
}

#Preview {
	ShareExtensionView()
}
