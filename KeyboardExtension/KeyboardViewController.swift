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
        keyboardLayoutProvider = MyKeyboardLayoutProvider(keyboardContext: keyboardContext, inputSetProvider: inputSetProvider)
        
        super.viewDidLoad()
    }
    
    override func viewWillSetupKeyboard() {
        // super only call this, which will be overriden by anything in this func
        // no need to call lah
        // `setup { SystemKeyboard(controller: $0) }`
        // super.viewWillSetupKeyboard()
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

//https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-layout
class MyKeyboardLayoutProvider: StandardKeyboardLayoutProvider {
    
    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let layout = super.keyboardLayout(for: context)
        var rows = layout.itemRows
        let lastRowIndex = rows.count - 1
        let lastRow = rows.last

        guard var lastRow else { return layout }

        let lastItem = lastRow.last
        let lastItemIndex = lastRow.count - 1

        guard let lastItem else { return layout }

        // following the size of last item
        let size = KeyboardLayoutItemSize(width: .input, height: lastItem.size.height)
        
        // add ctrl option and cmd
        let ctrl = KeyboardLayoutItem(action: .control, size: size, insets: lastItem.insets)
        let option = KeyboardLayoutItem(action: .option, size: size, insets: lastItem.insets)
        let command = KeyboardLayoutItem(action: .command, size: size, insets: lastItem.insets)

        lastRow.insert(ctrl, at: lastItemIndex - 1)
        lastRow.insert(option, at: lastItemIndex - 1)
        lastRow.insert(command, at: lastItemIndex - 1)
        rows[lastRowIndex] = lastRow
        layout.itemRows = rows
        return layout
    }
}
