import Vapor
import PostgreSQL

final class AcronymController: RouteCollection {
    
    func boot(router: Router) throws {
        
        router.post("api", "acronyms", use: createAcronymHandler)
        router.get("api", "all", use: getAllAcronyms)
        router.get("api", Int.parameter, use: getAcronymWithID)
        router.delete("api", Int.parameter, use: deleteAcronymAtID)

    }
    
    
    private func deleteAcronymAtID(_ req: Request) throws -> Future<HTTPResponseStatus> {
        
        let id = try req.parameters.next(Int.self)
        
        return Acronym
            .query(on: req)
            .filter(\.id, .equal, id)
            .first()
            .unwrap(or: HTTPError(identifier: "com.LambdaSchool.API", reason: "There's no todo with that identifiers: \(id)"))
            .delete(on: req)
            .transform(to: HTTPResponseStatus.noContent)
    }
    
    private func getAcronymWithID(_ req: Request) throws -> Future<Acronym> {
        let id = try req.parameters.next(Int.self)
        
        return Acronym
            .query(on: req)
            .filter(\.id, .equal, id)
            .first()
            .unwrap(or: HTTPError(identifier: "com.LambdaSchool.API", reason: "There's no todo with that identifiers: \(id)"))
        
    }
    
    private func createAcronymHandler(_ req: Request)  throws -> Future<Acronym> {
        
        //Returns a acronym object wants it's save
        return try req.content
            .decode(Acronym.self)
            .flatMap(to: Acronym.self) { acronym in
            
                return acronym.save(on: req)
        }
    
    }
    
    private func getAllAcronyms(_ req: Request) throws -> Future<[Acronym]> {
        return Acronym.query(on: req).all()
    }
    
}
