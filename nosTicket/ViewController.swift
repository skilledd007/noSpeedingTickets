//
//  ViewController.swift
//  nosTicket
//
//  Created by Amrit Mahendrarajah on 2022-07-21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var audioPlayer = AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
        var urlString = "https://routematching.hereapi.com/v8/match/routelinks?apikey=U5Mo7l-eKI5hX66VE7PSuLC1RaCu5BPAxcihb68q6G0&waypoint0=51.12326,-114.13433&waypoint1=51.12326,-114.13433&mode=fastest;car&routeMatch=1&attributes=SPEED_LIMITS_FCn(*)"
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data,response,error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                            let responseModel = try decoder.decode(Json4Swift_Base.self, from: data!)
                        //print(responseModel.response?.route[0].leg[0].link[0].attributes.SPEED_LIMITS_FCN[0].FROM_REF_SPEED_LIMIT)
                        print(responseModel.response?.route![0].leg![0].link![0].attributes?.sPEED_LIMITS_FCN![0].fROM_REF_SPEED_LIMIT)
                        
                    } catch {
                        print(error)
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
        
    }

    @IBAction func playSoundPressed(_ sender: UIButton) {
        audioPlayer.play()
    }
    
}

