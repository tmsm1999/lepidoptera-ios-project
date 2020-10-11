//
//  MyObservationsMap.swift
//  Lepidoptera
//
//  Created by Tomás Mamede on 11/10/2020.
//  Copyright © 2020 Tomás Santiago. All rights reserved.
//

import SwiftUI
import UIKit
import MapKit

class ObservationAnnotation: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    var image: UIImage?
    
    init(coordinate: CLLocationCoordinate2D, species: String, image: UIImage, confidence: Double) {
        self.coordinate = coordinate
        self.title = species
        self.subtitle = "Confidence: \(confidence)"
        self.image = image
    }
}

class ObservationAnnotationView: MKAnnotationView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        guard
            let observationAnnotation = self.annotation as? ObservationAnnotation else {
            return
        }
        
        let annotationImage = observationAnnotation.image?.resized(toWidth: 40)
        image = annotationImage
    }
}

///Map view containing the observation location.
struct MyObservationsMap: UIViewRepresentable {
    
    var observationList: [Observation]
    
    func makeUIView(context: UIViewRepresentableContext<MyObservationsMap>) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        uiView.delegate = context.coordinator
        
        for observation in observationList {
            
            let annotation = ObservationAnnotation(
                coordinate: CLLocationCoordinate2D(latitude: observation.latitude, longitude: observation.longitude),
                species: observation.speciesName!,
                image: UIImage(data: observation.image!)!,
                confidence: observation.confidence
            )
            
            uiView.addAnnotation(annotation)
        }
    }
    
    func makeCoordinator() -> MyObservationsMap.Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        var parent: MyObservationsMap
        
        init(parent: MyObservationsMap) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            let annotationView = ObservationAnnotationView(annotation: annotation, reuseIdentifier: "Observation")
            annotationView.canShowCallout = true
            
            return annotationView
        }
    }
}

