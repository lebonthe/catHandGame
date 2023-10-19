//
//  ViewController.swift
//  catHandGame
//
//  Created by Min Hu on 2023/10/19.
//

import UIKit

import AVFAudio

class ViewController: UIViewController {
    // 顯示電腦輪到海帶呀海帶的 Label
    @IBOutlet weak var computerTurnLabel: UILabel!
    // 顯示玩家輪到海帶呀海帶的 Label
    @IBOutlet weak var playerTurnLabel: UILabel!
    // 電腦的左手（從玩家視角）
    @IBOutlet weak var computerLeftHandImageView: UIImageView!
    // 電腦的右手（從玩家視角）
    @IBOutlet weak var computerRightHandImageView: UIImageView!
    // 玩家的左手
    @IBOutlet weak var playerLeftHandImageView: UIImageView!
    // 玩家的右手
    @IBOutlet weak var playerRightHandImageView: UIImageView!
    // 出拳選擇的左鍵 View
    @IBOutlet weak var chooseLeftView: UIView!
    // 出拳選擇的中間鍵 View
    @IBOutlet weak var chooseMiddleView: UIView!
    // 出拳選擇的右鍵 View
    @IBOutlet weak var chooseRightView: UIView!
    // 出拳選擇中間鍵裡的左手
    @IBOutlet weak var leftHandInChooseViewImageView: UIImageView!
    // 出拳選擇中間鍵裡的右手
    @IBOutlet weak var rightHandInChooseViewImageView: UIImageView!
    // 左鍵 Button
    @IBOutlet weak var leftButton: UIButton!
    // 中間鍵 Button
    @IBOutlet weak var middleButton: UIButton!
    // 右鍵 Button
    @IBOutlet weak var rightButton: UIButton!
    // 顯示勝場的 Label
    @IBOutlet weak var winScoreLabel: UILabel!
    // 顯示敗場的 Label
    @IBOutlet weak var loseScoreLabel: UILabel!
    // 創建 AVSpeechSynthesizer 實例 synthesizer，將文本轉化為語音並播放
    let synthesizer = AVSpeechSynthesizer()
    // 設定變數儲存電腦隨機數字
    var randomHands = 0
    // 設定變數儲存勝負回合
    var winScore = 0
    var loseScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 更改選擇鍵為圓邊
        chooseLeftView.layer.cornerRadius = 40
        chooseMiddleView.layer.cornerRadius = 40
        chooseRightView.layer.cornerRadius = 40
        // 更改選擇鍵中的手旋轉角度
        leftHandInChooseViewImageView.transform = CGAffineTransform(rotationAngle: .pi / 180 * 270)
        rightHandInChooseViewImageView.transform = CGAffineTransform(rotationAngle: .pi / 180 * 90)
        // 使玩家先當海帶呀海帶方
        computerTurnLabel.isHidden = true
        playerTurnLabel.isHidden = false
        // 玩家雙手預設隱藏
        playerLeftHandImageView.isHidden = true
        playerRightHandImageView.isHidden = true
        // 電腦雙手預設隱藏
        computerLeftHandImageView.isHidden = true
        computerRightHandImageView.isHidden = true
        // 勝負回合歸 0
        winScore = 0
        loseScore = 0
        winScoreLabel.text = "\(winScore)"
        loseScoreLabel.text = "\(loseScore)"
        
    }
    // 設定手機說海帶呀海帶的函式
    func speakKelp(){
        // 設定文本內容
        let utterance = AVSpeechUtterance(string: "海帶，呀海，帶。")
        // 設定語言為台灣中文
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        utterance.rate = 0.6 // 調整速度
        utterance.pitchMultiplier = 0.9 // 調整音高
        // 用上方聲音講出文本的內容
        synthesizer.speak(utterance)
    }
    
    // 電腦出拳
    func computerChooseHand(){
        randomHands = Int.random(in: 0...2)
        // 顯示出拳
        computerLeftHandImageView.isHidden = false
        computerRightHandImageView.isHidden = false
        switch randomHands {
        case 0:
            // 電腦出雙手向上拳
            computerLeftHandImageView.image = UIImage(named: "cat_hand_brown_back")
            computerRightHandImageView.image = UIImage(named: "cat_hand_brown_back")
            // 設定位置為原位
            computerLeftHandImageView.frame = CGRect(x: 76, y: 176, width: 120, height: 120)
            computerRightHandImageView.frame = CGRect(x: 179, y: 176, width: 120, height: 120)
            // 角度歸 180
            computerLeftHandImageView.transform = CGAffineTransform(rotationAngle: .pi / 180 * 180)
            computerRightHandImageView.transform = CGAffineTransform(rotationAngle: .pi / 180 * 180)
        case 1:
            // 電腦出雙手平舉拳
            computerLeftHandImageView.image = UIImage(named: "cat_hand_brown_back")
            computerRightHandImageView.image = UIImage(named: "cat_hand_brown_back")
            // 設定位置向兩旁移動
            computerLeftHandImageView.frame = CGRect(x: 40, y: 176, width: 120, height: 120)
            computerRightHandImageView.frame = CGRect(x: 215, y: 176, width: 120, height: 120)
            // 改變兩手角度
            computerLeftHandImageView.transform = CGAffineTransform(rotationAngle: .pi / 180 * 270)
            computerRightHandImageView.transform = CGAffineTransform(rotationAngle: .pi / 180 * 90)
        default:
            // 電腦出投降拳
            computerLeftHandImageView.image = UIImage(named: "cat_hand_brown")
            computerRightHandImageView.image = UIImage(named: "cat_hand_brown")
            // 設定位置為原位
            computerLeftHandImageView.frame = CGRect(x: 76, y: 176, width: 120, height: 120)
            computerRightHandImageView.frame = CGRect(x: 179, y: 176, width: 120, height: 120)
            // 角度歸 180
            computerLeftHandImageView.transform = CGAffineTransform(rotationAngle: .pi / 180 * 180)
            computerRightHandImageView.transform = CGAffineTransform(rotationAngle: .pi / 180 * 180)
        }
    }
    
    // 按下左邊選擇鍵
    @IBAction func clickLeftButton(_ sender: UIButton) {
        // 切換電腦與玩家回合顯示
        computerTurnLabel.isHidden.toggle()
        playerTurnLabel.isHidden.toggle()
        // 如果為電腦 Turn，則播放語音
        if computerTurnLabel.isHidden == false{
            speakKelp()
        }
        // 顯示出拳
        playerLeftHandImageView.isHidden = false
        playerRightHandImageView.isHidden = false
        // 玩家出雙手向上拳
        playerLeftHandImageView.image = UIImage(named: "cat_hand_mike_back")
        playerRightHandImageView.image = UIImage(named: "cat_hand_mike_back")
        // 設定位置為原位
        playerLeftHandImageView.frame = CGRect(x: 76, y: 324, width: 120, height: 120)
        playerRightHandImageView.frame = CGRect(x: 179, y: 324, width: 120, height: 120)
        // 角度歸 0
        playerLeftHandImageView.transform = CGAffineTransform(rotationAngle: .pi / 180 * 0)
        playerRightHandImageView.transform = CGAffineTransform(rotationAngle: .pi / 180 * 0)
        // 電腦出拳
        computerChooseHand()
        // 判斷勝負
        if randomHands == 0{ // 如果電腦也是高舉雙手
            // 如果當下不是顯示玩家
            if playerTurnLabel.isHidden == true{
                winScore += 1 // 則玩家+1勝
                // 勝利回合 Label 更新
                winScoreLabel.text = "\(winScore)"
                // 如果當下不是顯示電腦
            }else if computerTurnLabel.isHidden == true{
                loseScore += 1 // 則玩家+1敗
                // 輸的回合 Label 更新
                loseScoreLabel.text = "\(loseScore)"
            }
                }
    }
    // 按下中間選擇鍵
    @IBAction func clickMiddleButton(_ sender: UIButton) {
        // 切換電腦與玩家回合顯示
        computerTurnLabel.isHidden.toggle()
        playerTurnLabel.isHidden.toggle()
        // 如果為電腦 Turn，則播放語音
        if computerTurnLabel.isHidden == false{
            speakKelp()
        }
        // 顯示出拳
        playerLeftHandImageView.isHidden = false
        playerRightHandImageView.isHidden = false
        // 玩家出雙手平舉拳
        playerLeftHandImageView.image = UIImage(named: "cat_hand_mike_back")
        playerRightHandImageView.image = UIImage(named: "cat_hand_mike_back")
        // 設定位置向兩旁移動
        playerLeftHandImageView.frame = CGRect(x: 40, y: 324, width: 120, height: 120)
        playerRightHandImageView.frame = CGRect(x: 215, y: 324, width: 120, height: 120)
        // 改變兩手角度
        playerLeftHandImageView.transform = CGAffineTransform(rotationAngle: .pi / 180 * 270)
        playerRightHandImageView.transform = CGAffineTransform(rotationAngle: .pi / 180 * 90)
        // 電腦出拳
        computerChooseHand()
        // 判斷勝負
        if randomHands == 1{
            if playerTurnLabel.isHidden == true{
                winScore += 1
                winScoreLabel.text = "\(winScore)"
            }else if computerTurnLabel.isHidden == true{
                loseScore += 1
                loseScoreLabel.text = "\(loseScore)"
            }
                }
    }
    
    // 按下右邊選擇鍵
    @IBAction func clickRightButton(_ sender: UIButton) {
        // 切換電腦與玩家回合顯示
        computerTurnLabel.isHidden.toggle()
        playerTurnLabel.isHidden.toggle()
        // 如果為電腦 Turn，則播放語音
        if computerTurnLabel.isHidden == false{
            speakKelp()
        }
        // 顯示出拳
        playerLeftHandImageView.isHidden = false
        playerRightHandImageView.isHidden = false
        // 玩家出投降拳
        playerLeftHandImageView.image = UIImage(named: "cat_hand_mike")
        playerRightHandImageView.image = UIImage(named: "cat_hand_mike")
        // 設定位置為原位
        playerLeftHandImageView.frame = CGRect(x: 76, y: 324, width: 120, height: 120)
        playerRightHandImageView.frame = CGRect(x: 179, y: 324, width: 120, height: 120)
        // 角度歸 0
        playerLeftHandImageView.transform = CGAffineTransform(rotationAngle: .pi / 180 * 0)
        playerRightHandImageView.transform = CGAffineTransform(rotationAngle: .pi / 180 * 0)
        // 電腦出拳
        computerChooseHand()
        // 判斷勝負
        if randomHands == 2{
            if playerTurnLabel.isHidden == true{
                winScore += 1
                winScoreLabel.text = "\(winScore)"
            }else if computerTurnLabel.isHidden == true{
                loseScore += 1
                loseScoreLabel.text = "\(loseScore)"
            }
                }
    }
    
    // 重新開始
    @IBAction func resetGame(_ sender: UIButton) {
        viewDidLoad()
    }
    


}

