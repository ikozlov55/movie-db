//
//  ImagesFileCache.swift
//  MovieDB
//
//  Created by Илья Козлов on 27.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

final class ImagesFileCache: URLCache {
    
    // MARK: - Private Properties
    
    private let queue = DispatchQueue(label: "ImagesFileCache", attributes: [.concurrent])
    private let fileManager = FileManager()
    private let dirName = "images"
    private lazy var dir: URL? = {
        guard let systemCachesDir = try? fileManager.url(
            for: .cachesDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
            ) else { return nil }
        let dir = URL(fileURLWithPath: dirName, isDirectory: true, relativeTo: systemCachesDir)
        if !fileManager.fileExists(atPath: dir.path) {
            do {
                try fileManager.createDirectory(at: dir, withIntermediateDirectories: false, attributes: nil)
            } catch {
                return nil
            }
        }
        return dir
    }()
    
    // MARK: - URLCache Overrides
    
    override func storeCachedResponse(_ cachedResponse: CachedURLResponse, for dataTask: URLSessionDataTask) {
        guard let fileUrl = buildFileUrl(from: dataTask),
            !fileManager.fileExists(atPath: fileUrl.path) else {
                return
        }
        queue.async {
            guard let data = try? NSKeyedArchiver.archivedData(
                withRootObject: cachedResponse,
                requiringSecureCoding: false) else { return }
            self.fileManager.createFile(
                atPath: fileUrl.path,
                contents: data,
                attributes: [FileAttributeKey.protectionKey: FileProtectionType.complete]
            )
        }
    }
    
    override func getCachedResponse(
        for dataTask: URLSessionDataTask,
        completionHandler: @escaping (CachedURLResponse?) -> Void) {
        guard let fileUrl = buildFileUrl(from: dataTask),
            fileManager.fileExists(atPath: fileUrl.path) else {
                completionHandler(nil)
                return
        }
        
        queue.async { [weak self] in
            guard let data = self?.fileManager.contents(atPath: fileUrl.path),
                let responseData = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data),
                let response = responseData as? CachedURLResponse
                else { return }
            completionHandler(response)
        }
    }
    
    override func removeCachedResponse(for dataTask: URLSessionDataTask) {
        guard let fileUrl = buildFileUrl(from: dataTask) else {
            return
        }
        try? fileManager.removeItem(at: fileUrl)
    }
    
    // MARK: - Private Methods
    
    private func buildFileUrl(from dataTask: URLSessionDataTask) -> URL? {
        guard let fileName = dataTask.currentRequest?.url?.absoluteString.sha256() else {
            return nil
        }
        return URL(fileURLWithPath: fileName, isDirectory: false, relativeTo: dir)
    }
    
}
