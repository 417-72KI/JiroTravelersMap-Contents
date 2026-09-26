import Foundation

struct FilePath {
    let url: URL
}

extension FilePath {
    init(_ path: String) {
        self.url = URL(
            filePath: path,
            relativeTo: .currentDirectory()
        )
    }
}

extension FilePath {
    nonisolated var path: String { url.path(percentEncoded: false) }

    nonisolated var absolutePath: String { url.absoluteURL.path(percentEncoded: false) }
}

extension FilePath {
    var exists: Bool { fm.fileExists(atPath: path) }

    var isFile: Bool {
        var isDir = ObjCBool(false)
        guard fm.fileExists(atPath: path, isDirectory: &isDir) else { return false }
        return !isDir.boolValue
    }
}

extension FilePath {
    static var current: Self {
        Self(fm.currentDirectoryPath)
    }
}

// MARK: -
extension FilePath: Identifiable {
    var id: String { url.absoluteString }
}

// MARK: -
extension FilePath: CustomStringConvertible {
    nonisolated var description: String { absolutePath }
}

// MARK: -
private extension FilePath {
    static let fm = FileManager.default
}

private extension FilePath {
    var fm: FileManager { Self.fm }
}
