//
//  CoursesListView.swift
//  the_golf_scorecard_app
//
//  Created by Casey tirrell on 3/11/24.
//

import SwiftUI

struct CoursesListView: View {
    @StateObject private var viewModel = CoursesViewModel()
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(spacing: 10) {
                
                Image("golf_logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 60)
                    .padding(.top, 5)
                    .padding(.horizontal, 50)
                
                Text("Available Courses")
                    .font(.custom("Nunito-Medium", size: 34))
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 10)
                NavigationView {
                    List(viewModel.courses) { course in
                        CourseRow(course: course, viewModel: viewModel)
                    }
                    .listStyle(PlainListStyle())
                    .onAppear {
                        Task {
                            do {
                                try await viewModel.fetchCourses()
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
            }
        }
    }
    struct CourseRow: View {
        let course: Course
        @State private var image: UIImage? = nil
        @ObservedObject var viewModel: CoursesViewModel
        @State private var isLoading = false
        @State private var loadingError: Error? = nil
        
        var body: some View {
            HStack {
                Image(uiImage: viewModel.courseImage ?? UIImage(resource: .golfLogo))
                    .resizable()
                    .scaledToFill()
                    .fontWeight(.semibold)
                    .frame(width: 72, height: 72)
                    .background(Color(.systemGray))
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 5) {
                    Text(course.courseName)
                        .font(.headline)
                    if let description = course.desc {
                        Text(description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                    }
                    Text("\(course.address1), \(course.city), \(course.state) \(course.zipCode)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.leading, 8)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 1)
            .padding(.horizontal)
        }
    }
}

#Preview {
    CoursesListView()
}
