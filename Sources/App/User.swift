//
//  User.swift
//  App
//
//  Created by Cory Steers on 1/1/19.
//

import Foundation
import Fluent
import FluentSQLite
import Vapor

struct User: Content, SQLiteModel, Migration {
    var id: Int?
    var username: String
    var password: String
}
