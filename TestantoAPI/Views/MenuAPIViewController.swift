//
//  MenuAPIViewController.swift
//  TestantoAPI
//
//  Created by Ronaldo Allves on 02/05/21.
//

import UIKit

class MenuAPIViewController: UIViewController {
    
    var TOKEN : String?

    @IBOutlet weak var token: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if TOKEN != nil{
            self.token.text = TOKEN
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if TOKEN != nil{
            
            if segue.identifier == "segueInserir"{
                if let proximaView = segue.destination as? InserirViewController{
                    proximaView.TOKEN = self.TOKEN
                }
            }
            if segue.identifier == "segueListar"{
                if let proximaView = segue.destination as? ListaTableViewController{
                    proximaView.TOKEN = self.TOKEN
                }
            }
            if segue.identifier == "segueBuscarID"{
                if let proximaView = segue.destination as? BuscarPeloIDViewController{
                    proximaView.TOKEN = self.TOKEN
                }
            }
            if segue.identifier == "segueBuscarUF"{
                if let proximaView = segue.destination as? BuscarPeloUFViewController{
                    proximaView.TOKEN = self.TOKEN
                }
            }
            if segue.identifier == "segueAtualizar"{
                if let proximaView = segue.destination as? AtualizarViewController{
                    proximaView.TOKEN = self.TOKEN
                }
            }
            if segue.identifier == "segueDeletar"{
                if let proximaView = segue.destination as? DeletarViewController{
                    proximaView.TOKEN = self.TOKEN
                }
            }
        }
 
    }

}



