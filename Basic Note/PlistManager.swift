//
//  PlistManager.swift
//  Basic Note
//
//  Created by Aytaç Bulanık on 19.11.2024.
//

import Foundation

struct PlistManager {
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    func savePlist(marka : [Markalar]) {

        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(marka)
            try data.write(to: dataFilePath!)
            print("yazma başarılı")
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func loadPlist() -> [Markalar] {
        var markalar = [Markalar]()
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                markalar =  try decoder.decode([Markalar].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
        return markalar
    }
    
    
}
