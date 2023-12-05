//
//  SwiftUIView.swift
//  CSC680-2023-Fall-final_project-student_daily_tool
//
//  Created by Tang Jinwei on 12/4/23.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
            .background(Color.red.opacity(1))
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
            .background(Color.red.opacity(0.5))
        
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
        }
}

#Preview {
    SwiftUIView()
}
