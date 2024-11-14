//
//  ViewController.swift
//  Basic Note
//
//  Created by Aytaç Bulanık on 14.11.2024.
//

import UIKit

class MarkalarViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var markalar = [Markalar]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        markalar = [
            Markalar(name: "Apple", aciklama: "Girilmedi"),
            Markalar(name: "Samsung", aciklama: "Girilmedi")
        ]
    }

    @IBAction func markaEklePressed(_ sender: UIBarButtonItem) {
        
    }
    
}

extension MarkalarViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return markalar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "markaCell", for: indexPath)
        var content = cell.defaultContentConfiguration()

        content.text = markalar[indexPath.row].name
        cell.contentConfiguration = content
        
        return cell
    }
    
}

