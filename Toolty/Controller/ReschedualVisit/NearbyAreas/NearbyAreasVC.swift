//
//  NearbyAreasVC.swift
//  Toolty
//
//  Created by Chirag Patel on 28/07/21.
//

import UIKit
import GoogleMaps
import GooglePlaces

class NearbyAreasVC: ParentViewController {
    @IBOutlet weak var mapView : GMSMapView!
    @IBOutlet weak var tfSearch : UITextField!
    
    var arrNearAreas : [NearPlaces] = []
    var lat : Double = 0.00
    var long : Double = 0.00
    var locationManager = CLLocationManager()
    var markers = GMSMarker()
    var completion : ((NearPlaces) -> ()) = {_ in}
    var completionLatLong : ((_ lat: Double,_ long: Double,_ add: String) -> ()) = {_,_,_ in}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        setupLocationManager()
        setKeyboardNotifications()
        getCoordinates()
        fetchPlacesNearCoordinate(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long), radius: 500, name: "", color: #colorLiteral(red: 0.1411764706, green: 0.2980392157, blue: 0.631372549, alpha: 1))
    }
}

//MARK:- Others Methods
extension NearbyAreasVC {
    func prepareUI(){
        tableView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 10, right: 0)
    }
    
    @IBAction func btnSearchTapped(_ sender: UIButton){
        tfSearch.becomeFirstResponder()
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        present(acController, animated: true, completion: nil)
        
    }
}

//MARK:- Google Map Methods
extension NearbyAreasVC : CLLocationManagerDelegate,GMSMapViewDelegate{
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getCoordinates(){
        mapView.camera = GMSCameraPosition(latitude: lat, longitude: long, zoom: 15)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.delegate = self
        let markers = GMSMarker()
        markers.icon = GMSMarker.markerImage(with: .blue)
        markers.position = CLLocationCoordinate2DMake(lat, long)
        markers.map = mapView
    }
    
    func createMarker(latlng:CLLocationCoordinate2D,color:UIColor,tintcolor:UIColor) {
        let cord = CLLocationCoordinate2D(latitude: latlng.latitude, longitude:latlng.longitude)
        kprint(items: cord)
        markers.icon = GMSMarker.markerImage(with: color)
        markers.position = latlng
        markers.map = mapView
    }
}

//MARK:- TableView Delegate & DataSource Methods
extension NearbyAreasVC{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNearAreas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AreasTblCell
        
        cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! AreasTblCell
        cell.prepareCell(data: arrNearAreas[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objData = arrNearAreas[indexPath.row]
        self.completion(objData)
        self.navigationController?.popViewController(animated: true)
    }
}


//MARK:- NearBy Places API Methods
extension NearbyAreasVC{
    func fetchPlacesNearCoordinate(coordinate: CLLocationCoordinate2D, radius: Double, name : String, color:UIColor){
        showHud()
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=\(_googleApiKey)&location=\(coordinate.latitude),\(coordinate.longitude)&radius=\(radius)&types=All&sensor=true"
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { [weak self] (data, res, err) in
            guard let data = data, let weakSelf = self else {return}
            do {
                weakSelf.hideHud()
                let json = try! JSONDecoder().decode(locationData.self, from: data)
                DispatchQueue.main.async {
                    let result = json.results
                    for i in result{
                        let cord = CLLocationCoordinate2D(latitude: i.geometry.location.lat!, longitude: i.geometry.location.lng!)
                        let markers = GMSMarker()
                        markers.icon = GMSMarker.markerImage(with: color)
                        markers.position = cord
                        markers.map = weakSelf.mapView
                    }
                }
                if let dict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary{
                    if let result = dict["results"] as? [NSDictionary]{
                        for dictData in result{
                            let objData = NearPlaces(dict: dictData)
                            weakSelf.arrNearAreas.append(objData)
                        }
                    }
                    DispatchQueue.main.async {
                        weakSelf.tableView.reloadData()
                    }
                }
            }catch{
                print(err!.localizedDescription)
            }
        }.resume()
    }
}

//MARK:- GMSAutocompleteViewControllerDelegate Methods
extension NearbyAreasVC : GMSAutocompleteViewControllerDelegate{
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        tfSearch.resignFirstResponder()
        tfSearch.text = place.name
        dismiss(animated: true, completion: nil)
        completionLatLong(place.coordinate.latitude, place.coordinate.longitude, place.name!)
        self.navigationController?.popViewController(animated: true)
        
        
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // Handle the error
        print("Error: ", error.localizedDescription)
    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        // Dismiss when the user canceled the action
        dismiss(animated: true, completion: nil)
    }
}
