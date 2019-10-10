//
// This file is part of Canvas.
// Copyright (C) 2018-present  Instructure, Inc.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
//

import Foundation

// https://canvas.instructure.com/doc/api/account_domain_lookups.html#method.account_domain_lookups.search
public struct GetAccountsSearchRequest: APIRequestable {
    public typealias Response = [APIAccountResult]

    public let searchTerm: String

    public let path = "https://canvas.instructure.com/api/v1/accounts/search"
    public var query: [APIQueryItem] {
        return [
            .value("per_page", "50"),
            .value("search_term", searchTerm),
        ]
    }
    public let headers: [String: String?] = [
        HttpHeader.authorization: nil,
    ]
}

// https://canvas.instructure.com/doc/api/accounts.html#method.accounts.index
public struct GetAccountsRequest: APIRequestable {
    public typealias Response = [APIAccount]

    public let path = "accounts"
}

// https://canvas.instructure.com/doc/api/accounts.html#method.accounts.courses_api
public struct GetAccountCoursesRequest: APIRequestable {
    public typealias Response = [APICourse]

    public enum SearchBy: String, Codable {
        case course
        case teacher
    }

    public let accountID: String
    public let searchTerm: String?
    public let searchBy: SearchBy?

    public init(accountID: String, searchTerm: String?, searchBy: SearchBy?) {
        self.accountID = accountID
        self.searchTerm = searchTerm
        self.searchBy = searchBy
    }

    public var path: String {
        let context = ContextModel(.account, id: accountID)
        return "\(context.pathComponent)/courses"
    }
    public var query: [APIQueryItem] {
        var query: [APIQueryItem] = [
            .include(["teachers", "term"]),
            .value("sort", "sis_course_id"),
            .value("order", "desc"),
        ]
        if let searchTerm = searchTerm {
            query.append(.value("search_term", searchTerm))
        }
        if let searchBy = searchBy {
            query.append(.value("search_by", searchBy.rawValue))
        }
        return query
    }
}
