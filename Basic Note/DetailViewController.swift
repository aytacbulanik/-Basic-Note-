//
//  DetailViewController.swift
//  Basic Note
//
//  Created by Aytaç Bulanık on 14.11.2024.
//

import UIKit

class DetailViewController: UIViewController {
    var secilenMarka : Markalar?
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let secilenMarka = secilenMarka else { return }
        textView.text = secilenMarka.aciklama
    }
    

   

}
