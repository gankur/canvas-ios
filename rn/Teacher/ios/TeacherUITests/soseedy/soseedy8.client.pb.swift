/*
 * DO NOT EDIT.
 *
 * Generated by the protocol buffer compiler.
 * Source: general.proto
 *
 */

/*
 * Copyright 2017, gRPC Authors All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import Foundation
import Dispatch
import gRPC
import SwiftProtobuf

/// Type for errors thrown from generated client code.
internal enum Soseedy_SeedyGeneralClientError : Error {
  case endOfStream
  case invalidMessageReceived
  case error(c: CallResult)
}

/// GetHealthCheck (Unary)
internal class Soseedy_SeedyGeneralGetHealthCheckCall {
  private var call : Call

  /// Create a call.
  fileprivate init(_ channel: Channel) {
    self.call = channel.makeCall("/soseedy.SeedyGeneral/GetHealthCheck")
  }

  /// Run the call. Blocks until the reply is received.
  fileprivate func run(request: Soseedy_HealthCheckRequest,
                       metadata: Metadata) throws -> Soseedy_HealthCheck {
    let sem = DispatchSemaphore(value: 0)
    var returnCallResult : CallResult!
    var returnResponse : Soseedy_HealthCheck?
    _ = try start(request:request, metadata:metadata) {response, callResult in
      returnResponse = response
      returnCallResult = callResult
      sem.signal()
    }
    _ = sem.wait(timeout: DispatchTime.distantFuture)
    if let returnResponse = returnResponse {
      return returnResponse
    } else {
      throw Soseedy_SeedyGeneralClientError.error(c: returnCallResult)
    }
  }

  /// Start the call. Nonblocking.
  fileprivate func start(request: Soseedy_HealthCheckRequest,
                         metadata: Metadata,
                         completion: @escaping (Soseedy_HealthCheck?, CallResult)->())
    throws -> Soseedy_SeedyGeneralGetHealthCheckCall {

      let requestData = try request.serializedData()
      try call.start(.unary,
                     metadata:metadata,
                     message:requestData)
      {(callResult) in
        if let responseData = callResult.resultData,
          let response = try? Soseedy_HealthCheck(serializedData:responseData) {
          completion(response, callResult)
        } else {
          completion(nil, callResult)
        }
      }
      return self
  }

  /// Cancel the call.
  internal func cancel() {
    call.cancel()
  }
}

/// Call methods of this class to make API calls.
internal class Soseedy_SeedyGeneralService {
  private var channel: Channel

  /// This metadata will be sent with all requests.
  internal var metadata : Metadata

  /// This property allows the service host name to be overridden.
  /// For example, it can be used to make calls to "localhost:8080"
  /// appear to be to "example.com".
  internal var host : String {
    get {
      return self.channel.host
    }
    set {
      self.channel.host = newValue
    }
  }

  /// Create a client that makes insecure connections.
  internal init(address: String) {
    gRPC.initialize()
    channel = Channel(address:address)
    metadata = Metadata()
  }

  /// Create a client that makes secure connections.
  internal init(address: String, certificates: String?, host: String?) {
    gRPC.initialize()
    channel = Channel(address:address, certificates:certificates, host:host)
    metadata = Metadata()
  }

  /// Synchronous. Unary.
  internal func gethealthcheck(_ request: Soseedy_HealthCheckRequest)
    throws
    -> Soseedy_HealthCheck {
      return try Soseedy_SeedyGeneralGetHealthCheckCall(channel).run(request:request, metadata:metadata)
  }
  /// Asynchronous. Unary.
  internal func gethealthcheck(_ request: Soseedy_HealthCheckRequest,
                  completion: @escaping (Soseedy_HealthCheck?, CallResult)->())
    throws
    -> Soseedy_SeedyGeneralGetHealthCheckCall {
      return try Soseedy_SeedyGeneralGetHealthCheckCall(channel).start(request:request,
                                                 metadata:metadata,
                                                 completion:completion)
  }
}