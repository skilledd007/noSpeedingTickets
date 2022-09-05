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
    var monitoring: Bool = true
    @IBOutlet weak var speedLimitLabel: UILabel!
    @IBOutlet weak var userSpeedLabel: UILabel!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var monitoringButtonOutlet: UIButton!
    
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

   
    @IBAction func monitoringSpeedPressed(_ sender: UIButton) {
        monitoring = !monitoring
        if(monitoring) {
            sender.setTitle("Stop Monitoring", for: .normal)
            self.monitoringButtonOutlet.backgroundColor = UIColor.red
            sender.titleLabel?.font = UIFont(name: "System", size: 5.0)
            locationManager.startUpdatingLocation()
            print("Started Monitoring Speed")
        }
        else {
            sender.setTitle("Start Monitoring", for: .normal)
            self.monitoringButtonOutlet.backgroundColor = UIColor.blue
            self.monitoringButtonOutlet.titleLabel?.font = UIFont(name: "System", size: 30.0)
            locationManager.stopUpdatingLocation()
            print("Stopped Monitoring Speed")

        }
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
        DispatchQueue.main.async {
            self.errorMessageLabel.textColor = UIColor.purple
            self.errorMessageLabel.text = error.localizedDescription
        }
        
    }
    func didUpdateSpeed(speed: String) {
        
            DispatchQueue.main.async {
                self.errorMessageLabel.textColor = UIColor.black
                self.errorMessageLabel.text = "No Errors"
                self.speedLimitLabel.text = speed
                let speedKMH = (self.locationManager.location?.speed)! * 3.6
                    self.userSpeedLabel.text = String(format: "%.1f", speedKMH)
                    print(speed)
                if(Double(speed) == 0)
                {
                    //Push Notification informing user that the speed limit is zero and that audio alerts have been stopped.
                    self.errorMessageLabel.textColor = UIColor.orange
                    self.errorMessageLabel.text = "SPEED LIMIT RETURNED 0. STOPPED MONITORING"
                    self.audioPlayer.stop()
                }
                else if(speedKMH > Double(speed)!) {
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
    
    @IBAction func viewRecentSpeedingPressed(_ sender: UIBarButtonItem) {
        navigationController?.performSegue(withIdentifier: "toSpeedLogsViewController", sender: self)
    }
    
}

