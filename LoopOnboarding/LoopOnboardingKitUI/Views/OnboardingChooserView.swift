//
//  OnboardingChooserView.swift
//  LoopOnboardingKitUI
//
//  Created by Pete Schwamb on 9/11/20.
//  Copyright © 2020 LoopKit Authors. All rights reserved.
//

import SwiftUI
import LoopKitUI

struct OnboardingChooserView: View {
    var setupWithNightscout: (() -> Void)?
    var setupWithoutNightscout: (() -> Void)?

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text(LocalizedString("Nightscout", comment: "Title on OnboardingChooserView"))
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(LocalizedString("Loop可以与NightScout合作，为远程护理人员提供一种查看闭环在做什么的方法。 NightScout的使用是完全可选的闭环，您可以随时将其设置。", comment: "Descriptive text on OnboardingChooserView"))
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.secondary)
            Spacer()
            Button(action: {
                self.setupWithNightscout?()
            }) {
                Text(LocalizedString("将NightScout与闭环使用", comment:"Button title for choosing onboarding with nightscout"))
                    .actionButtonStyle(.secondary)
            }
            Button(action: {
                self.setupWithoutNightscout?()
            }) {
                Text(LocalizedString("设置闭环但没有Nightscout", comment:"Button title for choosing onboarding without nightscout"))
                    .actionButtonStyle(.secondary)
            }
        }
        .padding()
        .environment(\.horizontalSizeClass, .compact)
        .navigationBarTitle("")
    }
}

struct OnboardingChooserView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            OnboardingChooserView()
        }
        .previewDevice("iPod touch (7th generation)")
    }
}
