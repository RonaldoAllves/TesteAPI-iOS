//
//  AuthViewController.swift
//  TestantoAPI
//
//  Created by Ronaldo Allves on 02/05/21.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var nomeUsuario: UITextField!
    @IBOutlet weak var senhaUsuario: UITextField!
    @IBOutlet weak var roleUsuario: UITextField!
    @IBOutlet weak var token: UITextView!
    
    var TOKEN : String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func gerarToken(_ sender: Any) {
        
        let url_base = "https://127.0.0.1:5001/v1/account/criarToken?"
        
        if let nome = nomeUsuario.text{
            if let senha = senhaUsuario.text{
                if let role = roleUsuario.text{
                    
                    let url_s = url_base + "username=" + nome + "&password=" + senha + "&role=" + role
                    
                    let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
                    
                    let url = URL(string: url_s)
                    var request = URLRequest(url: url!)
                    
                    request.httpMethod = "POST"

                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                    
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
                                let token_json = json["user"] as! [String: Any]
                                print(token_json["token"] as! String)
                                
                                self.TOKEN = (token_json["token"] as! String)
                                
                                self.token.text = self.TOKEN
                            }
                        } catch let error {
                            print(error.localizedDescription)
                        }
                    })
                    task.resume()
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueMenuAPI"{
            if let proximaView = segue.destination as? MenuAPIViewController{
                if TOKEN != nil{
                    proximaView.TOKEN = self.TOKEN
                }
                proximaView.TOKEN = self.token.text
            }
            
        }
        
    }
    
}



extension AuthViewController : URLSessionDelegate {

    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }

}
