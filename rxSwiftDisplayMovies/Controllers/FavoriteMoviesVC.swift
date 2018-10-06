//
//  FavoriteMoviesVC.swift
//  rxSwiftDisplayMovies
//
//  Created by OSX on 10/4/18.
//  Copyright © 2018 DDSCompany. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FavoriteMoviesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var tableViewFavorite: UITableView!
    
    var ref : DatabaseReference!
    
    var favoriteMovies = [String]() {
        didSet{
            self.tableViewFavorite.reloadData()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
        // Do any additional setup after loading the view.

        ref.child("favourites").observeSingleEvent(of: .value) { (snapshot) in
            
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let favoriteMovieDict = child.value as? [String:String] ?? [:]
                if let favoriteMovie = favoriteMovieDict["movie-title"] {
                    
                        self.favoriteMovies.append(favoriteMovie)
                }
            }
        }
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFavorites")
        cell?.textLabel?.text = favoriteMovies[indexPath.row]
        return cell!
        
    }
   
    
    

}
