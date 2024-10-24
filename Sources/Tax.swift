import Foundation

struct Tax: Codable, Equatable {
    let tax: Decimal

    static func == (lhs: Tax, rhs: Tax) -> Bool {
        return lhs.tax == rhs.tax
    }
}
