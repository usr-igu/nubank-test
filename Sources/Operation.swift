import Foundation

struct Operation: Codable, Equatable {
    let operation: String
    let unitCost: Int
    let quantity: Int

    enum CodingKeys: String, CodingKey {
        case operation
        case unitCost = "unit-cost"
        case quantity
    }

    static func == (lhs: Operation, rhs: Operation) -> Bool {
        return lhs.operation == rhs.operation && lhs.unitCost == rhs.unitCost
            && lhs.quantity == rhs.quantity
    }
}
