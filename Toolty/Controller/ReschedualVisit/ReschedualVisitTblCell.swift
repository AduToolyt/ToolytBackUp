//
//  ReschedualVisitTblCell.swift
//  Toolty
//
//  Created by Chirag Patel on 23/07/21.
//

import UIKit
import FSCalendar
import GoogleMaps


class ReschedualVisitTblCell: UITableViewCell {
    @IBOutlet weak var timeCollView : UICollectionView!
    @IBOutlet weak var addNameCollView : UICollectionView!
    @IBOutlet weak var lblAssignName : UILabel!
    @IBOutlet weak var assignView : UIView!
    @IBOutlet weak var rightView : UIView!
    @IBOutlet weak var calender : FSCalendar!
    @IBOutlet weak var mapView : GMSMapView!
    @IBOutlet weak var lblAddress : UILabel!
    @IBOutlet weak var btnAM : UIButton!
    @IBOutlet weak var btnPM : UIButton!
    
    
    var locationManager = CLLocationManager()
    weak var parent : ReschedualVisitVC!
    var markers = GMSMarker()
    var placesLat : Double = 0.00
    var placesLong : Double = 0.00
    var slotCount : Int = 0
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    func prepareView(){
        assignView.roundCorners(corners: [.topLeft], radius: 10)
        rightView.roundCorners(corners: [.topRight], radius: 10)
    }
    
}

//MARK:- Calender Delegate Methods
extension ReschedualVisitTblCell : FSCalendarDelegate,FSCalendarDataSource{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        parent.arrSlots = []
        parent.reschedualData.date = self.dateFormatter.string(from: date)
        parent.getTime()
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }
}


//MARK:- CollectionView Delegate & DataSource Methods
extension ReschedualVisitTblCell : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == timeCollView{
            return parent.arrSlots.count
        }else{
            return parent.arrAlongData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == timeCollView{
            let cell : TimeCollCell
            cell = timeCollView.dequeueReusableCell(withReuseIdentifier: "timcell", for: indexPath) as! TimeCollCell
            cell.prepareCell(data: parent.arrSlots[indexPath.row])
            return cell
        }else{
            let cell : AddNameCollCell
            cell = addNameCollView.dequeueReusableCell(withReuseIdentifier: "addcell", for: indexPath) as! AddNameCollCell
            cell.lblName.text = parent.arrAlongData[indexPath.row].names
            cell.lblName.preferredMaxLayoutWidth = collectionView.frame.width - 32
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == timeCollView{
            let objData = parent.arrSlots[indexPath.row]
            slotCount = slotCount + 1
            parent.reschedualData.totalSlot = "\(slotCount)"
            parent.reschedualData.time = objData.timeStr
            setSelectedIdx(idx: indexPath.row)
        }
    }
    
    func setSelectedIdx(idx: Int){
        for (index, data) in parent.arrSlots.enumerated(){
            if idx == index{
                data.isSelected = true
            }else{
                data.isSelected = false
            }
        }
        timeCollView.reloadData()
    }
}

//MARK:- CollectionView Delegate Flow Layout Methods
extension ReschedualVisitTblCell : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == timeCollView{
            let objData = parent.arrSlots[indexPath.row]
            if objData.isSelected{
                let collHeight = 25.widthRatio
                let collWidth = collHeight * 4
                return CGSize(width: collWidth, height: collHeight)
            }else{
                let collHeight = 25.widthRatio
                let collWidth = collHeight * 2.4
                return CGSize(width: collWidth, height: collHeight)
            }
        }else{
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
}

//MARK:- Change Time
extension ReschedualVisitTblCell{
    @IBAction func btnAMPMTapped(_ sender: UIButton){
        btnAM.isSelected = !btnPM.isSelected
        btnPM.isSelected = !btnAM.isSelected
        if sender.tag == 0{
            parent.reschedualData.isFromVC = true
            parent.reschedualData.strTimeStatus = "am"
            parent.getTime()
            self.timeCollView.reloadData()
        }else{
            parent.reschedualData.isFromVC = true
            parent.reschedualData.strTimeStatus = "pm"
            parent.getTime()
            self.timeCollView.reloadData()
        }
    }
}

//MARK:- Google Maps Methods
extension ReschedualVisitTblCell : CLLocationManagerDelegate,GMSMapViewDelegate{
    @IBAction func btnViewNearAreasTapped(_ sender : UIButton){
        self.parent.performSegue(withIdentifier: "nearby", sender: (getCurrentLocation().lat,getCurrentLocation().long))
    }
    
    @IBAction func switchValueChanged(_ toggle: UISwitch){
        if !toggle.isOn{
            self.parent.performSegue(withIdentifier: "nearby", sender: (getCurrentLocation().lat,getCurrentLocation().long))
        }
    }
    
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getCurrentLocation() -> (lat : Double, long: Double){
        var getLatLong = (lat : 0.0, long: 0.0)
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways{
            if let currLocation = locationManager.location{
                getLatLong.lat = currLocation.coordinate.latitude
                getLatLong.long = currLocation.coordinate.longitude
            }
        }
        return getLatLong
    }
    
    func getCoordinates(){
        if let latLongPlaces = parent.places, let location = latLongPlaces.geoMetryLocation{
            placesLat = location.lat
            placesLong = location.long
            lblAddress.text = latLongPlaces.detailedAddress
            parent.reschedualData.address = latLongPlaces.detailedAddress
        }
        
        if parent.isFromGooglePlace{
            lblAddress.text = parent.address
            mapView.camera = GMSCameraPosition(latitude: parent.placeLat, longitude: parent.placeLong, zoom: 15)
        }else{
            mapView.camera = GMSCameraPosition(latitude: parent.isFromPlaces ? placesLat : getCurrentLocation().lat, longitude: parent.isFromPlaces ? placesLong : getCurrentLocation().long, zoom: 15)
        }
        //mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        let markers = GMSMarker()
        markers.icon = GMSMarker.markerImage(with: .blue)
        if parent.isFromGooglePlace{
            markers.position = CLLocationCoordinate2DMake(parent.placeLat, parent.placeLong)
            
        }else{
            markers.position = CLLocationCoordinate2DMake(parent.isFromPlaces ? placesLat : getCurrentLocation().lat, parent.isFromPlaces ? placesLong : getCurrentLocation().long)
        }
        markers.map = mapView
    }
    
    func createMarker(latlng:CLLocationCoordinate2D,color:UIColor,tintcolor:UIColor) {
        //        markers.icon = GMSMarker.markerImage(with: color)
        markers.position = latlng
        markers.map = mapView
    }
}
