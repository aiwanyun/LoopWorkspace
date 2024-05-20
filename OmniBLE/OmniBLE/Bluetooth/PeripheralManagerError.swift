//
//  PeripheralManagerErrors.swift
//  OmniBLE
//
//  Created by Randall Knutson on 8/18/21.
//  Copyright © 2021 LoopKit Authors. All rights reserved.
//

import Foundation

enum PeripheralManagerError: Error {
    case cbPeripheralError(Error)
    case notReady
    case incorrectResponse
    case timeout([PeripheralManager.CommandCondition])
    case emptyValue
    case unknownCharacteristic
    case nack
}

extension PeripheralManagerError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .cbPeripheralError(let error):
            return error.localizedDescription
        case .notReady:
            return LocalizedString("外围没有准备就绪", comment: "Error message description for PeripheralManagerError.notReady")
        case .incorrectResponse:
            return LocalizedString("不正确的响应", comment: "Error message description for PeripheralManagerError.incorrectResponse")
        case .timeout:
            return LocalizedString("暂停", comment: "Error message description for PeripheralManagerError.timeout")
        case .emptyValue:
            return LocalizedString("空值", comment: "Error message description for PeripheralManagerError.emptyValue")
        case .unknownCharacteristic:
            return LocalizedString("未知的特征", comment: "Error message description for PeripheralManagerError.unknownCharacteristic")
        case .nack:
            return LocalizedString("纳克", comment: "Error message description for PeripheralManagerError.nack")
        }
    }
}
