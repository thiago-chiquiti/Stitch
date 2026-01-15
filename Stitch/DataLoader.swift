//
//  DataLoader.swift
//  Stitch
//
//  Created by Thiago Chiquiti on 15/01/26.
//

import Foundation

class DataLoader {
    static func loadSuturas() -> [Sutura] {
        guard let url = Bundle.main.url(forResource: "suturas", withExtension: "json") else {
            print("Arquivo JSON não encontrado")
            return[]
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let suturas = try decoder.decode([Sutura].self, from: data)
            
            return suturas
            
        } catch {
            print("Erro ao decodificar JSON: \(error)")
            return []
        }
    }
}
