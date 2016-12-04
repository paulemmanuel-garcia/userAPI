//
//  AlbumViewController.swift
//  Users
//
//  Created by Paul-Emmanuel on 04/12/16.
//  Copyright © 2016 rstudio. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {
    
    var user: User?
    var albums: [Album] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let user = user {
            title = user.username
            AlbumsController.albums.get(forUser: user.id) {
                albums, error in
                if let _ = error {
                    return
                }
                
                self.albums = albums
                self.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AlbumDetail", let indexPath = tableView.indexPathForSelectedRow {
            (segue.destination as? AlbumDetailViewController)?.album = albums[indexPath.row]
        }
    }
    
}

// MARK: - UITableViewDegate - UITableViewDatasource
extension AlbumViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = albums[indexPath.row].title
        return cell
    }
}
