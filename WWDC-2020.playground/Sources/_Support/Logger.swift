
public protocol Logger {

    func log(info message: String)
    func log(warning message: String)
    func log(error message: String)

}

// MARK: - Implementation

class DefaultLogger: Logger {

    // MARK: - Private types

    private enum Status: String {
        case info = "[INFO]"
        case error = "[ERROR]"
        case warning = "[WARNING]"
    }

    // MARK: - Private properties

    private let isDebug: Bool

    // MARK: - Init

    init(isDebug: Bool) {
        self.isDebug = isDebug
    }

    // MARK: - Public static methods

    func log(info message: String) {
        if !isDebug { return }
        printMessage(status: .info, message: message)
    }

    func log(warning message: String) {
        printMessage(status: .warning, message: message)
    }

    func log(error message: String) {
        printMessage(status: .error, message: message)
        fatalError()
    }

    // MARK: - Fileprivate static methods

    private func printMessage(status: Status,
                              message: String) {
        print("\(status.rawValue) - \(message)")
    }

}
