//
//  SettingsTableViewController.swift
//  cc2
//
//  Created by 志村　啓太 on 2021/02/11.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var avaterImageView: UIImageView!
    @IBOutlet weak var appVersionLabel: UILabel!
    
    //MARK: - ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        showUserInfo()
    }
    
    //MARK: - TableView Delegates
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor(named: "tableViewBackgroundColor")
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return section == 0 ? 0.0 : 10.0
    }
    
    //MARK: - IBActions
    @IBAction func tellAFriendButtonPressed(_ sender: Any) {
        print(111111)
    }
    
    @IBAction func termAndConditionsButtonPressed(_ sender: Any) {
        print(2222222222)
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        print(333333333333)
    }
    
    //MARK: - UpdateUI
    private func showUserInfo() {
  
        if let user = User.currentUser {
            usernameLabel.text = user.username
            statusLabel.text = user.status
            appVersionLabel.text = "アプリバージョン\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "")"
            
            if user.avatarLink != "" {
                
            }
        }
    }
}
