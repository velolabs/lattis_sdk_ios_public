//
//  RootViewController.swift
//  Lattis SDK Demo
//
//  Created by Ravil Khusainov on 8/2/18.
//  Copyright © 2018 Lattis Inc. All rights reserved.
//

import UIKit
import LattisSDK
import GradientCircularProgress

class RootViewController: UITableViewController {
    var locks: [Ellipse] = []
    var connected: Set<Ellipse> = []
    let manager = EllipseManager.shared
    
    fileprivate var progressView: GradientCircularProgress?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.scan(with: self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EllipseTableCell
        cell.ellipse = locks[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let ellipse = locks[indexPath.row]
        
        let dialog = UIAlertController(title: "Action", message: ellipse.name, preferredStyle: .actionSheet)
        if case .paired = ellipse.connection {
            dialog.addAction(.init(title: "Open", style: .default, handler: { _ in
                let controller = self.storyboard?.instantiateViewController(withIdentifier: "ellipse") as! EllipseViewController
                controller.ellipse = ellipse
                self.navigationController?.pushViewController(controller, animated: true)
            }))
            dialog.addAction(.init(title: "Disconnect", style: .default, handler: { _ in
                ellipse.disconnect()
            }))
        } else {
            dialog.addAction(.init(title: "Connect", style: .default, handler: { _ in
                ellipse.connect(handler: self)
                self.progress(text: "Connecting...")
            }))
            dialog.addAction(.init(title: "Flash LED", style: .default, handler: { _ in
                self.progress(text: "Flashing LED")
                ellipse.flashLED { error in
                    self.hideProgress()
                }
            }))
        }
        dialog.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
        present(dialog, animated: true, completion: nil)
    }
    
    fileprivate func progress(text: String) {
        if progressView == nil {
            progressView = GradientCircularProgress()
            progressView?.show(message: text)
        } else {
            progressView?.updateMessage(message: text)
        }
    }
    
    fileprivate func hideProgress() {
        progressView?.dismiss()
        progressView = nil
    }
    
    fileprivate func alert(error: Error?) {
        hideProgress()
        let al = UIAlertController(title: "Warning", message: error?.localizedDescription, preferredStyle: .alert)
        al.addAction(.init(title: "OK", style: .cancel, handler: nil))
        present(al, animated: true, completion: nil)
    }
}

extension RootViewController: EllipseManagerDelegate {
    func manager(_ lockManager: EllipseManager, didRestoreConnected locks: [Ellipse]) {
        locks.forEach {$0.subscribe(self)}
    }
    
    func manager(_ lockManager: EllipseManager, didUpdateLocks insert: [Ellipse], delete: [Ellipse]) {
        self.locks = lockManager.locks
        tableView.reloadData()
    }
    
    func manager(_ lockManager: EllipseManager, didUpdateConnectionState connected: Bool) {
        
    }
}

extension RootViewController: EllipseDelegate {    
    func ellipse(_ ellipse: Ellipse, didUpdate connection: Ellipse.Connection) {
        guard let idx = locks.firstIndex(of: ellipse) else { return }
        let indexPath = IndexPath(row: idx, section: 0)
        switch connection {
        case .paired:
            connected.insert(ellipse)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            hideProgress()
        case .connecting:
            progress(text: "Connecting...")
        case .unpaired where connected.contains(ellipse):
            ellipse.unsubscribe(self)
            connected.remove(ellipse)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        case .failed(let error):
            alert(error: error)
        default:
            break
        }
    }
    
    func ellipse(_ ellipse: Ellipse, didUpdate security: Ellipse.Security) {
        
    }
}

extension UIViewController {
    func warn(error: Error?) {
        let al = UIAlertController(title: "Warning", message: error?.localizedDescription, preferredStyle: .alert)
        al.addAction(.init(title: "OK", style: .cancel, handler: nil))
        present(al, animated: true, completion: nil)
    }
}
