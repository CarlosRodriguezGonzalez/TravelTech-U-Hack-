//
//  WifiConection.swift
//  U-Hack!
//
//  Created by Charly Maxter on 02/10/2018.
//  Copyright © 2018 U-Hack. All rights reserved.
//

import UIKit
import NetworkExtension
import SystemConfiguration.CaptiveNetwork

func fetchWiFiInfo() ->  (ssid:String, mac:String) {
    var currentSSID = ""
    var macAddress = ""
    if let interfaces:CFArray = CNCopySupportedInterfaces() {
        if interfaces != nil{
            for i in 0..<CFArrayGetCount(interfaces){
                let interfaceName: UnsafeRawPointer = CFArrayGetValueAtIndex(interfaces, i)
                let rec = unsafeBitCast(interfaceName, to: AnyObject.self)
                let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)" as CFString)
                if unsafeInterfaceData != nil {
                    let interfaceData = unsafeInterfaceData! as Dictionary!
                    currentSSID = String(describing: interfaceData!["SSID" as NSObject]!)
                    macAddress = String(describing: interfaceData!["BSSID" as NSObject]!)
                }
            }
        }
    }
    
    return (currentSSID, macAddress);
}



func connectWifiPass(SSID:String, Pass:String, completion: @escaping (_ result:Bool) -> Void){
    let pato:NEHotspotConfiguration = NEHotspotConfiguration.init(ssid: SSID, passphrase: Pass, isWEP: false)
    NEHotspotConfigurationManager.shared.apply(pato, completionHandler: { error in
        //TODO MOSTRAR SI HAY ERROR O SI SE PUDO CONECTAR
        print("El error al conectar es: ",error)
        if error != nil {
            if error?.localizedDescription == "already associated."
            {
                completion(true)
            }
            else{
                completion(false)
                print("No Connected")
            }
        } else {
            //TODO comprobar red conectada con la que deberia
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
                var wifiActual: (ssid: String,mac: String)!
                let status = Reach().connectionStatus()
                switch status {
                    
                case .online(.wiFi):
                    wifiActual = fetchWiFiInfo()
                    if wifiActual.ssid == SSID {
                        completion(true)
                        print("CONEXION: CONECTADO")
                    } else {
                        completion(false)
                        print("CONEXION: NOPE")
                    }
                    print("WIFI ACTUAL",wifiActual)
                //getIsNetAdded(wifiActual.mac)
                case .offline, .online(.wwan), .unknown:
                    print("CONEXION: OTROS")
                    completion(false)
                    break
                    
                }
                
            })
            
        }
    })
    
    
}



