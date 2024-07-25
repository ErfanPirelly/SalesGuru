//
//  SwiftUIView+.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/23/24.
//

import SwiftUI


extension View {
    func shake(_ times: Int) -> some View {
        self.modifier(ShakeEffect(animatableData: CGFloat(times)))
    }
}
