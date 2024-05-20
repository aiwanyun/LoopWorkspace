//
//  ServiceStatus.swift
//  NightscoutServiceKitUI
//
//  Created by Pete Schwamb on 9/30/20.
//  Copyright © 2020 LoopKit Authors. All rights reserved.
//

import SwiftUI
import LoopKitUI
import NightscoutServiceKit

struct ServiceStatusView: View, HorizontalSizeClassOverride {
    @Environment(\.dismissAction) private var dismiss

    @ObservedObject var viewModel: ServiceStatusViewModel
    @ObservedObject var otpViewModel: OTPViewModel
    @State private var selectedItem: String?
    var body: some View {
        VStack {
            Text("Nightscout")
                .font(.largeTitle)
                .fontWeight(.semibold)
            Image(frameworkImage: "nightscout", decorative: true)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
            

            VStack(spacing: 0) {
                HStack {
                    Text("URL")
                    Spacer()
                    Text(viewModel.urlString)
                }
                .padding()
                Divider()
                HStack {
                    Text("状态")
                    Spacer()
                    Text(String(describing: viewModel.status))
                }
                .padding()
                Divider()
                NavigationLink(destination: OTPSelectionView(otpViewModel: otpViewModel), tag: "otp-view", selection: $selectedItem) {
                    HStack {
                        Text("一次性密码")
                        Spacer()
                        Text(otpViewModel.otpCode)
                        Image(systemName: "chevron.right")
                            .font(.caption)
                    }
                }.foregroundColor(Color.primary)
                .padding()
            }
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(10)
            
            Button(action: {
                viewModel.didLogout?()
            } ) {
                Text("登出").padding(.top, 20)
            }
        }
        .padding([.leading, .trailing])
        .navigationBarTitle("")
        .navigationBarItems(trailing: dismissButton)
    }
    
    private var dismissButton: some View {
        Button(action: dismiss) {
            Text("完毕").bold()
        }
    }
}
