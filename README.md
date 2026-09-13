# TaskReceipt

A minimal macOS task manager that turns your to-do list into a receipt.

TaskReceipt is a lightweight desktop app for keeping track of tasks, courses/categories, and due dates in a simple receipt-inspired interface.

## Features

- Add tasks with a name, course/category, and due date
- Check off completed tasks
- Edit existing tasks
- Delete tasks
- Automatically sorts and displays your tasks
- Shows overdue tasks
- Automatically resizes the receipt as tasks are added or removed
- Saves your tasks between sessions
- Native macOS interface
- Custom receipt-inspired design

## Preview

<img src="taskreceipt.png" alt="TaskReceipt Screenshot" width="300">

## Using TaskReceipt

Each task contains:

- **Task** — what you need to complete
- **Course / Category** — such as `CS 1635`, `ECON 1110`, `WORK`, or `OTHER`
- **Due Date** — when the task is due

### Add a task

Click:

```text
+ ADD TASK
```

Enter the task name, course/category, and due date, then click **ADD TASK**.

### Complete a task

Click the checkbox next to a task to mark it as complete.

### Edit a task

Click a task to open the edit window.

Update the information and click **SAVE**.

You can also right-click a task and select **Edit Task**.

### Delete a task

Hover over a task and click the **×** that appears on the right.

You can also right-click the task and select **Delete Task**.

## Installation

### Download the app

If a prebuilt version is available, go to the **Releases** section of this repository and download the latest TaskReceipt release.

After downloading:

1. Unzip `TaskReceipt.zip`.
2. Move `TaskReceipt.app` into your **Applications** folder.
3. Open TaskReceipt from Applications, Spotlight, or the Dock.

> TaskReceipt is currently built for macOS.

## Development

TaskReceipt is built with:

- **Swift**
- **SwiftUI**
- **AppKit**
- **Swift Package Manager**

The main source files are located in:

```text
Sources/TaskReceipt/
```

During development, run:

```bash
swift run
```

After making changes, rebuild the installed application with:

```bash
./build-app.sh
```

## Project Structure

```text
TaskReceipt/
├── Sources/
│   └── TaskReceipt/
│       ├── TaskReceiptApp.swift
│       ├── ContentView.swift
│       ├── TaskRow.swift
│       ├── AddTaskView.swift
│       ├── EditTaskView.swift
│       ├── TodoItem.swift
│       ├── TodoStore.swift
│       ├── AppDelegate.swift
│       └── WindowAccessor.swift
│
├── ReceiptIcon.png
├── ReceiptIcon.icns
├── Package.swift
├── build-app.sh
└── README.md
```

## Why TaskReceipt?

TaskReceipt started as a small project to experiment with building a native macOS application in SwiftUI.

The idea was to make a to-do list that feels less like a traditional productivity app and more like a small object that can live on your desktop. The receipt format provides a simple way to see what still needs to be completed without unnecessary features or clutter.