//
//  PublishedExtension.swift
//  Peggle
//
//  Created by Lee Yong Ler on 28/1/23.
//

import Foundation
import SwiftUI

extension Published:Encodable where Value:Decodable {
    public func encode(to encoder: Encoder) throws {
        let mirror = Mirror(reflecting: self)
        if let valueChild = mirror.children.first(where: { (child) -> Bool in
            child.label == "value"
        }) {
            if let value = valueChild.value as? Encodable {
                do {
                    try value.encode(to: encoder)
                    return
                } catch let error {
                    assertionFailure("Failed encoding: \(self) - \(error)")
                }
            }
            else {
                assertionFailure("Decodable Value not decodable. Odd \(self)")
            }
        }
        else {
            assertionFailure("Mirror Mirror on the wall - why no value y'all : \(self)")
        }
    }
}
extension Published:Decodable where Value:Decodable {
    public init(from decoder: Decoder) throws {
        self = Published(initialValue:try Value(from:decoder))
    }
}
