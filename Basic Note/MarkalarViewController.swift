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
        
    }
    

    @IBAction func markaEklePressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Marka Ekle", message: "Eklemek istediğiniz markanın adını yazınız", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Marka Adı"
        }
        let ekleButton = UIAlertAction(title: "Ekle", style: .default) { _ in
            guard let textfield = alert.textFields?[0].text else { return }
            let marka = Markalar(name: textfield,aciklama: "Girilmedi")
            self.markalar.append(marka)
            self.savePlist(marka: self.markalar)
            self.tableView.reloadData()
        }
        alert.addAction(ekleButton)
        present(alert, animated: true)
    }
    
    func savePlist(marka : [Markalar]) {
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(marka)
            try data.write(to: dataFilePath!)
            print("yazma başarılı")
        }catch {
            print(error.localizedDescription)
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
}

