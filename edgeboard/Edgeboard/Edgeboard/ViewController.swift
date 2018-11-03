//
//  ViewController.swift
//  Edgeboard
//
//  Created by Das on 6/5/18.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet weak var textField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		self.textField.delegate = self

		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
		view.addGestureRecognizer(tap)
	}
	
	@objc func dismissKeyboard() {
		textField.resignFirstResponder()
	}
	func createButtons(titles: [String]) -> [UIButton] {
		
		var buttons = [UIButton]()
		
		for title in titles {
			let button = UIButton(type: .system) as UIButton
			button.setTitle(title, for: .normal)
			button.translatesAutoresizingMaskIntoConstraints = false
			button.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
			button.setTitleColor(UIColor.darkGray, for: .normal)
			button.addTarget(self, action: "keyPressed:", for: .touchUpInside)
			buttons.append(button)
		}
		
		return buttons
	}


	func keyPressed(sender: AnyObject?) {
		let button = sender as! UIButton
		let title = button.title(for: .normal)
		// (UITextDocumentProxy).insertText(title!)
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	// UITextField Delegates
	func textFieldDidBeginEditing(textField: UITextField) {
		print("TextField did begin editing method called")
	}
	func textFieldDidEndEditing(textField: UITextField) {
		print("TextField did end editing method called")
	}
	func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
		print("TextField should begin editing method called")
		return true;
	}
	func textFieldShouldClear(textField: UITextField) -> Bool {
		print("TextField should clear method called")
		return true;
	}
	func textFieldShouldEndEditing(textField: UITextField) -> Bool {
		print("TextField should snd editing method called")
		return true;
	}
	func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
		print("While entering the characters this method gets called")
		return true;
	}
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		print("TextField should return method called")
		textField.resignFirstResponder();
		return true;
	}


}

