import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String?, _ action: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let repeatAction = UIAlertAction(title: "Повторить", style: .default, handler: action)
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel)
        
        alert.addAction(repeatAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}
