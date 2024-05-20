//
//  PeripheralManagerError.swift
//  xDripG5
//
//  Copyright © 2017 LoopKit Authors. All rights reserved.
//

import CoreBluetooth


enum PeripheralManagerError: Error {
    case cbPeripheralError(Error)
    case notReady
    case invalidConfiguration
    case timeout
    case unknownCharacteristic
}


extension PeripheralManagerError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .cbPeripheralError(let error):
            return error.localizedDescription
        case .notReady:
            return LocalizedString("外围不是连接的", comment: "Not ready error description")
        case .invalidConfiguration:
            return LocalizedString("外围命令无效", comment: "invlid config error description")
        case .timeout:
            return LocalizedString("外围未及时响应", comment: "Timeout error description")
        case .unknownCharacteristic:
            return LocalizedString("未知的特征", comment: "Error description")
        }
    }

    var failureReason: String? {
        switch self {
        case .cbPeripheralError(let error as NSError):
            return error.localizedFailureReason
        default:
            return errorDescription
        }
    }
}
