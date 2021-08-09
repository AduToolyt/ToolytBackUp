//
//  RevenuGraphViewController.swift
//  Toolty
//
//  Created by Suraj on 21/07/21.
//

import UIKit
import Charts

class RevenuGraphViewController: UIViewController {
    var InsightData = insightData()
    var objData : RevenuchartModel!
    var lbl = String()
    var dataEntries: [ChartDataEntry] = []
    
    @IBOutlet var barChartViewOutlet: BarChartView!
    
    var months = [String]()
    var unitsSold = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//         unitsSold = [30.0, 31.0, 32.0, 33.0, 34.0, 35.0, 36.0]
//         months = ["Jan" , "Feb", "Mar", "Apr", "May", "June", "July"]
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        callHomeData()
        
        
    }
}
//--> API CALLING FOR REVENU 
extension RevenuGraphViewController{
    func callHomeData(){
        self.InsightData.id = graphID
        self.InsightData.getRevenu{[weak self] (response, obj) in
            guard let weakSelf = self, let data = obj else {return}
            //            weakSelf.hideHud()
            if response == .success{
                weakSelf.objData = nil
                weakSelf.objData = data
                for i in data.revenu{
                    print(weakSelf.transformStringDate(i.date, fromDateFormat: "yyyy-MM-dd", toDateFormat: "MMM dd")!)
                    weakSelf.months.append(weakSelf.transformStringDate(i.date, fromDateFormat: "yyyy-MM-dd", toDateFormat: "MMM dd")!)
                    weakSelf.unitsSold.append(Double(i.revenu))
                }
                
                weakSelf.setChart(dataPoints: weakSelf.months, values: weakSelf.unitsSold, lable: data.graphName)
            }else{
                //                JTValidationToast.show(message: response.rawValue)
            }
        }
        
    }
    
    func transformStringDate(_ dateString: String,
                             fromDateFormat: String,
                             toDateFormat: String) -> String? {

        let initalFormatter = DateFormatter()
        initalFormatter.dateFormat = fromDateFormat
        guard let initialDate = initalFormatter.date(from: dateString) else {
            print ("Error in dateString or in fromDateFormat")
            return nil
        }

        let resultFormatter = DateFormatter()
        resultFormatter.dateFormat = toDateFormat

        return resultFormatter.string(from: initialDate)
    }
    
}

// --> SET DATA TO CHART
extension RevenuGraphViewController{
    func setChart(dataPoints: [String], values: [Double],lable:String) {
//        if  dataPoints.count == 0{
            barChartViewOutlet.noDataText = "No data available!"
//        }else{
            barChartViewOutlet.chartDescription?.text = ""
            var dataEntries: [BarChartDataEntry] = []
            for i in 0..<dataPoints.count {
                let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
                dataEntries.append(dataEntry)
            }
            
            let chartDataSet = BarChartDataSet(entries: dataEntries, label: lable)
            chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
            let chartData = BarChartData(dataSet: chartDataSet)
            barChartViewOutlet.data = chartData
            
            barChartViewOutlet.xAxis.enabled = true
            barChartViewOutlet.leftAxis.enabled = true
            barChartViewOutlet.rightAxis.enabled = false
            barChartViewOutlet.animate(xAxisDuration: 1.5)
            barChartViewOutlet.drawGridBackgroundEnabled = true
            
            
            barChartViewOutlet.xAxis.drawGridLinesEnabled = true
            barChartViewOutlet.xAxis.drawAxisLineEnabled = true
            barChartViewOutlet.xAxis.labelPosition = .bottom
            barChartViewOutlet.xAxis.drawLabelsEnabled = true
            barChartViewOutlet.leftAxis.drawGridLinesEnabled = true
            barChartViewOutlet.legend.enabled = true
            
            //MARL:show animation
            barChartViewOutlet.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
            let ll = ChartLimitLine(limit: 10.0, label: "Target")
            ll.lineWidth = 1.5
            ll.lineColor = UIColor.red
//            ll.lineDashLengths = [4, 4]
            ll.valueFont = .systemFont(ofSize: 10)
//            barChartViewOutlet.leftAxis.addLimitLine(ll)
            
            
//            barChartViewOutlet.xAxis.gridLineDashLengths = [4, 4]
//            barChartViewOutlet.xAxis.gridLineDashPhase = 0
//            barChartViewOutlet.leftAxis.gridLineDashLengths = [4, 4]
//        }
    }
}
