//
//  PinViewController.swift
//  Lattis SDK Demo
//
//  Created by Ravil Khusainov on 8/28/18.
//  Copyright © 2018 Lattis Inc. All rights reserved.
//

import UIKit
import LattisSDK

protocol PinViewControllerDelegate: class {
    func save(pin: [Pin], completion: @escaping (Error?) -> ())
}

class PinViewController: UIViewController {
    @IBOutlet weak var pinLabel: UILabel!
    
    var code: String?
    weak var delegate: PinViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pinLabel.text = code
    }
    
    @IBAction func addSign(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else { return }
        let text = pinLabel.text ?? ""
        pinLabel.text = text + title
    }
    
    @IBAction func deleteSign(_ sender: Any) {
        guard var text = pinLabel.text, text.isEmpty == false else { return }
        text.removeLast()
        pinLabel.text = text
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        func warn(error: Error? = nil) {
            let alert = UIAlertController(title: "Warning", message: error?.localizedDescription ?? "Pin code should be of 4-16 digits", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        guard let text = pinLabel.text, text.count > 3, text.count < 17 else { return warn() }
        let pin = Array(text).compactMap(Pin.init)
        delegate?.save(pin: pin, completion: { (error) in
            if let err = error {
                warn(error: err)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
}

enum Pin: String {
    case up, right, down, left
    
    var char: Character {
        switch self {
        case .up:
            return "⬆️"
        case .right:
            return "➡️"
        case .down:
            return "⬇️"
        case .left:
            return "⬅️"
        }
    }
    
    init?(char: Character) {
        switch char {
        case "⬆️":
            self = .up
        case "➡️":
            self = .right
        case "⬇️":
            self = .down
        case "⬅️":
            self = .left
        default:
            return nil
        }
    }
}

extension Ellipse.Pin {
    init(pin: Pin) {
        switch pin {
        case .up:
            self = .up
        case .right:
            self = .right
        case .down:
            self = .down
        case .left:
            self = .left
        }
    }
}
