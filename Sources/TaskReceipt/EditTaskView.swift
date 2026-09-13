import SwiftUI

struct EditTaskView: View {

    @EnvironmentObject var store: TodoStore

    @Environment(\.dismiss)
    private var dismiss

    let task: TodoItem

    @State private var title: String
    @State private var category: String
    @State private var dueDate: Date

    init(task: TodoItem) {
        self.task = task

        _title = State(initialValue: task.title)
        _category = State(initialValue: task.category)
        _dueDate = State(initialValue: task.dueDate)
    }

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 20
        ) {

            Text("EDIT TASK")
                .font(.system(
                    size: 20,
                    weight: .bold,
                    design: .monospaced
                ))
                .foregroundStyle(.white)

            VStack(
                alignment: .leading,
                spacing: 7
            ) {

                Text("TASK")
                    .fieldLabel()

                TextField(
                    "Problem Set 2",
                    text: $title
                )
                .textFieldStyle(.roundedBorder)
                .foregroundStyle(.white)
            }

            VStack(
                alignment: .leading,
                spacing: 7
            ) {

                Text("COURSE / CATEGORY")
                    .fieldLabel()

                TextField(
                    "ECON 1110",
                    text: $category
                )
                .textFieldStyle(.roundedBorder)
                .foregroundStyle(.white)
            }

            VStack(
                alignment: .leading,
                spacing: 7
            ) {

                Text("DUE DATE")
                    .fieldLabel()

                DatePicker(
                    "",
                    selection: $dueDate,
                    displayedComponents: .date
                )
                .labelsHidden()
            }

            HStack {

                Button("CANCEL") {
                    dismiss()
                }

                Spacer()

                Button("SAVE") {
                    saveTask()
                }
                .keyboardShortcut(.defaultAction)
                .disabled(
                    title.trimmingCharacters(
                        in: .whitespacesAndNewlines
                    ).isEmpty
                )
            }
        }
        .padding(28)
        .frame(width: 360)
        .fontDesign(.monospaced)

        // Make this sheet consistently use dark-mode controls/colors
        .preferredColorScheme(.dark)
    }

    private func saveTask() {

        let trimmedTitle =
            title.trimmingCharacters(
                in: .whitespacesAndNewlines
            )

        let trimmedCategory =
            category.trimmingCharacters(
                in: .whitespacesAndNewlines
            )

        store.updateTask(
            id: task.id,
            title: trimmedTitle,
            category:
                trimmedCategory.isEmpty
                ? "OTHER"
                : trimmedCategory,
            dueDate: dueDate
        )

        dismiss()
    }
}

private extension Text {

    func fieldLabel() -> some View {
        self
            .font(.system(
                size: 10,
                weight: .bold,
                design: .monospaced
            ))
            .foregroundStyle(
                Color.white.opacity(0.55)
            )
    }
}