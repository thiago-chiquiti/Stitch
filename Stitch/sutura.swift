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
        let concorrentes: [String] 
        let diametro: String
        let comprimento: String
        let tipoAgulha: String
        let codAgulha: String
        let curvatura: String
        let tamanhoAgulha: String
        let rms: String
        let descricaoLicitacao: String
    
}
