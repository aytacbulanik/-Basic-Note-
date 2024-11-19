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
    var secilenMarka : Markalar!
    var plistManager = PlistManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        markalar = plistManager.loadPlist()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(leftMarkaEklePressed))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        markalar = plistManager.loadPlist()
    }
    
    
    @IBAction func markaEklePressed(_ sender: UIBarButtonItem) {
        markaEkle()
    }
    
    @objc func leftMarkaEklePressed() {
        markaEkle()
    }
    
    func markaEkle() {
        let alert = UIAlertController(title: "Marka Ekle", message: "Eklemek istediğiniz markanın adını yazınız", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Marka Adı"
        }
        let ekleButton = UIAlertAction(title: "Ekle", style: .default) { _ in
            guard let textfield = alert.textFields?[0].text else { return }
            let marka = Markalar(name: textfield,aciklama: "Girilmedi")
            self.markalar.append(marka)
            self.plistManager.savePlist(marka: self.markalar)
            self.tableView.reloadData()
        }
        alert.addAction(ekleButton)
        present(alert, animated: true)
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
        secilenMarka = markalar[indexPath.row]
        performSegue(withIdentifier: "detailSegue", sender: secilenMarka)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let gidecekMarka = sender as? Markalar {
                let detailVC = segue.destination as! DetailViewController
                detailVC.secilenMarka = gidecekMarka
            }
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silButton = UIContextualAction(style: .destructive, title: "SİL") { action, view, completion in
            action.backgroundColor = .blue
            view.tintColor = .blue
            self.markalar.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            self.plistManager.savePlist(marka: self.markalar)
            completion(true)
        }
        let duzenleButton = UIContextualAction(style: .normal, title: "DÜZENLE") { action, view, completion in
            let markaAdi = self.markalar[indexPath.row].name
            let alert = UIAlertController(title: "Marka Adı Düzenle", message: nil, preferredStyle: .alert)
            alert.addTextField { textField in
                textField.text = markaAdi
            }
            let duzenleButton = UIAlertAction(title: "DÜZENLE", style: .default) { action in
                guard let markaAdi = alert.textFields?[0].text as? String else { return }
                let yeniMArkaAdi = markaAdi
                self.markalar[indexPath.row].name = yeniMArkaAdi
                self.plistManager.savePlist(marka: self.markalar)
                tableView.reloadRows(at: [indexPath], with: .left)
            }
            alert.addAction(duzenleButton)
            self.present(alert, animated: true)
            completion(true)
            
        }
        
        return UISwipeActionsConfiguration(actions: [silButton,duzenleButton])
    }
    
}

