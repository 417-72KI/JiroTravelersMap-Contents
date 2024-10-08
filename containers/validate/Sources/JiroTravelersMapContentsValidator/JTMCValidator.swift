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
        print(shops)
    }

    static var configuration: CommandConfiguration {
        .init(commandName: "jtmcvalidator")
    }
}
