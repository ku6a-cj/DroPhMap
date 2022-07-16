//
//  MapView.swift
//  FirstAppV63
//
//  Created by Jakub Chodara on 15/07/2022.
//

import Foundation
import MapKit
import SwiftUI
import UIKit



struct MapView: UIViewRepresentable {
    typealias UIViewType = UIView
    
    var coordinate: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        
        //let coordinate = CLLocationCoordinate2D(latitude: 52.2531871, longitude: 20.9006214)
        
        let map = MKMapView()
        
        map.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07)),
                      animated: true)
        
        view.addSubview(map)
        
        map.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            map.widthAnchor.constraint(equalTo: view.widthAnchor),
            map.heightAnchor.constraint(equalTo: view.heightAnchor),
            map.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            map.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        map.addAnnotation(pin)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        //do nothing
    }
    
    
    
    
    
    
}
