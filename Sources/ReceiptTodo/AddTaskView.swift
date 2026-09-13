import SwiftUI

struct AddTaskView: View {

    @EnvironmentObject var store: TodoStore

    @Environment(\.dismiss)
    private var dismiss

    @State private var title = ""

    @State private var category = ""

    @State private var dueDate = Date()

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 20
        ) {

            Text("NEW TASK")
                .font(.system(
                    size: 20,
                    weight: .bold,
                    design: .monospaced
                ))

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

                Button("ADD TASK") {
                    addTask()
                }
                .keyboardShortcut(
                    .defaultAction
                )
                .disabled(
                    title.trimmingCharacters(
                        in: .whitespaces
                    ).isEmpty
                )
            }
        }
        .padding(28)
        .frame(width: 360)
        .fontDesign(.monospaced)
    }

    private func addTask() {

        let trimmedTitle =
            title.trimmingCharacters(
                in: .whitespacesAndNewlines
            )

        let trimmedCategory =
            category.trimmingCharacters(
                in: .whitespacesAndNewlines
            )

        store.addTask(
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
            .foregroundStyle(.secondary)
    }
}