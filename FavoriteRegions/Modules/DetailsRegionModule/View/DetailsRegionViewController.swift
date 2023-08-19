import UIKit

protocol DetailsRegionViewControllerProtocol: AnyObject {
    
}

final class DetailsRegionViewController: UIViewController {
    
    var region: Region?
    var presenter: DetailsRegionPresenterProtocol?
    
    override func loadView() {
        let customView = DetailsRegionView()
        if let region {
            customView.configure(region)
        }
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
    }
    
    private func setupNavBar() {
        let regionTitle = region?.title ?? ""
        title = "\(regionTitle)"
        navigationController?.navigationBar.prefersLargeTitles = false

        let backButton = UIBarButtonItem(image: UIImage(named: "chevron.left"), style: .done, target: self, action: #selector(backToCollection))
        
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backToCollection() {
        navigationController?.popViewController(animated: true)
    }
}
