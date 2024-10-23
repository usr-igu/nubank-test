import Foundation

final class OperationReader: IteratorProtocol, Sequence {
    private let handle: FileHandle
    private let decoder = JSONDecoder()

    private let lf = UInt8(ascii: "\n")

    private var buffer = Data()

    init?(path: String) {
        guard let handle = try? FileHandle(forReadingFrom: URL(fileURLWithPath: path)) else {
            return nil
        }

        self.handle = handle
    }

    deinit {
        self.handle.closeFile()
    }

    func next() -> [Operation]? {
        while true {
            // Try to find a complete line in the current buffer
            if let index = buffer.firstIndex(of: lf) {
                let line = buffer.prefix(upTo: index)

                buffer.removeSubrange(0...index)

                if !line.isEmpty {
                    return try? decoder.decode([Operation].self, from: line)
                }
                continue
            }

            // Read more data if needed
            let chunk = self.handle.readData(ofLength: 16 * 1024)

            if chunk.isEmpty {
                // End of file reached - process remaining buffer if any
                if !buffer.isEmpty {
                    if let operations = try? decoder.decode([Operation].self, from: buffer) {
                        buffer.removeAll()
                        return operations
                    }
                }
                return nil
            }

            buffer.append(chunk)
        }
    }

    func makeIterator() -> OperationReader {
        return self
    }
}
