import SwiftUI
import UIKit
import UniformTypeIdentifiers

class ShareViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Ensure access to extensionItem and itemProvider
		guard
			let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
			let itemProvider = extensionItem.attachments?.first else {
			close()
			return
		}
		
		// Check type identifier
		let textDataType = UTType.plainText.identifier
		if itemProvider.hasItemConformingToTypeIdentifier(textDataType) {
			// Load the item from itemProvider
			itemProvider.loadItem(forTypeIdentifier: textDataType , options: nil) { (providedText, error) in
				if error != nil {
					self.close()
					return
				}
				
				if let text = providedText as? String {
					guard let url = URL(string: "https://kijktok.forbes.red/#\(text)") else { return }
					self.extensionContext?.open(url)
					self.close()
				} else {
					self.close()
					return
				}
			}
		} else {
			close()
			return
		}
		
		NotificationCenter.default.addObserver(forName: NSNotification.Name("close"), object: nil, queue: nil) { _ in
			DispatchQueue.main.async {
				self.close()
			}
		}
	}
	
	/// Close the Share Extension
	func close() {
		self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
	}
}
