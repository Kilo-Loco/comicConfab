//
//  FeedTableViewCell.swift
//  Comic Confab
//
//  Created by Kyle Lee on 12/4/16.
//  Copyright © 2016 Kyle Lee. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var sourceAgeLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postDescriptionLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var upVoteButton: UIButton!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var downVoteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(post: Post) {
        self.postTitleLabel.text = post.title
        self.postDescriptionLabel.text = post.description
        self.voteCountLabel.text = String(post.votesCount)
    }
    
    

}
