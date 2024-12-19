import Foundation
@preconcurrency import PathKit
import JiroTravelersMapContentsValidatorCore

enum Error: Swift.Error {
    case fileNotFound(Path)
    case directory(Path)
    case invalidHours([(Shop, [(Day, [Shop.OpeningHours.Time])])])
    case conflictIds([(Shop, Shop)])
    case conflictNames([(Shop, Shop)])
}

extension Error: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .fileNotFound(path):
            "File not found: `\(path)`"
        case let .directory(path):
            "`\(path)` is not directory"
        case let .invalidHours(data):
            data.map { "\($0) has an invalid opening hour:\n\t\($1.map { "\($0.0) is a regular holiday but not empty in openingHours" }.joined(separator: "\n\t"))" }
                .joined(separator: "\n")
        case let .conflictIds(shops):
            "Conflict ids found.\n\t\(shops.map { "\($0.id): [\($0.name), \($1.name)]" }.joined(separator: "\n\t"))"
        case let .conflictNames(shops):
            "Conflict names found.\n\t\(shops.map { "\($0.name): [\($0.id), \($1.id)]" }.joined(separator: "\n\t"))"
        }
    }
}

struct ValidationError: Swift.Error {
    private var errors: [Error] = []
}

extension ValidationError {
    var isEmpty: Bool { errors.isEmpty }
}

extension ValidationError {
    mutating func append(_ error: Error) {
        errors.append(error)
    }
}

extension ValidationError: LocalizedError {
    var errorDescription: String? {
        "\u{001B}[31m\n"
        + errors.map(\.localizedDescription)
            .joined(separator: "\n")
        + "\n\u{001B}[0m"
    }
}
