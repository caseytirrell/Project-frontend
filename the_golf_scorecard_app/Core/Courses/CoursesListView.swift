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
                        CourseRow(course: course)
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
    fileprivate struct CourseRow: View {
        
        let course: Course
        
        var body: some View {
            HStack {
                
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
                VStack(alignment: .leading, spacing: 5) {
                    Text(course.courseName)
                        .font(.headline)
                    if let description = course.desc, !description.isEmpty {
                        Text(description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                    }
                    Text("\(course.address1), \(course.city), \(course.state) \(course.zipCode)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("ID: \(course.id)")
                        .font(.caption)
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
