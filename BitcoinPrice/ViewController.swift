//
//  ViewController.swift
//  BitcoinPrice
//
//  Created by José Vitor Scheffer Boff dos Santos on 02/11/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var precoBitcoin: UILabel!
    @IBOutlet weak var botaoAtualizar: UIButton!
    
    @IBAction func handlePriceUpdate(_ sender: Any) {
        self.updateBitcoinPrice()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateBitcoinPrice()
    }
    
    func updateBitcoinPrice() {
        self.botaoAtualizar.setTitle("Atualizando...", for: .normal)
        if let baseUrl = URL(string: "https://blockchain.info/ticker") {
            let tarefa = URLSession.shared.dataTask(with: baseUrl) { dados, requisicao, erro in
                if erro == nil {
                    if let dadosRetorno = dados {
                        do {
                            if let objetoJson = try JSONSerialization.jsonObject(with: dadosRetorno, options: []) as? [String: Any] {
                                if let brl = objetoJson["BRL"] as? [String: Any] {
                                    if let buyPrice = brl["buy"] {
                                        let nf = NumberFormatter()
                                        nf.numberStyle = .decimal
                                        nf.locale = Locale(identifier: "pt_BR")
                                        if let buyPriceFormated = nf.string(from: buyPrice as! NSNumber) {
                                            DispatchQueue.main.async(execute: {
                                                self.precoBitcoin.text = "R$" + buyPriceFormated
                                                self.botaoAtualizar.setTitle("Atualizar", for: .normal)
                                            })
                                        }
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

