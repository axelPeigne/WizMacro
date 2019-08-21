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

    func getWaitingTasks(_ req: Request) throws -> Future<[Job]> {
        let op = FilterOperator<SQLiteDatabase, Job>.make(\Job.status, .equal, [.created])
        return Job.query(on: req).filter(op).all()
    }

}
