//
//  DisclaimerView.swift
//  NightscoutRemoteCGM
//
//  Created by Bill Gestrich on 2/6/2022.
//  Copyright © 2022 Bill Gestrich. All rights reserved.
//

import SwiftUI
import LoopKitUI
import Combine

final class DisclaimerViewModel: ObservableObject {
    let onCancel = PassthroughSubject<Void, Never>()
    let onContinue = PassthroughSubject<Void, Never>()
}

public struct DisclaimerView: View {
    
    @ObservedObject var viewModel: DisclaimerViewModel
    
    private let frameworkBundle = Bundle(for: DisclaimerViewModel.self)
    
    public var body: some View {
        
        VStack {
            Spacer()
            Text(LocalizedString("NightScout远程CGM", comment: "Title for the CGMManager option"))
                .font(.title)
                .fontWeight(.semibold)
            ScrollView {
                Image("nightscout", bundle: frameworkBundle)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                Text(NSLocalizedString("服务说明", bundle: frameworkBundle, comment: ""))
                    .lineLimit(nil)
                    .padding()
            }
            Button(action: self.viewModel.onContinue.send ) {
                Text(LocalizedString("继续", comment: "Button text to Continue in Nightscout Disclaimer view"))
            }
            .buttonStyle(ActionButtonStyle(.primary))
            .padding([.leading, .trailing])
            Button(action: self.viewModel.onCancel.send ) {
                Text(LocalizedString("取消", comment: "Button text to Cancel in Nightscout Disclaimer view"))
            }
            .padding()
            Spacer()
        }
        .navigationBarTitle(Text("CGM设置", bundle: frameworkBundle))
    }
}

struct DislaimerView_Previews: PreviewProvider {
    static var previews: some View {
        DisclaimerView(viewModel: DisclaimerViewModel()).environment(\.colorScheme, .dark)
    }
}
