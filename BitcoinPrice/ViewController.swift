//
//  ViewController.swift
//  BitcoinPrice
//
//  Created by José Vitor Scheffer Boff dos Santos on 02/11/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let baseUrl = URL(string: "https://blockchain.info/ticker") {
            let tarefa = URLSession.shared.dataTask(with: baseUrl) { dados, requisicao, erro in
                if erro == nil {
                    if let dadosRetorno = dados {
                        do {
                            if let objetoJson = try JSONSerialization.jsonObject(with: dadosRetorno, options: []) as? [String: Any] {
                                if let brl = objetoJson["BRL"] as? [String: Any] {
                                    if let buyPrice = brl["buy"] as? Float {
                                        print(buyPrice)
                                    }
                                }
                            }
                        }catch {
                            print("Erro ao formatar retorno!")
                        }
                    }
                } else {
                    print("Erro ao realizar tarefa")
                }
            }
            tarefa.resume()
        }
        
    }


}

