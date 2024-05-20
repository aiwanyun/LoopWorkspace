//
//  AlgorithmError.swift
//  G7SensorKit
//
//  Created by Pete Schwamb on 11/11/22.
//

import Foundation

enum AlgorithmError: Error {
    case unreliableState(AlgorithmState)
}

extension AlgorithmError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unreliableState:
            return LocalizedString("血糖数据不可用", comment: "Error description for unreliable state")
        }
    }

    var failureReason: String? {
        switch self {
        case .unreliableState(let state):
            return state.localizedDescription
        }
    }
}


extension AlgorithmState {
    public var localizedDescription: String {
        switch self {
        case .known(let state):
            switch state {
            case .ok:
                return LocalizedString("传感器还可以", comment: "The description of sensor algorithm state when sensor is ok.")
            case .stopped:
                return LocalizedString("传感器停止", comment: "The description of sensor algorithm state when sensor is stopped.")
            case .warmup, .questionMarks:
                return LocalizedString("传感器正在预热", comment: "The description of sensor algorithm state when sensor is warming up.")
            case .expired:
                return LocalizedString("传感器过期", comment: "The description of sensor algorithm state when sensor is expired.")
            case .sensorFailed:
                return LocalizedString("传感器失败", comment: "The description of sensor algorithm state when sensor failed.")
            }
        case .unknown(let rawValue):
            return String(format: LocalizedString("Sensor is in unknown state %1$d", comment: "The description of sensor algorithm state when raw value is unknown. (1: missing data details)"), rawValue)
        }
    }
}
