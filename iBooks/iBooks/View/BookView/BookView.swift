import SwiftUI

struct BookView: View {
    var book: SearchResultBook

    /// Requests cover image. A progress indicator is shown while running.
    @StateObject
    fileprivate var imageRequestViewModel: APIRequestViewModel<Data>

    /// Fetches the record for the book key if it exists in `FavouriteBook` Core Data entity.

    init(book: SearchResultBook) {
        self.book = book

        _imageRequestViewModel = StateObject(wrappedValue: APIRequestViewModel(urlString: book.mediumCoverImageUrlString, destinationType: Data.self))
    }

    var body: some View {
        NavigationLink {
            BookDetailView(book: book, imageRequestViewModel: imageRequestViewModel)

        } label: {
            VStack(alignment: .leading) {
                RequestTableView(requestable: imageRequestViewModel) {
                    ImageView(imageData: imageRequestViewModel.result)
                }

                Spacer()

                HStack {
                    VStack(alignment: .leading) {
                        Text(book.title ?? " ")
                            .font(.footnote)
                            .lineLimit(1)
                            .foregroundColor(.black)

                        Text(book.authorName?.first ?? " ")
                            .font(.caption2)
                            .lineLimit(1)
                            .foregroundColor(.black)
                    }

                    Spacer()
                }
            }
            .padding(3.0)
        }
    }
}

struct BookSimpleView_Previews: PreviewProvider {
    static var previews: some View {
        Text("ok")
    }
}
