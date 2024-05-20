//
//  G7StartupView.swift
//  CGMBLEKitUI
//
//  Created by Pete Schwamb on 9/24/22.
//  Copyright © 2022 LoopKit Authors. All rights reserved.
//

import Foundation
import SwiftUI

struct G7StartupView: View {
    var didContinue: (() -> Void)?
    var didCancel: (() -> Void)?

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Spacer()
            Text(LocalizedString("Dexcom G7", comment: "Title on WelcomeView"))
                .font(.largeTitle)
                .fontWeight(.semibold)
            VStack(alignment: .center) {
                Image(frameworkImage: "g7")
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fit)
                    .frame(height: 120)
                    .padding(.horizontal)
            }.frame(maxWidth: .infinity)
            Text(LocalizedString("LOOP可以读取G7 CGM数据，但是您仍然必须使用Dexcom G7应用程序进行配对，校准和其他传感器管理。", comment: "Descriptive text on G7StartupView"))
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.secondary)
            Spacer()
            Button(action: { self.didContinue?() }) {
                Text(LocalizedString("继续", comment:"Button title for starting setup"))
                    .actionButtonStyle(.primary)
            }
            Button(action: { self.didCancel?() } ) {
                Text(LocalizedString("取消", comment: "Button text to cancel G7 setup")).padding(.top, 20)
            }
        }
        .padding()
        .environment(\.horizontalSizeClass, .compact)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            G7StartupView()
        }
        .previewDevice("iPod touch (7th generation)")
    }
}
