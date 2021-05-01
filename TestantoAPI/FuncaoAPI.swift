//
//  FuncaoAPI.swift
//  TestantoAPI
//
//  Created by Ronaldo Allves on 30/04/21.
//

import UIKit

/*

class FuncaoAPI {
    
    let key = ""
    
    func receberObjetoJson() -> [String:Any]?{
        
        var objetoJson : [String:Any]!
        
        //let session = URLSession(configuration: URLSessionConfiguration.default)
        //let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)

        let url_base = "https://localhost:5001/api/Pessoas?"
        
        if let url = URL(string: url_base){
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let task = session.dataTask(with: request) { dados, response, error in
                      
                print(dados)
                
                if let dadosRetorno = dados{
                    do {
                        if let objeto = try JSONSerialization.jsonObject(with: dadosRetorno as Data, options: []) as? [String: Any]{
                            objetoJson = objeto
                            
                            print(objeto)
                        }
                        
                    } catch  {
                        print("\n\n\tErro na conversao para Json\n\n")
                    }

                }else{
                    print("Erro diferente")
                }
                

            }

            task.resume()
            
            /*
            let tarefa = URLSession.shared.dataTask(with: url) { (dados, requisicao, erro) in
                
                if let dadosRetorno = dados{
                    do {
                        if let objeto = try JSONSerialization.jsonObject(with: dadosRetorno as Data, options: []) as? [String: Any]{
                            objetoJson = objeto
                            
                            print(objeto)
                        }
                        
                    } catch  {
                        print("\n\n\tErro na conversao para Json\n\n")
                    }

                }else{
                    print("Erro diferente")
                }
                
            }
            tarefa.resume()
            
            */
            /*
            let data = NSData(contentsOf: url)
            
            print(data)
            
            if let dadosRetorno = data{
                do {
                    if let objeto = try JSONSerialization.jsonObject(with: dadosRetorno as Data, options: []) as? [String: Any]{
                        objetoJson = objeto
                    }
                    
                } catch  {
                    print("\n\n\tErro na conversao para Json\n\n")
                }

            }else{
                print("Erro diferente")
            }
            */
            
        }else{
            print("Erro estranho")
        }
    
        return objetoJson
    }
    
    
    
}


*/
