//
//  ClassificationDetails.swift
//  Lepidoptera
//
//  Created by Tomás Santiago on 14/08/2020.
//  Copyright © 2020 Tomás Santiago. All rights reserved.
//

import SwiftUI
import MapKit

///Model view that is used to present an observation.
///This show a circular image, map view with the location of the image.
///Also it includes buttons to show details, add to favorites and delete a view.
struct ObservationDetails: View {
    
    @EnvironmentObject var records: ObservationRecords
    
    ///Informs the parent view if the model view is being shown or not.
    @Binding var dismissModalView: Bool
    ///Current observation being shown.
    var observation: Observation
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ScrollView(.vertical, showsIndicators: true) {
                
                VStack {
                    
                    ZStack {
                        
                        MapView(observationCoordinates: observation.location)
                            .frame(width: geometry.size.width, height: geometry.size.height / 3, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .edgesIgnoringSafeArea(.top)
                        
                        
                        ObservationImage(image: observation.image)
                            .frame(width: geometry.size.height / 4.3, height: geometry.size.height / 4.3, alignment: .center)
                            .offset(x: 0, y: geometry.size.height / 4.7)
                    }
                    
                    HStack() {

                        VStack(alignment: .leading) {
                            Text(self.observation.speciesName)
                                .font(.system(size: geometry.size.height / 17, weight: .semibold))

                            Text(self.observation.date.description)
                                .font(.system(size: geometry.size.height / 45, weight: .medium))
                        }
                        .padding(.leading, 10)

                        Spacer()

                        ConfidenceCircleResults(confidence: self.observation.classificationConfidence)
                            .frame(width: geometry.size.width / 4.2, height: geometry.size.width / 4.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding(.trailing, 10)

                    }
                    .frame(width: geometry.size.width)
                    .padding(.top, geometry.size.height / 6)
                    
                    Spacer()
                }
                
                ObservationActionButtons(dismissModalView: self.$dismissModalView, observation: self.observation)
                                            .offset(x: 0, y: 20)
                                            .environmentObject(self.records)
                
                //Spacer()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}