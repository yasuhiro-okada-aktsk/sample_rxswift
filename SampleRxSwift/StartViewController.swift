//
//  ViewController.swift
//  SampleRxSwift
//
//  Created by yasuhiro.okada on 2016/01/27.
//  Copyright © 2016年 yasuhiro.okada. All rights reserved.
//

import UIKit
import RxSwift

class StartViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // calc()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func calc() {
        let a = Variable(1)
        let b = Variable(2)
        
        let c = Observable.combineLatest(a.asObservable(), b.asObservable()) { $0 + $1 }
            .filter { $0 >= 0 }
            .map { "\($0) is positive" }
        
        c.subscribeNext { print($0) }
        
        a.value = 4
        b.value = -8
    }
    
    private func simpleUi() {
        let subscription/*: Disposable */ = textField.rx_text      // type is Observable<String>
            //.map { WolframAlphaIsPrime($0.toInt() ?? 0) }       // type is Observable<Observable<Prime>>
            //.concat()                                           // type is Observable<Prime>
            //.map { "number \($0.n) is prime? \($0.isPrime)" }   // type is Observable<String>
            .bindTo(label.rx_text)                        // return Disposable that can be used to unbind everything
        
        // This will set resultLabel.text to "number 43 is prime? true" after
        // server call completes.
        textField.text = "43"
        
        // ...
        
        // to unbind everything, just call
        subscription.dispose()
    }
}

