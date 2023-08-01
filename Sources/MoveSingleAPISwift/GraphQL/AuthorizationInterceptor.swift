//
//  File.swift
//  
//
//  Created by Felix Fischer on 26/07/2023.
//

import Foundation
import Apollo
import ApolloAPI

class AuthorizationInterceptor: ApolloInterceptor {
    var id: String = "AuthorizationInterceptor"

    private let apiKey: String

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func interceptAsync<Operation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) where Operation : GraphQLOperation {
        request.addHeader(name: "Authorization", value: apiKey)
        chain.proceedAsync(
            request: request,
            response: response,
            interceptor: self,
            completion: completion
        )
    }

}

class NetworkInterceptorProvider: DefaultInterceptorProvider {

    private let apiKey: String

    init(apiKey: String, client: Apollo.URLSessionClient, store: ApolloStore) {
        self.apiKey = apiKey
        super.init(client: client, store: store)
    }

    override func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] where Operation : GraphQLOperation {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(AuthorizationInterceptor(apiKey: apiKey), at: 0)
        return interceptors
    }
}
