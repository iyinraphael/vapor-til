import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    let acronymController = AcronymController()
    
    try router.register(collection: acronymController)
}
