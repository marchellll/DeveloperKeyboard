//
//  MyKeyboardLayoutProvider.swift
//  KeyboardExtension
//
//  Created by Marchell Imanuel on 31/10/23.
//

import UIKit
import SwiftUI
import KeyboardKit


//https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-layout
class MyKeyboardLayoutProvider: StandardKeyboardLayoutProvider {
    
    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let layout = super.keyboardLayout(for: context)
//        var rows = layout.itemRows
//        let lastRowIndex = rows.count - 1
//        let lastRow = rows.last
//
//        guard var lastRow else { return layout }
//
//        let lastItem = lastRow.last
//        let lastItemIndex = lastRow.count - 1
//
//        guard let lastItem else { return layout }
//
//        // following the size of last item
//        let size = KeyboardLayout.ItemSize(width: .inputPercentage(0.75), height: lastItem.size.height)
//        
//        // add ctrl option and cmd
//        let ctrl = KeyboardLayout.Item(action: .control, size: size, edgeInsets: lastItem.insets)
//        let option = KeyboardLayout.Item(action: .option, size: size, edgeInsets: lastItem.insets)
//        let command = KeyboardLayout.Item(action: .command, size: size, edgeInsets: lastItem.insets)
//
//        lastRow.insert(ctrl, at: lastItemIndex - 1)
//        lastRow.insert(option, at: lastItemIndex - 1)
//        lastRow.insert(command, at: lastItemIndex - 1)
//        rows[lastRowIndex] = lastRow
//        layout.itemRows = rows
        return layout
    }
}
