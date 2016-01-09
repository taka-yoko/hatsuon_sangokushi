//
//  QuizViewController.swift
//  hatsuon_sangokushi
//
//  Created by tyoko on 2015/11/03.
//  Copyright © 2015年 tyoko. All rights reserved.
//

import UIKit
import AudioToolbox

class QuizViewController: UIViewController {
    
    //武将データ格納用配列
    var feeds = NSMutableArray()
    
    //第○問
    var questionCount = 0
    
    //総問題数（10問）
    var totalQuestionCount = 10
    
    //正解数
    var correctCount = 0
    
    //正解の番号
    var correctNum = 0
    
    //plist全体の人物数
    var totalFeeds = 0
    
    //問題の位置を格納する配列
    var questionArray = [Int]()
    
    //第0問／全0問
    @IBOutlet weak var questionCountLabel: UILabel!
    
    //ピンイン表示ラベル
    @IBOutlet weak var pinyinLabel: UILabel!
    
    //画像表示部分
    @IBOutlet weak var questionImageView: UIImageView!
    
    //人物1,2,3ボタン
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    
    //ボタンが押された時のイベント
    @IBAction func onPushButton1(sender: AnyObject) {
        if correctNum == 1 {
            correctCount++
            questionImageView.image = UIImage(named: "asset_komei_hao")
        } else {
            questionImageView.image = UIImage(named: "asset_komei_buhao")
        }
        
        changeCorrectButtonColor()
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "nextQuestion", userInfo: nil, repeats: false)
    }
    
    @IBAction func onPushButton2(sender: AnyObject) {
        if correctNum == 2 {
            correctCount++
            questionImageView.image = UIImage(named: "asset_komei_hao")
        } else {
            questionImageView.image = UIImage(named: "asset_komei_buhao")
        }

        changeCorrectButtonColor()
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "nextQuestion", userInfo: nil, repeats: false)

    }
    
    @IBAction func onPushButton3(sender: AnyObject) {
        if correctNum == 3 {
            correctCount++
            questionImageView.image = UIImage(named: "asset_komei_hao")
        } else {
            questionImageView.image = UIImage(named: "asset_komei_buhao")
        }
        
        changeCorrectButtonColor()
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "nextQuestion", userInfo: nil, repeats: false)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_2.jpg")!)
        
        //button1.layer.cornerRadius = 3
        //button2.layer.cornerRadius = 3
        //button3.layer.cornerRadius = 3
        
        let filePath = NSBundle.mainBundle().pathForResource("Person", ofType: "plist")
        
        feeds = NSMutableArray(contentsOfFile: filePath!)!
        
        //plist全体での人物数
        totalFeeds = feeds.count
        
        //plist全体からランダムにtotalQuestionCount数選択
        questionArray = pickupShuffle(totalFeeds, pickupNum: totalQuestionCount)
        
        //第○問の初期化
        questionCount = 0
        
        //正解数の初期化
        correctCount = 0

        //問題作成
        nextQuestion()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //問題を作成する関数
    func nextQuestion(){
        
        button1.backgroundColor = UIColor.whiteColor()
        button1.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button2.backgroundColor = UIColor.whiteColor()
        button2.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button3.backgroundColor = UIColor.whiteColor()
        button3.setTitleColor(UIColor.blackColor(), forState: .Normal)
        
        questionImageView.image = UIImage(named: "asset_komei_dot")
        
        questionCount++
        
        if questionCount <= totalQuestionCount {
            
            questionCountLabel.text = String(format: "第%d問／全%d問", questionCount, totalQuestionCount)
            
            let q = questionArray[questionCount - 1]
            
            //ピンイン姓
            let pinyin_sei = feeds[q].objectForKey("pinyin_sei") as? String
            //ピンイン名
            var pinyin_mei = feeds[q].objectForKey("pinyin_mei") as? String
            //名前のない（姓名区別がない）武将の場合
            if pinyin_mei == "null" {
                pinyin_mei = ""
            }
            //ピンイン表示
            pinyinLabel.text = pinyin_sei! + " " + pinyin_mei!
            
            //中国語名（正解）
            let chinese = feeds[q].objectForKey("chinese") as? String
            
            //中国語名（不正解2つ）
            let wrongAnsArray = pickupShuffle2(totalFeeds, pickupNum: 2, exclude: q)
            let wrongAns1 = feeds[wrongAnsArray[0]].objectForKey("chinese") as? String
            let wrongAns2 = feeds[wrongAnsArray[1]].objectForKey("chinese") as? String
            
            
            //選択肢格納用配列
            var nestArray = [[String : String]]()
            
            var ar1 = [String : String]()
            ar1["name"] = chinese
            ar1["ans"] = "correct"
            
            var ar2 = [String : String]()
            ar2["name"] = wrongAns1
            ar2["ans"] = "wrong"
            
            var ar3 = [String : String]()
            ar3["name"] = wrongAns2
            ar3["ans"] = "wrong"
            
            nestArray.append(ar1)
            nestArray.append(ar2)
            nestArray.append(ar3)
            
            nestArray.shuffle(nestArray.count)
            
            //正解の位置
            correctNum = 1
            for ar in nestArray {
                if ar["ans"] == "correct" {
                    break
                }
                correctNum++
            }
            
            //答え1・2・3ボタンを設定
            button1.setTitle(nestArray[0]["name"], forState: .Normal)
            button2.setTitle(nestArray[1]["name"], forState: .Normal)
            button3.setTitle(nestArray[2]["name"], forState: .Normal)
            
            //音声ファイルの再生
            let mp3 = feeds[q].objectForKey("mp3") as? String
            var soundIdRing:SystemSoundID = 0
            let soundUrl = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(mp3, ofType: "mp3")!)
            
            AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
            AudioServicesPlaySystemSound(soundIdRing)
            
            
        } else {
            performSegueWithIdentifier("toResult", sender: self)
        }
        
        
    }
    
    //セグエの実装
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toResult" {
            
            let resultViewController = segue.destinationViewController as! ResultViewController
            
            let correctRatio = Int((Double(correctCount) / Double(totalQuestionCount)) * 100)
            
            resultViewController.totalQuestionCount = totalQuestionCount
            resultViewController.correctCount = correctCount
            resultViewController.questionResult = correctRatio
            
        }
    }
    
    //totalNumまでのランダム値をpickupNum個ピックアップして、配列として返す
    func pickupShuffle(totalNum: Int, pickupNum: Int) -> [Int] {
        
        //戻り値を格納する配列
        var shuffledArray = [Int]()
        
        var i = 0
        repeat {
            let j = (Int)(arc4random_uniform(UInt32(totalNum)))
            
            if !(shuffledArray.contains(j)) {
                shuffledArray.append(j)
                i++
            }
            
        } while i < pickupNum
        
        return shuffledArray
    }
    
    
    //totalNumまでのランダム値をpickupNum個ピックアップして、配列として返す
    //excludeは除外する
    func pickupShuffle2(totalNum: Int, pickupNum: Int, exclude: Int) -> [Int] {
        
        //戻り値を格納する配列
        var shuffledArray = [Int]()
        
        var i = 0
        repeat {
            let j = (Int)(arc4random_uniform(UInt32(totalNum)))
            
            if !(shuffledArray.contains(j)) && j != exclude {
                shuffledArray.append(j)
                i++
            }
            
        } while i < pickupNum
        
        return shuffledArray
    }
    
    func changeCorrectButtonColor() {
        switch correctNum {
        case 1:
            button1.backgroundColor = UIColor(red:0.91, green:0.30, blue:0.24, alpha:1.0)
            button1.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        case 2:
            button2.backgroundColor = UIColor(red:0.91, green:0.30, blue:0.24, alpha:1.0)
            button2.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        case 3:
            button3.backgroundColor = UIColor(red:0.91, green:0.30, blue:0.24, alpha:1.0)
            button3.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        default:
            break
        }
    }
    
    
}

