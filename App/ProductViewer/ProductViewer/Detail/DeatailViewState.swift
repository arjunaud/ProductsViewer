import Foundation
import Tempo

struct DetailViewState: TempoViewState {
    var title:String
    var imageURL: URL?
    let price: String
    let description: String

    init(viewState: ListItemViewState) {
        self.title = viewState.title
        self.price = viewState.price
        self.description = viewState.description
        self.imageURL = viewState.imageURL
    }
}
