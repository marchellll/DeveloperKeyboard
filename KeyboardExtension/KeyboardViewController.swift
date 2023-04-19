//
//  KeyboardViewController.swift
//  KeyboardExtension
//
//  Created by Marchell Imanuel on 19/04/23.
//

import UIKit
import SwiftUI
import KeyboardKit


class KeyboardViewController: KeyboardInputViewController {
    
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        setup { controller in
            VStack(spacing: 0) {
                HStack {
                    Text("hehe")
                }

                SystemKeyboard(
                    layout: controller.keyboardLayoutProvider.keyboardLayout(for: controller.keyboardContext),
                    appearance: controller.keyboardAppearance,
                    actionHandler: controller.keyboardActionHandler,
                    autocompleteContext: controller.autocompleteContext,
                    autocompleteToolbar: .none,
                    autocompleteToolbarAction: { [weak controller] suggestion in
                        controller?.insertAutocompleteSuggestion(suggestion)
                    },
                    keyboardContext: controller.keyboardContext,
                    calloutContext: controller.calloutContext,
                    width: controller.view.frame.width
                )
            }
        }
    }
}

//public struct DeveloperKeyboard: View {
//    private let controller: KeyboardInputViewController
//
//    init(controller: KeyboardInputViewController) {
//        self.controller = controller
//    }
//
//    public var body: some View {
//
//    }
//}


//class KeyboardViewController: UIInputViewController {
//
//    @IBOutlet var nextKeyboardButton: UIButton!
//
//    override func updateViewConstraints() {
//        super.updateViewConstraints()
//
//        // Add custom view sizing constraints here
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Perform custom UI setup here
//        self.nextKeyboardButton = UIButton(type: .system)
//
//        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
//        self.nextKeyboardButton.sizeToFit()
//        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
//
//        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
//
//        self.view.addSubview(self.nextKeyboardButton)
//
//        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
//        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//    }
//
//    override func viewWillLayoutSubviews() {
//        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
//        super.viewWillLayoutSubviews()
//    }
//
//    override func textWillChange(_ textInput: UITextInput?) {
//        // The app is about to change the document's contents. Perform any preparation here.
//    }
//
//    override func textDidChange(_ textInput: UITextInput?) {
//        // The app has just changed the document's contents, the document context has been updated.
//        self.changeKeyboardTitleColor() // TODO: can this be moved somewhere?
//
//
//    }
//
//    func changeKeyboardTitleColor() {
//        var textColor: UIColor
//        let proxy = self.textDocumentProxy
//        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
//            textColor = UIColor.white
//        } else {
//            textColor = UIColor.black
//        }
//        self.nextKeyboardButton.setTitleColor(textColor, for: [])
//    }
//
//}
