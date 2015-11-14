//
//  ResultViewController.swift
//  hatsuon_sangokushi
//
//  Created by tyoko on 2015/11/03.
//  Copyright © 2015年 tyoko. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    //QuizViewControllerから渡される変数の初期化
    var totalQuestionCount = 0
    var correctCount = 0
    var questionResult = 0
    
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

