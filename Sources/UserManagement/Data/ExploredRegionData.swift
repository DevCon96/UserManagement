//
//  File.swift
//  
//
//  Created by Connor Jones on 07/11/2022.
//

import Foundation
import CoreLocation

struct ExploredRegionData {
    var regionBounds: CLRegion?
    var exploredRegions: [CLRegion] = []
    var hotSpots: [CLRegion] = []
    
    init(regionBounds: CLRegion? = nil, exploredRegions: [CLRegion]? = nil , hotspots: [CLRegion]? = nil) {
        self.regionBounds = regionBounds
        
        if let exploredRegions { self.exploredRegions = exploredRegions }
        if let hotspots { self.hotSpots = hotspots }
    }
}

struct ExploredRegionTotals {
    var maxRegionSpan: Double? // Max bound distance of region that contains all locations
    var totalDistanceExplored: Double?
    var journeyTotal: Int?
    
    init(maxRegionSpan: Double? = nil, totalDistanceExplored: Double? = nil, journeyTotal: Int? = nil) {
        self.maxRegionSpan = maxRegionSpan
        self.totalDistanceExplored = totalDistanceExplored
        self.journeyTotal = journeyTotal
    }
}
