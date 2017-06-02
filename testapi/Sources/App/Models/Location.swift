import Vapor
import MySQLProvider
import HTTP

final class Location: Model {
    let storage = Storage()
    
    var key: String
    var owner_id: Int
    var name: String
    var phone: String
    var address: String
    var website: String?
    var email: String
    var bad_review_email: String?
    var city: String
    var state: String
    var zip: String
    var category: Int?
    var group_id: Int?
    var logo: String?
    var manager_photo: String?
    var status: String
    
    init(
        key: String,
        owner_id: Int,
        name: String,
        phone: String,
        address: String,
        website: String?,
        email: String,
        bad_review_email: String?,
        city: String,
        state: String,
        zip: String,
        category: Int?,
        group_id: Int?,
        logo: String?,
        manager_photo: String?,
        status: String
        ) {
        self.key = key
        self.owner_id = owner_id
        self.name = name
        self.phone = phone
        self.address = address
        self.website = website
        self.email = email
        self.bad_review_email = bad_review_email
        self.city = city
        self.state = state
        self.zip = zip
        self.category = category
        self.group_id = group_id
        self.logo = logo
        self.manager_photo = manager_photo
        self.status = status
    }
    
    init(row: Row) throws {
        key = try row.get("key")
        owner_id = try row.get("owner_id")
        name = try row.get("name")
        phone = try row.get("phone")
        address = try row.get("address")
        website = try row.get("website")
        email = try row.get("email")
        bad_review_email = try row.get("bad_review_email")
        city = try row.get("city")
        state = try row.get("state")
        zip = try row.get("zip")
        category = try row.get("category")
        group_id = try row.get("group_id")
        logo = try row.get("logo")
        manager_photo = try row.get("manager_photo")
        status = try row.get("status")
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set("key", key)
        try row.set("owner_id", owner_id)
        try row.set("name", name)
        try row.set("phone", phone)
        try row.set("address", address)
        try row.set("website", website)
        try row.set("email", email)
        try row.set("bad_review_email", bad_review_email)
        try row.set("city", city)
        try row.set("state", state)
        try row.set("zip", zip)
        try row.set("category", category)
        try row.set("group_id", group_id)
        try row.set("logo", logo)
        try row.set("manager_photo", manager_photo)
        try row.set("status", status)
        
        return row
    }
}

extension Location: Preparation {
    /// Prepares a table/collection in the database
    /// for storing Posts
    static func prepare(_ database: Database) throws {
//        try database.create(self) { builder in
//            builder.id()
//            builder.string("content")
//        }
    }
    
    /// Undoes what was done in `prepare`
    static func revert(_ database: Database) throws {
//        try database.delete(self)
    }
}

// MARK: JSON

// How the model converts from / to JSON.
// For example when:
//     - Creating a new Post (POST /posts)
//     - Fetching a post (GET /posts, GET /posts/:id)
//
extension Location: JSONConvertible {
    convenience init(json: JSON) throws {
        
        try self.init(
            key: json.get("key"),
            owner_id: json.get("owner_id"),
            name: json.get("name"),
            phone: json.get("phone"),
            address: json.get("address"),
            website: json.get("website"),
            email: json.get("email"),
            bad_review_email: json.get("bad_review_email"),
            city: json.get("city"),
            state: json.get("state"),
            zip: json.get("zip"),
            category: json.get("category"),
            group_id: json.get("group_id"),
            logo: json.get("logo"),
            manager_photo: json.get("manager_photo"),
            status: json.get("status")
        )
    }
    
    func makeJSON() throws -> JSON {
        var json = JSON()

        try json.set("key", key)
        try json.set("owner_id", owner_id)
        try json.set("name", name)
        try json.set("phone", phone)
        try json.set("address", address)
        try json.set("website", website)
        try json.set("email", email)
        try json.set("bad_review_email", bad_review_email)
        try json.set("city", city)
        try json.set("state", state)
        try json.set("zip", zip)
        try json.set("category", category)
        try json.set("group_id", group_id)
        try json.set("logo", logo)
        try json.set("manager_photo", manager_photo)
        try json.set("status", status)
        try json.set("reviews", try self.reviews.all())

        return json
    }
}

extension Location {
    var reviews: Children<Location, Review> {
        return children()
    }
}

extension Location: ResponseRepresentable { }
