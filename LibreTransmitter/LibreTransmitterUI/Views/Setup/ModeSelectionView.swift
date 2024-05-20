//
//  ModeSelectionView.swift
//  LibreTransmitterUI
//
//  Created by LoopKit Authors on 02/09/2021.
//  Copyright © 2021 LoopKit Authors. All rights reserved.
//

import SwiftUI
import LoopKitUI
import LibreTransmitter

struct ModeSelectionView: View {

    @ObservedObject public var cancelNotifier: GenericObservableObject
    @ObservedObject public var saveNotifier: GenericObservableObject

    var pairingService: SensorPairingProtocol
    var bluetoothSearcher: BluetoothSearcher

    var modeSelectSection : some View {
        Section(header: Text(LocalizedString("连接选项", comment: "Text describing options for connecting to sensor or transmitter"))) {

            NavigationLink(destination: Libre2DirectSetup(cancelNotifier: cancelNotifier, saveNotifier: saveNotifier, pairingService: pairingService)) {
                SettingsItem(title: LocalizedString("libre 2直接", comment: "Libre 2 connection option"))
                    .actionButtonStyle(.primary)
                    .padding([.top, .bottom], 8)
            }

            NavigationLink(destination: BluetoothSelection(cancelNotifier: cancelNotifier, saveNotifier: saveNotifier, searcher: bluetoothSearcher)) {
                SettingsItem(title: LocalizedString("蓝牙发射器", comment: "Bluetooth Transmitter connection option"))
                    .actionButtonStyle(.primary)
                    .padding([.top, .bottom], 8)
            }
        }
    }

    var cancelButton: some View {
        Button(LocalizedString("取消", comment: "Cancel button")) {
            cancelNotifier.notify()

        }// .accentColor(.red)
    }

    var body : some View {
        GuidePage(content: {
            VStack {
                getLeadingImage()
                
                HStack {
                    InstructionList(instructions: [
                        LocalizedString("传感器应激活并充分加热。", comment: "Label text for step 1 of connection setup"),
                        LocalizedString("选择所需的设置类型。", comment: "Label text for step 2 of connection setup"),
                        LocalizedString("除了北美Libre 2以外，支持大多数Libre 1和Libre 2传感器；有关详细信息，请参见readme.md。", comment: "Label text for step 3 of connection setup"),
                        LocalizedString("公平的警告：传感器将不使用制造商的算法，并且在使用此过程时可能会缺少制造商算法中的一些安全性缓解。", comment: "Label text for step 4 of connection setup")
                    ])
                }
  
            }

        }) {
            VStack(spacing: 10) {
                modeSelectSection
            }.padding()
        }
        
        .navigationBarTitle("New Device Setup", displayMode: .large)
        .navigationBarItems(trailing: cancelButton)
        .navigationBarBackButtonHidden(true)
    }
}

struct ModeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ModeSelectionView(cancelNotifier: GenericObservableObject(), saveNotifier: GenericObservableObject(), pairingService: MockSensorPairingService(), bluetoothSearcher: MockBluetoothSearcher())
    }
}
