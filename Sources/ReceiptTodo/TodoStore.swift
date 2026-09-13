import Foundation

final class TodoStore: ObservableObject {

    @Published var tasks: [TodoItem] = [] {
        didSet {
            saveTasks()
        }
    }

    private let saveKey = "savedReceiptTasks"

    init() {
        loadTasks()
    }

    var sortedTasks: [TodoItem] {
        tasks.sorted { first, second in

            // Incomplete tasks first
            if first.isCompleted != second.isCompleted {
                return !first.isCompleted
            }

            // Then sort by due date
            return first.dueDate < second.dueDate
        }
    }

    var remainingCount: Int {
        tasks.filter { !$0.isCompleted }.count
    }

    func addTask(
        title: String,
        category: String,
        dueDate: Date
    ) {
        let task = TodoItem(
            title: title,
            category: category,
            dueDate: dueDate
        )

        tasks.append(task)
    }

    func toggleTask(_ task: TodoItem) {
        guard let index = tasks.firstIndex(where: {
            $0.id == task.id
        }) else {
            return
        }

        tasks[index].isCompleted.toggle()
    }

    func deleteTask(_ task: TodoItem) {
        tasks.removeAll {
            $0.id == task.id
        }
    }

    private func saveTasks() {
        do {
            let data = try JSONEncoder().encode(tasks)

            UserDefaults.standard.set(
                data,
                forKey: saveKey
            )
        } catch {
            print("Failed to save tasks: \(error)")
        }
    }

    private func loadTasks() {
        guard
            let data = UserDefaults.standard.data(
                forKey: saveKey
            )
        else {
            return
        }

        do {
            tasks = try JSONDecoder().decode(
                [TodoItem].self,
                from: data
            )
        } catch {
            print("Failed to load tasks: \(error)")
        }
    }
}