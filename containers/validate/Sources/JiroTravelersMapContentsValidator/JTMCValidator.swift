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
        let combination = shops.indices.flatMap {
            let shop = shops[$0]
            return shops.indices.dropFirst($0 + 1).map {
                (shop, shops[$0])
            }
        }
        let conflictingIds = combination.filter { $0.id == $1.id }
        guard conflictingIds.isEmpty else {
            throw Error.conflictIds(conflictingIds)
        }
        let conflictingNames = combination.filter { $0.name == $1.name }
        guard conflictingNames.isEmpty else {
            throw Error.conflictNames(conflictingNames)
        }

        print(shops)
    }

    static var configuration: CommandConfiguration {
        .init(commandName: "jtmcvalidator")
    }
}
