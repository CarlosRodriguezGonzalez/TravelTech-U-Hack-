//
//  HTTPRequest.swift
//  U-Hack!
//
//  Created by Charly Maxter on 02/10/2018.
//  Copyright © 2018 U-Hack. All rights reserved.
//

import UIKit
import Foundation

typealias ServiceResponse = (JSON, NSError?) -> Void

func makeHTTPGetRequest(_ path: String, onCompletion: @escaping ServiceResponse) {
    print("ENTRE AQUI")
    let request = NSMutableURLRequest(url: URL(string: path)!)
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: URLRequest(url: URL(string: path)!), completionHandler: {data, response, error -> Void in
        do{
            print("DATA: ", data)
            if let jsonData = data {
                
                let json:JSON = try JSON(data: jsonData)
                onCompletion(json, nil)
            } else {
                onCompletion(JSON.null, error as! NSError)
            }
        }catch let err as NSError{
            print("SO SAAAAD",err)
        }
    })
    task.resume()
}

func makeHTTPGetRequestAuth(_ path: String, auth: String, onCompletion: @escaping ServiceResponse) {
    print("ENTRE AQUI")
    let request = NSMutableURLRequest(url: URL(string: path)!)
    if(auth != ""){
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("jwt \(auth)", forHTTPHeaderField: "Authorization")
    }
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
        do{
            print("DATA: ", data)
            if let jsonData = data {
                
                let json:JSON = try JSON(data: jsonData)
                onCompletion(json, nil)
            } else {
                onCompletion(JSON.null, error as! NSError)
            }
        }catch let err as NSError{
            print("SO SAAAAD",err)
        }
    })
    task.resume()
}

func makeHTTPPostRequest(_ path: String, body: String, auth: String, onCompletion: @escaping ServiceResponse) {
    let request = NSMutableURLRequest(url: URL(string: path)!)
    // Set the method to POST
    request.httpMethod = "POST"
    // Set the POST body for the request
    request.httpBody = body.data(using: String.Encoding.utf8);
    print("inicio algo",body)
    if(auth != ""){
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(auth)", forHTTPHeaderField: "authorization")
    }
    let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
        
        do{
            if let jsonData = data {
                let json:JSON = try JSON(data: jsonData)
                print("RES: ",json)
                //ERROR ESTA NIL, PROBLEMA
                
                onCompletion(json, nil)
            } else {
                onCompletion(JSON.null, error as! NSError)
            }
        }catch let err as NSError{
            print("asdfasdf",err)
        }
    })
    task.resume()
}
