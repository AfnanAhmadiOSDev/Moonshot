//
//  ContentView.swift
//  Moonshot
//
//  Created by Afnan Ahmad on 29/04/2024.
//

import SwiftUI

let missionsJsonFile = "missions.json"
let astronautsJsonFile = "astronauts.json"

struct ContentView: View {
    
    let astronauts: [String: Astronauts] = Bundle.main.decode(astronautsJsonFile)
    let missions: [Mission] = Bundle.main.decode(missionsJsonFile)
    
    @State private var showGridView: Bool = true
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if showGridView {
                    MyGridView(missions: missions, astronauts: astronauts)
                } else {
                    MyListView(missions: missions, astronauts: astronauts)
                        .padding([.horizontal, .bottom])
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Switch") {
                        showGridView.toggle()
                    }
                }
            }
            .animation(.easeInOut, value: showGridView)
        }
    }
}

#Preview {
    ContentView()
}




struct MyGridView: View {
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    let missions: [Mission]
    let astronauts: [String: Astronauts]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    VStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                        
                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            Text(mission.formattedLaunchDate)//mission.launchDate ?? "N/A")
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(.lightBackground)
                    }
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.lightBackground)
                    )
                }
            }
        }
    }
}//end struct


struct MyListView: View {
    
    let columns = [
        GridItem(.adaptive(minimum: 200, maximum: .infinity))
    ]
    let missions: [Mission]
    let astronauts: [String: Astronauts]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                        
                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            Text(mission.formattedLaunchDate)//mission.launchDate ?? "N/A")
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(.lightBackground)
                    }
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.lightBackground)
                    )
                }
            }
        }
    }
}//end struct
