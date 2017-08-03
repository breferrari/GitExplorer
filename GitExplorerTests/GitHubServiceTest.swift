import XCTest
@testable import GitExplorer

import Moya
import Unbox

class GitHubServiceTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testLoadRepositoriesFail() {
        // given
        let expectation = self.expectation(description: "Expected load repositories to fail")
        
        // when
        GitHubService.queryRepositories(language: "Swift", cursor: nil) { (container) in
            expectation.fulfill()
            XCTAssert((container != nil))
        }
        
        // then
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testLoadPullRequestsFail() {
        // given
        let expectation = self.expectation(description: "Expected load pull requests to fail")
        
        // when
        GitHubService.queryPullRequests(owner: "Alamofire", name: "Alamofire", cursor: nil) { (container) in
            expectation.fulfill()
            XCTAssert((container != nil))
        }
        
        // then
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testHandleRepositoriesStubFail() {
        // given
        let expectation = self.expectation(description: "Expected handle repositories stub to fail")
        
        // when
        let provider = MoyaProvider<GitHub>(stubClosure: MoyaProvider.immediatelyStub)
        provider.request(.repositories(language: "SwiftStub", cursor: nil)) { (result) in
            switch result {
            case let .success(response):
                do {
                    if let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any] {
                        var container: RepositoryContainer = try unbox(dictionary: json)
                        expectation.fulfill()
                        container.append(container)
                        XCTAssert(container.repositories.count == 60)
                    }
                } catch let error as NSError {
                    print("[GithubServiceTest] Error Parsing JSON: \(error)")
                }
            case let .failure(error):
                print("[GithubServiceTest] Error: \(error)")
            }
        }
    
        // then
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testHandlePullRequestsStubFail() {
        // given
        let expectation = self.expectation(description: "Expected handle pull requests stub to fail")
        
        // when
        let provider = MoyaProvider<GitHub>(stubClosure: MoyaProvider.immediatelyStub)
        provider.request(.pullRequests(owner: "Stub", name: "Stub", cursor: nil)) { (result) in
            switch result {
            case let .success(response):
                do {
                    if let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any] {
                        var container: PullRequestContainer = try unbox(dictionary: json)
                        expectation.fulfill()
                        container.append(container)
                        XCTAssert(container.pullRequests.count == 60)
                    }
                } catch let error as NSError {
                    print("[GithubServiceTest] Error Parsing JSON: \(error)")
                }
            case let .failure(error):
                print("[GithubServiceTest] Error: \(error)")
            }
        }
        
        // then
        waitForExpectations(timeout: 3, handler: nil)
    }
    
}
