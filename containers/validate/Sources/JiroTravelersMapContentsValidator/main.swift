import Foundation
import ArgumentParser
import PathKit

struct Main: ParsableCommand {
    @Argument(help: "File path")
    var jsonFilePath: String

    func run() throws {
        let path = Path(jsonFilePath)
        guard path.exists && path.isFile else { throw Error.fileNotFound(path) }
        print(path.absolute())
    }

    static var configuration: CommandConfiguration {
        .init(commandName: "jtmcvalidator")
    }
}

Main.main()
