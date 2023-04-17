//
//  Requestable.swift
//  iBooks
//
//  Created by Александр Пархамович on 17.04.23.
//
import Foundation

protocol Requestable {
    var error: Error? { get }
    var isRequesting: Bool { get }
}
