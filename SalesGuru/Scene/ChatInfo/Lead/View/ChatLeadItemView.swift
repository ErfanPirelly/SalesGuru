//
//  ChatLeadItemView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/23/24.
//

import SwiftUI

struct ChatLeadItemView: View {
    let data: LeadState
    @Binding var selectedLead: LeadState?
    @Binding var loading: Bool
    @State private var selected: Bool = false
    @State private var shakeTimes: Int = 0
    let action: (LeadState) -> Void
    
    var body: some View {
        HStack {
            Image(data.swiftUIImage)
                .frame(width: 40, height: 40, alignment: .center)
                .background(data.color.convert())
                .clipShape(.circle)
                .contentShape(.circle)
                .overlay(
                    Circle()
                        .stroke(selectedLead?.title == data.title ? .white : .clear , lineWidth: 1)
                )
                .padding(.leading, 16)
                
            Text(data.title)
                .font(.Quicksand.semiBold(13))
                .foregroundStyle(selectedLead?.title == data.title ? .white : UIColor.ui.darkColor.convert())
            Spacer()
            
            if loading {
                ProgressView()
                    .tint(UIColor.ui.primaryBlue.convert())
                    .progressViewStyle(.circular)
                    .frame(width: 40, height: 40, alignment: .center)
                    .scaleEffect(1) // Scale up the activity indicator
                    .padding(.trailing, 24)
            } else {
                RadioButton(selected: .constant(selectedLead?.title == data.title))
                    .frame(width: 22, height: 22, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.trailing, 16)
            }
        }
        .padding(.vertical, 12)
        .background(selectedLead?.title == data.title ? data.color.convert() : UIColor(p3: "#F6F6F6").convert())
        .cornerRadius(15, corners: .allCorners)
        .shake(shakeTimes)
        .padding(.horizontal)
            .onTapGesture {
                guard !loading else { return }
                if selectedLead?.rawValue != data.rawValue {
                    action(data)
                }
                self.selectedLead = data
                withAnimation(.default) {
                    shakeTimes += 1
                }
                
             }
    }
}
