//
//  CoreDataStorage.swift
//  MovieDBStorage
//
//  Created by Илья Козлов on 13.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import CoreData
import Foundation

final public class CoreDataStorage: MovieDBStorage {
    
    // MARK: - Private Properties
    
    private let bundleIdentifier = "ru.ikozlov.MovieDBStorage"
    private let modelName = "MovieDBStorage"
    
    // MARK: - Private Methods
    
    private lazy var container: NSPersistentContainer = {
        guard let bundle = Bundle(identifier: bundleIdentifier),
            let modelUrl = bundle.url(forResource: modelName, withExtension: "momd"),
            let managedObject = NSManagedObjectModel(contentsOf: modelUrl)
            else {
                fatalError("Unable to load \(modelName)!")
        }
        let container = NSPersistentContainer(name: modelName, managedObjectModel: managedObject)
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    private var getMoviesRequest: NSFetchRequest<CDMovie> {
        let request: NSFetchRequest<CDMovie> = CDMovie.fetchRequest()
        return request
    }
    
    private var deleteMoviesRequest: NSBatchDeleteRequest {
        let request: NSFetchRequest<NSFetchRequestResult> = CDMovie.fetchRequest()
        return NSBatchDeleteRequest(fetchRequest: request)
    }
    
    // MARK: - Init
    
    public init() {}
    
    // MARK: - Public methods
    
    public func read() throws -> [StorageMovie] {
        let objects = try container.viewContext.fetch(getMoviesRequest)
        return objects.map {
            StorageMovie(
                id: Int($0.id),
                voteCount: Int($0.voteCount),
                voteAverage: $0.voteAverage,
                posterUrl: $0.posterUrl,
                originalTitle: $0.originalTitle ?? "",
                genres: $0.genres ?? [],
                title: $0.title ?? "",
                overview: $0.overview ?? "",
                releaseDate: $0.releaseDate
            )
        }
    }
    
    public func save(_ movies: [StorageMovie]) throws {
        let context = container.newBackgroundContext()
        try context.execute(deleteMoviesRequest)
        movies.forEach { movie in
            let object = CDMovie(context: context)
            object.id = Int32(movie.id)
            object.voteCount = Int32(movie.voteCount)
            object.voteAverage = movie.voteAverage
            object.posterUrl = movie.posterUrl
            object.originalTitle = movie.originalTitle
            object.genres = movie.genres
            object.title = movie.title
            object.overview = movie.overview
            object.releaseDate = movie.releaseDate
        }
        try context.save()
    }
}
