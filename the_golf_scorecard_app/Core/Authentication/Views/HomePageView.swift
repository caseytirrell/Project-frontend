//
//  HomePageView.swift
//  the_golf_scorecard_app
//
//  Created by Casey tirrell on 3/5/24.
//

import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        ZStack {
            Color.limeGreen.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack(spacing: 15){
                Image("golf_logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 32)
                
                Text("Welcome to")
                    .font(.system(size: 40))
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("The Golf Scorecard!")
                    .font(.system(size: 40))
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 20)
                
                Button("Courses") {
                    
                }
                .buttonStyle(PrimaryButtonStyle())
                Button("Register a Tournament") {
                    
                }
                .buttonStyle(PrimaryButtonStyle())
                Button("Plans") {
                    
                }
                .buttonStyle(PrimaryButtonStyle())
                Button("Tournaments") {
                    
                }
                .buttonStyle(PrimaryButtonStyle())
                Button("Features") {
                    
                }
                .buttonStyle(PrimaryButtonStyle())
                Button("Past Scores") {
                    
                }
                .buttonStyle(PrimaryButtonStyle())
                Spacer()
                
                HStack(spacing: 10) {
                    
                    Button(action: {
                        
                    }) {
                        Text("About Us")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        authViewModel.signOut()
                    }) {
                        
                        Text("Logout")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .padding()
            .navigationBarTitle("Home", displayMode: .large)
        }
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    var foregroundColor: Color = .white
    var backgroundColor: Color = .blue
    var height: CGFloat = 44
    var width: CGFloat = 200

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(foregroundColor)
            .padding()
            .frame(width: width, height: height)
            .background(backgroundColor)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

extension Color {
    static let limeGreen = Color(red: 128 / 255, green: 235 / 255, blue: 52 / 255)
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView().environmentObject(AuthViewModel()) // Ensure AuthViewModel is provided for previews as well
    }
}

