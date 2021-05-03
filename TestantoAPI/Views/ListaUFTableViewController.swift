//
//  ListaUFTableViewController.swift
//  TestantoAPI
//
//  Created by Ronaldo Allves on 03/05/21.
//

import UIKit

class ListaUFTableViewController: UITableViewController {
    
    
    var UF : String?
    var TOKEN : String?
    var pessoas : Array<Any>?

    @IBOutlet var listaUFtableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url_base = "https://127.0.0.1:5001/api/Pessoas/UF?uf="
        url_base = url_base + self.UF!
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
            
            print(data?.description)
            print(response?.description)
            print(error?.localizedDescription)
            
            guard error == nil else {
                return
            }

            guard let data = data else {
                return
            }

            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? Array<Any> {
                    print("Json: \(json)")
                    self.pessoas = json
                    
                    self.listaUFtableView.reloadData()
                    
                }
            } catch let error {
                print("erro: \(error.localizedDescription)")

            }
        })
        task.resume()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if pessoas != nil{
            return pessoas!.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celula = tableView.dequeueReusableCell(withIdentifier: "celulaListaUF", for: indexPath) as! ListaUFTableViewCell
        let indice = indexPath.row

        let pessoa = pessoas![indice] as! [String:Any]
        
        let id = pessoa["id"] as? Int
        celula.textId.text = String(id!)
        celula.textNome.text = pessoa["nome"] as? String
        celula.textCpf.text = pessoa["cpf"] as? String
        celula.textData.text = pessoa["data"] as? String
        celula.textUF.text = pessoa["uf"] as? String

        return celula
        
    }
    
}

extension ListaUFTableViewController : URLSessionDelegate {

    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }

}
