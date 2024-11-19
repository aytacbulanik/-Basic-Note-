//
//  DetailViewController.swift
//  Basic Note
//
//  Created by Aytaç Bulanık on 14.11.2024.
//

import UIKit

class DetailViewController: UIViewController {
    var secilenMarka : Markalar?
    var plistManager = PlistManager()
    var yeniMArkalar = [Markalar]()
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        yeniMArkalar = plistManager.loadPlist()
        guard let secilenMarka = secilenMarka else { return }
        title = secilenMarka.name
        textView.text = secilenMarka.aciklama
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let markaAciklama = textView.text else { return }
        guard let secilenMarka else { return }
        var markaSira = 0
        for (index,marka) in yeniMArkalar.enumerated() {
            if marka.name == secilenMarka.name {
                markaSira = index
            }
        }
        if markaAciklama == "" {
            yeniMArkalar.remove(at: markaSira)
        }else {
            yeniMArkalar[markaSira].aciklama = markaAciklama
        }
        
        plistManager.savePlist(marka: yeniMArkalar)
        textView.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.becomeFirstResponder()
    }
   

}
