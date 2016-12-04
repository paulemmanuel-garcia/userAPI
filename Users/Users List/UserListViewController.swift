//
//  UserListViewController.swift
//  Users
//
//  Created by Paul-Emmanuel on 04/12/16.
//  Copyright © 2016 rstudio. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UsersController.users.get {
            users, error in
            
            if let _ = error {
                return
            }

            self.users = users
            self.tableView.reloadData()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserAlbums", let indexPath = tableView.indexPathForSelectedRow {
            (segue.destination as? AlbumViewController)?.user = users[indexPath.row]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UITableViewDegate - UITableViewDatasource
extension UserListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") else {
            return UITableViewCell()
        }

        cell.textLabel?.text = users[indexPath.row].username
        return cell
    }
}
