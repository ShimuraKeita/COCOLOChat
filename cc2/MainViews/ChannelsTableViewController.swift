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
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .always
        self.title = "チャンネル"
        
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    //MARK: - IBActions
    @IBAction func channelSegmentValueChanged(_ sender: Any) {
    }
}
