//
//  CheckoutViewController.swift
//  CheshireCheeseCompany
//
//  Created by apple on 26/04/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import Braintree
import PassKit
import AddressBookUI

struct Address {
    var Street: String?
    var City: String?
    var State: String?
    var Zip: String?
    var FirstName:String?
    var LastName: String?
    
    init() {
        FirstName="Anju"
    }
}




class CheckoutViewController: UIViewController,PKPaymentAuthorizationViewControllerDelegate{
   
    var name=PKContact()
    var braintreeClient: BTAPIClient?
    let tokenizationKey="sandbox_v25wgx2t_bkrn3b56nfnkh582"

    override func viewDidLoad() {
        super.viewDidLoad()
        braintreeClient = BTAPIClient(authorization: tokenizationKey )
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard, PKPaymentNetwork.amex, PKPaymentNetwork.discover]) {
          PKPaymentNetwork.init(rawValue:  "4761 1200 1000 0492")
            let button = self.applePayButton()
           button.frame = CGRect(x:50, y:50, width: 100, height:40)
            self.view.addSubview(button)
        }else {
            print(false)
        }
    }
    
    func applePayButton() -> UIButton {
        var button: UIButton?
        
        if #available(iOS 8.3, *) { // Available in iOS 8.3+
             button = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .black)
        } else {
            // TODO: Create and return your own apple pay button
            // button = ...
        }
        
        button?.addTarget(self, action: #selector(tappedApplePay), for: UIControlEvents.touchUpInside)
        
        return button!
    }
    
    func setupPaymentRequest(completion: @escaping (PKPaymentRequest?, Error?) -> Void) {
        let applePayClient = BTApplePayClient(apiClient: self.braintreeClient!)
        // You can use the following helper method to create a PKPaymentRequest which will set the `countryCode`,
        // `currencyCode`, `merchantIdentifier`, and `supportedNetworks` properties.
        // You can also create the PKPaymentRequest manually. Be aware that you'll need to keep these in
        // sync with the gateway settings if you go this route.
        applePayClient.paymentRequest { (paymentRequest, error) in
            guard let paymentRequest = paymentRequest else {
                completion(nil, error)
                return
            }
            
            var contact = PKContact()
//            var phonenumber=CNPhoneNumber()
        
            var name = PersonNameComponents()
            name.givenName = "Rakhi"
            name.familyName = "santia"
            contact.name = name

            var address = CNMutablePostalAddress()
            address.street = "1234 Laurel Street"
            address.city = "Kottayam"
            address.state = "India"
            address.postalCode = "30303"
            contact.phoneNumber=CNPhoneNumber(stringValue: "8524789645")
            contact.emailAddress="asanju@gmail.com"
            contact.postalAddress = address
          
           
            paymentRequest.countryCode="US"
            paymentRequest.currencyCode="GBP"
            paymentRequest.merchantIdentifier="merchant.com.websight"
            paymentRequest.shippingContact = contact
            
            
            let shippingMethod = PKShippingMethod()
            shippingMethod.label="COD"
            shippingMethod.amount=NSDecimalNumber(string: "56")
            shippingMethod.identifier = "COD"
            shippingMethod.detail = "Delivery within 24hrs"
            paymentRequest.shippingMethods = [shippingMethod]
           
        
            paymentRequest.requiredShippingAddressFields=PKAddressField.all
            paymentRequest.merchantCapabilities = .capability3DS
            paymentRequest.paymentSummaryItems =
                [
                    PKPaymentSummaryItem(label: "CCC", amount: NSDecimalNumber(string: "12")),
                    PKPaymentSummaryItem(label: "websight", amount: NSDecimalNumber(string: "12")),
             ]
            completion(paymentRequest, nil)
        }
     
    }
   
    @objc func tappedApplePay(){
        self.setupPaymentRequest { (paymentRequest, error) in
            guard error == nil else {
                return
            }
            if let vc=PKPaymentAuthorizationViewController(paymentRequest: paymentRequest!) as PKPaymentAuthorizationViewController?
            {
                vc.delegate = self
                self.present(vc, animated: true, completion: nil)
            } else {
                print("Error: Payment request is invalid.")
            }
        }
    }

    @available(iOS 11.0, *)
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void){

        // Example: Tokenize the Apple Pay payment
        let applePayClient = BTApplePayClient(apiClient: braintreeClient!)
        applePayClient.tokenizeApplePay(payment) {
            (tokenizedApplePayPayment, error) in
            guard let tokenizedApplePayPayment = tokenizedApplePayPayment else {
               
              //  completion(PKPaymentAuthorizationStatus.failure)
                if #available(iOS 11.0, *) {
                    let result = PKPaymentAuthorizationResult(status: .failure,
                                                              errors: [])
                     completion(result)
                } else {
                    // Fallback on earlier versions
                }
               
                print("failure......")
                return
            }
            print("nonce = \(tokenizedApplePayPayment.nonce)")
            
          //  print("billingPostalCode = \(payment.billingContact?.postalAddress?.postalCode)")
             print("billingPostalCode = \(payment.shippingContact?.postalAddress?.postalCode)")
            let result = PKPaymentAuthorizationResult(status: .success,
                                                      errors: [])
           
            // Then indicate success or failure via the completion callback, e.g.
            completion(result)
            print("success....")
        }
    }

    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
//    func createShippingAddressFromRef(address: ABRecord!) -> Address {
//        var shippingAddress: Address = Address()
//
//        shippingAddress.FirstName = ABRecordCopyValue(address, kABPersonFirstNameProperty)?.takeRetainedValue() as? String
//        shippingAddress.LastName = ABRecordCopyValue(address, kABPersonLastNameProperty)?.takeRetainedValue() as? String
//
//        let addressProperty : ABMultiValue = ABRecordCopyValue(address, kABPersonAddressProperty).takeUnretainedValue() as ABMultiValue
//        if let dict : NSDictionary = ABMultiValueCopyValueAtIndex(addressProperty, 0).takeUnretainedValue() as? NSDictionary {
//            shippingAddress.Street = dict[String(kABPersonAddressStreetKey)] as? String
//            shippingAddress.City = dict[String(kABPersonAddressCityKey)] as? String
//            shippingAddress.State = dict[String(kABPersonAddressStateKey)] as? String
//            shippingAddress.Zip = dict[String(kABPersonAddressZIPKey)] as? String
//        }
//
//        return shippingAddress
//    }
    
    
    
//   func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didSelectShippingAddress address: ABRecord, completion: @escaping (PKPaymentAuthorizationStatus, [AnyObject], [AnyObject]) -> Void) {
//        let shippingAddress = createShippingAddressFromRef(address: address)
//
//        switch (shippingAddress.State, shippingAddress.City, shippingAddress.Zip) {
//        case (.some(let state), .some(let city), .some(let zip)):
//
//            completion(PKPaymentAuthorizationStatus.Success, nil, nil)
//        default:
//            completion(status: PKPaymentAuthorizationStatus.InvalidShippingPostalAddress, shippingMethods: nil, summaryItems: nil)
//        }
    }

    
   





