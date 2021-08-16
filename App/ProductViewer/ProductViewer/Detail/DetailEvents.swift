import Foundation
import Tempo


struct AddToCartPressed: EventType {
    let product: DetailViewState
}

struct AddToListPressed: EventType {
    let product: DetailViewState
}
