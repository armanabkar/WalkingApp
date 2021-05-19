//
//  GraphView.swift
//  WalkingApp
//
//  Created by Arman Abkar on 5/15/21.
//

import SwiftUI

struct GraphView: View {
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter
    }()
    
    let steps: [Step]
    var totalSteps: Int {
        steps.map { $0.count }.reduce(0, +)
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .lastTextBaseline) {
                ForEach(steps, id: \.id) { step in
                    let yValue = Swift.min(step.count / 20, 300)
                    VStack {
                        Text("\(step.count)")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        Rectangle()
                            .fill(step.count > 10000 ? Color.green : Color.red)
                            .frame(width: 20, height: CGFloat(yValue))
                        Text("\(step.date, formatter: Self.dateFormatter)")
                            .bold()
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                }
            }
            Text("Total Steps: \(totalSteps)")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.top, 50)
                .foregroundColor(.white)
                .opacity(0.9)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)))
        .cornerRadius(12)
        .padding()
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        
        let steps = [
            Step(count: 3456, date: Date()),
            Step(count: 123, date: Date()),
            Step(count: 1223, date: Date()),
            Step(count: 5223, date: Date()),
            Step(count: 12023, date: Date())
        ]
        
        GraphView(steps: steps)
    }
}
