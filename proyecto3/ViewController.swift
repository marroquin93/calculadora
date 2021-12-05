//
//  ViewController.swift
//  proyecto3
//
//  Created by Ivan Miguel Chame Marroquin on 15/11/21.
//  Copyright © 2021 Ivan Miguel Chame Marroquin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var total: UILabel!
    
    @IBOutlet weak var descuento: UILabel!
    
    @IBOutlet weak var cantidadText: UITextField!
    
    @IBOutlet weak var porcetanjeText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pantalla()
        
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        
    }
    
    func pantalla(){
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height{
            case 1136:
                print("IPHONE 5 O SE")
            case 1334:
                print("IPHONE 6 6S 7 8")
            case 1920:
                print("IPHONE PLUS")
            case 2436:
                print("IPHONE X XS")
            case 1792:
                print("IPHONE XR")
            case 2688:
                print("IPHONE XS MAX")
            default:
                print("CUAL QUIER OTRO TAMAÑO")
            }
        
    }


}
    @objc func teclado(notificacion: Notification){
        guard let tecladoUP = (notificacion.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else
        { return }
        if notificacion.name == UIResponder.keyboardWillShowNotification{
            if UIScreen.main.nativeBounds.height == 1136 {
                self.view.frame.origin.y = -tecladoUP.height
            }
        }else{
            self.view.frame.origin.y = 0
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func calcular(_ sender: UIButton) {
        if cantidadText.text != "" && porcetanjeText.text != "" {
            self.view.endEditing(true)
            guard let cantidad = cantidadText.text else { return }
            guard let porcetanje = porcetanjeText.text else { return }
            let cant = (cantidad as NSString).floatValue
            let porciento = (porcetanje as NSString).floatValue
            
            let desc = cant * porciento / 100
            let totalfinal = cant - desc
            
            total.text = "$\(totalfinal)"
            descuento.text = "$\(desc)"
        }else{
            let alert = UIAlertController(title: "alert", message: "Escribe cantidad y porcentaje", preferredStyle: .alert)
            let accion = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(accion)
            present(alert, animated: true, completion: nil)
            
        }
    }
        
        
    
    
    @IBAction func limpiar(_ sender: UIButton) {
        self.view.endEditing(true)
        total.text = "$0.00"
        descuento.text = "$0.00"
        cantidadText.text = ""
        porcetanjeText.text = ""
    }
    
}

