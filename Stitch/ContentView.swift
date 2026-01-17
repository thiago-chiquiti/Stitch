//
//  ContentView.swift
//  Stitch
//
//  Created by Thiago Chiquiti on 15/01/26.
//  Updated for Version 1.1 (Bioline Support)
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var suturas: [Sutura] = []
    @Environment(\.isSearching) private var isSearching
    
    var resultados: [Sutura] {
        if searchText.isEmpty {
            return []
        } else {
            return suturas.filter { sutura in
                // Busca por codigo Medtronic
                let noCodigo = sutura.codigo.localizedCaseInsensitiveContains(searchText)
                
                // Busca por código Bioline (NOVO)
                let noBioline = sutura.codigoBioline.localizedCaseInsensitiveContains(searchText)
                
                // Busca por código do concorrente (Johnson/Ethicon)
                // Nota: Mudamos de .concorrentes para .concorrentesJJ
                let noConcorrente = sutura.concorrentesJJ.contains { item in
                    item.localizedCaseInsensitiveContains(searchText)
                }
                
                // Busca por descrição
                let naDescricao = sutura.descricao.localizedCaseInsensitiveContains(searchText)
                
                // Busca por composto
                let noComposto = sutura.composto.localizedCaseInsensitiveContains(searchText)
                
                // Busca por nome do concorrente
                let noNomeConcorrente = sutura.nomeConcorrente.localizedCaseInsensitiveContains(searchText)
                
                return noCodigo || noBioline || noConcorrente || naDescricao || noComposto || noNomeConcorrente
            }
        }
    }
    
    // Função para realce do texto buscado
    func destacar(_ texto: String) -> AttributedString {
        var styledText = AttributedString(texto)
        
        if let range = styledText.range(of: searchText, options: .caseInsensitive) {
            styledText[range].backgroundColor = .yellow
            styledText[range].foregroundColor = .black
            styledText[range].inlinePresentationIntent = .emphasized
        }
        
        return styledText
    }
    
    
    var body: some View {
        NavigationStack {
            VStack {
                if searchText.isEmpty {
                    VStack(spacing: 20) {
                        Spacer()
                        
                        Image("Logo_stitch")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                        
                        Text("Bem-vindo ao Stitch")
                            .font(.largeTitle)
                            .bold()
                        
                        Text("Sua biblioteca técnica de suturas.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Divider()
                            .frame(width: 200)
                        
                        HStack(spacing: 40) {
                            ContentUnavailableView {
                                Label("Guia Rápido", systemImage: "magnifyingglass")
                            } description: {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("• Busque por códigos (ex: VCP311)")
                                    Text("• Busque por Bioline (ex: BIO...)")
                                    Text("• Busque por composto (ex: Poliglactina)")
                                    Text("• Busque por tipo (ex: Incolor)")
                                }
                            }
                        }
                        .padding()
                        .background(Color.secondary.opacity(0.1))
                        .cornerRadius(10)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    
                } else {
                    List(resultados) { sutura in
                        NavigationLink(destination: SuturaDetailView(sutura: sutura)) {
                            VStack (alignment: .leading, spacing: 6) {
                                
                                // 1. Descrição Principal
                                Text(destacar(sutura.descricao))
                                    .font(.headline)
                                
                                // 2. Nome Comercial Equivalente
                                if !sutura.composto.isEmpty {
                                    Text("Composto: \(destacar(sutura.composto))")
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                }
                                
                                // 3. Código Medtronic 
                                if sutura.codigo.localizedCaseInsensitiveContains(searchText) {
                                    HStack(spacing: 4) {
                                        Text("Código Medtronic:").bold()
                                        Text(destacar(sutura.codigo))
                                    }
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                }
                                
                                // 4. Código Bioline (NOVO - Se encontrado na busca)
                                if sutura.codigoBioline.localizedCaseInsensitiveContains(searchText) {
                                    HStack(spacing: 4) {
                                        Text("Código Bioline:").bold()
                                        Text(destacar(sutura.codigoBioline))
                                    }
                                    .font(.subheadline)
                                    .foregroundColor(.green)
                                }
                                
                                // 5. Composto
                                if sutura.composto.localizedCaseInsensitiveContains(searchText) {
                                    HStack(spacing: 4) {
                                        Text("Composto:").bold()
                                        Text(destacar(sutura.composto))
                                    }
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                }
                                
                                // 6. Códigos Johnson/Ethicon (Se encontrados na busca)
                                // Nota: Atualizado para concorrentesJJ
                                let matchesRefs = sutura.concorrentesJJ.filter { $0.localizedCaseInsensitiveContains(searchText) }
                                if !matchesRefs.isEmpty {
                                    HStack(spacing: 4) {
                                        Text("Ref. Johnson:").bold()
                                        Text(destacar(matchesRefs.joined(separator: ", ")))
                                    }
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationTitle("Stitch")
            .searchable(text: $searchText, placement: .automatic, prompt: "Código, Marca ou Composto")
            .onAppear {
                suturas = DataLoader.loadSuturas()
            }
        }
    }
}

#Preview {
    ContentView()
}
