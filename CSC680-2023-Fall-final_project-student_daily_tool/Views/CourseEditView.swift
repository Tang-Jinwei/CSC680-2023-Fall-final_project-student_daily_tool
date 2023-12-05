//  Created by Tang Jinwei on 12/2/23.
//

import SwiftUI


struct CourseEditView: View {
    
    @Binding var courses: [Course]
    @State var newCourseName: String = ""
    @State var newSemester: Semester = .none
    @State var isEditng:Bool = false
    
    
    let colors: [Color] = [.red,.green,.yellow,.blue]
    
    var columns: [GridItem] = Array(repeating: .init(.flexible(), alignment: .center), count: 2)
    
    func resetEdit() {
        withAnimation {
            isEditng.toggle()
        }
        newCourseName = ""
        newSemester = .none
    }
    
    
    func addCourse(_ courses: [Course]) -> some View{
//        let screenRect = UIScreen.main.bounds
//        let screenWidth = screenRect.size.width
//        let screenHeight = screenRect.size.height
        return VStack {
            VStack {
                Text("Course Name: ")
                TextField("", text: $newCourseName)
                    .padding([.bottom,.leading,.trailing])
                    .textFieldStyle(.roundedBorder)
                Text("Semester: ")
                Picker(selection: $newSemester, label: Text("Semester: ")) {
                    ForEach(Semester.allCases, id: \.rawValue) { item in
                        Text(item.rawValue).tag(item)
                    }
                }
                .padding([.bottom,.leading,.trailing])
                .pickerStyle(SegmentedPickerStyle())
                
                HStack {
                    Spacer()
                    Button{
                        resetEdit()
                    } label: {
                         Text("Cancel")
                    }
                    Spacer()
                    Button{
                        withAnimation {
                            self.courses.append(Course(courseName: newCourseName, semester: newSemester, todoList: []))
                        }
                        resetEdit()
                    } label: {
                         Text("Done")
                    }
                    .disabled(newCourseName.isEmpty ? true : false)
                    Spacer()
                }
            }
            .padding()
            .background(Color.white)
            .overlay(RoundedRectangle(cornerRadius: 5)
                .stroke(ThemeController.theme.themeColor, lineWidth: 0.5))
            .padding()
            }
            .transition(.scale)
    }
    
    var body: some View {
        NavigationStack{
            ZStack {
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach($courses) { $course in
                            NavigationLink(destination: CourseDetailView(courses: $courses, currentCourse: $course)) {
                                VStack{
                                    Spacer()
                                    Text(course.courseName)
                                    Spacer()
                                    Text(course.semester.rawValue)
                                    Text(course.year.description)
                                    Spacer()
                                }
                                .foregroundStyle(Color.primary)
                                .padding()
                                .frame(width: 150, height: 150)
                                .overlay(RoundedRectangle(cornerRadius: 5)
                                .stroke(ThemeController.theme.themeColor, lineWidth: 0.5))
                            }
    //                        .background(colors[index % colors.count])
                        }
                        Button {
                            withAnimation {
                                isEditng.toggle()
                            }
                        } label: {
                            Image(systemName: "plus")
                                .frame(width: 50, height: 50)
                                .border(ThemeController.theme.themeColor)
                        }
                    }
                    .padding()
                }
                .disabled(isEditng ? true : false )
                .opacity(isEditng ? 0.3 : 1)
                if(isEditng) {
                    addCourse(courses)
                }
            }
            .navigationTitle("Courses")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CourseEditView(courses: .constant(Course.sampleData))
}
