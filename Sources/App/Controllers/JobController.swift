//
//  JobController.swift
//  App
//
//  Created by Axel Peigné on 21/08/2019.
//

import Vapor
import FluentSQLite

final class JobController {
    
    func index(_ req: Request) throws -> Future<[Job]> {
        return Job.query(on: req).all()
    }
    
    func create(_ req: Request) throws -> Future<Job> {
        return try req.content.decode(Job.self).flatMap { job in
            return job.save(on: req)
        }
    }
    
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Job.self).flatMap { job in
            return job.delete(on: req)
        }.transform(to: .ok)
    }

    func getWaitingJobs(_ req: Request) throws -> Future<Job> {
        let op = FilterOperator<SQLiteDatabase, Job>.make(\Job.status, .equal, [.created])
        return Job.query(on: req)
            .filter(op)
            .first()
            .unwrap(or: Abort(.notFound))
    }
    
    func finishedJob(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Job.self).flatMap { job in
            return job.script
                .get(on: req)
                .do({ script in
                    if script.identifier == .vrs08 {
                        guard let data = req.http.body.data else {
                            job.status = .empty
                            return
                        }
                        job.jsonResult = data
                        guard let cars = try? JSONDecoder().decode([Car].self, from: data) else {
                            if let logger = try? req.make(Logger.self) {
                                logger.info("wrong data")
                            }
                            job.status = .errored
                            return
                        }
                        for car in cars {
                            _ = car.save(on: req)
                        }
                        job.status = .succeded
                        _ = job.save(on: req)
                    }
            })
        }.transform(to: .ok)
    }
    

}

extension NSError: Debuggable {
    public var identifier: String {
        return "NSError"
    }
    
    public var reason: String {
        return localizedDescription
    }
    
    
}
