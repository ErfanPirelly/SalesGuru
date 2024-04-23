//
//  SwiftUIWrapper.swift
//  Pirelly
//
//  Created by mmdMoovic on 8/25/23.
//

import SwiftUI

struct HotspotItemPreview: UIViewRepresentable {
    typealias UIViewType = UIView // Replace with the actual UIKit view type

     func makeUIView(context: Context) -> UIView {
         return UIView()// Initialize your UIKit view
     }

     func updateUIView(_ uiView: UIView, context: Context) {
         // Update your UIKit view here if needed
     }
}

struct ContentView: View {
    var body: some View {
        HotspotItemPreview().frame(width: 160,
                                   height: 33,
                                   alignment: .center)
    }
}
struct UIKitViewWrapper_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.sizeThatFits)
    }
}
