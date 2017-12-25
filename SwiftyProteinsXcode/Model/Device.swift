//
//  TouchID.swift
//  SwiftyProteinsXcode
//
//  Created by Vetaliy Poltavets on 12/25/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import Foundation
import LocalAuthentication

class Device {
    let context = LAContext()
    
    public func isEnableID() -> Bool {
        if self.context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            return true
        }
        return false
    }
}

