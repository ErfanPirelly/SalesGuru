//
//  SwiftUIRadioButton.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/23/24.
//

import SwiftUI

struct RadioButton: View {
    @Binding var selected: Bool

    var body: some View {
        Image(systemName: selected ? "largecircle.fill.circle" : "circle")
            .foregroundColor(selected ? .white : .gray)
    }
}
