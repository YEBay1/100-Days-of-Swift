//
//  ViewController.swift
//  Project16
//
//  Created by Yunus Emre Bayezit on 24.09.2022.
//

import UIKit
import MapKit
import WebKit

class ViewController: UIViewController, MKMapViewDelegate, WKNavigationDelegate {

    @IBOutlet var mapView: MKMapView!
    var webView: WKWebView!
    
    var websites = ["wikipedia.org"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")

        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
        let ac = UIAlertController(title: "Map Type", message: "Please select Map Type", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Standart", style: .default){ [self]_ in
            mapView.mapType = .standard
        })
        ac.addAction(UIAlertAction(title: "Satellite", style: .default){ [self]_ in
            mapView.mapType = .satellite
        })
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default){ [self]_ in
            mapView.mapType = .hybrid
        })
        ac.addAction(UIAlertAction(title: "Satellite Flyover", style: .default){ [self]_ in
            mapView.mapType = .satelliteFlyover
        })
        
        present(ac, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard annotation is Capital else { return nil }

        let identifier = "Capital"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        //var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKPinAnnotationView)
        //annotationView.pinTintColor = UIColor.yellow
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true

            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        }
        
        else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
        let placeInfo = capital.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        ac.addAction(UIAlertAction(title: "Go to the Wikipedia", style: .default){ [self]_ in
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
                vc.selectedSite = capital.title ?? "London"
                navigationController?.pushViewController(vc, animated: true)
        }
        })
        present(ac, animated: true)
    }
}
