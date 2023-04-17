import SwiftUI

struct BookDetailView: View {
    var book: SearchResultBook

    // Requests  image. A progress indicator is shown while running.
    @ObservedObject
    var imageRequestViewModel: APIRequestViewModel<Data>

    // Requests book description.
    @StateObject
    fileprivate var bookPropertiesRequestViewModel: APIRequestViewModel<BookProperties>

    init(book: SearchResultBook, imageRequestViewModel: APIRequestViewModel<Data>) {
        self.book = book
        self.imageRequestViewModel = imageRequestViewModel

        _bookPropertiesRequestViewModel = StateObject(wrappedValue: APIRequestViewModel(urlString: AppConfiguration.default.openLibraryBookPropertiesUrlString.localized(book.key ?? ""), destinationType: BookProperties.self))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16.0) {
                HStack {
                    RequestTableView(requestable: imageRequestViewModel) {
                        ImageView(imageData: imageRequestViewModel.result)
                    }
                    .frame(width: 80.0)

                    VStack(alignment: .leading, spacing: 5.0) {
                        Text(book.title ?? " ")
                            .font(.body)
                            .lineLimit(2)

                        Text((book.authorName ?? []).joined(separator: ", "))
                            .font(.subheadline)
                            .lineLimit(2)

                        Text((book.subject ?? []).joined(separator: ", "))
                            .font(.footnote)
                            .lineLimit(2)

                        Spacer()
                    }

                    Spacer()
                }
                .frame(maxWidth: .infinity)

                RequestTableView(requestable: bookPropertiesRequestViewModel) {
                    Text(bookPropertiesRequestViewModel.result?.description ?? "")
                }

                Spacer()
            }
        }
        .padding(16.0)
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Text("ok")
    }
}
