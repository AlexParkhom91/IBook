import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack {
                    Text("Trending Books")
                        .font(.title2)
                        .bold()

                    MainBooksView(urlString: AppConfiguration.default.openLibraryTrendingUrlString)

                    Spacer()
                    Spacer()

                    Text("Classic Books")
                        .font(.title2)
                        .bold()

                    MainBooksView(urlString: AppConfiguration.default.openLibraryClassicUrlString)

                    Spacer()
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

struct MainBooksView: View {
    var urlString: String

    @StateObject
    fileprivate var booksRequestViewModel: APIRequestViewModel<SearchResult>

    init(urlString: String) {
        self.urlString = urlString

        _booksRequestViewModel = StateObject(wrappedValue: APIRequestViewModel(urlString: urlString, destinationType: SearchResult.self))
    }

    var body: some View {
        RequestTableView(requestable: booksRequestViewModel) {
            if let books = booksRequestViewModel.result?.books {
                if !books.isEmpty {
                    BookList(numberOfItems: books.count) { index in
                        BookView(book: books[index])
                            .border(.gray)
                    }
                } else {
                    Text("No books")
                }
            }
        }
        .frame(maxWidth: .infinity, minHeight: 250.0)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
