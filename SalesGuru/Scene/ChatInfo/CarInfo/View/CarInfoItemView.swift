//
//  CarInfoItemView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/22/24.
//

import SwiftUI

struct IMCarInfo: Identifiable {
    var id = UUID()
    let title: String
    let value: String
    let image: String?
}

struct CarInfoItemView: View {
    let data: IMCarInfo
    @Binding var selectedCar: IMCarInfo?
    
    var body: some View {
        HStack {
            Image(data.image ?? "")
                .frame(width: 40, height: 40, alignment: .center)
                .background(.blue)
                .clipShape(.circle)
//                .padding(.leading, 24)
            Text(data.title)
                .font(.Quicksand.normal(17))
            Spacer()
            Text(data.value)
                .foregroundStyle(.black.opacity(0.35))
                .font(.Quicksand.normal(17))
                .padding(.trailing, 24)
        }.background()
            .onTapGesture {
            self.selectedCar = data
        }
    }
}
