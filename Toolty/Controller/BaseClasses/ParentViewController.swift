//
//  ParentViewController.swift
//  Gradex
//
//  Created by Multipz Technology on 11/06/21.
//

import UIKit
import CoreLocation
import MapKit
import NotificationCenter
import FSCalendar


class ParentViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate{
    
    // MARK: - Outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var horizontalConstraints: [NSLayoutConstraint]?
    @IBOutlet var verticalConstraints: [NSLayoutConstraint]?
    @IBOutlet weak var MapAddress : MKMapView!
    var pageControl: JTPageControl!
    @IBOutlet weak var pagerView: UIView!
    @IBOutlet weak var calendarview:FSCalendar!

    
    let annotation = MKPointAnnotation()
    let regionRadius: CLLocationDistance = 1000
    var userLocation: CLLocation?
    var lattitude =  ""
    var longitude = ""
    var getAddress = ""
    var userLocationAddress = ""
    
    
    var actInd:UIActivityIndicatorView!
    var blurEffectView = UIView()
    let refresh = UIRefreshControl()

    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    
    // MARK: - Actions
    @IBAction func parentBackAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func parentBackActionAnim(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func parentDismissAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - iOS Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        constraintUpdate()
        setDefaultUI()
        kprint(items: "Allocated: \(self.classForCoder)")
    }
    
    func getNoDataCell(){
        tableView.register(UINib(nibName: "NoDataTableCell", bundle: nil), forCellReuseIdentifier: "noDataCell")
    }
    
    func getCollNoDataCell(){
        collectionView.register(UINib(nibName: "EmptyCollCell", bundle: nil), forCellWithReuseIdentifier: "noDataCell")
    }
    
//    --> ADD   CHILD VIEW ON VIEW CONTROLLER
    func add(asChildViewController viewController: UIViewController,vi:UIView) {
        addChild(viewController)
        vi.isHidden = false
        vi.addSubview(viewController.view)
        viewController.view.frame = vi.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    //    --> REMOVE   CHILD VIEW ON VIEW CONTROLLER
    func remove_ViewController(viewController:UIViewController?,vi:UIView) {
        if viewController != nil {
            if vi.subviews.contains(viewController!.view) {
                viewController!.view.removeFromSuperview()
            }
        }
    }
    
    deinit{
        _defaultCenter.removeObserver(self)
        kprint(items: "Deallocated: \(self.classForCoder)")
//        categoryArray.removeAll()
//        filterArray.removeAll()
    }
    
    // Set Default UI
    func setDefaultUI() {
        actInd = UIActivityIndicatorView(style:.whiteLarge)
        actInd.center = view.center;
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        tableView?.scrollsToTop = true
        tableView?.tableFooterView = UIView()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    // This will update constaints and shrunk it as device screen goes lower.
    func constraintUpdate() {
        if let hConts = horizontalConstraints {
            for const in hConts {
                let v1 = const.constant
                let v2 = v1 * _widthRatio
                const.constant = v2
            }
        }
        if let vConst = verticalConstraints {
            for const in vConst {
                let v1 = const.constant
                let v2 = v1 * _heightRatio
                const.constant = v2
            }
        }
    }
}

extension ParentViewController {
    
    func showHud() -> () {
        
        blurEffectView.frame = .init(x: 0, y: 0, width: 80, height: 80)
        blurEffectView.center = view.center
        blurEffectView.backgroundColor = UIColor(white:0, alpha:0.6)
        blurEffectView.layer.cornerRadius = 5
        self.blurEffectView.alpha = 1
        view.addSubview(blurEffectView)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        blurEffectView.addSubview(actInd)
        actInd.frame.origin = CGPoint(x:(blurEffectView.frame.width / 2) - (actInd.frame.width / 2) , y: (blurEffectView.frame.height / 2) - (actInd.frame.height / 2))
        actInd.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    func hideHud() -> (){
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            UIView.animate(withDuration:0.2, animations: {
                self.blurEffectView.alpha = 0
            }, completion: { (done) in
                self.actInd.stopAnimating()
                self.blurEffectView.removeFromSuperview()
            })
            self.view.isUserInteractionEnabled = true
        }
    }
    
}

extension ParentViewController{
    
    func setKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let kbSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height + 10, right: 0)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        tableView.contentInset = UIEdgeInsets(top:0, left: 0, bottom: 0, right: 0)
    }
}

