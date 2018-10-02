//
//  VCTesting.swift
//  U-Hack!
//
//  Created by Charly Maxter on 02/10/2018.
//  Copyright © 2018 U-Hack. All rights reserved.
//

import UIKit

class VCTesting: UIViewController {
    
    @IBOutlet var textFieldFlightNumber: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    @IBAction func buttonPressed(){
        getBBVASEL(onCompletion: {
            json in
            print("JSON:", json)
            
        })
    }
    
    func getInfoFlight(flightNumber: String){
    DataHolder.sharedInstance.firDataBaseRef.child("flights").child(flightNumber).observeSingleEvent(of: .value, with: { (dataSnapshot) in
                let dic = dataSnapshot.value as! NSDictionary
            
            print("dic: ", dic)
            
            })
        
    }
    
    /*
     getWeatherInfo(place: "Luxembourg", onCompletion: {
     (weather) in
     print("FIN: ", weather)
     })
     */
    func getWeatherInfo(place: String, onCompletion: @escaping (String) -> Void){
        getWeatherInfoRest(destino: place, onCompletion: {
            (json) in
            print("JSON: ", json)
            let weather = json["list"].array![0].dictionary!["weather"]?.array![0].dictionary!["main"]!.string
            onCompletion(weather!)
        })
    }
    
    func connectWifi(aeropuerto: String){
        DataHolder.sharedInstance.firDataBaseRef.child("wifi").child(aeropuerto).observeSingleEvent(of: .value, with: {
            (datasnapshot) in
            let dic = datasnapshot.value as! NSDictionary
            let ssid = dic["ssid"] as! String
            let pass = dic["pass"] as! String
            
            connectWifiPass(SSID: ssid, Pass: pass, completion: {
                (res:Bool) in
                print("RESULTADO: ", res)
                
            })
            
        })
    }
    
    func getFlight(destino: String, onCompletion: @escaping (NSDictionary) -> Void){
        DataHolder.sharedInstance.firDataBaseRef.child("flightAvailables").child("0").observeSingleEvent(of: .value, with: {dataSnapshot in
            let dic = dataSnapshot.value as! NSDictionary
            print("FLIGHT:", dic)
            onCompletion(dic)
        })
    }
    
    func getHotel(destino: String, onCompletion: @escaping (NSDictionary) -> Void){
        DataHolder.sharedInstance.firDataBaseRef.child("hotel").child(destino).child("0").observeSingleEvent(of: .value, with: {dataSnapshot in
            let dic = dataSnapshot.value as! NSDictionary
            print("HOTEL:", dic)
            onCompletion(dic)
        })
    }
    
    func getBBVASEL(onCompletion: @escaping(JSON) -> Void){
        getAuthBBVACode(onCompletion: {
          json in
            let access_token = json["access_token"].string
        
            print("Access Token:", access_token!)
            getBBVASELRest(auth: access_token!, onCompletion: {
                json in
                onCompletion(json)
            })
            
        })
    }
    
}
