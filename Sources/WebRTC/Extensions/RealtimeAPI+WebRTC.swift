import Core
import Foundation

public extension RealtimeAPI {

    static func webRTC(connectingTo request: URLRequest) async throws -> RealtimeAPI {
        try RealtimeAPI(connector: await WebRTCConnector.create(connectingTo: request))
    }

    static func webRTC(ephemeralKey: String, model: Model = .gptRealtime) async throws -> RealtimeAPI {
        return try await webRTC(connectingTo: .webRTCConnectionRequest(ephemeralKey: ephemeralKey, model: model))
    }
}
