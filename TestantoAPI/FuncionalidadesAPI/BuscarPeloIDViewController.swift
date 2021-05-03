//
//  BuscarPeloIDViewController.swift
//  TestantoAPI
//
//  Created by Ronaldo Allves on 03/05/21.
//

import UIKit

class BuscarPeloIDViewController: UIViewController {
    
    var TOKEN : String?

    @IBOutlet weak var textID: UITextField!
    @IBOutlet weak var resultado: UILabel!
    
    var pessoa : [String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func buscar(_ sender: Any) {
        
        var url_base = "https://127.0.0.1:5001/api/Pessoas/ID?id="
        url_base = url_base + self.textID.text!
        let url = URL(string: url_base)
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        var request = URLRequest(url: url!)
        
        request.httpMethod = "GET"
        
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
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] {
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

extension BuscarPeloIDViewController : URLSessionDelegate {

    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }

}
