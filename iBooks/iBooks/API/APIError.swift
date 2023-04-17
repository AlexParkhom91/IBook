import Foundation

enum APIError: LocalizedError {
    // Invalid request
    case invalidRequestError(String)

    // Error on the transport layer(no connection to server)
    case transportError(Error)

    // Invalid response
    case invalidResponse

    // Server validation error
    case validationError(String)

    // Server sent data in an unexpected format
    case decodingError(Data, Error)

    //General server-side error. If `retryAfter` is set, the client can send the same request after the given time.
    case serverError(statusCode: Int, reason: String? = nil, retryAfter: String? = nil)

    var errorDescription: String? {
        switch self {
        case .invalidRequestError(let message):
            return "Invalid request: \(message)"
        case .transportError(let error):
            return "Transport error: \(error)"
        case .invalidResponse:
            return "Invalid response"
        case .validationError(let reason):
            return "Validation Error: \(reason)"
        case .decodingError(let data, let error):
            return "The server returned data in an unexpected format. Error: \(error) \nData: \(String(decoding: data, as: UTF8.self))"
        case .serverError(let statusCode, let reason, let retryAfter):
            return "Server error with code \(statusCode), reason: \(reason ?? "no reason given"), retry after: \(retryAfter ?? "no retry after provided")"
        }
    }
}
