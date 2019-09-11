import Vapor
import FluentSQLite

final class Acronym: Codable {
    var id: Int?
    var short:String
    var long: String
    
    init(short: String, long: String) {
        self.short = short
        self.long = long
    }
}

//Create ID for the data
extension Acronym: SQLiteModel {}

//To create your database schema or table
extension Acronym: Migration {}

//Allows conversion of model from different format  
extension Acronym: Content {}

