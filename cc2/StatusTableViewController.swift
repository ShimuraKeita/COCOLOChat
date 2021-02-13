//
//  StatusTableViewController.swift
//  cc2
//
//  Created by 志村　啓太 on 2021/02/13.
//

import UIKit

class StatusTableViewController: UITableViewController {
    
    //MARK: - Vars
    var allStatus: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        loadUserStatus()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allStatus.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let status = allStatus[indexPath.row]
        cell.textLabel?.text = status
        
        cell.accessoryType = User.currentUser?.status == status ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - LoadingStatus
    private func loadUserStatus() {
        allStatus = userDefaults.object(forKey: kSTATUS) as! [String]
        tableView.reloadData()
    }
}
