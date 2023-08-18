import UIKit

final class DetailsRegionViewController: UIViewController {
    override func loadView() {
        let customView = DetailsRegionView()
        customView.configure()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
    }
    
    private func setupNavBar() {
        title = "Название региона"
        navigationController?.navigationBar.prefersLargeTitles = false

        let backButton = UIBarButtonItem(image: UIImage(named: "chevron.left"), style: .done, target: self, action: #selector(backToCollection))
        
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backToCollection() {
        navigationController?.popViewController(animated: true)
    }
}
