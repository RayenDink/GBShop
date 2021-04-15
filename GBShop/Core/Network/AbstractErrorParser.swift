//
//  AbstractErrorParser.swift
//  GBShop
//
//  Created by Rayen on 4/15/21.
//

import Foundation

protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
