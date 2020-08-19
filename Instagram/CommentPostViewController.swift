//
//  CommentPostViewController.swift
//  Instagram
//
//  Created by 西村史旺 on 2020/08/15.
//  Copyright © 2020 Fumio Nishimura. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD


class CommentPostViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    var postId = ""
    
    // 投稿ボタンをタップした時に呼ばれるメソッド
    @IBAction func handlePostButton(_ sender: Any) {
        // コメント投稿データの保存場所（ドキュメントID）を定義
        let postRef = Firestore.firestore().collection(Const.PostPath).document(postId)
        // HUD で投稿処理中の表示を開始
        SVProgressHUD.show()
        
        let commentText = self.textField.text
        if commentText == nil {
            
        }
        // FireStore にコメントデータを追加する
        let name = Auth.auth().currentUser?.displayName
        
        var updateValue: FieldValue
        updateValue = FieldValue.arrayUnion(["\(name!) : \(commentText!)"])
        
        postRef.updateData(["comments": updateValue])
        
        
        // HUD で投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "コメントを投稿しました")
        // 投稿処理が完了したので先頭画面に戻る
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    // キャンセルボタンを押した時に呼ばれるメソッド
    @IBAction func handleCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
