//
//  SpeedLogsViewController.swift
//  nosTicket
//
//  Created by Amrit Mahendrarajah on 2022-09-04.
//

import UIKit

class SpeedLogsViewController: UIViewController,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var speedEvents: [SpeedEvent] = [
        SpeedEvent(location: "16 Ave", speed: "180KPH"),
        SpeedEvent(location: "Stoney Trail ", speed: "220KPH")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        self.registerTableViewCells()
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return speedEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell {
            cell.title.text = speedEvents[indexPath.row].location
            cell.detail.text = speedEvents[indexPath.row].speed
            return cell
        }//Updating each Row.
        return UITableViewCell()
    }
    func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "CustomTableViewCell", bundle: nil)
        self.tableView.register(textFieldCell,forCellReuseIdentifier:"CustomTableViewCell")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
