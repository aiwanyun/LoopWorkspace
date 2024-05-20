//
//  UsageDataPrivacyPreferenceView.swift
//  LoopOnboardingKitUI
//
//  Created by Pete Schwamb on 12/29/22.
//

import SwiftUI
import LoopKitUI

public struct UsageDataPrivacyPreferenceView: View {
    var onboardingMode: Bool

    var didChoosePreference: ((UsageDataPrivacyPreference) -> Void)?
    var didFinish: (() -> Void)?

    @State private var preference: UsageDataPrivacyPreference

    public init(preference: UsageDataPrivacyPreference, onboardingMode: Bool, didChoosePreference: ((UsageDataPrivacyPreference) -> Void)? = nil, didFinish: (() -> Void)?) {
        self.preference = preference
        self.onboardingMode = onboardingMode
        self.didChoosePreference = didChoosePreference
        self.didFinish = didFinish
    }

    private func choice(title: String, description: String, sharingPreference: UsageDataPrivacyPreference) -> CheckmarkListItem {
        CheckmarkListItem(
            title: Text(title),
            description: Text(description),
            isSelected: Binding(
                get: { self.preference == sharingPreference},
                set: { isSelected in
                    if isSelected {
                        self.preference = sharingPreference
                    }
                }
            )
        )
    }

    public var body: some View {
        ConfigurationPageScrollView(content: {
            Text(LocalizedString("您可以选择选择与闭环开发人员共享使用数据以改善闭环。不需要共享，无论您选择哪种选项，闭环都将完全运行。使用数据将不会与第三方共享。", comment: "Main summary text for UsageDataPrivacyPreferenceView"))
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.secondary)
                .padding()
            Card {
                chooser
            }
        }, actionArea: {
            if onboardingMode {
                Spacer()
                Button(action: {
                    self.didFinish?()
                }) {
                    Text(LocalizedString("继续", comment:"Button title for choosing onboarding without nightscout"))
                        .actionButtonStyle(.primary)
                }
                .padding()
            }
        }) 
        .navigationTitle(Text(LocalizedString("共享数据", comment: "Title on UsageDataPrivacyPreferenceView")))
        .navigationBarHidden(false)
    }

    public var chooser: some View {
        VStack(alignment: .center, spacing: 20) {
            VStack(alignment: .leading) {
                choice(title: LocalizedString("没有分享", comment: "Title in UsageDataPrivacyPreferenceView for no sharing"),
                       description: LocalizedString("不要共享任何数据。", comment: "Description in UsageDataPrivacyPreferenceView for no sharing"),
                       sharingPreference: .noSharing)
                choice(title: LocalizedString("仅共享版本", comment: "Title in UsageDataPrivacyPreferenceView for shareInstallationStatsOnly"),
                       description: LocalizedString("匿名分享有关此闭环版本的最小数据，以帮助开发人员知道有多少人在使用闭环。哪个设备和操作系统版本也将共享。", comment: "Description in UsageDataPrivacyPreferenceView for shareInstallationStatsOnly"),
                       sharingPreference: .shareInstallationStatsOnly)
                choice(title: LocalizedString("共享用法数据", comment: "Title in UsageDataPrivacyPreferenceView for shareUsageDetailsWithDevelopers"),
                       description: LocalizedString("除了版本信息外，还匿名共享有关手机上闭环的使用方式。用法数据包括诸如打开闭环，Bolusing，添加碳水化合物以及在屏幕之间导航的事件。它不包括诸如血糖值或给药量之类的健康数据。", comment: "Description in UsageDataPrivacyPreferenceView for shareUsageDetailsWithDevelopers"),
                       sharingPreference: .shareUsageDetailsWithDevelopers)
            }
        }
        .onChange(of: preference) { newValue in
            didChoosePreference?(newValue)
        }
    }
}
