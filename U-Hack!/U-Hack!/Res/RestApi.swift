//
//  RestApi.swift
//  U-Hack!
//
//  Created by Charly Maxter on 02/10/2018.
//  Copyright © 2018 U-Hack. All rights reserved.
//

import UIKit

let weatherURLBase = "http://api.openweathermap.org/data/2.5/forecast?q="
let bbvaApiAuth = "https://connect.bbva.com/token?grant_type=client_credentials&appID=app.bbva.AirTree"
let bbvaAuth = "Basic YXBwLmJidmEuQWlyVHJlZXA6bUYzTypASjhVRmcwWlVPWm8qcXg3TE1MZTZGVlpHVnFaeXEyRWRXd2FtYmdrbzZ4ajElTU4wc1ZXeklWTkQwQw=="
let bbvaSel = "https://apis.bbva.com/sel-sbx/v1/info?lat=40.309251&long=-3.934121"

func getWeatherInfoRest(destino: String, onCompletion: @escaping(JSON) -> Void){
    
    let appID = "&appid=71f57db207e2e95f070ee3c47ae7ec6e&units=metric"
    let route = weatherURLBase + destino + appID
    print("ROUTE: ", route)
    makeHTTPGetRequest(route, onCompletion: {json, err in
        onCompletion(json as JSON)
    })
    
}

func getAuthBBVACode(onCompletion: @escaping(JSON) -> Void){
    let route = bbvaApiAuth
    makeHTTPPostRequest(route, body: "", auth: bbvaAuth, onCompletion: {
        json, err in
        onCompletion(json as JSON)
    })
}

func getBBVASELRest(auth: String, onCompletion: @escaping(JSON) -> Void){
    
    let route = bbvaSel
    
    makeHTTPGetRequestAuth(route, auth: auth, onCompletion: {
        json, err in
        onCompletion(json as JSON)
    })
    
    
}
