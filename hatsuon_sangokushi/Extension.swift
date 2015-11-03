//
//  Extension.swift
//  Quiz_4
//
//  Created by tyoko on 2015/11/03.
//  Copyright © 2015年 tyoko. All rights reserved.
//

import Foundation


//Arrayランダムソートメソッド
extension Array {
    mutating func shuffle(count: Int) {
        for _ in 0..<count {
            sortInPlace { (_,_) in arc4random() < arc4random() }
        }
    }
}

//NSMutableArrayランダムソートメソッド
extension NSMutableArray {
    func shuffle(count: Int) {
        for i in 0..<count {
            let nElements: Int = count - i
            let n: Int = Int(arc4random_uniform(UInt32(nElements))) + i
            self.exchangeObjectAtIndex(i, withObjectAtIndex: n)
        }
    }
}