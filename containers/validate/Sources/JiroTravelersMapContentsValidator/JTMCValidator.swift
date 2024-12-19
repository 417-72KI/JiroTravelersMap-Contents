import Foundation
import ArgumentParser
import PathKit
import JiroTravelersMapContentsValidatorCore

@main
struct JTMCValidator: ParsableCommand {
    @Argument(help: "File path")
    var jsonFilePath: String

    mutating func run() throws {
        let path = Path(jsonFilePath)
        guard path.exists else { throw Error.fileNotFound(path.absolute()) }
        guard path.isFile else { throw Error.directory(path.absolute()) }
        let data = try Data(contentsOf: path.url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let shops = try decoder.decode([Shop].self, from: data)

        var validationError = ValidationError()

        let invalidHours = shops.lazy
            .map { ($0, $0.regularHoliday.compactMap($0.openingHours.forDay(_:))) }
            .filter { $0.status != .closed && !$1.isEmpty } as Array
        if !invalidHours.isEmpty {
            validationError.append(Error.invalidHours(invalidHours))
        }

        let combination = shops.indices.flatMap {
            let shop = shops[$0]
            return shops.indices.dropFirst($0 + 1).map {
                (shop, shops[$0])
            }
        }
        let conflictingIds = combination.filter { $0.id == $1.id }
        if !conflictingIds.isEmpty {
            validationError.append(Error.conflictIds(conflictingIds))
        }
        let conflictingNames = combination.filter { $0.name == $1.name }
        if !conflictingNames.isEmpty {
            validationError.append(Error.conflictNames(conflictingNames))
        }
        guard validationError.isEmpty else {
            throw validationError
        }

        print(shops)
    }

    static var configuration: CommandConfiguration {
        .init(commandName: "jtmcvalidator")
    }
}
