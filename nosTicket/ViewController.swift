//
//  ViewController.swift
//  nosTicket
//
//  Created by Amrit Mahendrarajah on 2022-07-21.
//

import UIKit
import AVFoundation
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate,SpeedManagerDelegate {

    var audioPlayer = AVAudioPlayer()
    let locationManager = CLLocationManager()
    var speedManager = SpeedManager()
    
    @IBOutlet weak var speedLimitLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        // Do any additional setup after loading the view.
        speedManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        let sound = Bundle.main.path(forResource: "alarm", ofType: "mp3")
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch let error {
            print(error.localizedDescription)
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch let error {
            print(error.localizedDescription)
        }
        
        
    }

    @IBAction func playSoundPressed(_ sender: UIButton) {
        audioPlayer.play()
    }
    
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            speedManager.getSpeedLimit(lat: lat, lon: lon)
           
            print("Latitude: \(lat)")
            print("Longitude: \(lon)")
            
        }
       
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    func didUpdateSpeed(speed: String) {
        
            DispatchQueue.main.async {
                self.speedLimitLabel.text = speed
                print(speed)
            }
    }
    
}

