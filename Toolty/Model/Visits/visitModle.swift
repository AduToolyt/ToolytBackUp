//
//  visitModle.swift
//  Toolty
//
//  Created by Suraj on 19/07/21.
//

import Foundation

// MARK: - VisitModel
class visitModle {
    var status: String
    var filterLabels: FilterLabel?
    var totalCount, scheduledVistEditStatus, visitRecordingEnalbed: Int
    var visits: [Visit] = []
    var visitStatusFilterArray: [VisitStatusFilterArray] = []
    
    init(dict: NSDictionary) {
        status = dict.getStringValue(key: "status")
        if let filterDict = dict["filterLabels"] as? NSDictionary{
            self.filterLabels = FilterLabel(dict: filterDict)
        }
        
        
            
        totalCount = dict.getIntValue(key: "totalCount")
        scheduledVistEditStatus = dict.getIntValue(key: "scheduledVistEditStatus")
        visitRecordingEnalbed = dict.getIntValue(key: "visitRecordingEnalbed")
        
        if let dictVisit = dict["visits"] as? [NSDictionary]{
            for dictData in dictVisit{
                let objdata = Visit(dict: dictData)
                self.visits.append(objdata)
            }
        }
            if let dictVisitstatusfilter = dict["visitStatusFilterArray"] as? [NSDictionary]{
                for dictData in dictVisitstatusfilter{
                    let objdata = VisitStatusFilterArray(dict: dictData)
                    self.visitStatusFilterArray.append(objdata)
                }
                
            }
        }
}
        
// MARK: - VisitStatusFilterArray
class VisitStatusFilterArray {
            var id: String
            var label: String
            init(dict: NSDictionary) {
                id = dict.getStringValue(key: "id")
                label = dict.getStringValue(key: "label")
            }
        }
        
// MARK: - Visit
class Visit {
            var id: Int
            var recordingURL, assignedBy: String
            var customerID, statusType, visitStat, leadStatusID: Int
            var customerName, fullName, companyName, assigneeName: String
            var orderPrivilege, paymentPrivilege, deliveryPrivilege: Int
            var date, time, visitContent: String
            var updateMissedVisit: Int
            var visitStatus, schuledOrNot, orderByVal, ascDescVal: String
            var address, scheduleLatLng, alongWithUsers, customerLatLng: String
            var leadStatus, email, phone, checkInTime: String
            var checkOutTime, scheduleDate, scheduleTime, scheduleEndDate: String
            var scheduleEndTime: String
            
            init(dict: NSDictionary) {
                id = dict.getIntValue(key: "id")
                recordingURL = dict.getStringValue(key: "recording_url")
                assignedBy = dict.getStringValue(key:"assigned_by")
                customerID = dict.getIntValue(key:"customer_id")
                statusType = dict.getIntValue(key: "status_type")
                visitStat = dict.getIntValue(key: "visit_stat")
                leadStatusID = dict.getIntValue(key: "lead_status_id")
                customerName = dict.getStringValue(key:"customer_name")
                fullName = dict.getStringValue(key:"full_name")
                companyName = dict.getStringValue(key:"company_name")
                assigneeName = dict.getStringValue(key:"assignee_name")
                orderPrivilege = dict.getIntValue(key: "order_privilege")
                paymentPrivilege = dict.getIntValue(key: "payment_privilege")
                deliveryPrivilege = dict.getIntValue(key: "delivery_privilege")
                date = dict.getStringValue(key:"date")
                time = dict.getStringValue(key:"time")
                visitContent = dict.getStringValue(key:"visit_content")
                updateMissedVisit = dict.getIntValue(key: "update_missed_visit")
                visitStatus = dict.getStringValue(key:"visit_status")
                schuledOrNot = dict.getStringValue(key:"schuled_or_not")
                orderByVal = dict.getStringValue(key:"order_by_val")
                ascDescVal = dict.getStringValue(key:"asc_desc_val")
                address = dict.getStringValue(key:"address")
                scheduleLatLng = dict.getStringValue(key:"schedule_lat_lng")
                alongWithUsers = dict.getStringValue(key:"along_with_users")
                customerLatLng = dict.getStringValue(key:"customer_lat_lng")
                leadStatus = dict.getStringValue(key:"lead_status")
                email = dict.getStringValue(key:"email")
                phone = dict.getStringValue(key:"phone")
                checkInTime = dict.getStringValue(key:"check_in_time")
                checkOutTime = dict.getStringValue(key:"check_out_time")
                scheduleDate = dict.getStringValue(key:"schedule_date")
                scheduleTime = dict.getStringValue(key:"schedule_time")
                scheduleEndDate = dict.getStringValue(key:"schedule_end_date")
                scheduleEndTime = dict.getStringValue(key:"schedule_end_time")
            }
        }


