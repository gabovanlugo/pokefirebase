//
//  Util.swift
//  PokeFirebase
//
//  Created by Gabo Lugo on 9/12/16.
//  Copyright © 2016 Gabo Lugo. All rights reserved.
//

import Foundation
import UIKit

func shadowElement(element: AnyObject, color: String, opacity: Double, radius: Double) -> Void {
    element.layer.shadowColor = UIColor(hex: color).CGColor
    element.layer.shadowOpacity = Float(opacity)
    element.layer.shadowRadius = CGFloat(radius)
    element.layer.shadowOffset = CGSizeZero
}