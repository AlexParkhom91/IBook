import Foundation

class AppConfiguration {
    static let `default` = AppConfiguration()

    var openLibraryTrendingUrlString = "https://openlibrary.org/trending/daily.json"

    var openLibraryClassicUrlString = "https://openlibrary.org/read.json"

    var openLibraryBookPropertiesUrlString = "https://openlibrary.org%@.json"

    var openLibraryMediumCoverImageUrlString = "https://covers.openlibrary.org/b/olid/%@-M.jpg"
}
