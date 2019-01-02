//
//  Forum.swift
//  App
//
//  Created by Cory Steers on 12/30/18.
//

import Foundation
import Fluent
import FluentSQLite
import Vapor

struct Forum: Content, SQLiteModel, Migration {
    var id: Int?
    var name: String
    var user: String?
}
