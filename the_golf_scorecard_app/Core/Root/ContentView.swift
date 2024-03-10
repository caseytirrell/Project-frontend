//
//  ContentView.swift
//  the_golf_scorecard_app
//
//  Created by user254089 on 3/3/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isActive = false
    
    var body: some View {
        NavigationView {
            if viewModel.isAuthenticated {
                HomePageView()
            } else {
                ZStack {
                    Color.green.ignoresSafeArea()
                    Image("HomePage").resizable(resizingMode: .stretch).ignoresSafeArea()
                    
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
                        
                        Text("Touch Anywhere...")
                            .font(.custom("Nunito-Medium", size: 10))
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .shadow(color: .black, radius: 3)
                            .padding()
                    }
                    NavigationLink(destination: LoginView(), isActive: $isActive) { EmptyView() }
                }
                .navigationBarHidden(true)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(AuthViewModel())
}

