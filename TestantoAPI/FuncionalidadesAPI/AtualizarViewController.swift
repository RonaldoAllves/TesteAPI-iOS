//
//  AtualizarViewController.swift
//  TestantoAPI
//
//  Created by Ronaldo Allves on 03/05/21.
//

import UIKit

class AtualizarViewController: UIViewController {
    
    var TOKEN : String?
    
    @IBOutlet weak var resultado: UILabel!
    @IBOutlet weak var nomePessoa: UITextField!
    @IBOutlet weak var dataPessoa: UITextField!
    @IBOutlet weak var cpfPessoa: UITextField!
    @IBOutlet weak var ufPessoa: UITextField!
    @IBOutlet weak var idPessoa: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func atualizar(_ sender: Any) {
        
        let url_base = "https://127.0.0.1:5001/api/Pessoas/Atualizar"
        let url = URL(string: url_base)
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "id": self.idPessoa.text,
            "Nome": self.nomePessoa.text,
            "Uf": self.ufPessoa.text,
            "Data": self.dataPessoa.text,
            "Cpf": self.cpfPessoa.text,
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        /* ##########  Header ########## */
        let token = "Bearer " + TOKEN!
        request.allHTTPHeaderFields = [
            "Authorization": token
        ]

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }

            guard let data = data else {
                return
            }

            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print("Json: \(json)")
                    self.resultado.text = json.description
                }
            } catch let error {
                print("erro: \(error.localizedDescription)")

            }
        })
        task.resume()
        
    }
        
}
    


extension AtualizarViewController : URLSessionDelegate {

    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }

}

