import Foundation

struct StockOperation: Codable, Equatable {
    let operation: String
    let unitCost: Int
    let quantity: Int

    enum CodingKeys: String, CodingKey {
        case operation
        case unitCost = "unit-cost"
        case quantity
    }

    static func == (lhs: StockOperation, rhs: StockOperation) -> Bool {
        return lhs.operation == rhs.operation && lhs.unitCost == rhs.unitCost
            && lhs.quantity == rhs.quantity
    }
}
