//
//  SuturaDetailView.swift
//  Stitch
//
//  Created by Thiago Chiquiti on 16/01/26.
//  Updated for Version 1.1 (Bioline Support)
//

import SwiftUI

struct SuturaDetailView: View {
    let sutura: Sutura

    var body: some View {
        List {
            // Seção Principal: Identificação
            Section(header: Text("Identificação")) {
                InfoRow(label: "Código Medtronic", value: sutura.codigo)
                InfoRow(label: "Família", value: sutura.familia)
                if !sutura.subtipo.isEmpty { InfoRow(label: "Subtipo", value: sutura.subtipo) }
                InfoRow(label: "Composto", value: sutura.composto)
            }

            // Seção Técnica: O Fio e a Agulha
            Section(header: Text("Especificações Técnicas")) {
                InfoRow(label: "Diâmetro", value: sutura.diametro)
                InfoRow(label: "Comprimento Fio", value: sutura.comprimento)
                InfoRow(label: "Tipo de Agulha", value: sutura.tipoAgulha)
                InfoRow(label: "Cód. Agulha", value: sutura.codAgulha)
                InfoRow(label: "Tamanho Agulha", value: sutura.tamanhoAgulha)
                InfoRow(label: "Curvatura", value: sutura.curvatura)
            }

            // Seção de Equivalência (ATUALIZADA)
            Section(header: Text("Concorrência e Equivalentes")) {
                
                // 1. Nome Comercial (ex: Vicryl)
                InfoRow(label: "Ref. Comercial", value: sutura.nomeConcorrente)
                
                // 2. Johnson / Ethicon
                if !sutura.concorrentesJJ.isEmpty {
                    InfoRow(label: "Ref. Johnson", value: sutura.concorrentesJJ.joined(separator: ", "))
                }
                
                // 3. Bioline (NOVO - Com destaque Verde)
                if !sutura.codigoBioline.isEmpty {
                    HStack {
                        Text("Ref. Bioline")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(sutura.codigoBioline)
                            .bold()
                            .foregroundColor(.green) // Mantendo o padrão verde da tela inicial
                            .multilineTextAlignment(.trailing)
                    }
                }
            }

            // Seção Administrativa
            Section(header: Text("Regulatório")) {
                InfoRow(label: "RMS", value: sutura.rms)
                VStack(alignment: .leading, spacing: 5) {
                    Text("Descrição para Licitação").font(.caption).foregroundColor(.secondary)
                    Text(sutura.descricaoLicitacao).font(.body)
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle(sutura.codigo)
        .listStyle(.inset)
        .textSelection(.enabled) // Permite copiar os textos segurando o dedo
    }
}

// Componente auxiliar para manter a estética das linhas limpa
struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary)
            Spacer()
            Text(value.isEmpty ? "N/A" : value)
                .bold()
                .multilineTextAlignment(.trailing)
        }
    }
}


