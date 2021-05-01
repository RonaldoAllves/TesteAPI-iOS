//
//  ViewController.swift
//  TestantoAPI
//
//  Created by Ronaldo Allves on 30/04/21.
//

import UIKit

struct NewsModel: Decodable {
    var id: Int
    var nome: String
    var uf: String
    var data: String
    var cpf: Int64
}

class ViewController: UIViewController {
    
    @IBOutlet weak var resultado: UILabel!
    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var uf: UITextField!
    @IBOutlet weak var data: UITextField!
    @IBOutlet weak var cpf: UITextField!
    @IBOutlet weak var id: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func getResultado(_ sender: Any) {
        
        print("retorno: \(receberPessoas())" as Any)
        
    }
    
    @IBAction func postDados(_ sender: Any) {
        
        let cpf_64 = Int64(self.cpf.text!)
        let id_int = Int(self.id.text!)
        let pessoa = NewsModel(id: id_int!, nome: self.nome.text!, uf: self.uf.text!, data: self.data.text!, cpf: cpf_64!)
        
        enviarPessoas(pessoa: pessoa)
        
    }
    
    func enviarPessoas(pessoa : NewsModel){
        
        let url = URL(string: "https://127.0.0.1:5001/api/Pessoas/Inserir")!
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "Id": pessoa.id,
            "Nome": pessoa.nome,
            "Uf": pessoa.uf,
            "Data": pessoa.data,
            "Cpf": pessoa.cpf,
        ]


        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }

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
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
        
    }
    
    func receberPessoas() -> [String:Any]?{
        
        var objetoJson : [String:Any]!
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        let url_base = "https://127.0.0.1:5001/api/Pessoas"
        
        if let url = URL(string: url_base){
            
            
            let tarefa = session.dataTask(with: url) { (dados, response, error) in
                
                var teste = [NewsModel]()
                
                if let dadosRetorno = dados{

                    do{
                        teste = try JSONDecoder().decode([NewsModel].self, from: dadosRetorno)
                        
                        //self.resultado.text = teste
                        print("\nTeste: \(teste[0].nome)")
                        //print("\nTeste: \(teste[1].nome)")
                    }catch {
                        
                    }

                }else{
                    print("Erro diferente")
                }
            }
            
            tarefa.resume()
            
        }else{
            print("Erro estranho")
        }
    
        return objetoJson
    }
    
    
}

extension ViewController : URLSessionDelegate {

    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }

}
