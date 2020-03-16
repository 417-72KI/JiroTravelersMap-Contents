import Foundation
import PathKit

enum Error: Swift.Error {
    case fileNotFound(Path)
    case directory(Path)
}
