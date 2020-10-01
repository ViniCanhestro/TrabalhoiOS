//
//  DetailViewController.swift
//  TrabalhoAndreHuberViniciusMartins
//
//  Created by COTEMIG on 22/09/20.
//  Copyright © 2020 AndreHuberViniciusMartins. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailTableView: UITableView!
    
    @IBOutlet weak var cdDetailImage: UIImageView!
    @IBOutlet weak var cdDetailName: UILabel!
    @IBOutlet weak var cdDetailDescription: UILabel!
    @IBOutlet weak var cdDetailPrice: UILabel!
    
    var cd: CdApi?
    var cdDetails: [String] = ["Nome", "Preço", "Descrição"]
    
    override func viewDidLoad() {
   
        super.viewDidLoad()
        
        if let cd = cd {
            cdDetailName.text = cd.name
            cdDetailDescription.text = cd.description
            cdDetailPrice.text = "R$" + String(cd.price)
            
            downloadImage(with: cd.image) { (image) in
                self.cdDetailImage.image = image
            }
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
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonCarrinho(_ sender: Any) {
        let alert = UIAlertController(title: "Sucesso!", message: "Produto adicionado ao carrinho", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK!", style: .default))
        present(alert, animated: true)
        
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cdDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = cdDetails[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}
