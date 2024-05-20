//
//  PeripheralManagerError.swift
//  RileyLinkBLEKit
//
//  Copyright © 2017 Pete Schwamb. All rights reserved.
//

import CoreBluetooth


enum PeripheralManagerError: Error {
    case cbPeripheralError(Error)
    case notReady
    case busy
    case timeout([PeripheralManager.CommandCondition])
    case emptyValue
    case unknownCharacteristic(CBUUID)
    case unknownService(CBUUID)
}


extension PeripheralManagerError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .cbPeripheralError(let error):
            return error.localizedDescription
        case .notReady:
            return LocalizedString("Rileylink未连接", comment: "PeripheralManagerError.notReady error description")
        case .busy:
            return LocalizedString("Rileylink很忙", comment: "PeripheralManagerError.busy error description")
        case .timeout:
            return LocalizedString("Rileylink没有及时响应", comment: "PeripheralManagerError.timeout error description")
        case .emptyValue:
            return LocalizedString("特征价值是空的", comment: "PeripheralManagerError.emptyValue error description")
        case .unknownCharacteristic(let cbuuid):
            return String(format: LocalizedString("Unknown characteristic: %@", comment: "PeripheralManagerError.unknownCharacteristic error description"), cbuuid.uuidString)
        case .unknownService(let cbuuid):
            return String(format: LocalizedString("Unknown service: %@", comment: "PeripheralManagerError.unknownCharacteristic error description"), cbuuid.uuidString)
        }
    }

    public var failureReason: String? {
        switch self {
        case .cbPeripheralError(let error as NSError):
            return error.localizedFailureReason
        case .unknownCharacteristic:
            return LocalizedString("Rileylink暂时断开", comment: "Failure reason: unknown peripheral characteristic")
        default:
            return nil
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .cbPeripheralError(let error as NSError):
            return error.localizedRecoverySuggestion
        case .unknownCharacteristic:
            return LocalizedString("确保设备在附近，并且问题应自动解决", comment: "Recovery suggestion for unknown peripheral characteristic")
        default:
            return nil
        }
    }
}
