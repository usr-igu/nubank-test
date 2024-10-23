import Foundation

if let reader = OperationReader(path: "test.jsonl") {
    for operations in reader {
        print(operations)
    }
}
