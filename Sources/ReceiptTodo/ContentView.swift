import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: TodoStore
    @State private var showingAddTask = false

    private let paper = Color(
        red: 0.97,
        green: 0.97,
        blue: 0.95
    )

    private let ink = Color(
        red: 0.12,
        green: 0.11,
        blue: 0.09
    )

    var body: some View {
        VStack(spacing: 0) {

            header

            receiptDivider

            taskList

            receiptDivider

            footer
        }
        .padding(.horizontal, 22)
        .padding(.top, 24)
        .padding(.bottom, 24)
        .frame(width: 340)
        .background(paper)
        .foregroundStyle(ink)
        .fontDesign(.monospaced)
        .background(WindowAccessor())
        .sheet(isPresented: $showingAddTask) {
            AddTaskView()
                .environmentObject(store)
        }
    }

    // MARK: Header

    private var header: some View {
        VStack(spacing: 4) {

            Text("TASK RECEIPT")
                .font(
                    .system(
                        size: 22,
                        weight: .bold,
                        design: .monospaced
                    ))

            Text("CURRENT ORDERS")
                .font(
                    .system(
                        size: 10,
                        weight: .medium,
                        design: .monospaced
                    )
                )
                .tracking(2)

            Text(
                Date.now.formatted(
                    .dateTime
                        .month(.abbreviated)
                        .day()
                        .year()
                )
                .uppercased()
            )
            .font(
                .system(
                    size: 10,
                    design: .monospaced
                )
            )
            .opacity(0.6)
            .padding(.top, 3)
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 16)
    }

    // MARK: Tasks

    private var taskList: some View {
        VStack(spacing: 0) {

            if store.tasks.isEmpty {

                VStack(spacing: 6) {
                    Text("NO OPEN ORDERS")
                        .font(
                            .system(
                                size: 12,
                                weight: .medium,
                                design: .monospaced
                            ))

                    Text("your receipt is empty :)")
                        .font(
                            .system(
                                size: 10,
                                design: .monospaced
                            )
                        )
                        .opacity(0.5)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 32)

            } else {

                ForEach(store.sortedTasks) { task in
                    TaskRow(task: task)

                    if task.id != store.sortedTasks.last?.id {
                        Rectangle()
                            .fill(ink.opacity(0.15))
                            .frame(height: 1)
                    }
                }
            }
        }
        .padding(.vertical, 8)
    }

    // MARK: Footer

    private var footer: some View {
        VStack(spacing: 14) {

            HStack {
                Text("REMAINING")
                Spacer()
                Text("\(store.remainingCount)")
            }
            .font(
                .system(
                    size: 11,
                    weight: .semibold,
                    design: .monospaced
                ))

            Button {
                showingAddTask = true
            } label: {
                Text("+ ADD TASK")
                    .font(
                        .system(
                            size: 12,
                            weight: .bold,
                            design: .monospaced
                        )
                    )
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 9)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .overlay {
                Rectangle()
                    .stroke(
                        ink,
                        style: StrokeStyle(
                            lineWidth: 1,
                            dash: [5, 3]
                        )
                    )
            }

            VStack(spacing: 2) {
                Text("THANK YOU")
                Text("PLEASE COMPLETE AGAIN")
            }
            .font(
                .system(
                    size: 9,
                    design: .monospaced
                )
            )
            .opacity(0.45)
            .padding(.top, 2)
        }
        .padding(.top, 14)
    }

    // MARK: Divider

    private var receiptDivider: some View {
        Rectangle()
            .fill(ink)
            .frame(height: 1)
            .mask {
                HStack(spacing: 4) {
                    ForEach(0..<40, id: \.self) { _ in
                        Rectangle()
                            .frame(width: 5, height: 1)
                    }
                }
            }
            .opacity(0.45)
    }
}
