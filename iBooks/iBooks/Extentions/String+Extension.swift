import Foundation

extension String {
    // Localized string.
    // - Returns: Localized string.
    var localized: String {
        NSLocalizedString(self, comment: "")
    }

    /// - Parameters:
    /// - arguments: Positional arguments in string.
    /// - Returns: Localized string.
    func localized(_ arguments: CVarArg...) -> String {
        String(format: localized, arguments: arguments)
    }
}
