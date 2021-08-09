//
//  NearByViewController.swift
//  Toolty
//
//  Created by Suraj on 13/07/21.
//

import UIKit
import GoogleMaps
import CoreLocation

class NearByViewController: ParentViewController,GMSMapViewDelegate{
    
    @IBOutlet weak var lblDate : UILabel!
    @IBOutlet weak var notiAlertView : UIView!
    @IBOutlet weak var mapview: GMSMapView!
    var cellId = "NearByCollectionViewCell"
    
    var mapdata = NearByData()
    var objmap : GetMapContentModel!
    var dataarray = [mapContentCustomers]()
    var uniquearray = [mapContentCustomers]()
    var arra = [LocationnameString]()
    var unreadCount : Int = 0
    var homeData = HomeData()
    var unreadstatus : Int = 0
    var typeStatus = ""
    var typefilter = false
    var visitfilter = false
    var visitStatus = ""
    var currentDate : String{
        let strDate = Date.localDateString(from: Date(), format: "EEEE, MMM d, yyyy")
        return strDate
    }
    var isFilter = false
    var isFilterString:String!
    var markers = GMSMarker()
    var coord = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserLocation.sharedInstance.fetchUserLocationForOnce(controller: self) { [self] (cllocation, nserr) in
            coord = cllocation!.coordinate
            getmapoptions()
            getCoordinates()
        }
        collectionView.isHidden = true
        dataarray.removeAll()
        lblDate.text = currentDate
        self.collectionView.register(UINib(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getNotiCount()
        categoryArray.removeAll()
//        testing pusrose
//        let collr = CLLocationCoordinate2D(latitude:17.575197, longitude: 74.1357403)
//        coord = collr
        getCoordinates()

        
    }
    
    @IBAction func btnNotificationTapped(_ sender: UIButton){
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC
        vc!.modalPresentationStyle = .fullScreen
        vc!.unreadCount = unreadCount
        self.present(vc!, animated: true)
    }
    
    @IBAction func filterView(_ sender: Any) {        
        let storyboard = UIStoryboard(name: "Filter", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FilterViewController") as? FilterViewController
        let label = LabelData.fetchDataFromEntity(predicate: nil, sortDescs: nil)
        for i in label{
            if i.id == "13"{
                vc!.arr.append(i.moduleName)
                vc!.value = i.moduleName
            }
        }
        vc!.modalPresentationStyle = .fullScreen
        vc!.delegate = self
        categoryArray = vc!.arr
        self.present(vc!, animated: true)
    }
    
    //    -> MARK Map Options
    func getRecom(cllocation:CLLocationCoordinate2D) -> [String]{
        var str = [String]()
        let mapOpt = MapsOption.fetchDataFromEntity(predicate: nil, sortDescs: nil)
        for i in mapOpt{
            str.append(i.nearbyTypes)
        }
        return str
    }
    //    --> GET RANDAOM COLOR
    func random() -> UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
    
    //     -> MARK near By Me Api CALLING
    func fetchPlacesNearCoordinate(coordinate: CLLocationCoordinate2D, radius: Double, name : String, color:UIColor){
        var urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=\(_googleApiKey)&location=\(coordinate.latitude),\(coordinate.longitude)&radius=\(radius)&rankby=prominence&sensor=true"
        urlString += "&name=\(name)"
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { [self] (data, res, err) in
            guard let data = data else {return}
            do {
                let json = try! JSONDecoder().decode(locationData.self, from: data)
                DispatchQueue.main.async {
                    let nd = json.results
                    for i in nd{
                        let cord = CLLocationCoordinate2D(latitude: i.geometry.location.lat!, longitude: i.geometry.location.lng!)
                        let markers = GMSMarker()
                        markers.icon = GMSMarker.markerImage(with: color)
                        markers.position = cord
                        markers.map = mapview
                    }
                }
            }
        }.resume()
    }
    
    //    --> CREATE MARKER
    func createMarker(latlng:CLLocationCoordinate2D,color:UIColor,tintcolor:UIColor) {
        let cord = CLLocationCoordinate2D(latitude: latlng.latitude, longitude:latlng.longitude)
        kprint(items: cord)
        markers.icon = GMSMarker.markerImage(with: color)
        markers.position = latlng
        markers.map = mapview
    }
}

extension NearByViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataarray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : NearByCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NearByCollectionViewCell
        let values = dataarray[indexPath.row]
        cell.companyNameLbl.text = values.companyName
        cell.visitcountLbl.text = "0"
        cell.DealcountLbl.text = "\(values.opportunities.count)"
        
        cell.AddressLbl.text = values.address
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let cellwidth = collectionView.frame.width - 80
            let cellheight = collectionView.frame.height-40
            return CGSize(width: cellwidth, height: cellheight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 30)
    }
}


