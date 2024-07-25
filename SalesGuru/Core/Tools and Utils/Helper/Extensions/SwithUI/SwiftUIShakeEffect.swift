//
//  SwiftUIShakeEffect.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/23/24.
//

import SwiftUI

import SwiftUI

struct ShakeEffect: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 1
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
          ProjectionTransform(CGAffineTransform(translationX: amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)), y: 0))
      }
}
