//
//  MyiPhoneKeyboardLayoutProvider.swift
//  KeyboardExtension
//
//  Created by Marchell Imanuel on 31/10/23.
//

import UIKit
import SwiftUI
import KeyboardKit


class MyiPhoneKeyboardLayoutProvider: iPhoneKeyboardLayoutProvider {
    open override func actions(
        for inputs: InputSet.Rows,
        context: KeyboardContext
    ) -> KeyboardAction.Rows {
        let actions = super.actions(for: inputs, context: context)
        guard actions.count == 3 else { return actions }
        var result = KeyboardAction.Rows()
        result.append(topLeadingActions(for: actions, context: context) + actions[0] + topTrailingActions(for: actions, context: context))
        result.append(middleLeadingActions(for: actions, context: context) + actions[1] + middleTrailingActions(for: actions, context: context))
        result.append(lowerLeadingActions(for: actions, context: context) + actions[2] + lowerTrailingActions(for: actions, context: context))
        result.append(bottomActions(for: context))
        return result
    }
    
    /// Leading actions to add to the top input row.
    open override func topLeadingActions(
        for actions: KeyboardAction.Rows,
        context: KeyboardContext
    ) -> KeyboardAction.Row {
        guard shouldAddUpperMarginActions(for: actions, context: context) else { return [] }
        return [actions[0].leadingCharacterMarginAction]
    }

    /// Trailing actions to add to the top input row.
    open override func topTrailingActions(
        for actions: KeyboardAction.Rows,
        context: KeyboardContext
    ) -> KeyboardAction.Row {
        guard shouldAddUpperMarginActions(for: actions, context: context) else { return [] }
        return [actions[0].trailingCharacterMarginAction]
    }

    /// Leading actions to add to the middle input row.
    open override func middleLeadingActions(
        for actions: KeyboardAction.Rows,
        context: KeyboardContext
    ) -> KeyboardAction.Row {
        guard shouldAddMiddleMarginActions(for: actions, context: context) else { return [] }
        return [actions[1].leadingCharacterMarginAction]
    }

    /// Trailing actions to add to the middle input row.
    open override func middleTrailingActions(
        for actions: KeyboardAction.Rows,
        context: KeyboardContext
    ) -> KeyboardAction.Row {
        guard shouldAddMiddleMarginActions(for: actions, context: context) else { return [] }
        return [actions[1].trailingCharacterMarginAction]
    }

    /// Leading actions to add to the lower input row.
    open override func lowerLeadingActions(
        for actions: KeyboardAction.Rows,
        context: KeyboardContext
    ) -> KeyboardAction.Row {
        guard actions.count == 3 else { return [] }
        let margin = actions[2].leadingCharacterMarginAction
        guard let switcher = keyboardSwitchActionForBottomInputRow(for: context) else { return [] }
        return [switcher, margin]
    }

    /// Trailing actions to add to the lower input row.
    open override func lowerTrailingActions(
        for actions: KeyboardAction.Rows,
        context: KeyboardContext
    ) -> KeyboardAction.Row {
        guard actions.count == 3 else { return [] }
        let margin = actions[2].trailingCharacterMarginAction
        return [margin, .backspace]
    }

    /// The width of system buttons on the lower input row.
    open override func lowerSystemButtonWidth(
        for context: KeyboardContext
    ) -> KeyboardLayout.ItemWidth {
//        if context.isAlphabetic(.ukrainian) { return .input }
        return .percentage(0.13)
    }

    /// The actions to add to the bottom system row.
    open override func bottomActions(
        for context: KeyboardContext
    ) -> KeyboardAction.Row {
        var result = KeyboardAction.Row()
        let needsInputSwitch = context.needsInputModeSwitchKey
        let needsDictation = context.needsInputModeSwitchKey
        if let action = keyboardSwitchActionForBottomRow(for: context) { result.append(action) }
        if needsInputSwitch { result.append(.nextKeyboard) }
        if !needsInputSwitch { result.append(.keyboardType(.emojis)) }
        let dictationReplacement = context.keyboardDictationReplacement
        if context.interfaceOrientation.isPortrait, needsDictation, let action = dictationReplacement { result.append(action) }
        result.append(.space)
        #if os(iOS) || os(tvOS)
        if context.textDocumentProxy.keyboardType == .emailAddress {
            result.append(.character("@"))
            result.append(.character("."))
        }
        if context.textDocumentProxy.returnKeyType == .go {
            result.append(.character("."))
        }
        #endif
        result.append(keyboardReturnAction(for: context))
        if !context.interfaceOrientation.isPortrait, needsDictation, let action = dictationReplacement { result.append(action) }
        return result
    }
    
    /// Whether or not to add margins to the middle row.
    open override func shouldAddMiddleMarginActions(
        for actions: KeyboardAction.Rows,
        context: KeyboardContext
    ) -> Bool {
        guard actions.count == 3 else { return false }
        return actions[0].count > actions[1].count
    }

    /// Whether or not to add margins to the upper row.
    open override func shouldAddUpperMarginActions(
        for actions: KeyboardAction.Rows,
        context: KeyboardContext
    ) -> Bool {
        false
    }
}
