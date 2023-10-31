//
//  MyiPadKeyboardLayoutProvider.swift
//  KeyboardExtension
//
//  Created by Marchell Imanuel on 31/10/23.
//

import UIKit
import SwiftUI
import KeyboardKit

class MyiPadKeyboardLayoutProvider: iPadKeyboardLayoutProvider {
    
    open override func actions(
        for inputs: InputSet.Rows,
        context: KeyboardContext
    ) -> KeyboardAction.Rows {
        let actions = super.actions(for: inputs, context: context)
        guard actions.count == 3 else { return actions }
        var result = KeyboardAction.Rows()
        result.append(topLeadingActions(for: context) + actions[0] + topTrailingActions(for: context))
        result.append(middleLeadingActions(for: context) + actions[1] + middleTrailingActions(for: context))
        result.append(lowerLeadingActions(for: context) + actions[2] + lowerTrailingActions(for: context))
        result.append(bottomActions(for: context))
        return result
    }
    
    open override func keyboardReturnAction(
        for context: KeyboardContext
    ) -> KeyboardAction {
        let base = super.keyboardReturnAction(for: context)
        return base == .primary(.return) ? .primary(.newLine) : base
    }
    
    /// Leading actions to add to the top input row.
    open override func topLeadingActions(
        for context: KeyboardContext
    ) -> KeyboardAction.Row {
        return []
    }

    /// Trailing actions to add to the top input row.
    open override func topTrailingActions(
        for context: KeyboardContext
    ) -> KeyboardAction.Row {
        return [.backspace]
    }

    /// Leading actions to add to the middle input row.
    open override func middleLeadingActions(
        for context: KeyboardContext
    ) -> KeyboardAction.Row {
        return [.none]
    }

    /// Trailing actions to add to the middle input row.
    open override func middleTrailingActions(
        for context: KeyboardContext
    ) -> KeyboardAction.Row {
        return [keyboardReturnAction(for: context)]
    }

    /// Leading actions to add to the lower input row.
    open override func lowerLeadingActions(
        for context: KeyboardContext
    ) -> KeyboardAction.Row {
        guard let action = keyboardSwitchActionForBottomInputRow(for: context) else { return [] }
        return [action]
    }

    /// Trailing actions to add to the lower input row.
    open override func lowerTrailingActions(
        for context: KeyboardContext
    ) -> KeyboardAction.Row {
        guard let action = keyboardSwitchActionForBottomInputRow(for: context) else { return [] }
        return [action]
    }

    /// The actions to add to the bottom system row.
    open override func bottomActions(for context: KeyboardContext) -> KeyboardAction.Row {
        var result = KeyboardAction.Row()
        // let needsDictation = context.needsInputModeSwitchKey
        result.append(.nextKeyboard)
        
        // this is the left keyboard switcher
        if let action = keyboardSwitchActionForBottomRow(for: context) { result.append(action) }
        
        let escape = .escape
        escape.standardButtonText(for: <#T##KeyboardContext#>)
        result.append(escape)
        
        // coder dont need dictation yet
        // if needsDictation, let action = context.keyboardDictationReplacement { result.append(action) }
        result.append(.space)
        
        result.append(.command)
        result.append(.option)
        result.append(.control)
        
        // one (left) keyboard switcher is sufficient
        //if let action = keyboardSwitchActionForBottomRow(for: context) { result.append(action) }
        result.append(.dismissKeyboard)
        return result
    }
}
