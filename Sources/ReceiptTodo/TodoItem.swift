import Foundation

struct TodoItem: Identifiable, Codable, Equatable {
    var id = UUID()

    var title: String
    var category: String
    var dueDate: Date
    var isCompleted: Bool = false
}