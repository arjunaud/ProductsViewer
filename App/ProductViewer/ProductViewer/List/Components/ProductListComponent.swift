//
//  ProductListComponent.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo
import Kingfisher

struct ProductListComponent: Component {
    var dispatcher: Dispatcher?

    func prepareView(_ view: ProductListView, item: ListItemViewState) {
        // Called on first view or ProductListView
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.aisleLabel.layer.borderColor = UIColor.lightGray.cgColor
        view.aisleLabel.layer.cornerRadius = 5
        view.aisleLabel.layer.borderWidth = 1
    }
    
    func configureView(_ view: ProductListView, item: ListItemViewState) {
        view.titleLabel.text = item.title
        view.priceLabel.text = item.price
        view.aisleLabel.text = item.aisle
        view.productImage.kf.indicatorType = .activity
        view.productImage.kf.setImage(with: item.imageURL)

    }
    
    func selectView(_ view: ProductListView, item: ListItemViewState) {
        dispatcher?.triggerEvent(ListItemPressed(product: item))
    }
}

extension ProductListComponent: HarmonyLayoutComponent {
    func heightForLayout(_ layout: HarmonyLayout, item: TempoViewStateItem, width: CGFloat) -> CGFloat {
        return 110.0
    }
}
