//
//  ContentView.swift
//  KijkTok
//
//  Created by Alexander Forbes-Reed on 24/05/2024.
//

import SwiftUI

struct ContentView: View {
	enum FocusedField {
		case tiktokUrl
	}
	
	@Environment(\.openURL) var openURL

	@State var text: String = ""
	@FocusState private var focusedField: FocusedField?

	var body: some View {
		VStack {
			Spacer()
			ZStack(alignment: .bottom) {
				TextField("enter your TikTok share link", text: $text, axis: .vertical)
					.focused($focusedField, equals: .tiktokUrl)
					.padding(.trailing, 25)
					.padding(9)
					.background(
						RoundedRectangle(cornerRadius: 25)
							.stroke(lineWidth: 1.0)
							.foregroundStyle(Color(uiColor: .clear))
							.background(Color.gray.opacity(0.1)
								.clipShape(RoundedRectangle(cornerRadius: 25))
							)
					)
					.onAppear {
						focusedField = .tiktokUrl
					}
				HStack(alignment: .bottom) {
					Spacer()
					Button(action: {
						openURL(URL(string: "https://kijktok.forbes.red/#\(self.text)")!)
					}) {
						Image(systemName: "arrow.up.circle.fill")
							.foregroundColor(Color(uiColor: .systemBlue))
							.font(.title)
							.padding(.trailing, 3)
							.imageScale(.small)
					}
					Button(action: {
						if let url = UIPasteboard.general.string {
							openURL(URL(string: "https://kijktok.forbes.red/#\(url)")!)
						}
					}) {
						Image(systemName: "doc.on.clipboard.fill")
							.foregroundColor(Color(uiColor: .systemPurple))
							.font(.title)
							.padding(.trailing, 3)
							.imageScale(.small)
					}
				}.padding(.bottom, 5)
			}
		}.padding()
		
	}
}

#Preview {
    ContentView()
}
