//
//  SessionsView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 24/02/2025.
//

import SwiftUI

// MARK: - SessionsView
/// A view that displays a list of saved focus sessions from our Pokémon.
struct SessionsView: View {
    @Environment(SessionManager.self) var sessionManager
    @Environment(PokemonManager.self) var pokemonManager
    @State private var groupedSessions: [String: [Session]] = [:] // Sessions grouped by date

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    if groupedSessions.isEmpty {
                        Text("No recorded sessions yet.")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding(.top, 50)
                    } else {
                        let sortedKeys = groupedSessions.keys.sorted(by: >)

                        ForEach(sortedKeys, id: \.self) { dateKey in
                            if let sessions = groupedSessions[dateKey] {
                                sectionView(for: dateKey, sessions: sessions)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Focus Sessions")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            .onAppear {
                groupSessionsByDate()
            }
        }
    }

    private func sectionView(for dateKey: String, sessions: [Session]) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(dateKey)
                .font(.title3)
                .bold()
                .padding(.top, 8)
                .frame(maxWidth: .infinity, alignment: .leading)

            ForEach(sessions, id: \.id) { session in
                SessionCardView(
                    session: session,
                    pokemon: pokemonManager.getPokemon(by: session.pokemonID),
                    showPokemonImage: true
                )
            }
        }
    }

    private func groupSessionsByDate() {
        let sessions = sessionManager.sessions.sorted(by: { $0.startTime > $1.startTime })
        groupedSessions = Dictionary(grouping: sessions) { session in
            DateFormatterUtil.formattedDate(session.startTime, format: "MMM d, yyyy")
        }
    }
}

#Preview {
    SessionsView()
    .environment(PreviewData.pokemonManager)
    .environment(PreviewData.sessionManager)
}
