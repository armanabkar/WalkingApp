//
//  ContentView.swift
//  WalkingApp
//
//  Created by Arman Abkar on 5/15/21.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    
    private var healthStore: HealthStore?
    @State private var steps: [Step] = [Step]()
    
    init() {
        healthStore = HealthStore()
    }
    
    private func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            let step = Step(count: Int(count ?? 0), date: statistics.startDate)
            steps.append(step)
        }
    }
    
    var body: some View {
        TabView {
            VStack(alignment: .leading) {
                Text("Just Walking!")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                List(steps, id: \.id) { step in
                    VStack(alignment: .leading) {
                        Text("\(step.count)")
                        Text(step.date, style: .date)
                            .opacity(0.5)
                    }
                }
            }
            .tabItem {
                Image(systemName: "table.fill")
                Text("Table")
            }
            
            GraphView(steps: steps)
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Chart")
                }
            
        }
        .onAppear {
            if let healthStore = healthStore {
                healthStore.requestAuthorization { success in
                    if success {
                        healthStore.calculateSteps { statisticsCollection in
                            if let statisticsCollection = statisticsCollection {
                                updateUIFromStatistics(statisticsCollection)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
