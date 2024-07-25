//
//  ChatTipView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/19/24.
//

import TipKit
import SwiftUI

struct ChatTipView: Tip {
    
    @available(iOS 17.0, *)
    @Parameter
    var show: Bool = true
    
    let id = UUID().uuidString
    
    var title: Text {
        Text("Sample tip title")
    }

    var message: Text? {
        Text("Sample tip message")
    }


    var image: Image? {
        Image(systemName: "globe")
    }
    
    @available(iOS 17.0, *)
    var rules: [Rule] {
        #Rule($show) {_ in 
            return true
        }
    }
}

@available(iOS 17.0, *)
public struct TipWithoutDismissViewStyle: TipViewStyle {
    var tipBackgroundColor: Color = .clear
    var imageTintColor: Color = .accentColor
    
    public func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .top, spacing: 6) {
            configuration.image?
                .font(.system(size: 45.5))
                .foregroundColor(imageTintColor)
            VStack(alignment: .leading) {
                configuration.title.font(.headline)
                configuration.message?.font(.subheadline).foregroundStyle(.secondary)
                VStack(alignment: .leading, spacing: 11) {
                    ForEach(configuration.actions.indices, id: \.self) { index in
                        Divider()
                        Button(action: configuration.actions[index].handler, label: {
                            if index == 0 {
                                configuration.actions[index].label().bold()
                            } else {
                                configuration.actions[index].label()
                            }
                        })
                    }
                }
            }
        }.padding(.leading, 9)
            .padding([.top, .bottom], 15)
            .background(tipBackgroundColor)
    }
    
    public func tipBackground(_ color: Color) -> TipWithoutDismissViewStyle {
        var copy = self
        copy.tipBackgroundColor = color
        return copy
    }
    
    public func tint(_ color: Color) -> TipWithoutDismissViewStyle {
        var copy = self
        copy.imageTintColor = color
        return copy
    }
}
