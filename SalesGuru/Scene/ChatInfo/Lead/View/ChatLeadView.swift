//
//  ChatLeadView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/23/24.
//

import SwiftUI

struct ChatLeadView: View {
    // MARK: - properties
    @StateObject var toastManager = SwiftUIToastManager()
    private let dataSource = LeadState.allCases
    let viewModel: ChatLeadVM
    @State var selectedLead: LeadState? = .cold
    let dismissAction: Action
    
    // MARK: - init
    init(viewModel: ChatLeadVM, selectedLead: LeadState? = nil, dismissAction: @escaping Action) {
        self.viewModel = viewModel
        self.selectedLead = selectedLead
        self.dismissAction = dismissAction
    }
    
    // MARK: - view
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    dismissAction()
                }, label: {
                    Image("back_ic").renderingMode(.template)
                        .resizable()
                        .frame(width: 12.6, height: 22, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }).tint(UIColor.ui.darkColor1.convert())
                    .padding(.leading, 24)
                
                Spacer()
                Text("Lead Status")
                    .font(.Quicksand.bold(24))
                    .foregroundStyle(UIColor.ui.darkColor1.convert())
                Spacer()
            }
            
            Spacer()
                .frame(height: 29)
            
            VStack(spacing: 12) {
                Spacer()
                    .frame(height: 24)
                ForEach(dataSource, id: \.title) { lead in
                    ChatLeadItemView(data: lead,
                                     selectedLead: $selectedLead,
                                     loading: .constant(viewModel.loading)) { lead in
                        viewModel.changeChat(lead: lead)
                    }
                }
                Spacer()
            }.background(.white)
                .cornerRadius(16, corners: [.topLeft, .topRight])
        }.colorScheme(.light)
            .background(UIColor(p3: "#F6F6F6").convert())
            .onReceive(viewModel.$error, perform: { error in
                if error != nil {
                    toastManager.addToast(.init(type: .error(message: viewModel.error ?? "something went wrong")))
                }
            })
    }
}
