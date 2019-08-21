import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    let jobController = JobController()
    router.get("jobs", use: jobController.index)
    router.post("jobs", use: jobController.create)
    router.delete("jobs", Job.parameter, use: jobController.delete)
    router.get("get-wating-tasks", use: jobController.getWaitingTasks)
    
    let scriptController = ScriptController()
    router.get("scripts", use: scriptController.index)
    router.post("scripts", use: scriptController.create)
    router.get("scripts/update-data", Script.parameter, use: scriptController.updateData)

}
