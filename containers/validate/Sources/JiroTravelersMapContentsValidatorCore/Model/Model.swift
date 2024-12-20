import Foundation

protocol Model: Decodable, Hashable, Sendable {
}

public protocol Identifiable {
    /// A type representing the stable identity of the entity associated with `self`.
    associatedtype ID : Hashable

    /// The stable identity of the entity associated with `self`.
    var id: Self.ID { get }
}