extension ParentViewController:FSCalendarDelegate,FSCalendarDataSource{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
       print("did select date \(self.dateFormatter.string(from: date))")
       let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
       print("selected dates is \(selectedDates)")
       if monthPosition == .next || monthPosition == .previous {
           calendar.setCurrentPage(date, animated: true)
       }
   }

    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
       print("\(self.dateFormatter.string(from: calendar.currentPage))")
   }
}

//MARK: - TableView
extension ParentViewController{
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}

extension ParentViewController {
    func prepareMapView()  {
        MapAddress.delegate = self
        MapAddress.mapType = .standard
        MapAddress.isZoomEnabled = true
        MapAddress.isScrollEnabled = true
        self.MapAddress.showsUserLocation = true
        if let coor = MapAddress.userLocation.location?.coordinate{
            MapAddress.setCenter(coor, animated: true)
        }
    }
    
    func getUserCurrLocation(isBool: Bool) {
        weak var controller: UIViewController! = self
        UserLocation.sharedInstance.fetchUserLocationForOnce(controller: controller) { [self] (location, error) in
            if let _ = location {
                let lat = location!.coordinate.latitude
                let long = location!.coordinate.longitude
                self.userLocation = CLLocation(latitude: lat, longitude: long)
                
                if let loc = self.userLocation {
                    self.lattitude = "\(loc.coordinate.latitude)"
                    self.longitude = "\(loc.coordinate.longitude)"
                    if isBool {
                        self.addressFromLocationOfLatLong(location: self.userLocation!)
                        self.setMapResion(lat: location!.coordinate.latitude, long: location!.coordinate.longitude)
                        self.prepareMap(location: self.userLocation!)
                        self.prepareMapView()
                    }
                }
            } else {
            }
        }
    }

    
    func addressFromLocationOfLatLong(location: CLLocation) {
        print(location)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
                
            }
            let placemark = placemarks! as [CLPlacemark]
            if placemark.count>0{
                let placemark = placemarks![0]
                let strAddress = " \(placemark.subLocality!), \(placemark.locality!), \(placemark.administrativeArea!), \(placemark.country!), \(placemark.postalCode!)"
                self.userLocationAddress = strAddress
               // let loginFrm = "YourAddressTxt".localized()
               // self.getAddress(strAddres:"\(loginFrm) + \n + \(strAddress)")
                self.getAddress(strAddres: strAddress)
            }
        }
    }
    
    func getAddress(strAddres :String)  {
        getAddress = strAddres
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        annotationView?.image = #imageLiteral(resourceName: "ic_map_pin")
        return annotationView
    }
    
    /// Set resion on map with selected loaction
    func setMapResion(lat: Double, long: Double){
        var loc = CLLocationCoordinate2D()
        loc.latitude = lat
        loc.longitude = long
        
        var span = MKCoordinateSpan()
        span.latitudeDelta = 0.05
        span.longitudeDelta = 0.05
        
        var myResion = MKCoordinateRegion()
        myResion.center = loc
        myResion.span = span
        self.MapAddress.setRegion(myResion, animated: true)
    }
    
   
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        self.MapAddress.setRegion(coordinateRegion, animated: true)
        self.MapAddress.addAnnotation(annotation)
    }
    func prepareMap(location: CLLocation) {
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        centerMapOnLocation(location: location)
    }
    
}


extension ParentViewController {
    func setUpPageControl() {
        pageControl = JTPageControl(frame: CGRect(x: 0, y: 0, width: 75.0, height: 37.0))
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pagerView.addSubview(pageControl)
        
        pageControl.centerXAnchor.constraint(equalTo: pagerView.centerXAnchor).isActive = true
        pageControl.centerYAnchor.constraint(equalTo: pagerView.centerYAnchor).isActive = true
        
        pageControl.cornerRadius = 5
        pageControl.dotHeight = 10
        pageControl.dotSpace = 5
        pageControl.currentDotWidth = 10
        pageControl.otherDotWidth = 10
        pageControl.otherDotColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
        pageControl.currentDotColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pageControl.numberOfPages = 2
    }
    
    
    func registerPushNotification(){
        let authOption : UNAuthorizationOptions = [.alert,.badge,.sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOption) { (granted, error) in
            kprint(items: "Notification Access : \(granted)")
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
}
