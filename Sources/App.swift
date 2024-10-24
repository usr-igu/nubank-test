import Foundation

@main
struct App {
    static func main() throws {
        let reader = OperationReader(handle: FileHandle.standardInput)

        defer {
            try? FileHandle.standardInput.close()
        }

        let encoder = JSONEncoder()
        let lf = Data("\n".utf8)

        for operations in reader {
            let taxes = TaxCalculator.calculate(operations: operations)
            if let encoded = try? encoder.encode(taxes) {
                FileHandle.standardOutput.write(encoded)
                FileHandle.standardOutput.write(lf)
            }
        }
    }

}
