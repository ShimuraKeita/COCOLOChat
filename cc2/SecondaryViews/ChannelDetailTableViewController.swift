//
//  ChannelTableViewController.swift
//  cc2
//
//  Created by 志村　啓太 on 2021/02/19.
//

import UIKit

protocol ChannelDetailTableViewControllerDelegate {
    func didClickFollow()
}

class ChannelDetailTableViewController: UITableViewController {
    
    //MARK: - IBActions
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var membersLabel: UILabel!
    @IBOutlet weak var aboutTextView: UITextView!
    
    //MARK: - Vars
    var channel: Channel!
    var delegate: ChannelDetailTableViewControllerDelegate?
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        tableView.tableFooterView = UIView()
        
        showChannelData()
        configureRightBarButton()
    }
    
    //MARK: - Configure
    private func showChannelData() {
        self.title = channel.name
        nameLabel.text = channel.name
        membersLabel.text = "\(channel.memberIds.count) 人"
        aboutTextView.text = channel.aboutChannel
        setAvatar(avatarLink: channel.avaterLink)
    }
    
    private func configureRightBarButton() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登録", style: .plain, target: self, action: #selector(followChannel))
    }
    
    private func setAvatar(avatarLink: String) {
        print("avatar link is ", avatarLink)
        if avatarLink != "" {
            FileStorage.downloadImage(imageUrl: avatarLink) { (avatarImage) in
                
                DispatchQueue.main.async {
                    self.avatarImageView.image = avatarImage != nil ? avatarImage?.circleMasked : UIImage(named: "avatar")
                }
            }
        } else {
            self.avatarImageView.image = UIImage(named: "avatar")
        }
    }
    
    //MARK: - Actions
    
    @objc func followChannel() {
        channel.memberIds.append(User.currentId)
        FirebaseChannelListener.shared.saveChannel(channel)
        delegate?.didClickFollow()
        self.navigationController?.popViewController(animated: true)
    }
}
