//
//  KeyboardViewController.swift
//  Edge
//
//  Created by Das on 6/5/18.
//

import UIKit

class KeyboardViewController: UIInputViewController {
	var capsLockOn = true
	@IBOutlet var nextKeyboardButton: UIButton!
	@IBOutlet weak var charSet1: UIStackView!
	@IBOutlet weak var charSet2: UIStackView!
	@IBOutlet weak var stackView1: UIStackView!
	@IBOutlet weak var stackView2: UIStackView!
	@IBOutlet weak var stackView3: UIStackView!
	@IBOutlet weak var stackView4: UIStackView!
	override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
		
		
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

		let nib = UINib(nibName: "KeyboardView", bundle: nil)
		let objects = nib.instantiate(withOwner: self, options: nil)
		view = objects[0] as! UIView;
	
		self.charSet2.isHidden = true
        // Perform custom UI setup here
		
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("", comment: "Title for 'Next Keyboard' button"), for: [])
        // self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
		
		
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
	

	
	@IBAction func nextKeyboardPressed(button: UIButton) {
		advanceToNextInputMode()
	}
	

	@IBAction func keyPressed(button: UIButton) {
		var string = button.titleLabel!.text
		(textDocumentProxy as UIKeyInput).insertText("\(string!)")
		
		UIView.animate(withDuration: 0.2, animations: {
			button.transform = CGAffineTransform.identity.scaledBy(x: 2.0, y: 2.0)
		}, completion: {(_) -> Void in
			button.transform =
				CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
		})
	}
	
	@IBAction func backSpacePressed(button: UIButton) {
		(textDocumentProxy as UIKeyInput).deleteBackward()
		UIView.animate(withDuration: 0.2, animations: {
			button.transform = CGAffineTransform.identity.scaledBy(x: 2.0, y: 2.0)
		}, completion: {(_) -> Void in
			button.transform =
				CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
		})
	}
	
	@IBAction func spacePressed(button: UIButton) {
		(textDocumentProxy as UIKeyInput).insertText(" ")
		UIView.animate(withDuration: 0.2, animations: {
			button.transform = CGAffineTransform.identity.scaledBy(x: 2.0, y: 2.0)
		}, completion: {(_) -> Void in
			button.transform =
				CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
		})
	}
	
	@IBAction func returnPressed(button: UIButton) {
		(textDocumentProxy as UIKeyInput).insertText("\n")
		UIView.animate(withDuration: 0.2, animations: {
			button.transform = CGAffineTransform.identity.scaledBy(x: 2.0, y: 2.0)
		}, completion: {(_) -> Void in
			button.transform =
				CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
		})
	}
	@IBAction func charSetPressed(button: UIButton) {
		if button.titleLabel!.text == "1/2" {
			charSet1.isHidden = true
			charSet2.isHidden = false
			button.setTitle("2/2", for: .normal)
		} else if button.titleLabel!.text == "2/2" {
			charSet1.isHidden = false
			charSet2.isHidden = true
			button.setTitle("1/2", for: .normal)
		}
	}
	@IBAction func capsLockPressed(_ button: CustomRoundedButton) {
		changeCaps(containerView: stackView2)
		changeCaps(containerView: stackView3)
		changeCaps(containerView: stackView4)
		UIView.animate(withDuration: 0.2, animations: {
			button.transform = CGAffineTransform.identity.scaledBy(x: 2.0, y: 2.0)
		}, completion: {(_) -> Void in
			button.transform =
				CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
		})
		capsLockOn = !capsLockOn
	}
	

	func changeCaps(containerView: UIView) {
		print("-----Change caps was called")
		for view in containerView.subviews {
			if let button = view as? CustomRoundedButton {
				// let buttonTitleLabel = button.titleLabel!.text
				guard let buttonTitleLabel = button.titleLabel?.text else { return }
				if (capsLockOn) {
					let text = buttonTitleLabel.lowercased()
					print("\(String(describing: text))")
					button.setTitle("\(text)", for: .normal)
				} else {
					let text = buttonTitleLabel.uppercased()
					button.setTitle("\(text)", for: .normal)
				}
				

			}
		}
	}


}
