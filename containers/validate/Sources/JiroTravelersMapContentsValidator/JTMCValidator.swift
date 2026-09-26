import Foundation
import ArgumentParser
import JiroTravelersMapModel

@main
struct JTMCValidator: AsyncParsableCommand {
    @Argument(help: "File path")
    var jsonFilePath: String

    mutating func run() async throws {
        @MainActor
        func runInMainActor() throws {
            let path = FilePath(jsonFilePath)
            guard path.exists else { throw Error.fileNotFound(path) }
            guard path.isFile else { throw Error.directory(path) }
            let data = try Data(contentsOf: path.url)
            let shops = try Shop.decodeArray(from: data)

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

            print(
                shops.map {
                    "\($0), Twitter: \($0.twitter.map { "`\($0)`" }, default: "(null)"), Last Update: \($0.lastUpdate, default: "<unknown>")"
                }.joined(separator: "\n")
            )
        }
        try await runInMainActor()
    }

    static var configuration: CommandConfiguration {
        .init(commandName: "jtmcvalidator")
    }
}
