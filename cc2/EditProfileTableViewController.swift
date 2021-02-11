//
//  EditProfileTableViewController.swift
//  cc2
//
//  Created by 志村　啓太 on 2021/02/11.
//

import UIKit
import Gallery
import ProgressHUD

class EditProfileTableViewController: UITableViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var avaterImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
    //MARK: - Vars
    var gallary: GalleryController!
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        configureTextField()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showUserInfo()
    }
    
    //MARK: - TableViewDelegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor(named: "tableViewBackgroundColor")
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return section == 0 ? 0.0 : 30.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - IBActions
    @IBAction func editButtonPressed(_ sender: Any) {
        
        showImageGallery()
    }
    
    
    //MARK: - UpdateUI
    private func showUserInfo() {
        
        if let user = User.currentUser {
            usernameTextField.text = user.username
            statusLabel.text = user.status
            
            if user.avatarLink != "" {
                
            }
        }
    }
    
    //MARK: - Configure
    private func configureTextField() {
        usernameTextField.delegate = self
        usernameTextField.clearButtonMode = .whileEditing
    }
    
    //MARK: - Gallery
    private func showImageGallery() {
        
        self.gallary = GalleryController()
        self.gallary.delegate = self
        
        Config.tabsToShow = [.imageTab, .cameraTab]
        Config.Camera.imageLimit = 1
        Config.initialTab = .imageTab
        
        self.present(gallary, animated: true, completion: nil)
    }
    
    //MARK: - UploadImages
    private func uploadAvaterImage(_ image: UIImage) {
        
        
        let fileDirectory = "Avaters/" + "_\(User.currentId)" + ".jpg"
        
        FileStorage.uploadImage(image, dictionary: fileDirectory) { (avaterLink) in
            
            if var user = User.currentUser {
                user.avatarLink = avaterLink ?? ""
                saveUserLocally(user)
                FirebaseUserListener.shared.saveUserToFireStore(user)
            }
        }
    }
}

extension EditProfileTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == usernameTextField {
            if textField.text != "" {
                if var user = User.currentUser {
                    user.username = textField.text!
                    saveUserLocally(user)
                    FirebaseUserListener.shared.saveUserToFireStore(user)
                }
            }
            textField.resignFirstResponder()
            return false
        }
        
        return true
    }
}

extension EditProfileTableViewController: GalleryControllerDelegate {
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        
        if images.count > 0 {
            images.first!.resolve { (avaterImage) in
                if avaterImage != nil {
                    self.uploadAvaterImage(avaterImage!)
                    self.avaterImageView.image = avaterImage
                } else {
                    ProgressHUD.showError("画像が選択されていません。")
                }
            }
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
