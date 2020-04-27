//
//  ImagesInMemoryCacheTests.swift
//  MovieDBTests
//
//  Created by Илья Козлов on 27.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

@testable import MovieDB
import XCTest

class ImagesInMemoryCacheTests: XCTestCase {
    
    let testData = ImagesCacheTestDataGenerator()
    
    override func setUp() {
        super.setUp()
    }
    
    func testSaveResponseToCache() {
        let cache = ImagesInMemoryCache()
        let response = testData.randomResponse()
        cache.storeCachedResponse(response, for: testData.randomDataTask())
        
        XCTAssertTrue(true)
    }
    
    func testSaveAlreadyCachedResponseToCache() {
        let cache = ImagesInMemoryCache()
        let response = testData.randomResponse()
        let task = testData.randomDataTask()
        cache.storeCachedResponse(response, for: task)
        cache.storeCachedResponse(response, for: task)
        
        XCTAssertTrue(true)
    }
    
    func testReadResponseFromCache() {
        let cache = ImagesInMemoryCache()
        let request = testData.randomRequest()
        let response = testData.randomResponse()
        cache.storeCachedResponse(response, for: testData.randomDataTask(for: request))
        
        let restoredResponse = cache.cachedResponse(for: request)
        
        XCTAssertEqual(restoredResponse, response)
        XCTAssertEqual(restoredResponse?.data, response.data)
        XCTAssertEqual(restoredResponse?.response, response.response)
    }
    
    func testDeleteResponseFromCache() {
        let cache = ImagesInMemoryCache()
        let request = testData.randomRequest()
        let task = testData.randomDataTask(for: request)
        cache.storeCachedResponse(testData.randomResponse(), for: task)
        cache.removeCachedResponse(for: task)
        
        XCTAssertNil(cache.cachedResponse(for: request))
    }
    
    func testClearCache() {
        let cache = ImagesInMemoryCache()
        let firstRequest = testData.randomRequest()
        let secondRequest = testData.randomRequest()
        cache.storeCachedResponse(testData.randomResponse(), for: testData.randomDataTask(for: firstRequest))
        cache.storeCachedResponse(testData.randomResponse(), for: testData.randomDataTask(for: secondRequest))
        cache.removeAllCachedResponses()
        
        XCTAssertNil(cache.cachedResponse(for: firstRequest))
        XCTAssertNil(cache.cachedResponse(for: secondRequest))
    }
}
