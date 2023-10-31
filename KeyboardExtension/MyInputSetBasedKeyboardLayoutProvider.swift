//
//  MyInputSetBasedKeyboardLayoutProvider.swift
//  KeyboardExtension
//
//  Created by Marchell Imanuel on 31/10/23.
//

import UIKit
import SwiftUI
import KeyboardKit


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
