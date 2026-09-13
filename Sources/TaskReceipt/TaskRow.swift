import SwiftUI

struct TaskRow: View {
    @EnvironmentObject var store: TodoStore

    let task: TodoItem

    @State private var isHovering = false
    @State private var showingEditTask = false

    private let ink = Color(
        red: 0.12,
        green: 0.11,
        blue: 0.09
    )

    var body: some View {
        HStack(
            alignment: .top,
            spacing: 10
        ) {

            // Checkbox
            Button {
                store.toggleTask(task)
            } label: {
                Image(
                    systemName:
                        task.isCompleted
                        ? "checkmark.square.fill"
                        : "square"
                )
                .font(.system(size: 15))
                .foregroundStyle(ink)
            }
            .buttonStyle(.plain)

            // Task title + category
            VStack(
                alignment: .leading,
                spacing: 4
            ) {

                Text(task.title)
                    .font(
                        .system(
                            size: 12,
                            weight: .medium,
                            design: .monospaced
                        )
                    )
                    .foregroundStyle(ink)
                    .strikethrough(task.isCompleted)

                Text(task.category.uppercased())
                    .font(
                        .system(
                            size: 9,
                            weight: .semibold,
                            design: .monospaced
                        )
                    )
                    .foregroundStyle(
                        ink.opacity(0.5)
                    )
            }

            Spacer()

            // Due date
            VStack(
                alignment: .trailing,
                spacing: 4
            ) {

                Text(
                    task.dueDate.formatted(
                        .dateTime
                            .month(.abbreviated)
                            .day()
                    )
                    .uppercased()
                )
                .font(
                    .system(
                        size: 10,
                        weight: .semibold,
                        design: .monospaced
                    )
                )
                .foregroundStyle(ink)

                if isOverdue && !task.isCompleted {
                    Text("OVERDUE")
                        .font(
                            .system(
                                size: 8,
                                weight: .bold,
                                design: .monospaced
                            )
                        )
                        .foregroundStyle(
                            ink.opacity(0.65)
                        )
                }
            }

            // Delete button only appears on hover
            if isHovering {
                Button {
                    store.deleteTask(task)
                } label: {
                    Image(systemName: "xmark")
                        .font(
                            .system(
                                size: 9,
                                weight: .bold
                            )
                        )
                        .foregroundStyle(
                            ink.opacity(0.45)
                        )
                }
                .buttonStyle(.plain)
                .help("Delete task")
            }
        }
        .padding(.vertical, 11)

        // Makes the full row clickable
        .contentShape(Rectangle())

        // Hover effect
        .onHover { hovering in
            isHovering = hovering
        }

        // Click anywhere on the row to edit
        .onTapGesture {
            showingEditTask = true
        }

        // Fade completed tasks
        .opacity(
            task.isCompleted
                ? 0.4
                : 1
        )

        // Edit sheet
        .sheet(
            isPresented: $showingEditTask
        ) {
            EditTaskView(task: task)
                .environmentObject(store)
        }

        // Right-click menu
        .contextMenu {

            Button("Edit Task") {
                showingEditTask = true
            }

            Divider()

            Button(
                task.isCompleted
                    ? "Mark Incomplete"
                    : "Mark Complete"
            ) {
                store.toggleTask(task)
            }

            Divider()

            Button(
                "Delete Task",
                role: .destructive
            ) {
                store.deleteTask(task)
            }
        }
    }

    // MARK: - Overdue

    private var isOverdue: Bool {
        Calendar.current.startOfDay(
            for: task.dueDate
        ) < Calendar.current.startOfDay(
            for: Date()
        )
    }
}