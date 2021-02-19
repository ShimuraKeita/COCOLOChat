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
        
        self.refreshControl = UIRefreshControl()
        self.tableView.refreshControl = self.refreshControl
        
        tableView.tableFooterView = UIView()
        
        downloadAllChanels()
        downloadSubscribedChannels()
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
    
    //MARK: TableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if ChannelsSegmentOutlet.selectedSegmentIndex == 1 {
            showChannelView(channel: allChannels[indexPath.row])
        } else {
            showChat(channel: subscribeChannels[indexPath.row])
        }
    }
    
    //MARK: - IBActions
    @IBAction func channelSegmentValueChanged(_ sender: Any) {
        
        tableView.reloadData()
    }
    
    //MARK: - Download channels
    private func downloadAllChanels() {
        
        FirebaseChannelListener.shared.downloadAllChannels { (allChannels) in
            
            self.allChannels = allChannels
            
            if self.ChannelsSegmentOutlet.selectedSegmentIndex == 1 {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func downloadSubscribedChannels() {
        FirebaseChannelListener.shared.downloadSubscribedChannels { (subscribedChannels) in
            
            self.subscribeChannels = subscribedChannels
            
            if self.ChannelsSegmentOutlet.selectedSegmentIndex == 0 {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    //MARK: - UIScrollViewDelegate
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if self.refreshControl!.isRefreshing {
            self.downloadAllChanels()
            self.refreshControl!.endRefreshing()
        }
    }
    
    //MARK: - Navigation
    private func showChannelView(channel: Channel) {
        
        let channelVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "channelView") as! ChannelDetailTableViewController
        
        channelVC.channel = channel
        channelVC.delegate = self
        self.navigationController?.pushViewController(channelVC, animated: true)
    }
    
    private func showChat(channel: Channel) {
        print(1111111111111111111)
    }
}

extension ChannelsTableViewController: ChannelDetailTableViewControllerDelegate {
    func didClickFollow() {
        print(5555555555)
        self.downloadAllChanels()
    }
}
