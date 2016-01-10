//
//  ResultViewController.swift
//  hatsuon_sangokushi
//
//  Created by tyoko on 2015/11/03.
//  Copyright © 2015年 tyoko. All rights reserved.
//

import UIKit
import Social

class ResultViewController: UIViewController {
    
    //QuizViewControllerから渡される変数の初期化
    var totalQuestionCount = 0
    var correctCount = 0
    var questionResult = 0
    
    //キャプチャ画像
    var capturedImage: UIImage?
    
    //twitterボタン
    @IBOutlet weak var twitterButton: UIButton!
    
    //facebookボタン
    @IBOutlet weak var facebookButton: UIButton!
    
    //0問中0問正解
    @IBOutlet weak var resultLabel: UILabel!
    
    //正解率
    @IBOutlet weak var correctRatio: UILabel!
    
    //結果画像
    @IBOutlet weak var resultImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_3.jpg")!)
        
        resultLabel.text = String(format: "%d問中%d問正解", totalQuestionCount, correctCount)
        correctRatio.text = String(format: "正解率 %d%%", questionResult)
        
        if questionResult == 100 {
            resultImageView.image = UIImage(named: "asset_komei_100per")
        } else if questionResult >= 80 && questionResult <= 99 {
            resultImageView.image = UIImage(named: "asset_komei_80per")
        } else if questionResult >= 60 && questionResult <= 79 {
            resultImageView.image = UIImage(named: "asset_komei_60per")
        } else if questionResult >= 40 && questionResult <= 59 {
            resultImageView.image = UIImage(named: "asset_komei_40per")
        } else if questionResult >= 20 && questionResult <= 39 {
            resultImageView.image = UIImage(named: "asset_komei_20per")
        } else if questionResult >= 1 && questionResult <= 19 {
            resultImageView.image = UIImage(named: "asset_komei_1per")
        } else {
            resultImageView.image = UIImage(named: "asset_komei_0per")
        }
        
        capturedImage = GetImage() as UIImage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //SNS設定
    
    /*
    スクリーンキャプチャ用関数
    :return UIImage
    */
    func GetImage() -> UIImage {
        let rect = self.view.bounds
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let context: CGContextRef = UIGraphicsGetCurrentContext()!
        
        self.view.layer.renderInContext(context)
        let capturedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return capturedImage
        
    }
    
    
    
    @IBAction func pressTwitter(sender: AnyObject) {
        //Tweet用のViewを作成する
        let twitterPostView:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)!
        let tweetDescription1:String = "【発音三国志】"
        let tweetDescription2:String = "あなたの知力は・・・"
        //Tweetする文章を設定する
        twitterPostView.setInitialText("\(tweetDescription1)\n\(tweetDescription2)")
        
        //起動時にキャプチャしたスクリーンショットを添付する
        twitterPostView.addImage(capturedImage)

        //上述の内容を反映したTweet画面を表示する
        self.presentViewController(twitterPostView, animated: true, completion: nil)
    }
    
    
    @IBAction func pressFacebook(sender: AnyObject) {
        //Facebookシェア用のViewを作成する
        let facebookPostView:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)!
        let facebookDescription1:String = "【発音三国志】"
        let facebookDescription2:String = "あなたの知力は・・・"
        //シェアする文章を設定する
        facebookPostView.setInitialText("\(facebookDescription1)\n\(facebookDescription2)")
        
        //起動時にキャプチャしたスクリーンショットを添付する
        facebookPostView.addImage(capturedImage)

        //上述の内容を反映したfacebookシェア画面を表示する
        self.presentViewController(facebookPostView, animated: true, completion: nil)
    }
    
    
}

























