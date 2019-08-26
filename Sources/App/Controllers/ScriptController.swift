//
//  ScriptController.swift
//  App
//
//  Created by Axel Peigné on 21/08/2019.
//

import Vapor

final class ScriptController {
    
    func index(_ req: Request) throws -> Future<[Script]> {
        return Script.query(on: req).all()
    }
    
    func create(_ req: Request) throws -> Future<Script> {
        return try req.content.decode(Script.self).flatMap { script in
            return script.save(on: req)
        }
    }
    
    func updateData(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Script.self).flatMap { script -> Future<Job> in
            let job = try Job(scriptId: script.requireID())
            job.status = .created
            return job.save(on: req)
        }.transform(to: .ok)
    }
    
}
