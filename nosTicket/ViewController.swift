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
    @IBOutlet weak var userSpeedLabel: UILabel!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        // Do any additional setup after loading the view.
        speedManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        setupAudioPlayer()
        
        
    }
    
    func setupAudioPlayer() {
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
                self.errorMessageLabel.textColor = UIColor.black
                self.errorMessageLabel.text = "No Errors"
                self.speedLimitLabel.text = speed
                let speedKMH = (self.locationManager.location?.speed)! * 3.6
                    self.userSpeedLabel.text = String(format: "%.1f", speedKMH)
                    print(speed)
                if(speedKMH > Double(speed)!) {
                    self.audioPlayer.numberOfLoops = -1
                    self.audioPlayer.play()
                } else {
                    self.audioPlayer.stop()
                }
            }
           
    }
    func showErrorMessage(errorMessage: String) {
        DispatchQueue.main.async {
            self.errorMessageLabel.textColor = UIColor.red
            self.errorMessageLabel.text = errorMessage
        }
    }
    
}

