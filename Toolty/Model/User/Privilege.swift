//
//  Privilege.swift
//  Toolty
//
//  Created by Chirag Patel on 13/07/21.
//

import Foundation
import CoreData

class Privilege : NSManagedObject, ParentManagedObject{
    @NSManaged var productView : String
    @NSManaged var productAdd : Int32
    @NSManaged var leadMobileMask : Int32
    @NSManaged var customerMobileMask : Int32
    @NSManaged var productEdit : Int32
    @NSManaged var userView : Int32
    @NSManaged var userAdd : Int32
    @NSManaged var userEdit : Int32
    @NSManaged var customerView : Int32
    //key start
    @NSManaged var customer_add : Int32
    @NSManaged var customer_edit : Int32
    @NSManaged var lead_view : Int32
    @NSManaged var lead_add : Int32
    @NSManaged var lead_edit : Int32
    @NSManaged var task_view : Int32
    @NSManaged var task_add : Int32
    @NSManaged var dpr_view : Int32
    @NSManaged var visit_view : Int32
    @NSManaged var visit_schedule : Int32
    @NSManaged var purchase_view : Int32
    @NSManaged var purchase_add : Int32
    @NSManaged var contacts_menu_view : Int32
    @NSManaged var contacts_menu_add : Int32
    @NSManaged var contacts_menu_update : Int32
    @NSManaged var order_view : Int32
    @NSManaged var order_payment_approve : Int32
    @NSManaged var order_delivery_approve : Int32
    @NSManaged var invoice_view : Int32
    @NSManaged var invoice_record_payment : Int32
    @NSManaged var expense_add : Int32
    @NSManaged var expense_view : Int32
    @NSManaged var expense_approve : Int32
    @NSManaged var expense_claim : Int32
    @NSManaged var service_job_view : Int32
    @NSManaged var service_job_add : Int32
    @NSManaged var service_job_edit : Int32
    @NSManaged var oppurtunity_view : Int32
    @NSManaged var oppurtunity_add : Int32
    @NSManaged var oppurtunity_edit : Int32
    @NSManaged var form_view : Int32
    @NSManaged var form_add : Int32
    @NSManaged var form_edit : Int32
    @NSManaged var leave_apply : Int32
    @NSManaged var leave_approve : Int32
    @NSManaged var stock_view : Int32
    @NSManaged var stock_add : Int32
    @NSManaged var distributor_view : Int32
    @NSManaged var distributor_edit : Int32
    @NSManaged var distributor_add : Int32
    @NSManaged var start_beat : Int32
    @NSManaged var attendance_view : Int32
    @NSManaged var live_track_view : Int32
    @NSManaged var broadcast_view : Int32
    @NSManaged var start_job_beat : Int32
    @NSManaged var account_view : Int32
    @NSManaged var account_add : Int32
    @NSManaged var account_edit : Int32
    @NSManaged var approval_form_view : Int32
    @NSManaged var approval_form_add : Int32
    @NSManaged var approval_form_edit : Int32
    @NSManaged var call_history_view : Int32
    @NSManaged var news_module_status : Int32
    @NSManaged var form_menu_view : Int32
    @NSManaged var form_menu_add : Int32
    @NSManaged var form_menu_edit : Int32
    @NSManaged var approval_form_menu_view : Int32
    @NSManaged var approval_form_menu_add : Int32
    @NSManaged var approval_form_menu_edit : Int32
    @NSManaged var lost_won_update : Int32
    @NSManaged var productPricingStatus : Int32
    @NSManaged var productMandatoryStatus : Int32
    @NSManaged var dealForCustomerOrLeadStatus : Int32
    @NSManaged var outbound_enabled : Int32
    @NSManaged var deal_estimated_value_edit : Int32
    @NSManaged var product_based_on_currency : Int32
    @NSManaged var visit_draft_status : Int32
    @NSManaged var team_customisation_status : Int32
    @NSManaged var dot_message_status : Int32
    @NSManaged var cibil_module_status : Int32
    @NSManaged var agora_module_status : Int32
    @NSManaged var work_from_home_status : Int32
    @NSManaged var view_all_attendance_status : Int32
    @NSManaged var goal_view : Int32
    @NSManaged var display_nearby_tab_in_lead : Int32
    @NSManaged var display_nearby_tab_in_customer : Int32
    
    
    func initWith(dict: NSDictionary){
        productView = dict.getStringValue(key: "product_view")
        productAdd = dict.getInt32Value(key: "product_add")
        leadMobileMask = dict.getInt32Value(key: "lead_mobile_mask")
        customerMobileMask = dict.getInt32Value(key: "customer_mobile_mask")
        productEdit = dict.getInt32Value(key: "product_edit")
        userView = dict.getInt32Value(key: "user_view")
        userAdd = dict.getInt32Value(key: "user_add")
        userEdit = dict.getInt32Value(key: "user_edit")
        customerView = dict.getInt32Value(key: "customer_view")
        customer_add  = dict.getInt32Value(key: "customer_add")
        customer_edit = dict.getInt32Value(key: "customer_edit")
        lead_view  = dict.getInt32Value(key: "lead_view")
        lead_add = dict.getInt32Value(key: "lead_add")
        lead_edit = dict.getInt32Value(key: "lead_edit")
        task_view = dict.getInt32Value(key: "task_view")
        task_add = dict.getInt32Value(key: "task_add")
        dpr_view = dict.getInt32Value(key: "dpr_view")
        visit_view = dict.getInt32Value(key: "visit_view")
        visit_schedule = dict.getInt32Value(key: "visit_schedule")
        purchase_view = dict.getInt32Value(key: "purchase_view")
        purchase_add = dict.getInt32Value(key: "purchase_add")
        contacts_menu_view = dict.getInt32Value(key: "contacts_menu_view")
        contacts_menu_add = dict.getInt32Value(key: "contacts_menu_add")
        contacts_menu_update = dict.getInt32Value(key: "contacts_menu_update")
        order_view = dict.getInt32Value(key: "order_view")
        order_payment_approve = dict.getInt32Value(key: "order_payment_approve")
        order_delivery_approve = dict.getInt32Value(key: "order_delivery_approve")
        invoice_view = dict.getInt32Value(key: "invoice_view")
        invoice_record_payment = dict.getInt32Value(key: "invoice_record_payment")
        expense_add = dict.getInt32Value(key: "expense_add")
        expense_view = dict.getInt32Value(key: "expense_view")
        expense_approve = dict.getInt32Value(key: "expense_approve")
        expense_claim = dict.getInt32Value(key: "expense_claim")
        service_job_view = dict.getInt32Value(key: "service_job_view")
        service_job_add = dict.getInt32Value(key: "service_job_add")
        service_job_edit = dict.getInt32Value(key: "service_job_edit")
        oppurtunity_view = dict.getInt32Value(key: "oppurtunity_view")
        oppurtunity_add = dict.getInt32Value(key: "oppurtunity_add")
        oppurtunity_edit = dict.getInt32Value(key: "oppurtunity_edit")
        form_view = dict.getInt32Value(key: "form_view")
        form_add = dict.getInt32Value(key: "form_add")
        form_edit = dict.getInt32Value(key: "form_edit")
        leave_apply = dict.getInt32Value(key: "leave_apply")
        leave_approve = dict.getInt32Value(key: "leave_approve")
        stock_view = dict.getInt32Value(key: "stock_view")
        stock_add = dict.getInt32Value(key: "stock_add")
        distributor_view = dict.getInt32Value(key: "distributor_view")
        distributor_edit = dict.getInt32Value(key: "distributor_edit")
        distributor_add = dict.getInt32Value(key: "distributor_add")
        start_beat = dict.getInt32Value(key: "start_beat")
        attendance_view = dict.getInt32Value(key: "attendance_view")
        live_track_view = dict.getInt32Value(key: "live_track_view")
        broadcast_view = dict.getInt32Value(key: "broadcast_view")
        start_job_beat = dict.getInt32Value(key: "start_job_beat")
        account_view = dict.getInt32Value(key: "account_view")
        account_add = dict.getInt32Value(key: "account_add")
        account_edit = dict.getInt32Value(key: "account_edit")
        approval_form_view = dict.getInt32Value(key: "approval_form_view")
        approval_form_add = dict.getInt32Value(key: "approval_form_add")
        approval_form_edit = dict.getInt32Value(key: "approval_form_edit")
        call_history_view = dict.getInt32Value(key: "call_history_view")
        news_module_status = dict.getInt32Value(key: "news_module_status")
        form_menu_view = dict.getInt32Value(key: "form_menu_view")
        form_menu_add = dict.getInt32Value(key: "form_menu_add")
        form_menu_edit = dict.getInt32Value(key: "form_menu_edit")
        approval_form_menu_view = dict.getInt32Value(key: "approval_form_menu_view")
        approval_form_menu_add = dict.getInt32Value(key: "approval_form_menu_add")
        approval_form_menu_edit = dict.getInt32Value(key: "approval_form_menu_edit")
        lost_won_update = dict.getInt32Value(key: "lost_won_update")
        productPricingStatus = dict.getInt32Value(key: "productPricingStatus")
        productMandatoryStatus = dict.getInt32Value(key: "productMandatoryStatus")
        dealForCustomerOrLeadStatus = dict.getInt32Value(key: "dealForCustomerOrLeadStatus")
        outbound_enabled = dict.getInt32Value(key: "outbound_enabled")
        deal_estimated_value_edit = dict.getInt32Value(key: "deal_estimated_value_edit")
        product_based_on_currency = dict.getInt32Value(key: "product_based_on_currency")
        visit_draft_status = dict.getInt32Value(key: "visit_draft_status")
        team_customisation_status = dict.getInt32Value(key: "team_customisation_status")
        dot_message_status = dict.getInt32Value(key: "dot_message_status")
        cibil_module_status = dict.getInt32Value(key: "cibil_module_status")
        agora_module_status = dict.getInt32Value(key: "agora_module_status")
        work_from_home_status = dict.getInt32Value(key: "work_from_home_status")
        view_all_attendance_status = dict.getInt32Value(key: "view_all_attendance_status")
        goal_view = dict.getInt32Value(key: "goal_view")
        display_nearby_tab_in_lead = dict.getInt32Value(key: "display_nearby_tab_in_lead")
        display_nearby_tab_in_customer  = dict.getInt32Value(key: "display_nearby_tab_in_customer")
    }
}

