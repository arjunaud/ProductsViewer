import UIKit
import Tempo

class DetailViewController: UIViewController {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var addToListButton: UIButton!
    
    fileprivate var coordinator: TempoCoordinator!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.coordinator.presenters = [DetailViewPresenter(detailViewController: self, dispatcher: self.coordinator.dispatcher)]
    }
    
    class func viewControllerFor(coordinator: TempoCoordinator) -> DetailViewController {
        let viewController = DetailViewController.init(nibName: "ProductDetailView", bundle: nil)
        viewController.coordinator = coordinator
        return viewController
    }
    
}
