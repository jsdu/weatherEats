//
//  CustomPointAnnotation.swift
//  weatherEats
//
//  Created by Jason Du on 2016-04-01.
//  Copyright © 2016 Jason Du. All rights reserved.
//

import Foundation
import MapKit

class CustomPointAnnotation: MKPointAnnotation {
    var imageName: String!
    var category:[String]?
    var name: String?
    var address: String?
}