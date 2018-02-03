//
//  PinCodeViewController.swift
//  Lattis SDK Demo
//
//  Created by Ravil Khusainov on 2/2/18.
//  Copyright © 2018 Lattis Inc. All rights reserved.
//

import UIKit
import LattisSDK

class PinCodeViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    
    var lock: Peripheral!
    var code: [Peripheral.Pin] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func up(_ sender: Any) {
        code.append(.up)
        updateResult()
    }
    
    @IBAction func right(_ sender: Any) {
        code.append(.right)
        updateResult()
    }
    
    @IBAction func down(_ sender: Any) {
        code.append(.down)
        updateResult()
    }
    
    @IBAction func left(_ sender: Any) {
        code.append(.left)
        updateResult()
    }
    
    @IBAction func save(_ sender: Any) {
        BLEService.shared.network.save(pinCode: code, forLock: lock.macId, success: { [weak self] in
            do {
                try self?.lock.set(pinCode: self!.code)
            } catch {
                print(error)
            }
        }, fail: { error in
            print(error)
        })
    }
    
    @IBAction func remove(_ sender: Any) {
        code.removeLast()
        updateResult()
    }
    
    func updateResult() {
        resultLabel.text = code.map({$0.rawValue}).joined(separator: ", ")
    }
}
