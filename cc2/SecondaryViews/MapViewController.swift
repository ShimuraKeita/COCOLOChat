//
//  MapViewController.swift
//  cc2
//
//  Created by 志村　啓太 on 2021/02/16.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    //MARK: - Vars
    var location: CLLocation?
    var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTitle()
        configureMapView()
        configureLeftBarButton()
    }
    
    //MARK: - Configurations
    private func configureMapView() {
        
        mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        mapView.showsUserLocation = true
        
        if location != nil {
            mapView.setCenter(location!.coordinate, animated: false)
            //add annotation
        }
        
        view.addSubview(mapView)
    }
    
    private func configureLeftBarButton() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonPressed))
    }
    
    private func configureTitle() {
        
        self.title = "マップ"
    }
    
    //MARK: - Actions
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}
