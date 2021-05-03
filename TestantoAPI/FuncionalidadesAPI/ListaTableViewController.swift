//
//  ListaTableViewController.swift
//  TestantoAPI
//
//  Created by Ronaldo Allves on 02/05/21.
//

import UIKit

class ListaTableViewController: UITableViewController {
    
    var TOKEN : String?
    
    var totalPessoas : Int = 0
    var pessoas : Array<Any>?
    
    @IBOutlet var listaTableView: UITableView!
    
    var dados: [String] = ["Ronaldo","Sarah"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //listaTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let url_base = "https://127.0.0.1:5001/api/Pessoas"
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
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? Array<Any> {
                    print("Json: \(json)")
                    self.pessoas = json
                    self.totalPessoas = self.pessoas!.count
                    /*
                    print("\n\ntotal: \(json.count)")
                    let pessoa = json[2] as! [String: Any]
                    print(pessoa)
                    print(pessoa["nome"])
                */
                    self.listaTableView.reloadData()
                    
                }
            } catch let error {
                print("erro: \(error.localizedDescription)")

            }
        })
        task.resume()
        //self.listaTableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return totalPessoas
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celula = tableView.dequeueReusableCell(withIdentifier: "celulaListaPessoas", for: indexPath)
        let indice = indexPath.row

        let pessoa = pessoas![indice] as! [String:Any]
        
        print(pessoa)
        celula.textLabel!.text = pessoa["nome"] as? String

        return celula
        
    }
    
}


extension ListaTableViewController : URLSessionDelegate {

    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }

}
