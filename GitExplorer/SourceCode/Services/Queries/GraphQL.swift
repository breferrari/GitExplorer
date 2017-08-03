import UIKit

struct GraphQL {
    struct Repository {
        static func query(cursor: Bool) -> String {
            if cursor {
                return "query ($language: String!, $querySize: Int!, $cursor: String!) { search(query: $language, type: REPOSITORY, first: $querySize, after: $cursor) { repositoryCount edges { cursor node { ... on Repository { id name nameWithOwner description stargazers { totalCount } forks { totalCount } owner { login avatarUrl } } } } } }"
            } else {
                return "query ($language: String!, $querySize: Int!) { search(query: $language, type: REPOSITORY, first: $querySize) { repositoryCount edges { cursor node { ... on Repository { id name nameWithOwner description stargazers { totalCount } forks { totalCount } owner { login avatarUrl } } } } } }"
            }
        }
    }
    struct PullRequest {
        static func query(cursor: Bool) -> String {
            if cursor {
                return "query ($owner: String!, $name: String!, $querySize: Int!, $cursor: String!) { repository(owner: $owner, name: $name) { pullRequests(first: $querySize after: $cursor) { totalCount edges { cursor node { ... on PullRequest { title body url author { avatarUrl login } } } } } } }"
            } else {
                return "query ($owner: String!, $name: String!, $querySize: Int!) { repository(owner: $owner, name: $name) { pullRequests(first: $querySize) { totalCount edges { cursor node { ... on PullRequest { title body url author { avatarUrl login } } } } } } }"
            }
        }
    }
}
