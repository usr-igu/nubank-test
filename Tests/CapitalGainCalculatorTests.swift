import Testing
import XCTest

@testable import Taxes

@Suite class CapitalGainCalculatorTests {
    @Test
    func ExemploProvido_Caso12() throws {
        let operations: [StockOperation] = [
            StockOperation(operation: "buy", unitCost: 10, quantity: 100),
            StockOperation(operation: "sell", unitCost: 15, quantity: 50),
            StockOperation(operation: "sell", unitCost: 15, quantity: 50),
            StockOperation(operation: "buy", unitCost: 10, quantity: 10000),
            StockOperation(operation: "sell", unitCost: 20, quantity: 5000),
            StockOperation(operation: "sell", unitCost: 5, quantity: 5000),
        ]

        let result = TaxCalculator.calculate(operations: operations)

        let expected: [Tax] = [
            Tax(tax: 0), Tax(tax: 0), Tax(tax: 0),
            Tax(tax: 0), Tax(tax: 10000), Tax(tax: 0),
        ]

        #expect(result == expected)
    }

    @Test
    func ExemploProvido_Caso1() throws {
        let operations: [StockOperation] = [
            StockOperation(operation: "buy", unitCost: 10, quantity: 100),
            StockOperation(operation: "sell", unitCost: 15, quantity: 50),
            StockOperation(operation: "sell", unitCost: 15, quantity: 50),
        ]

        let result = TaxCalculator.calculate(operations: operations)

        let expected: [Tax] = [Tax(tax: 0), Tax(tax: 0), Tax(tax: 0)]

        #expect(result == expected)
    }

    @Test
    func ExemploProvido_Caso2() throws {
        let operations: [StockOperation] = [
            StockOperation(operation: "buy", unitCost: 10, quantity: 10000),
            StockOperation(operation: "sell", unitCost: 20, quantity: 5000),
            StockOperation(operation: "sell", unitCost: 5, quantity: 5000),
        ]

        let result = TaxCalculator.calculate(operations: operations)

        let expected: [Tax] = [Tax(tax: 0), Tax(tax: 10000), Tax(tax: 0)]

        #expect(result == expected)
    }

    @Test
    func ExemploProvido_Caso3() throws {
        let operations: [StockOperation] = [
            StockOperation(operation: "buy", unitCost: 10, quantity: 10000),
            StockOperation(operation: "sell", unitCost: 5, quantity: 5000),
            StockOperation(operation: "sell", unitCost: 20, quantity: 5000),
        ]

        let result = TaxCalculator.calculate(operations: operations)

        let expected: [Tax] = [Tax(tax: 0), Tax(tax: 0), Tax(tax: 5000)]

        #expect(result == expected)
    }

    @Test
    func ExemploProvido_Caso4() throws {
        let operations: [StockOperation] = [
            StockOperation(operation: "buy", unitCost: 10, quantity: 10000),
            StockOperation(operation: "buy", unitCost: 25, quantity: 5000),
            StockOperation(operation: "sell", unitCost: 15, quantity: 10000),
        ]

        let result = TaxCalculator.calculate(operations: operations)

        let expected: [Tax] = [Tax(tax: 0), Tax(tax: 0), Tax(tax: 0)]

        #expect(result == expected)
    }

    @Test
    func ExemploProvido_Caso5() throws {
        let operations: [StockOperation] = [
            StockOperation(operation: "buy", unitCost: 10, quantity: 10000),
            StockOperation(operation: "buy", unitCost: 25, quantity: 5000),
            StockOperation(operation: "sell", unitCost: 15, quantity: 10000),
            StockOperation(operation: "sell", unitCost: 25, quantity: 5000),
        ]

        let result = TaxCalculator.calculate(operations: operations)

        let expected: [Tax] = [Tax(tax: 0), Tax(tax: 0), Tax(tax: 0), Tax(tax: 10000)]

        #expect(result == expected)
    }

    @Test
    func ExemploProvido_Caso6() throws {
        let operations: [StockOperation] = [
            StockOperation(operation: "buy", unitCost: 10, quantity: 10000),
            StockOperation(operation: "sell", unitCost: 2, quantity: 5000),
            StockOperation(operation: "sell", unitCost: 20, quantity: 2000),
            StockOperation(operation: "sell", unitCost: 20, quantity: 2000),
            StockOperation(operation: "sell", unitCost: 25, quantity: 1000),
        ]

        let result = TaxCalculator.calculate(operations: operations)

        let expected: [Tax] = [Tax(tax: 0), Tax(tax: 0), Tax(tax: 0), Tax(tax: 0), Tax(tax: 3000)]

        #expect(result == expected)
    }
}
