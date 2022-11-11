//
//  HealthData.swift
//  
//
//  Created by Connor Jones on 06/11/2022.
//

import Foundation

enum MeasurementUnit {
    case metric
    case imperial
}

struct HealthState {
    var restingHR: HeartRateData?
    var walkingHR: HeartRateData?
    var activityHR: HeartRateData?
    
    var weight: Double?
    var height: Double?
    var bmi: Double? {
        get {
            guard let weight, let height else { return nil }
            let heightSquared = pow(height, 2)
            return (weight / heightSquared)
        } set {}
    }
    
    var hasChronicCondition: Bool = false
    var mesurmentUnit: MeasurementUnit = .metric
    
    init(restingHR: HeartRateData? = nil, walkingHR: HeartRateData? = nil, activityHR: HeartRateData? = nil, weight: Double? = nil, height: Double? = nil, bmi: Double? = nil, hasChronicCondition: Bool, mesurmentUnit: MeasurementUnit) {
        self.restingHR = restingHR
        self.walkingHR = walkingHR
        self.activityHR = activityHR
        self.weight = weight
        self.height = height
        self.bmi = bmi
        self.hasChronicCondition = hasChronicCondition
        self.mesurmentUnit = mesurmentUnit
    }
}

struct HeartRateData {
    var averageHR: Int?
    var maxHR: Int?
    var minHR: Int?
    
    init(averageHR: Int? = nil, maxHR: Int? = nil, minHR: Int? = nil) {
        self.averageHR = averageHR
        self.maxHR = maxHR
        self.minHR = minHR
    }
}
