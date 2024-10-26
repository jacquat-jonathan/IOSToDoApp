//
//  CalendarView.swift
//  ToDoApp
//
//  Created by Jonathan Jacquat on 26.10.2024.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 25))
                Text("Under construction")
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 25))
            }
            .padding(.bottom)
            Text("This view will be used to display the calendar (like a real calendar). Usefull to see task far in the future. Use IOS Calendar app for example")
        }
        .padding()
    }
}

#Preview {
    CalendarView()
}
