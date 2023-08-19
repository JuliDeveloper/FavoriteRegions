import UIKit

extension UIViewController {
    func showAlert(_ action: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(
            title: "Oшибка",
            message: "Проверьте ваше интернет соединение",
            preferredStyle: .alert
        )
        
        let repeatAction = UIAlertAction(title: "Повторить", style: .default, handler: action)
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel)
        
        alert.addAction(repeatAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}
