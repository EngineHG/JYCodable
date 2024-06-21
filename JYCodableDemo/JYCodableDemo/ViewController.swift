//
//  ViewController.swift
//  JYCodableDemo
//
//  Created by admin on 2024/3/14.
//

import UIKit
import JYCodable
import JYNameSpace

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let m = Model(a: "a", b: 2, c: false)
        
        JYdebug(m.toString())
        
        let str = """
        {"a":"a","b":2,"c":123}
        """
        JYdebug(str.jy.toModel(Model.self))
    }


}

struct Model: Codable {
    
    let a: String
    let b: Int
    @Default<Bool.True> var c: Bool
    
    init(a: String, b: Int, c: Bool) {
        self.a = a
        self.b = b
        self.c = c
    }
}
