//
//  CBPeripheralState.swift
//  Naterade
//
//  Created by Nathan Racklyeft on 3/5/16.
//  Copyright © 2016 Nathan Racklyeft. All rights reserved.
//

import CoreBluetooth


extension CBPeripheralState {

    // MARK: - CustomStringConvertible

    public var description: String {
        switch self {
        case .connected:
            return LocalizedString("连接的", comment: "The connected state")
        case .connecting:
            return LocalizedString("连接", comment: "The in-progress connecting state")
        case .disconnected:
            return LocalizedString("断开连接", comment: "The disconnected state")
        case .disconnecting:
            return LocalizedString("断开连接", comment: "The in-progress disconnecting state")
        @unknown default:
            return "Unknown: \(rawValue)"
        }
    }
}
