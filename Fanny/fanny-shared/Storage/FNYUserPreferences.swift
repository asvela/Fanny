//
//  FNYUserPreferences.swift
//  Fanny
//
//  Created by Daniel Storm on 9/21/19.
//  Copyright © 2019 Daniel Storm. All rights reserved.
//

import Foundation

typealias MonitorRefreshTimeIntervalOption = (index: Int, title: String, timeInterval: TimeInterval)
typealias TemperatureUnitOption = (index: Int, title: String, suffix: String)

class FNYUserPreferences {
    
    static let monitorRefreshTimeIntervalOptions: [MonitorRefreshTimeIntervalOption] = {
        return [defaultMonitorRefreshTimeIntervalOption,
                (1, "5 seconds", 5.0),
                (2, "10 seconds", 10.0),
                (3, "15 seconds", 15.0),
                (4, "30 seconds", 30.0),
                (5, "60 seconds", 60.0)]
    }()
    
    static let temperatureUnitOptions: [TemperatureUnitOption] = {
        return [defaultTemperatureUnitOption,
                (1, "Fahrenheit (°F)", "°F"),
                (2, "Kelvin (°K)", "°K")]
    }()
    
    private static let defaultMonitorRefreshTimeIntervalOption: MonitorRefreshTimeIntervalOption = (0, "3 seconds", 3.0)
    private static let defaultTemperatureUnitOption: TemperatureUnitOption = (0, "Celsius (°C)", "°C")
    
    private static let sharedDefaultsSuiteName: String = "fanny-shared-defaults"
    private static let sharedDefaults: UserDefaults = UserDefaults(suiteName: FNYUserPreferences.sharedDefaultsSuiteName)!
    
    // MARK: - Refresh Interval
    static func save(monitorRefreshTimeIntervalOption: MonitorRefreshTimeIntervalOption) {
        sharedDefaults.set(monitorRefreshTimeIntervalOption.index, forKey: FNYUserPreferencesKey.monitorRefreshTimeIntervalOption.stringValue)
    }
    
    static func monitorRefreshTimeIntervalOption() -> MonitorRefreshTimeIntervalOption {
        let savedIndex: Int = sharedDefaults.integer(forKey: FNYUserPreferencesKey.monitorRefreshTimeIntervalOption.stringValue)
        return monitorRefreshTimeIntervalOptions.first(where: { $0.index == savedIndex }) ?? defaultMonitorRefreshTimeIntervalOption
    }
    
    // MARK: - Temperature
    static func save(temperatureUnitOption: TemperatureUnitOption) {
        sharedDefaults.set(temperatureUnitOption.index, forKey: FNYUserPreferencesKey.temperatureUnitOption.stringValue)
    }
    
    static func temperatureUnitOption() -> TemperatureUnitOption {
        let savedIndex: Int = sharedDefaults.integer(forKey: FNYUserPreferencesKey.temperatureUnitOption.stringValue)
        return temperatureUnitOptions.first(where: { $0.index == savedIndex }) ?? defaultTemperatureUnitOption
    }
    
}

// MARK: - FNYUserPreferencesKey
private enum FNYUserPreferencesKey {
    
    case monitorRefreshTimeIntervalOption
    case temperatureUnitOption
    
    var stringValue: String {
        switch self {
        case .monitorRefreshTimeIntervalOption: return "FNYUserPreferencesKey_MonitorRefreshTimeIntervalOption"
        case .temperatureUnitOption: return "FNYUserPreferencesKey_TemperatureUnitOption"
        }
    }
    
}
