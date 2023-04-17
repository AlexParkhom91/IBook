import Foundation
// Data model for searching Open Library (https://openlibrary.org/dev/docs/api/books)

// MARK: - OpenLibrarySearchResult

struct SearchResult: Codable {
    let docs: [SearchResultBook]?
    let works: [SearchResultBook]?
    let openLibrarySearchResultNumFound: Int?

    enum CodingKeys: String, CodingKey {
        case docs, works
        case openLibrarySearchResultNumFound = "num_found"
    }

    init(jsonData: Data) throws {
        self = try JSONDecoder().decode(SearchResult.self, from: jsonData)
    }
}

// MARK: - OpenLibrarySearchResult extension

extension SearchResult {
    var books: [SearchResultBook]? {
        works ?? docs
    }
}

// MARK: - OpenLibrarySearchResultBook

struct SearchResultBook: Codable {
    let title, type: String?
    let key: String?
    let coverEditionKey: String?
    let authorName: [String]?
    let publishYear: [Int]?
    let subject: [String]?

    enum CodingKeys: String, CodingKey {
        case title
        case type
        case key
        case coverEditionKey = "cover_edition_key"
        case authorName = "author_name"
        case publishYear = "publish_year"
        case subject
    }

    init(jsonData: Data) throws {
        self = try JSONDecoder().decode(SearchResultBook.self, from: jsonData)
    }

    func toJSONData() throws -> Data {
        try JSONEncoder().encode(self)
    }
}

// MARK: - OpenLibrarySearchResultBook extension

extension SearchResultBook {
    var mediumCoverImageUrlString: String {
        AppConfiguration.default.openLibraryMediumCoverImageUrlString.localized(coverEditionKey ?? "")
    }
}

// MARK: - Identifiable

extension SearchResultBook: Identifiable {
    var id: String {
        key ?? UUID().uuidString
    }
}

// MARK: - OpenLibraryBookProperties

struct BookProperties: Codable {
    let description: String?

    enum CodingKeys: String, CodingKey {
        case description
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            self.description = try container.decode(String.self, forKey: .description)
        } catch DecodingError.keyNotFound(_, _) {
            self.description = nil
        } catch DecodingError.typeMismatch {
            let typeValue = try container.decode(TypeValue<String>.self, forKey: .description)
            self.description = typeValue.value
        }
    }

    init(jsonData: Data) throws {
        self = try JSONDecoder().decode(BookProperties.self, from: jsonData)
    }

    func toJSONData() throws -> Data {
        try JSONEncoder().encode(self)
    }
}

// MARK: - OpenLibraryTypeValue

struct TypeValue<V: Codable>: Codable {
    let type: String?
    let value: V
}
