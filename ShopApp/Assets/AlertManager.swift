//
//  AlertManager.swift
//  ShopApp
//
//  Created by Agostina Corcuera Di Salvo on 31/01/2024.
//

import Foundation
import UIKit

class AlertManager {
    
    static func showAlert(type: AlertType, in viewController: UIViewController) {
        let alertController = UIAlertController(title: title(for: type), message: message(for: type), preferredStyle: .alert)
        
        var alertAction: UIAlertAction!
        
        switch type {
        case .genericError:
            alertAction = UIAlertAction(title: "", style: .default, handler: nil)
        case .inputError:
            alertAction = UIAlertAction(title: "", style: .cancel, handler: nil)
        }
        
        alertController.addAction(alertAction)
        
        let closeAction = UIAlertAction(title: "Close", style: .destructive, handler: nil)
        alertController.addAction(closeAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }

    static func title(for type: AlertType) -> String {
        switch type {
        case .genericError:
            return "¡Ups!"
        case .inputError:
            return "Error de búsqueda"
        }
    }

    static func message(for type: AlertType) -> String {
        switch type {
        case .genericError:
            return "Ocurrió un error, intente nuevamente."
        case .inputError:
            return "Por favor, ingrese un término de búsqueda válido."
        }
    }

}

enum AlertType {
    case genericError
    case inputError
}

