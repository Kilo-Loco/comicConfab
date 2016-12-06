//
//  Post.swift
//  Comic Confab
//
//  Created by Kyle Lee on 12/4/16.
//  Copyright © 2016 Kyle Lee. All rights reserved.
//

import Foundation

class Post {
    private var _commentsCount: Int!
    private var _description: String!
    private var _imageUrl: String!
    private var _title: String!
    private var _votesCount: Int!
    private var _postId: String!
    
    var commentsCount: Int { return self._commentsCount }
    var description: String { return self._description }
    var imageURL: String { return self._imageUrl }
    var title: String { return self._title }
    var votesCount: Int { return self._votesCount }
    var postId: String { return self._postId }
    
    init(commentsCount: Int, description: String, imageUrl: String, title: String, votesCount: Int) {
        
        self._commentsCount = commentsCount
        self._description = description
        self._imageUrl = imageUrl
        self._title = title
        self._votesCount = votesCount
    }
    
    init(postId: String, postData: Dictionary<String, AnyObject>) {
        guard let commentsCount = postData["commentsCount"] as? Int else { return }
        self._commentsCount = commentsCount
        guard let description = postData["description"] as? String else { return }
        self._description = description
        guard let imageUrl = postData["imageUrl"] as? String else { return }
        self._imageUrl = imageUrl
        guard let title = postData["title"] as? String else { return }
        self._title = title
        guard let votesCount = postData["votesCount"] as? Int else { return }
        self._votesCount = votesCount
        self._postId = postId
        
    }
    
}
