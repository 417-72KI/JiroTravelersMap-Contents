import Foundation

public enum Day: String, Model {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    case holiday
}

public extension Day {
    var stringValue: String {
        switch self {
        case .monday: return R.string.day.monday()
        case .tuesday: return R.string.day.tuesday()
        case .wednesday: return R.string.day.wednesday()
        case .thursday: return R.string.day.thursday()
        case .friday: return R.string.day.friday()
        case .saturday: return R.string.day.saturday()
        case .sunday: return R.string.day.sunday()
        case .holiday: return R.string.day.holiday()
        }
    }

    var shortStringValue: String {
        switch self {
        case .monday: return R.string.day.monday_short()
        case .tuesday: return R.string.day.tuesday_short()
        case .wednesday: return R.string.day.wednesday_short()
        case .thursday: return R.string.day.thursday_short()
        case .friday: return R.string.day.friday_short()
        case .saturday: return R.string.day.saturday_short()
        case .sunday: return R.string.day.sunday_short()
        case .holiday: return R.string.day.holiday_short()
        }
    }
}

// MARK: -
extension Array where Element == Day {
    var stringValue: String {
        map { $0.stringValue }
            .joined(separator: R.string.symbol.separator())
    }

    var shortStringValue: String {
        map { $0.shortStringValue }
            .joined(separator: R.string.symbol.separator())
    }
}