//--> FILTER VALUE DELEGATE CALL
extension NearByViewController:FilterValue{
//    func selectedFilterValue(id: String, name: String, isFilters: Bool) {
//        print(id,name,isFilters)
//        isFilter = isFilters
//        isFilterString = name
//        mapview.clear()
//        getCoordinates()
//    }
    func getFiltervalue(Userinfo: [filterValuesStruct]) {
        for i in Userinfo{
            print(i.DateType!,i.name!,i.value!,i.id!)
            if i.DateType! == "Recommendation"{
                isFilter = true
                isFilterString = i.name!
                mapview.clear()
                getCoordinates()
            }else if i.DateType == "Type"{
                typefilter = true
//                typeStatus = i.id!
                if i.id! == "-0"{
                    dataarray = uniquearray
                }else if i.id! == "1"{
                    dataarray = uniquearray.filter({ (name) -> Bool in
                        name.status.contains("0")
                    })
                }else if i.id! == "2"{
                    dataarray = uniquearray.filter({ (name) -> Bool in
                        name.status.contains("1")
                    })
                }
            }else if i.DateType == "Visits"{
                visitfilter = true
                visitStatus = i.id!
                if i.id! == "-0"{
                    dataarray = uniquearray
                }else{
                    dataarray = uniquearray.filter({ (name) -> Bool in
                        name.status.contains(i.id!)
                    })
                }
            }
        }
        collectionView.reloadData()
    }
}

//--> GET COORDINATE
extension NearByViewController{
    func getCoordinates(){
        mapview.camera = GMSCameraPosition(target: coord, zoom: 15, bearing: 0, viewingAngle: 0)
        mapview.isMyLocationEnabled = true
        mapview.settings.myLocationButton = true
        mapview.delegate = self
        
        let markers = GMSMarker()
        markers.icon = GMSMarker.markerImage(with: .blue)
        markers.position = coord
        markers.map = mapview
        if isFilter{
            if (isFilterString!) == "All"{
                for i in getRecom(cllocation: coord){
                    let data = LocationnameString(color: random(), name: i)
                    arra.append(data)
                }
                for o in arra{
                    fetchPlacesNearCoordinate(coordinate: coord, radius: 5000, name: o.name, color: o.color)
                }
            }else if (isFilterString!) == "None"{
                mapview.clear()
            }else{
                fetchPlacesNearCoordinate(coordinate: coord, radius: 5000, name: isFilterString!, color: random())
            }
        }else{
            for i in getRecom(cllocation: coord){
                let data = LocationnameString(color: random(), name: i)
                arra.append(data)
            }
            for o in arra{
                fetchPlacesNearCoordinate(coordinate: coord, radius: 5000, name: o.name, color: o.color)
            }
        }
    }
    
    func getmapoptions(){
        mapdata.longi = "\(coord.longitude)"
        mapdata.lati = "\(coord.latitude)"
        showHud()
        dataarray.removeAll()
        self.mapdata.getMapOptionOverview {[weak self] (response, obj) in
            guard let weakSelf = self, let data = obj else {return}
            weakSelf.hideHud()
            if response == .success{
                weakSelf.objmap = nil
                weakSelf.objmap = data
                print(data.customers.count)
//                weakSelf.dataarray.append(contentsOf: data.customers)
                weakSelf.uniquearray.append(contentsOf: data.customers)
                weakSelf.dataarray.append(contentsOf: data.customers)
                
                if weakSelf.dataarray.count >= 1{
                    weakSelf.collectionView.isHidden = false
                }else{
                    weakSelf.collectionView.isHidden = true
                }
                DispatchQueue.main.async {
                    weakSelf.collectionView.delegate = self
                    weakSelf.collectionView.dataSource = self
                    weakSelf.collectionView.reloadData()
                }
            }else{
                JTValidationToast.show(message: response.rawValue)
            }
        }
    }
}

extension NearByViewController{
    func getNotiCount(){
        showHud()
        self.homeData.getUnreadNotiCount {[weak self] (response, status, count) in
            guard let weakSelf = self else {return}
            weakSelf.hideHud()
            if response == .success{
                weakSelf.unreadstatus = status
                weakSelf.unreadCount = count
                weakSelf.notiAlertView.isHidden = count == 0 ? true : false
            }else{
                JTValidationToast.show(message: response.rawValue)
            }
        }
    }
}






