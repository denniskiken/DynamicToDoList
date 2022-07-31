//
//  ContentView.swift
//  DynamicToDoList
//  Created by Dennis Kikendall on 6/16/22.
//

import SwiftUI

struct InputTodoView: View {
    @State
    private var newToDoDescription: String = ""
    
    @Binding
    var todos: [Todo]   // View shared Todo array
    
    var body: some View {
        HStack {
            TextField("Todo", text: $newToDoDescription)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Spacer()
            Button {
                guard !newToDoDescription.isEmpty else {
                    return
                }
                todos.append(Todo(description: newToDoDescription,
                                  done: false))
                newToDoDescription = ""
            } label: {
                Text("Add")
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .foregroundColor(.white)
                    .background(.green)
                    .cornerRadius(5)
            }
        }
        .frame(height: 60)
        .padding(.horizontal, 24)
        .padding(.bottom, 30)
        .background(Color.gray)
    }
    
}

struct Todo: Identifiable {
    let id = UUID()
    let description: String
    var done: Bool
}

struct ContentView: View {
    @State
    private var todos = [
        Todo(description: "review the first chapter", done: false),
        Todo(description: "buy wine", done: false),
        Todo(description: "paint kitchen", done: false),
        Todo(description: "cut the grass", done: false),
    ]

    var body: some View {
        ZStack(alignment: .bottom) {
            List($todos) { $todo in
                HStack {
                    Text(todo.description)
                        .strikethrough(todo.done)
                    Spacer()
                    Image(systemName:
                            todo.done ?
                          "checkmark.square" :
                            "square")
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    todo.done.toggle()
                }
            }
            InputTodoView(todos: $todos)    // append Add view
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
