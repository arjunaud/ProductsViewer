//
//  ListCoordinator.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Foundation
import Tempo
import Kingfisher

/*
 Coordinator for the product list
 */
class ListCoordinator: TempoCoordinator {
    
    let productSerive = ProductService()

    // MARK: Presenters, view controllers, view state.
    
    var presenters = [TempoPresenterType]() {
        didSet {
            updateUI()
        }
    }
    
    fileprivate var viewState: ListViewState {
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
    
    lazy var viewController: ListViewController = {
        return ListViewController.viewControllerFor(coordinator: self)
    }()
    
    // MARK: Init
    
    required init() {
        viewState = ListViewState(listItems: [])
        updateState()
        registerListeners()
        KingfisherManager.shared.cache.memoryStorage.config.totalCostLimit = 300 * 1024 * 1024
    }
    
    // MARK: ListCoordinator
    
    fileprivate func registerListeners() {
        dispatcher.addObserver(ListItemPressed.self) { [weak self] event in
            let detailCoordinator = DetailCoordinator(listItemViewState: event.product)
            self?.viewController.present(detailCoordinator.viewController, animated: true, completion: nil)
        }
    }
    
    func showProductsFetchError() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Data fetch error", message: "Unable to fetch products", preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil) )
            self?.viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateState() {
        self.productSerive.fetchProducts { (products, error) in
            if products.isEmpty {
                self.showProductsFetchError()
            } else {
                self.viewState.listItems = products.map({ (product) -> ListItemViewState in
                    ListItemViewState(title: product.title, price: product.displayString, imageURL: product.imageURL, description: product.description, aisle: product.aisle)
                })
            }
        }
    }
}
