//
//  ContentView.swift
//  ToDo
//
//  Created by Student on 12/17/20.
//

import SwiftUI

struct ToDoListView: View {
    @ObservedObject var viewModel: ToDoViewModel
    
    @State var popUpVisible = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.toDoModel.toDoList, id: \.self) { item in
                        VStack {
                            Text(item.description)
                            HStack {
                                Text(item.dueDate)
                                Spacer()
                                Text(item.status)
                            }
                        }
                    }
                }
                .navigationBarTitle("My To Do List")
                .popover(isPresented: $popUpVisible, content: {
                    Text("Add")
                        .onTapGesture {
                            popUpVisible = false
                        }
                })
                Button(action: {popUpVisible = true}, label: {
                    Text("ADD")
                })
            }
        }

    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(viewModel: ToDoViewModel())
    }
}
