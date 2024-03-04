//
//  ContentView.swift
//  the_golf_scorecard_app
//
//  Created by user254089 on 3/3/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        NavigationView {
            NavigationLink(destination: LoginView()) {
                        ZStack {
                            Color.green
                                .ignoresSafeArea()

                            Image("HomePage")
                                .resizable(resizingMode: .stretch)
                                .ignoresSafeArea()

                            VStack {
                                Text("The Golf Scorecard")
                                    .font(.custom("Inter Regular", size: 32))
                                    .foregroundColor(Color.white)
                                    .multilineTextAlignment(.center)
                                    .shadow(color: .black, radius: 1)
                                    .padding()

                                Text("The Forefront of Golf Scoring-Where Innovation Drives the Game")
                                    .font(.custom("Nunito-Medium", size: 22))
                                    .foregroundColor(Color.white)
                                    .multilineTextAlignment(.center)
                                    .shadow(color: .black, radius: 3)
                                    .padding()

                                NavigationLink(destination: LoginView()) {
                                    Text("Continue")
                                        .font(.headline)
                                        .padding()
                                        .tint(.white)
                                        .foregroundColor(.white)
                                        .shadow(color: .black, radius: 2)
                                        .cornerRadius(8)
                                        .padding()
                                }
                            }
                        }
                        .navigationBarHidden(true)
                  }
        }
    }
}

#Preview {
    ContentView()
}
