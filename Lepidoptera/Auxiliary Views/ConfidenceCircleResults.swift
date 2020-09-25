//
//  ConfidenceCircleResults.swift
//  Lepidoptera
//
//  Created by Tomás Santiago on 15/08/2020.
//  Copyright © 2020 Tomás Santiago. All rights reserved.
//

import SwiftUI

///Circular view that shows the confidence of the observation.
struct ConfidenceCircleResults: View {
    //TODO: Change color depending on the confidence of the observation.
    
    ///Confidence value received to be shown.
    var confidence: Double
    
    ///Controls animation completion.
    @State var show = false
    
    var body: some View {
        
        ZStack {
            Circle()
                .trim(from: show ? (1 - CGFloat(confidence)) : 0.99, to: 1)
                .stroke(Color.green, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .frame(width: 75, height: 75, alignment: .center)
                .rotationEffect(.degrees(90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x:1, y: 0, z: 0))
                .onAppear() {
                    withAnimation(.easeOut(duration: 1.7)) {
                        self.show = true
                    }
            }
            
            Text(String(format: "%.1f", confidence * 100) + "%")
                .fontWeight(.semibold)
                .font(.system(size: 15))
        }
            .padding(10)
    }
}
