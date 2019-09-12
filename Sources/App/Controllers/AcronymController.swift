import Vapor

final class AcronymController: RouteCollection {
    
    func boot(router: Router) throws {
        
        router.post("api", "acronyms", use: createAcronymHandler)
        router.get("api", "all", use: getAllAcronyms)
        
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
