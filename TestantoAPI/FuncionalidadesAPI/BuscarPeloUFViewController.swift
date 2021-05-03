//
//  BuscarPeloUFViewController.swift
//  TestantoAPI
//
//  Created by Ronaldo Allves on 03/05/21.
//

import UIKit

class BuscarPeloUFViewController: UIViewController {
    
    var TOKEN : String?
    //var pessoas : Array<Any>?

    @IBOutlet weak var textUF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func buscarUF(_ sender: Any) {
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueListaBuscarUF"{
            if let proximaView = segue.destination as? ListaUFTableViewController{
                proximaView.UF = self.textUF.text
                proximaView.TOKEN = self.TOKEN
            }
        }
    }
    

}

