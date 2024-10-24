import Foundation

final class TaxCalculator {
    private static let taxRate: Decimal = 0.20
    private static let valueLimit: Decimal = 20_000
    private static let buyOperation = "buy"

    static func calculate(operations: [StockOperation]) -> [Tax] {
        var state = CalculationState()
        var results: [Tax] = []

        operations.reduce(Tax.zero()) { partialResult, StockOperation in
            Tax.zero()
        }

        for transaction in operations {
            if isBuyOperation(transaction) {
                processBuy(transaction: transaction, state: &state)
                results.append(Tax(tax: 0))
            } else {
                let tax = calculateTax(transaction: transaction, state: &state)
                results.append(Tax(tax: tax))
            }
        }

        return results
    }

    private static func processBuy(transaction: StockOperation, state: inout CalculationState) {
        state.total += transaction.quantity
        state.accumulated += Decimal(transaction.unitCost * transaction.quantity)
    }

    private static func calculateTax(transaction: StockOperation, state: inout CalculationState)
        -> Decimal
    {
        let average = state.accumulated / Decimal(state.total)
        let difference = Decimal(transaction.unitCost) - average

        var tax: Decimal = 0

        if difference > 0 && isAboveValueLimit(transaction) {
            let gross = Decimal(transaction.quantity) * difference
            let net = gross + state.loss

            if net > 0 {
                tax = net * taxRate
            } else {
                state.loss += gross
            }
        } else if difference < 0 {
            state.loss += Decimal(transaction.quantity) * difference
        }

        return tax
    }

    private static func isAboveValueLimit(_ transaction: StockOperation) -> Bool {
        return Decimal(transaction.quantity * transaction.unitCost) > valueLimit
    }

    private static func isBuyOperation(_ transaction: StockOperation) -> Bool {
        return transaction.operation == buyOperation
    }

    private struct CalculationState {
        var total: Int = 0
        var accumulated: Decimal = 0
        var loss: Decimal = 0
    }
}
