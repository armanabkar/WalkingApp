//
//  Step.swift
//  WalkingApp
//
//  Created by Arman Abkar on 5/15/21.
//

import Foundation

struct Step: Identifiable {
    
    let id = UUID()
    let count: Int
    let date: Date
}
