//
//  FirstViewController.swift
//  test-app
//
//  Created by metasemenov on 22.10.17.
//  Copyright © 2017 metasemenov. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Outlets
    //Post
    @IBOutlet weak var postTitleLbl: UILabel!
    @IBOutlet weak var postBodyLbl: UILabel!
    @IBOutlet weak var postIdTxtField: UITextField!
    @IBOutlet weak var postSubmitBtn: UIButton!
    
    //Comment
    @IBOutlet weak var commNameLbl: UILabel!
    @IBOutlet weak var commBodyLbl: UILabel!
    @IBOutlet weak var commEmailLbl: UILabel!
    @IBOutlet weak var commIdTxtField: UITextField!
    @IBOutlet weak var commSubmitBtn: UIButton!
    
    //Users
    @IBOutlet weak var tableView: UITableView!
    
    //Img
    @IBOutlet weak var imgView: UIImageView!
    
    //ToDo
    @IBOutlet weak var toDoTitleLbl: UILabel!
    @IBOutlet weak var toDoStatusLbl: UILabel!
    
    
    //Variables
    //Post
    var postTitle: String!
    var postBody: String!
    
    //Comment
    var commName: String!
    var commEmail: String!
    var commBody: String!
    
    //Users
    var users = [User]()
    
    //Img
    var img: UIImage!
    
    //ToDo
    var toDoTitle: String!
    var toDoStatus: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(FirstViewController.handleTap))
        view.addGestureRecognizer(tap)
        
        for n in 1...5 {
        requestUsers(id: n) { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
        }
        
        requestImg { (success) in
            if success {
                self.updateImg()
            }
        }
        
        requestToDo { (success) in
            if success {
                self.updateToDoUI()
            }
        }
    }
    
    @IBAction func postSubmitBtnPressed(_ sender: Any) {
        guard let id = postIdTxtField.text, postIdTxtField.text != "" else { return }
        let numId = Int(id)!
        if numId != 0 && numId <= 100 {
            requestPost(id: numId, completion: { (success) in
                self.updatePostUI()
            })
        }
    }
    
    @IBAction func commSubmitBtnPressed(_ sender: Any) {
        guard let id = commIdTxtField.text, commIdTxtField.text != "" else { return }
        let numId = Int(id)!
        if numId != 0 && numId <= 500 {
            requestComment(id: numId, completion: { (success) in
                self.updateCommentUI()
            })
        }
        
    }
    
    func requestPost(id: Int, completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_POSTS)\(id)").responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                let json = JSON(data: data)
                self.postBody = json["body"].stringValue
                self.postTitle = json["title"].stringValue
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func requestComment(id: Int, completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_COMMENTS)\(id)").responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                let json = JSON(data: data)
                self.commName = json["name"].stringValue
                self.commEmail = json["email"].stringValue
                self.commBody = json["body"].stringValue
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func requestUsers(id: Int, completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_USERS)\(id)").responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                let json = JSON(data: data)
                let user = User(userName: json["name"].stringValue, userEmail: json["email"].stringValue, userCity: json["address"]["city"].stringValue, userPhone: json["phone"].stringValue)
                self.users.append(user)
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func requestImg(completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_PHOTOS)3").responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                let json = JSON(data: data)
                let imgUrl = json["url"].stringValue
                
                Alamofire.request("\(imgUrl)").responseData(completionHandler: { (response) in
                    if response.result.error == nil {
                        guard let data = response.data else { return }
                        self.img = UIImage(data: data)
                        completion(true)
                    } else {
                        debugPrint(response.result.error as Any)
                        completion(false)
                    }
                })
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func requestToDo(completion: @escaping CompletionHandler) {
        let randomToDo = Int(arc4random_uniform(200) + 1)
        print("TODO: \(randomToDo)")
        Alamofire.request("\(URL_TODOS)\(randomToDo)").responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                let json = JSON(data: data)
                self.toDoTitle = json["title"].stringValue
                self.toDoStatus = json["completed"].stringValue
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func updatePostUI() {
        postBodyLbl.text = postBody
        postTitleLbl.text = postTitle
    }
    
    func updateCommentUI() {
        commNameLbl.text = commName
        commBodyLbl.text = commBody
        commEmailLbl.text = commEmail
    }
    
    func updateImg() {
        imgView.image = img
    }
    
    func updateToDoUI() {
        toDoTitleLbl.text = toDoTitle
        toDoStatusLbl.text = "Completed: \(toDoStatus!)"
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    
}


//Users table view
extension FirstViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserCell {
            let user = users[indexPath.row]
            cell.configureCell(user: user)
            return cell
        } else {
            return UITableViewCell()
        }
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

