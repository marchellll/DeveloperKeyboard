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
    
    override func viewDidLoad() {
        services.layoutProvider = MyKeyboardLayoutProvider(baseProvider: MyInputSetBasedKeyboardLayoutProvider())

        super.viewDidLoad()
    }
    
    override func viewWillSetupKeyboard() {
        // super only call this, which will be overriden by anything in this func
        // no need to call lah
        // `setup { SystemKeyboard(controller: $0) }`
        super.viewWillSetupKeyboard()
        setup { controller in
            VStack(spacing: 0) {
                HStack {
                    Text("hehe")
                    Text("hehe")
                    Text("hehe")
                    Text("hehe")
                    Text("hehe")
                    Text("hehe")
                    Text("hehe")
                }

                SystemKeyboard(
                    state: controller.state,
                    services: controller.services,
                    buttonContent: { $0.view },
                    buttonView: { $0.view },
                    emojiKeyboard: { $0.view },
                    toolbar: { $0.view }
                )
            }
        }
    }
}






