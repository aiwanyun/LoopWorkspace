//
//  ShareService+UI.swift
//  Loop
//
//  Copyright © 2018 LoopKit Authors. All rights reserved.
//

import LoopKitUI
import ShareClient


extension ShareService: ServiceAuthenticationUI {
    public var credentialFormFieldHelperMessage: String? {
        return nil
    }

    public var credentialFormFields: [ServiceCredential] {
        return [
            ServiceCredential(
                title: LocalizedString("用户名", comment: "The title of the Dexcom share username credential"),
                isSecret: false,
                keyboardType: .asciiCapable
            ),
            ServiceCredential(
                title: LocalizedString("密码", comment: "The title of the Dexcom share password credential"),
                isSecret: true,
                keyboardType: .asciiCapable
            ),
            ServiceCredential(
                title: LocalizedString("服务器", comment: "The title of the Dexcom share server URL credential"),
                isSecret: false,
                options: [
                    (title: LocalizedString("美国", comment: "U.S. share server option title"),
                     value: KnownShareServers.US.rawValue),
                    (title: LocalizedString("亚太地区", comment: "Japan, Phillipines, Singapore share server option title"), value: KnownShareServers.APAC.rawValue),
                    (title: LocalizedString("全世界", comment: "Outside US and APAC share server option title"),
                     value: KnownShareServers.Worldwide.rawValue)

                ]
            )
        ]
    }
}
