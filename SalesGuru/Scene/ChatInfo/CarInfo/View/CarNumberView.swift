//
//  CarNumberView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/22/24.
//

import SwiftUI

struct CarNumberView: View {
    let data: IMCarInfo
    let copyAction: (String) -> Void
    
    var body: some View {
        HStack {
            Text(data.title)
                .font(.Quicksand.normal(17))
            Spacer()
            Button {
                copyAction(data.value)
            } label: {
                HStack {
                    Text("Copy")
                        .font(.Quicksand.normal(17))
                    Image(AImages.copy.rawValue)
                        .frame(width: 32, height: 32, alignment: .center)
                        .background(UIColor.ui.darkColor1.convert().opacity(0.04))
                        .clipShape(.circle)
                }.padding(.trailing, 12)
            }.tint(UIColor.ui.darkColor1.convert().opacity(0.35))
        }
    }
}
