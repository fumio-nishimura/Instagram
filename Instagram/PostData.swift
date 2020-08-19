//
//  PostData.swift
//  Instagram
//
//  Created by 西村史旺 on 2020/08/14.
//  Copyright © 2020 Fumio Nishimura. All rights reserved.
//

import UIKit
import Firebase


class PostData: NSObject {
    var id: String
    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = []
    var isLiked: Bool = false
    var comments: [String] = []
    
    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID
        
        let postDic = document.data()
        
        self.name = postDic["name"] as? String
        
        self.caption = postDic["caption"] as? String
        
        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()
        
        if let likes = postDic["likes"] as? [String] {
            self.likes = likes
        }
        if let myid = Auth.auth().currentUser?.uid {
            // likes の配列の中に myid が含まれているかチェックすることで、自分がいいねを押しているかを判断
            if self.likes.firstIndex(of: myid) != nil {
                // myid があれば、いいねを押していると認識する
                self.isLiked = true
            }
        }
        if let comments = postDic["comments"] as? [String] {
            self.comments = comments
        }
    }
}
