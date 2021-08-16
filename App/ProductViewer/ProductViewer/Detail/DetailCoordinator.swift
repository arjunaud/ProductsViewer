import Foundation
import Tempo

class DetailCoordinator: TempoCoordinator {
    
    // MARK: Presenters, view controllers, view state.
    
    var presenters = [TempoPresenterType]() {
        didSet {
            updateUI()
        }
    }
    
    fileprivate var viewState: DetailViewState {
        didSet {
            updateUI()
        }
    }
    
    fileprivate func updateUI() {
        for presenter in presenters {
            presenter.present(viewState)
        }
    }
    
    let dispatcher = Dispatcher()
    
    lazy var viewController: DetailViewController = {
        return DetailViewController.viewControllerFor(coordinator: self)
    }()
    
    // MARK: Init
    
    required init(listItemViewState: ListItemViewState) {
        viewState = DetailViewState(viewState: listItemViewState)
        registerListeners()
    }
    
    // MARK: DetailtCoordinator
    
    fileprivate func registerListeners() {
        dispatcher.addObserver(AddToCartPressed.self) { [weak self] event in
            let alert = UIAlertController(title: "Product added to cart", message: "\(event.product.title) added to cart", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self?.viewController.present(alert, animated: true, completion: nil)
        }

        dispatcher.addObserver(AddToListPressed.self) { [weak self] event in
            let alert = UIAlertController(title: "Product added to list", message: "\(event.product.title) added to list", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self?.viewController.present(alert, animated: true, completion: nil)
        }
    }
    
}
