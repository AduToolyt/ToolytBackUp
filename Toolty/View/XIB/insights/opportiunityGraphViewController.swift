//
//  opportiunityGraphViewController.swift
//  Toolty
//
//  Created by Suraj on 21/07/21.
//

import UIKit
import Charts

class opportiunityGraphViewController: UIViewController {
    
    var objopp: opportinyModel!
    var InsightData = insightData()
    var months = [String]()
    var unit1 = [Double]()
    var unit2 = [Double]()
    var unit3 = [Double]()
    var dataEntries: [ChartDataEntry] = []
    
    @IBOutlet var chartViewOutlet: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        unit1 = [10.0, 11.0, 12.0, 13.0, 10.0, 15.0, 16.0]
//        unit2 = [20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0]
//        unit3 = [10.0, 31.0, 10.0, 33.0, 34.0, 35.0, 36.0]
//        months = ["Jan" , "Feb", "Mar", "Apr", "May", "June", "July"]
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        callHomeData()
//        multiplechatdata()
    }
}
// --> API CALLOING FOR OPPORTIUNITY GRAPH
extension opportiunityGraphViewController{
    func callHomeData(){
        self.InsightData.id = graphID
        self.InsightData.getOpportunityGraph{[weak self] (response, obj) in
            guard let weakSelf = self, let data = obj else {return}
            if response == .success{
                weakSelf.objopp = nil
                weakSelf.objopp = data
                
                for i in data.oppCount{
                    print(weakSelf.transformStringDate(i.date, fromDateFormat: "yyyy-MM-dd", toDateFormat: "MMM dd")!)
                    weakSelf.months.append(weakSelf.transformStringDate(i.date, fromDateFormat: "yyyy-MM-dd", toDateFormat: "MMM dd")!)
                    weakSelf.unit1.append(Double(i.open))
                    weakSelf.unit2.append(Double(i.closed))
                    weakSelf.unit3.append(Double(i.won))
                }
                weakSelf.multiplechatdata()
//                weakSelf.setChart(dataPoints: weakSelf.months, values: weakSelf.unit1, label: data.graphName)
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
extension opportiunityGraphViewController{
    func multiplechatdata(){
        let data = LineChartData()
        var lineChartEntry1 = [ChartDataEntry]()
        chartViewOutlet.noDataText = "No data available!"
        for i in 0..<unit1.count {
            lineChartEntry1.append(ChartDataEntry(x: Double(i), y: Double(unit1[i])))
        }
        let line1 = LineChartDataSet(entries: lineChartEntry1, label: "open")
        line1.colors = [NSUIColor.green]
        data.addDataSet(line1)
        if (unit2.count > 0) {
            var lineChartEntry2 = [ChartDataEntry]()
            for i in 0..<unit2.count {
                lineChartEntry2.append(ChartDataEntry(x: Double(i), y: Double(unit2[i])))
            }
            let line2 = LineChartDataSet(entries: lineChartEntry2, label: "won")
            line2.colors = [NSUIColor.blue]
        data.addDataSet(line2)
        }
        if (unit3.count > 0) {
            var lineChartEntry3 = [ChartDataEntry]()
            for i in 0..<unit3.count {
                lineChartEntry3.append(ChartDataEntry(x: Double(i), y: Double(unit3[i])))
            }
            let line3 = LineChartDataSet(entries: lineChartEntry3, label: "close")
            line3.colors = [NSUIColor.red]
            data.addDataSet(line3)
        }
        self.chartViewOutlet.data = data
    }
    /*func setChart(dataPoints: [String], values: [Double],label:String) {
//        if  dataPoints.count == 0{
            chartViewOutlet.noDataText = "No data available!"
//        }else{
            
            for i in 0 ..< dataPoints.count {
                print("chart point : \(values[i])")
                let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
                dataEntries.append(dataEntry)
                
            }
            let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: label)
            lineChartDataSet.setCircleColor(UIColor.clear)
            lineChartDataSet.circleRadius = 0.0
            lineChartDataSet.lineWidth = 2.0
            lineChartDataSet.valueTextColor = UIColor.clear
            
            lineChartDataSet.colors = [NSUIColor.blue]
            lineChartDataSet.mode = .cubicBezier
            lineChartDataSet.cubicIntensity = 0.2
            var dataSets = [LineChartDataSet]()
            dataSets.append(lineChartDataSet)
            
            let lineChartData = LineChartData(dataSets: dataSets)
            chartViewOutlet.data = lineChartData
            chartViewOutlet.xAxis.enabled = true
            chartViewOutlet.leftAxis.enabled = true
            chartViewOutlet.rightAxis.enabled = false
            chartViewOutlet.animate(xAxisDuration: 1.5)
            chartViewOutlet.drawGridBackgroundEnabled = true
            
            
            chartViewOutlet.xAxis.drawGridLinesEnabled = true
            chartViewOutlet.xAxis.drawAxisLineEnabled = true
            chartViewOutlet.xAxis.labelPosition = .bottom
            chartViewOutlet.xAxis.drawLabelsEnabled = true
            
            chartViewOutlet.leftAxis.drawGridLinesEnabled = true
            chartViewOutlet.legend.enabled = false
            let llXAxis = ChartLimitLine(limit: 10, label: "Index 10")
            llXAxis.lineWidth = 1.5
            llXAxis.lineDashLengths = [10, 10, 0]
            llXAxis.labelPosition = .bottomRight
            llXAxis.valueFont = .systemFont(ofSize: 10)
            
            chartViewOutlet.xAxis.gridLineDashLengths = [4, 4]
            chartViewOutlet.xAxis.gridLineDashPhase = 0
            
            let leftAxis = chartViewOutlet.leftAxis
            leftAxis.removeAllLimitLines()
            
            leftAxis.axisMaximum = 200
            leftAxis.axisMinimum = 0
            
            leftAxis.gridLineDashLengths = [5, 5]
            leftAxis.drawLimitLinesBehindDataEnabled = true
            
            chartViewOutlet.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints) //enable/show
//        } 
    }*/
}
