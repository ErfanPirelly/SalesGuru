//
//  CarInfoView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/22/24.
//

import SwiftUI

struct CarInfoView: View {
    @StateObject var toastManager = SwiftUIToastManager()
    @StateObject var viewModel: CarInfoVM
    @State var selectedItem: IMCarInfo? = nil
    @State private var showToast = false
    let dismissAction: Action
    
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
                Text("Car information")
                    .font(.Quicksand.bold(24))
                    .foregroundStyle(UIColor.ui.darkColor1.convert())
                Spacer()
                if viewModel.dataSource == nil {
                    ProgressView()
                        .tint(UIColor.ui.primaryBlue.convert())
                        .progressViewStyle(.circular)
                        .scaleEffect(1) // Scale up the activity indicator
                        .padding(.trailing, 24)
                }
                
                if viewModel.error != nil {
                    Button {
                        viewModel.getLead()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .frame(width: 22, height: 22, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }.padding(.trailing, 24)

                }
            }
            if viewModel.dataSource == nil {
                Spacer()
                
            } else {
                Spacer(minLength: 29)
                
                VStack {
                    List {
                        ForEach(viewModel.dataSource.unsafelyUnwrapped) { section in
                            Section(header: Text(section.title).padding(.vertical, 12)) {
                                ForEach(section.data) { data in
                                    if data.image == nil {
                                        CarNumberView(data: data) { txt in
                                            copyToClipboard(data: txt)
                                        }
                                    } else {
                                        CarInfoItemView(data: data, selectedCar: $selectedItem)
                                    }
                                }
                            }
                        }
                    }.listStyle(.plain)
                        .refreshable {
                            viewModel.getLead()
                        }.tint(UIColor.ui.primaryBlue.convert())
                    
                    Spacer()
                }.background(.white)
                .background(ignoresSafeAreaEdges: .bottom)
                .cornerRadius(16, corners: [.topLeft, .topRight])
            }
        }
        .colorScheme(.light)
        .background(UIColor(p3: "#F6F6F6").convert())
        .withToasts(toastManager: toastManager)
        .onReceive(viewModel.$error, perform: { error in
            if error != nil {
                toastManager.addToast(.init(type: .error(message: viewModel.error ?? "something went wrong")))
            }
        })
    }
    
    func copyToClipboard(data: String) {
         UIPasteboard.general.string = data
         withAnimation {
             toastManager.addToast(.init(type: .custom(message: "Copied to clipboard", duration: 1.5, backgroundColor: .black)))
         }
     }
}
