import Vapor
import MySQLProvider
import HTTP

final class Review: Model {
    var location_id: Int
    var domain: String
    var author_name: String
    var profile_name: String
    let storage = Storage()
    
    init(location_id: Int, domain: String, author_name: String, profile_name: String) {
        self.location_id = location_id
        self.domain = domain
        self.author_name = author_name
        self.profile_name = profile_name
    }
    
    init(row: Row) throws {
        location_id = try row.get("location_id")
        domain = try row.get("domain")
        author_name = try row.get("author_name")
        profile_name = try row.get("profile_name")
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set("location_id", location_id)
        try row.set("domain", domain)
        try row.set("author_name", author_name)
        try row.set("profile_name", profile_name)
    
        return row
    }
}

extension Review: Preparation {
    /// Prepares a table/collection in the database
    /// for storing Posts
    static func prepare(_ database: Database) throws {
//        try database.create(self) { builder in
//            builder.id()
//            builder.int("location_id")
//            builder.string("domain")
//            builder.string("author_name")
//            builder.string("profile_name")
//        }
    }
    
    /// Undoes what was done in `prepare`
    static func revert(_ database: Database) throws {
//        try database.delete(self)
    }
}

extension Review: JSONConvertible {
    convenience init(json: JSON) throws {
        try self.init(
            location_id: json.get("location_id"),
            domain: json.get("domain"),
            author_name: json.get("author_name"),
            profile_name: json.get("profile_name")
        )
    }
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("location_id", location_id)
        try json.set("domain", domain)
        try json.set("author_name", author_name)
        try json.set("profile_name", profile_name)
        
        return json
    }
}

extension Review: ResponseRepresentable { }
