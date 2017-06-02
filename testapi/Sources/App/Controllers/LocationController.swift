import Vapor
import HTTP

final class LocationController: ResourceRepresentable {
    func index(request: Request) throws -> ResponseRepresentable {
        let query = try Location.makeQuery();
        if let requestData = request.query?.wrapped {
            print(requestData["location_id"]!)
            if let location_id = requestData["location_id"] {
                try query.filter("id", location_id)
            }
        }
        return try query.all().makeJSON()
    }
    
       func makeResource() -> Resource<Location> {
        return Resource(
            index: index
        )
    }
}

extension Request {
       func location() throws -> Location {
        guard let json = json else { throw Abort.badRequest }
        return try Location(json: json)
    }
}

extension LocationController: EmptyInitializable { }
