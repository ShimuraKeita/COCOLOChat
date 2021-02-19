//
//  ChannelsTableViewController.swift
//  cc2
//
//  Created by 志村　啓太 on 2021/02/17.
//

import UIKit

class ChannelsTableViewController: UITableViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var ChannelsSegmentOutlet: UISegmentedControl!
    
    //MARK: - Vars
    var allChannels: [Channel] = []
    var subscribeChannels: [Channel] = []
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .always
        self.title = "チャンネル"
        
        tableView.tableFooterView = UIView()
        
        downloadChanels()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChannelsSegmentOutlet.selectedSegmentIndex == 0 ? subscribeChannels.count : allChannels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ChannelsTableViewCell
        
        let channel = ChannelsSegmentOutlet.selectedSegmentIndex == 0 ? subscribeChannels[indexPath.row] : allChannels[indexPath.row]

        cell.configure(channel: channel)
        
        return cell
    }
    
    //MARK: - IBActions
    @IBAction func channelSegmentValueChanged(_ sender: Any) {
        
        tableView.reloadData()
    }
    
    //MARK: - Download channels
    private func downloadChanels() {
        
        FirebaseChannelListener.shared.downloadAllChannels { (allChannels) in
            
            self.allChannels = allChannels
            
            if self.ChannelsSegmentOutlet.selectedSegmentIndex == 1 {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        FirebaseChannelListener.shared.downloadSubscribedChannels { (subscribedChannels) in
            
            self.subscribeChannels = subscribedChannels
            
            if self.ChannelsSegmentOutlet.selectedSegmentIndex == 0 {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
