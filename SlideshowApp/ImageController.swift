//
//  ImageController.swift
//  SlideshowApp
//
//  Created by mafu on 2019/09/24.
//  Copyright © 2019 masa-fu. All rights reserved.
//

import UIKit

class ImageController: UIViewController {
    @IBOutlet weak var imageWideView: UIImageView!
    
    // 受け取るためのプロパティ（変数）を宣言しておく
    var pictureNo = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 画像の名前の配列
        let imageNameArray = [
            "picture1.jpeg",
            "picture2.jpeg",
            "picture3.jpeg",
        ]
        // 表示している画像の番号から名前を取り出し
        let name = imageNameArray[pictureNo]
        
        // 画像を読み込み
        let image = UIImage(named: name)
        
        // Inage Viewに読み込んだ画像をセット
        self.imageWideView.frame = CGRect(x:50,y:50,width: 350,height:350)
        self.imageWideView.center = self.view.center
        imageWideView.image = image
    }
}
