import UIKit
import Tempo
import Kingfisher

class DetailViewPresenter: TempoPresenter {
    let detailViewController: DetailViewController
    var viewState: DetailViewState?
    let dispatcher:Dispatcher
        
    init(detailViewController:DetailViewController, dispatcher:Dispatcher) {
        self.detailViewController = detailViewController
        self.dispatcher = dispatcher
    }
    
    public func present(_ viewState: DetailViewState) {
        self.viewState = viewState
        self.detailViewController.priceLabel.text = viewState.price
        self.detailViewController.descriptionTextView.text = viewState.description
        self.detailViewController.productImageView.kf.setImage(with: viewState.imageURL)
        
        self.detailViewController.addToCartButton.addTarget(self, action: #selector(addToCartButtonPressed) , for: .touchUpInside)

        self.detailViewController.addToListButton.addTarget(self, action: #selector(addToListButtonPressed) , for: .touchUpInside)
    }
    

    @objc func addToCartButtonPressed() {
        guard let viewState = self.viewState else {
            return
        }
        dispatcher.triggerEvent(AddToCartPressed(product: viewState))
    }

    @objc func addToListButtonPressed() {
        guard let viewState = self.viewState else {
            return
        }
        dispatcher.triggerEvent(AddToListPressed(product: viewState))
    }
}
