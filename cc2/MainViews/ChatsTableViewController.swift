//
//  ChatsTableViewController.swift
//  cc2
//
//  Created by 志村　啓太 on 2021/02/14.
//

import UIKit

class ChatsTableViewController: UITableViewController {
    
    //MARK: - Vars
    var allRecents: [RecentChat] = []
    var filteredRecents: [RecentChat] = []
    
    let searchController = UISearchController(searchResultsController: nil)

    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        downloadRecentChats()
        setupSearchController()
    }
    
    //MARK: - IBActions
    @IBAction func composeBarButtonPressed(_ sender: Any) {
        
        let userView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "usersView") as! UsersTableViewController
        
        navigationController?.pushViewController(userView, animated: true)
    }
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchController.isActive ? filteredRecents.count : allRecents.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RecentTableViewCell
        
        let recent = searchController.isActive ? filteredRecents[indexPath.row] : allRecents[indexPath.row]
        
        cell.configure(recent: recent)
        return cell
    }
    
    //MARK: - TableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let recent = searchController.isActive ? filteredRecents[indexPath.row] : allRecents[indexPath.row]
        
        FirebaseRecentListener.shared.clearUnreadContainer(recent: recent)
        
        goToChat(recent: recent)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let recent = searchController.isActive ? filteredRecents[indexPath.row] :allRecents[indexPath.row]
            
            FirebaseRecentListener.shared.deleteRecent(recent)
            
            searchController.isActive ? self.filteredRecents.remove(at: indexPath.row) : allRecents.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor(named: "tableViewBackgroundColor")
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 5
    }
    
    //MARK: - Download Chats
    private func downloadRecentChats() {
        FirebaseRecentListener.shared.downloadRecentChatsFromFirebase { (allChats) in
            
            self.allRecents = allChats
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Navigation
    
    private func goToChat(recent: RecentChat) {
    
        restartChat(chatRoomId: recent.chatRoomId, memberIds: recent.memberIds)
        
        let privateChatView = ChatViewController(chatId: recent.chatRoomId, recipientId: recent.receiverId, recipientName: recent.receiverName)
        
        privateChatView.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(privateChatView, animated: true)
    }
    
    //MARK: - SetupSearchController
    private func setupSearchController() {
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "ユーザー検索"
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
    }
    
    private func filteredContentForSearchText(searchText: String) {
        
        filteredRecents = allRecents.filter({ (recent) -> Bool in
            return recent.receiverName.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
}

extension ChatsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
