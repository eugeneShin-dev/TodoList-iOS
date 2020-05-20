//
//  Todo.swift
//  TodoList
//
//  Created by joonwon lee on 2020/03/19.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit


// TODO: Codable과 Equatable 추가
struct Todo: Codable, Equatable {
    let id: Int
    var isDone: Bool // 완료 되었는지
    var detail: String // 관련 내용
    var isToday: Bool // 오늘 해야하는지
    
    // 뮤테이팅 : 이 메서드를 호출하면 프로퍼티의 값을 바꾼다  
    mutating func update(isDone: Bool, detail: String, isToday: Bool) {
        // [x]TODO: update 로직 추가
        self.isDone = isDone
        self.detail = detail
        self.isToday = isToday
        
    }
    // == : 두 객체가 같은지 (Todo 간의 동등 비교)
    // == : TODO 객체에 대해 업데이트를 했을 때 (완료했을 때) 여러 개의 TODO중에 어떤 걸 업데이트 시킬 거냐
    // Equatble이라는 프로토콜을 상속했기 때문에 사용할 수 있다
    static func == (lhs: Self, rhs: Self) -> Bool { // lhs => left hand side라는 뜻
        // [x]TODO: 동등 조건 추가
        return lhs.id == rhs.id
    }
}

class TodoManager {
    
    static let shared = TodoManager()
    
    static var lastId: Int = 0
    
    var todos: [Todo] = []
    
    func createTodo(detail: String, isToday: Bool) -> Todo {
        //TODO: create로직 추가
        return Todo(id: 1, isDone: false, detail: "2", isToday: true)
    }
    
    func addTodo(_ todo: Todo) {
        //TODO: add로직 추가
    }
    
    func deleteTodo(_ todo: Todo) {
        //TODO: delete 로직 추가
        
    }
    
    func updateTodo(_ todo: Todo) {
        //TODO: updatee 로직 추가
        
    }
    
    func saveTodo() {
        Storage.store(todos, to: .documents, as: "todos.json")
    }
    
    func retrieveTodo() {
        todos = Storage.retrive("todos.json", from: .documents, as: [Todo].self) ?? []
        
        let lastId = todos.last?.id ?? 0
        TodoManager.lastId = lastId
    }
}

class TodoViewModel {
    
    enum Section: Int, CaseIterable {
        case today
        case upcoming
        
        var title: String {
            switch self {
            case .today: return "Today"
            default: return "Upcoming"
            }
        }
    }
    
    private let manager = TodoManager.shared
    
    var todos: [Todo] {
        return manager.todos
    }
    
    var todayTodos: [Todo] {
        return todos.filter { $0.isToday == true }
    }
    
    var upcompingTodos: [Todo] {
        return todos.filter { $0.isToday == false }
    }
    
    var numOfSection: Int {
        return Section.allCases.count
    }
    
    func addTodo(_ todo: Todo) {
        manager.addTodo(todo)
    }
    
    func deleteTodo(_ todo: Todo) {
        manager.deleteTodo(todo)
    }
    
    func updateTodo(_ todo: Todo) {
        manager.updateTodo(todo)
    }
    
    func loadTasks() {
        manager.retrieveTodo()
    }
}

