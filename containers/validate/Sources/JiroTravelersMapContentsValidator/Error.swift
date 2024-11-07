import Foundation
import PathKit
import JiroTravelersMapContentsValidatorCore

enum Error: Swift.Error {
    case fileNotFound(Path)
    case directory(Path)
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
        case let .conflictIds(shops):
            "Conflict ids found.\n\t\(shops.map { "\($0.id): [\($0.name), \($1.name)]" }.joined(separator: "\n\t"))"
        case let .conflictNames(shops):
            "Conflict names found.\n\t\(shops.map { "\($0.name): [\($0.id), \($1.id)]" }.joined(separator: "\n\t"))"
        }
    }
}
