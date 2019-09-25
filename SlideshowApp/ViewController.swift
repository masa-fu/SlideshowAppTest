//
//  ViewController.swift
//  SlideshowApp
//
//  Created by mafu on 2019/09/23.
//  Copyright © 2019 masa-fu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var autoStart: UIButton!
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
    
    // 画像を押した時に呼び出し
    @IBAction func onTapImage(_ sender: Any) {
        // セグエを使用して画面を遷移
        self.performSegue(withIdentifier: "result", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueから遷移先のImageControllerを取得する
        let imageController:ImageController = segue.destination as! ImageController
        
        // 遷移先のImageControllerで宣言しているpictureNoに現在の画像の番号を代入して渡す
        imageController.pictureNo = pictureNo
    }
    
    // 進むボタンを押した時に呼び出し
    @IBAction func startButton(_ sender: Any) {
        // autostart変数が0(停止中)の時のみ処理
        if (autostart == 0) {
            start()
        }
    }
    
    // 戻るボタンを押した時に呼び出し
    @IBAction func backButton(_ sender: Any) {
        // autostart変数が0(停止中)の時のみ処理
        if (autostart == 0) {
            back()
        }
    }
    
    // 再生or停止ボタンを押した時に呼び出し
    @IBAction func autoStart(_ sender: Any) {
        // 再生ボタンが押された場合
        if (autostart == 0) {
            autoStart.setTitle("停止", for: .normal)
            startButton.setTitle("不可", for: .normal)
            startButton.isEnabled = false // ボタン無効
            backButton.setTitle("不可", for: .normal)
            backButton.isEnabled = false // ボタン無効
            autostart = 1
            // 動作中のタイマーを1つに保つために、 timer が存在しない場合だけ、タイマーを生成して動作させる
            if self.timer == nil {
                self.timer = Timer.scheduledTimer(timeInterval:1, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
            }
        }
        // 停止ボタンが押された場合
        else {
            autoStart.setTitle("再生", for: .normal)
            startButton.setTitle("進む", for: .normal)
            startButton.isEnabled = true // ボタン有効
            backButton.setTitle("戻る", for: .normal)
            backButton.isEnabled = true // ボタン有効
            autostart = 0
            // タイマー停止
            self.timer.invalidate()
            self.timer = nil
        }
    }
    
    // 表示している画像の番号
    var pictureNo = 0
    
    // 再生/停止ボタン
    var autostart = 0

    // タイマー
    var timer: Timer!
    
    // タイマー用の時間のための変数
    var timer_sec: Int = 0
    
    func start() {
        // 表示している画像が1枚目、2枚目の時は番号を1増やす
        if (pictureNo < 2) {
            pictureNo += 1
        }
            // 表示している画像が3枚目の時は番号を0にする
        else {
            pictureNo = 0
        }
        // 表示している画像の番号を元に画像を表示する
        displayImage()
    }

    func back() {
        if ( 0 < pictureNo && pictureNo < 3 ) {
            // 表示している画像が2枚目、3枚目の時は番号を1減らす
            pictureNo -= 1
        }
            // 表示している画像が1枚目の時は番号を2にする
        else {
            pictureNo = 2
        }
        //表示している画像の番号を元に画像を表示する
        displayImage()
    }
    
    // 表示している画像の番号を元に画像を表示する
    func displayImage() {
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
        self.imageView.frame = CGRect(x:50,y:50,width: 250,height:250)
        self.imageView.center = self.view.center
        imageView.image = image
    }
    
    // select: #select(updatetimer(_:) で指定された関数
    // timeInterval: 1, repeats: true で指定された通り、
    // 1秒毎に呼び出され続ける
    @objc func updateTimer(_ timer: Timer) {
        self.timer_sec += 1
        if (self.timer_sec == 2) {
            self.timer_sec = 0
            start()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 画像ファイル読み込み
        let image = UIImage(named: "picture1.jpeg")

        // Image Viewに画像を設定
        self.imageView.frame = CGRect(x:50,y:50,width: 250,height:250)
        self.imageView.center = self.view.center
        imageView.image = image
    }


}

