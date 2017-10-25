//
//  SecondViewController.swift
//  test-app
//
//  Created by metasemenov on 22.10.17.
//  Copyright © 2017 metasemenov. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    var contacts = ["telephone": "+79060494212", "mail": "metasemenov@gmail.com", "github": "https://github.com/metasemenov"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactCell {
            let imgName = [String](contacts.keys)[indexPath.row]
            let info = [String](contacts.values)[indexPath.row]
            cell.configureCell(contactInfo: info, imgName: imgName)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    


}

