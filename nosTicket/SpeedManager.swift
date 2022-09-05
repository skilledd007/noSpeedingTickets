//
//  SpeedManager.swift
//  nosTicket
//
//  Created by Amrit Mahendrarajah on 2022-07-24.
//

import Foundation
import CoreLocation
protocol SpeedManagerDelegate {
    func didUpdateSpeed(speed: String)
    func showErrorMessage(errorMessage: String)
}
struct SpeedManager {
    var delegate: SpeedManagerDelegate?
    func getSpeedLimit(lat: CLLocationDegrees, lon: CLLocationDegrees ) {
        var speed = "default"
        var urlString = "https://routematching.hereapi.com/v8/match/routelinks?apikey=U5Mo7l-eKI5hX66VE7PSuLC1RaCu5BPAxcihb68q6G0&waypoint0=\(lat),\(lon)&waypoint1=\(lat),\(lon)&mode=fastest;car&routeMatch=1&attributes=SPEED_LIMITS_FCn(*)"
        print(urlString)
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data,response,error) in
                if  let errorSafe = error {
                    self.delegate?.showErrorMessage(errorMessage: errorSafe.localizedDescription)
                }
                /*if response != nil {
                    print(response)
                }
                 */
                
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                            let responseModel = try decoder.decode(Json4Swift_Base.self, from: data!)
                        //print(responseModel.response?.route[0].leg[0].link[0].attributes.SPEED_LIMITS_FCN[0].FROM_REF_SPEED_LIMIT)
                         let speed = responseModel.response?.route![0].leg![0].link![0].attributes?.sPEED_LIMITS_FCN![0].tO_REF_SPEED_LIMIT
                        if let speedSafe = speed {
                            print("Sending Updated Speed")
                        self.delegate?.didUpdateSpeed(speed: speedSafe)
                        }
                        
                    } catch {
                        print("JSON Decoding Error")
                        self.delegate?.showErrorMessage(errorMessage: "JSON DECODING ERROR")
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
        //return speed
        //Need to call delegate Method.
        
    }
    
}
