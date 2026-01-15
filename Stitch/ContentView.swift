//
//  ContentView.swift
//  Stitch
//
//  Created by Thiago Chiquiti on 15/01/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Bem-vindo ao Stitch!")
                .font(.largeTitle)
                .bold(true)
            Text("O seu aplicativo de suturas")
                .foregroundColor(Color.secondary)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
