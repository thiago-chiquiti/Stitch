//
//  sutura.swift
//  Stitch
//
//  Created by Thiago Chiquiti on 15/01/26.
//

import Foundation

struct Sutura: Codable, Identifiable {
    var id: String {codigo}
    
    let codigo: String
        let familia: String
        let subtipo: String
        let descricao: String
        let especialidade: String
        let concorrentesJJ: [String]
        let codigoBioline: String
        let diametro: String
        let comprimento: String
        let tipoAgulha: String
        let codAgulha: String
        let curvatura: String
        let tamanhoAgulha: String
        let rms: String
        let descricaoLicitacao: String
        let composto: String       
        let nomeConcorrente: String
    
    // Mapeamento das chaves do JSON para as variáveis do Swift
    enum CodingKeys: String, CodingKey {
        case codigo, descricao, familia, subtipo, especialidade
        case codigoBioline = "codigoBioline"   // Tem que ser igual ao JSON
        case concorrentesJJ = "concorrentesJJ" // Tem que ser igual ao JSON
        case diametro, comprimento, tipoAgulha, codAgulha
        case curvatura, tamanhoAgulha, rms, descricaoLicitacao, composto, nomeConcorrente
    }
}
