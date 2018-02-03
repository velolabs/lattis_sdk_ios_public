//
//  ViewController.swift
//  Lattis SDK Demo
//
//  Created by Ravil Khusainov on 1/30/18.
//  Copyright © 2018 Lattis Inc. All rights reserved.
//

import UIKit
import LattisSDK

class ViewController: UIViewController {
    @IBOutlet weak var loadingContainer: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var locks: [Peripheral] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "lock")
        tableView.delegate = self
        tableView.dataSource = self
        
        BLEService.shared.subscribe(delegate: self)
        BLEService.shared.startScan()
    }
    
    var isLoading = false {
        didSet {
            guard isLoading != oldValue else { return }
            UIView.animate(withDuration: 0.3) {
                self.loadingContainer.alpha = self.isLoading ? 1 : 0
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lock", for: indexPath)
        cell.textLabel?.text = locks[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let per = locks[indexPath.row]
        BLEService.shared.connect(per)
        per.subscribe(delegate: self)
        isLoading = true
    }
}

extension ViewController: BLEServiceDelegate {
    func service(_ service: BLEService, didRefresh peripherals: [Peripheral]) {
        locks = peripherals
        tableView.reloadData()
    }
}

extension ViewController: PeripheralDelegate {
    func peripheral(_ peripheral: Peripheral, didChangeConnection state: Peripheral.Connection) {
        switch state {
        case .paired:
            peripheral.unsubscribe(delegate: self)
            isLoading = false
            let details = storyboard!.instantiateViewController(withIdentifier: "details") as! LockViewController
            details.lock = peripheral
            navigationController?.pushViewController(details, animated: true)
        case .failed(let error):
            isLoading = false
            let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
            present(alert, animated: true, completion: nil)
        default:
            break
        }
    }
}

