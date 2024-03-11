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
            Color.white.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack(spacing: 15) {
                NavigationLink{
                    ProfileView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 2){
                        if let userEmail = authViewModel.email {
                            Text("Logged in as \(userEmail)")
                                .font(.custom("Inter Regular", size: 12))
                                .padding(.top, 20)
                        }
                    }
                    .font(.system(size: 14))
                }
                
                
                Image("golf_logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.top, 20)
                    .padding(.horizontal, 100)
                
                Text("Welcome to")
                    .font(.custom("Inter Regular", size: 40))
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("The Golf Scorecard!")
                    .font(.custom("Inter Regular", size: 40))
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 15)
                
                
                Button("Courses") {
                    
                }
                .buttonStyle(PrimaryButtonStyle())
                Button("Register") {
                    
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
                
                HStack(spacing: 10) {
                    
                    Button(action: {
                        
                    }) {
                        Text("About Us")
                            .font(.custom("Inter Regular", size: 20))
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(8)
                            .frame(width: 200, height: 30)
                    }
                    NavigationLink{
                        ProfileView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack(spacing: 2){
                            Text("Profile")
                                .font(.custom("Inter Regular", size: 20))
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(8)
                                .frame(width: 200, height: 30)
                        }
                        .font(.system(size: 14))
                    }
   
                    

                }
                .padding()
            }
            .padding()
            //.navigationBarTitle("Home", displayMode: .large)
        }
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    var foregroundColor: Color = .black
    var backgroundColor: Color = .limeGreen
    var height: CGFloat = 50
    var width: CGFloat = 200

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.custom("Inter Regular", size: 20))
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

