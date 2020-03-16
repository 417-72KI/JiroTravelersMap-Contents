import Foundation
import ArgumentParser
import PathKit

struct Main: ParsableCommand {
    @Argument(help: "File path")
    var jsonFilePath: String

    func run() throws {
        let path = Path(jsonFilePath)
        guard path.exists else { throw Error.fileNotFound(path.absolute()) }
        guard path.isFile else { throw Error.directory(path.absolute()) }
        let data = try Data(contentsOf: path.url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let entity = try decoder.decode([Entity].self, from: data)
        print(entity)
    }

    static var configuration: CommandConfiguration {
        .init(commandName: "jtmcvalidator")
    }
}

Main.main()
