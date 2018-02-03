//
//  LockViewController.swift
//  Lattis SDK Demo
//
//  Created by Ravil Khusainov on 1/31/18.
//  Copyright © 2018 Lattis Inc. All rights reserved.
//

import UIKit
import LattisSDK

class LockViewController: UIViewController {
    @IBOutlet weak var loadingContainer: UIView!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var updateView: UIView!
    @IBOutlet weak var pinCodeLabel: UILabel!
    @IBOutlet weak var availableLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var rssiLabel: UILabel!
    @IBOutlet weak var batteryLabel: UILabel!
    @IBOutlet weak var lockSwitch: UISwitch!
    
    var lock: Peripheral!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = lock.name
        
        lock.subscribe(delegate: self)
        lockSwitch.isOn = lock.currentState == .locked
        
        BLEService.shared.network.getPinCode(forLockWith: lock.macId, success: { [weak self] (pin) in
            self?.pinCodeLabel.text = pin.map({$0.rawValue}).joined(separator: ",")
        }, fail: { error in
            print(error)
        })
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Disconnect", style: .plain, target: self, action: #selector(disconnect))
    }
    
    var isLoading = false {
        didSet {
            guard isLoading != oldValue else { return }
            UIView.animate(withDuration: 0.3) {
                self.loadingContainer.alpha = self.isLoading ? 1 : 0
            }
        }
    }
    
    @IBAction func checkFirmware(_ sender: Any) {
        isLoading = true
        BLEService.shared.network.firmvareVersions(success: { [weak self] (versions) in
            self?.isLoading = false
            self?.availableLabel.text = versions.joined(separator: ", ")
        }, fail: { [weak self] error in
            self?.isLoading = false
            print(error)
        })
    }
    
    @IBAction func updateFW(_ sender: Any) {
        isLoading = true
        BLEService.shared.network.firmvareChangeLog(for: nil, success: { [weak self]  (log) in
            self?.isLoading = false
            self?.show(log: log)
        }, fail: { [weak self] error in
            self?.isLoading = false
            print(error)
        })
        
    }
    
    func show(log: [String]) {
        let str = log.joined(separator: "\n")
        let alert = UIAlertController(title: "FW Changelog", message: str, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (_) in
            self.isLoading = true
            BLEService.shared.network.firmvare(version: nil, success: { [weak self] (fw) in
                self?.isLoading = false
                self?.perform(update: fw)
            }, fail: { [weak self] error in
                self?.isLoading = false
                print(error)
            })
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func perform(update: [UInt8]) {
        lock.update(firmware: update) { (progress) in
            self.progress = progress
        }
    }
    
    var progress: Double = 0 {
        didSet {
            if oldValue == 0 && progress > 0 {
                navigationItem.rightBarButtonItem?.isEnabled = false
                UIView.animate(withDuration: 0.3, animations: {
                    self.updateView.alpha = 1
                })
            }
            if progress == 1 {
                navigationItem.rightBarButtonItem?.isEnabled = true
                UIView.animate(withDuration: 0.3, animations: {
                    self.updateView.alpha = 0
                    self.progress = 0
                })
            }
            progressView.progress = Float(progress)
            percentLabel.text = "\(Int(progress*100))%"
        }
    }
    
    @IBAction func changePin(_ sender: Any) {
        let pin = storyboard!.instantiateViewController(withIdentifier: "pin") as! PinCodeViewController
        pin.lock = lock
        present(pin, animated: true, completion: nil)
    }
    
    @IBAction func lockAction(_ sender: UISwitch) {
        let state: Peripheral.LockState = sender.isOn ? .locked : .unlocked
        try? lock.set(lockState: state)
    }
    
    @objc func disconnect() {
        BLEService.shared.disconnect(lock)
        navigationController?.popViewController(animated: true)
    }
}

extension LockViewController: PeripheralDelegate {
    func peripheral(_ peripheral: Peripheral, got firmwareVersion: String) {
        versionLabel.text = firmwareVersion
    }
    
    func peripheral(_ peripheral: Peripheral, didChangeLock state: Peripheral.LockState) {

    }
    
    func peripheral(_ peripheral: Peripheral, didUpdate metadata: Peripheral.Metadata) {
        batteryLabel.text = "\(Int(metadata.batteryLevel*100))%"
        rssiLabel.text = "\(Int(metadata.rssiLevel*100))%"
    }
}
