//
//  FeedVC.swift
//  Comic Confab
//
//  Created by Kyle Lee on 10/21/16.
//  Copyright © 2016 Kyle Lee. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        DataService.ds.REF_POSTS.observe(FIRDataEventType.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print(snap)
                    guard let postDict = snap.value as? Dictionary<String, AnyObject> else { return }
                    let postId = snap.key
                    let post = Post(postId: postId, postData: postDict)
                    self.posts.append(post)
                }
            }
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOut(_ sender: AnyObject) {
        let keychain = KeychainWrapper.defaultKeychainWrapper().removeObjectForKey(KEY_UID)
        print("KYLE: REMOVING KEYCHAING \(keychain)")
        do {
            try FIRAuth.auth()?.signOut()
            self.performSegue(withIdentifier: "SignOut", sender: nil)
        } catch {
            print(error)
        }
    }
    
    @IBAction func onPostButtonTapped(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Post", message: "What's on your mind?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField { (titleTF) in
            print("TEXT FIELD ADDED")
        }
        alert.addTextField { (descriptionTF) in
            print("TEXT FIELD ADDED")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        let postAction = UIAlertAction(title: "Post", style: UIAlertActionStyle.default) { (post) in
            print(alert.textFields!.first!.text!)
            print(alert.textFields!.last!.text!)
        }
        alert.addAction(cancelAction)
        alert.addAction(postAction)
        self.present(alert, animated: true, completion: nil)
    }
    

}

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as? FeedTableViewCell {
            
            let post = self.posts[indexPath.row]
            cell.configureCell(post: post)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
}
