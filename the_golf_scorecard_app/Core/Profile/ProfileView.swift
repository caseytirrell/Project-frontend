//
//  ProfileView.swift
//  the_golf_scorecard_app
//
//  Created by user254089 on 3/4/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        if let user = viewModel.currentUser {
            List {
                Section{
                    HStack {
                        Image(uiImage: viewModel.profileImage ?? UIImage(resource: .golfLogo))
                            .resizable()
                            .scaledToFill()
                            .fontWeight(.semibold)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray))
                            .clipShape(Circle())
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.fullName)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                        Text(user.email)
                            .font(.footnote)
                            .foregroundStyle(.gray)
                        Text(user.phoneNumber)
                            .font(.footnote)
                            .foregroundStyle(.gray)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Address")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                        Text(user.address1 + ", " + user.address2)
                            .font(.footnote)
                            .foregroundStyle(.gray)
                        Text(user.city + ", " + user.state + " " + user.zipCode)
                            .font(.footnote)
                            .foregroundStyle(.gray)
                    }
                    
                }
                Section("General") {
                    HStack {
                        SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
                        Spacer()
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                }
                Section ("Account") {
                    Button {
                        //viewModel.signOut()
                        print("Update User Profile")
                    } label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill", title: "Update Profile Information", tintColor: .red)
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
