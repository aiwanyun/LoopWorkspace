//
//  G7ProgressBarState.swift
//  G7SensorKitUI
//
//  Created by Pete Schwamb on 11/22/22.
//

import Foundation

enum G7ProgressBarState {
    case warmupProgress
    case lifetimeRemaining
    case gracePeriodRemaining
    case sensorFailed
    case sensorExpired
    case searchingForSensor

    var label: String {
        switch self {
        case .searchingForSensor:
            return LocalizedString("搜索传感器", comment: "G7 Progress bar label when searching for sensor")
        case .sensorExpired:
            return LocalizedString("传感器过期", comment: "G7 Progress bar label when sensor expired")
        case .warmupProgress:
            return LocalizedString("预热完成", comment: "G7 Progress bar label when sensor in warmup")
        case .sensorFailed:
            return LocalizedString("传感器失败", comment: "G7 Progress bar label when sensor failed")
        case .lifetimeRemaining:
            return LocalizedString("传感器到期", comment: "G7 Progress bar label when sensor lifetime progress showing")
        case .gracePeriodRemaining:
            return LocalizedString("宽限期剩下", comment: "G7 Progress bar label when sensor grace period progress showing")
        }
    }

    var labelColor: ColorStyle {
        switch self {
        case .sensorExpired:
            return .critical
        default:
            return .normal
        }
    }
}
