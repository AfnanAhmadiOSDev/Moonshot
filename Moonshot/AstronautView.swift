//
//  AstronautView.swift
//  Moonshot
//
//  Created by Afnan Ahmad on 06/05/2024.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronauts
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let astronauts: [String: Astronauts] = Bundle.main.decode(astronautsJsonFile)
    
        return AstronautView(astronaut: astronauts["aldrin"]!)
            .preferredColorScheme(.dark)
}
