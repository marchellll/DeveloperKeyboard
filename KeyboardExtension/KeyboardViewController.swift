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
        services.layoutProvider = MyKeyboardLayoutProvider()

        super.viewDidLoad()
    }
    
    override func viewWillSetupKeyboard() {
        // super only call this, which will be overriden by anything in this func
        // no need to call lah
        // `setup { SystemKeyboard(controller: $0) }`
        // super.viewWillSetupKeyboard()
        setup { controller in
            MyVieww(controller: controller)
        }
    }
}


public struct MyVieww: View {

    var controller: KeyboardInputViewController
    init(controller: KeyboardInputViewController) {
        self.controller = controller
    }
    
    public var body: some View {
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
        }    }
}

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
        let needsDictation = context.needsInputModeSwitchKey
        if let action = keyboardSwitchActionForBottomRow(for: context) { result.append(action) }
        result.append(.nextKeyboard)
        if needsDictation, let action = context.keyboardDictationReplacement { result.append(action) }
        result.append(.space)
        if let action = keyboardSwitchActionForBottomRow(for: context) { result.append(action) }
        result.append(.dismissKeyboard)
        return result
    }
}

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

class MyInputSetBasedKeyboardLayoutProvider: InputSetBasedKeyboardLayoutProvider {
    public override init(
        alphabeticInputSet: InputSet = .qwerty,
        numericInputSet: InputSet = .standardNumeric(currency: "$"),
        symbolicInputSet: InputSet = .standardSymbolic(currencies: "€£¥".chars)
    ) {
        super.init(
            alphabeticInputSet: alphabeticInputSet,
            numericInputSet: numericInputSet,
            symbolicInputSet: symbolicInputSet
        )
        
        // use custom layout provide
        iPadProvider = MyiPadKeyboardLayoutProvider(
            alphabeticInputSet: alphabeticInputSet,
            numericInputSet: numericInputSet,
            symbolicInputSet: symbolicInputSet
        )
        iPhoneProvider = MyiPhoneKeyboardLayoutProvider(
            alphabeticInputSet: alphabeticInputSet,
            numericInputSet: numericInputSet,
            symbolicInputSet: symbolicInputSet
        )
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
        let size = KeyboardLayout.ItemSize(width: .inputPercentage(0.75), height: lastItem.size.height)
        
        // add ctrl option and cmd
        let ctrl = KeyboardLayout.Item(action: .control, size: size, edgeInsets: lastItem.insets)
        let option = KeyboardLayout.Item(action: .option, size: size, edgeInsets: lastItem.insets)
        let command = KeyboardLayout.Item(action: .command, size: size, edgeInsets: lastItem.insets)

        lastRow.insert(ctrl, at: lastItemIndex - 1)
        lastRow.insert(option, at: lastItemIndex - 1)
        lastRow.insert(command, at: lastItemIndex - 1)
        rows[lastRowIndex] = lastRow
        layout.itemRows = rows
        return layout
    }
}


