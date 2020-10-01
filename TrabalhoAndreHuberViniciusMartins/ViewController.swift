//
//  ViewController.swift
//  TrabalhoAndreHuberViniciusMartins
//
//  Created by COTEMIG on 29/09/20.
//  Copyright © 2020 AndreHuberViniciusMartins. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        api()
    }
    
    var cdList: [CdApi] = []
    
    private func api(){
        
        let stringURL = "https://5f688defdc0bff0016f439c8.mockapi.io/produtos"
        
        if let url = URL(string: stringURL){
            let urlSession = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let cdObjeto = try JSONDecoder().decode([CdApi].self, from: data)
                        
                        self.cdList.append(contentsOf: cdObjeto)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch let error {
                        print("Erro de parse \(error)")
                    }
                }
            }
            urlSession.resume()
        }
    }
    
    func downloadImage(with url: String,  completion: @escaping(UIImage?) -> ()) {
        if let link = URL(string: url) {
            URLSession.shared.dataTask(with: link) { (data, response, error) in
                if let data = data {
                    let uiImage = UIImage(data: data)
                    DispatchQueue.main.async {
                        completion(uiImage)
                    }
                }
            }.resume()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? DetailViewController, let cd = sender as? CdApi {
            viewController.cd = cd
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cdList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cdCell", for: indexPath) as? CdViewCell {
            let cd = cdList[indexPath.row]
            cell.cdName.text = cd.name
            cell.cdDescription.text = cd.description
            cell.cdPrice.text = "R$" + String(cd.price)
            
            downloadImage(with: cd.image) { (image) in
                cell.cdImage.image = image
            }
            
            return cell
        } else {
            fatalError("Não foi possivel convertar a celula.")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cd = cdList[indexPath.row]
        performSegue(withIdentifier: "segueDetail", sender: cd)
    }
}

struct CdApi: Codable {
    let name: String
    let image: String
    let description: String
    let price: String
}
