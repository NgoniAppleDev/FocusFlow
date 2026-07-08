# 9. First Design Pattern

Applying the **MVVM** Design Pattern to **FocusFlow** app.


## Git Checkpoint
```bash
git checkout -b refactor/habit-list-view-model
```

## Why now?

Opening ContentView, shows that we have way more than the **UI**

We have stuff like these methods:
```swift
private func addHabit(_:)
private func deleteHabits(at:)
private func moveHabit(from:to:)
```

### ContentView has these responsibilities
**UI**
- [x] Navigation
- [x] Toolbar
- [x] Sheet
- [x] Empty State
- [x] List

**Application Logic**
- [x] Add habit
- [x] Delete habit
- [x] Move habit

**Persistence**
- [x] Insert into SwiftData
- [x] Delete from SwiftData
- [x] Save


### The SRP says

> The **Single Responsibility Principle** says:
> "A type should have one reason to change"
> Right now, **ContentView** has at least three.


## Introducing MVVM

### What should the ViewModel own?

```swift
addHabit()

deleteHabits()

moveHabit()

toggleHabit()
```

Views mostly display.

ViewModels mostly perform actions.


### What remains in the ContentView?
```swift
showingCreateHabit

NavigationStack

.sheet

.toolbar

ContentUnavailableView

List
```


### What this means

```
ContentView
│
├── owns UI state
│
├── observes HabitListViewModel
│
└── sends user actions
        │
        ▼
HabitListViewModel
│
├── addHabit()
├── deleteHabits()
├── moveHabit()
├── toggleHabit()
│
└── uses ModelContext
```

```
                    ContentView
                        │
        ┌───────────────┴───────────────┐
        │                               │
    @Query observes                 HabitListViewModel
      [Habit]                            │
        │                                │
        │                        addHabit()
        │                        deleteHabits()
        │                        moveHabits()
        │                        toggleHabit()
        │                                │
        └───────────────SwiftData────────┘
```

### So we update the Folder Structure

```
.
├── Assets.xcassets
│   FocusFlowApp.swift
├── FocusFlowDocumentation.docc
│   ├── App Building Journey
│   │   ├── AppBuildingJourney.md
│   │   ├── ...
│   ├── FocusFlowDocumentation.md
├── Model
│   └── Habit.swift
├── Preview Support
│   ├── PreviewContainer.swift
│   └── SampleData.swift
└── Views
    ├── CreateHabitView.swift
    ├── HabitListView+ViewModel.swift
    └── HabitListView.swift
```

## Clean up ContentView uhh... HabitListView

> Rename ContentView to **HabitListView**

### Creat ViewModel in extension
```swift
extension HabitListView {
    
    final class ViewModel { ... }
```

### Move methods to the ViewModel

#### add(_:using:currentCount:)
```swift
func add(_ habit: Habit, using modelContext: ModelContext, currentCount: Int) { ... }
```

#### toggle(_:using:)
```swift
func toggle(_ habit: Habit, using modelContext: ModelContext) { ... }
```

#### delete(_:at:using)
```swift
func delete(_ habits: [Habit], at offsets: IndexSet, using modelContext: ModelContext) { ... }
```

#### move(_ from:to:using:)
```swift
func move(_ habits: [Habit], from indexSet: IndexSet, to newOffset: Int, using modelContext: ModelContext) { ... }
```

#### save(using:) helper method
```swift
private func save(using modelContext: ModelContext) { ... }
```

### Introduce the ViewModel property
```swift
@State private var viewModel: ViewModel = .init()
```

### Update call sites
```swift
.onTapGesture {
    viewModel.toggle(habit, using: modelContext)
}
```

```swift
.onDelete { indexSet in
    viewModel.delete(habits, at: indexSet, using: modelContext)
}
```

```swift
.onMove { indices, destination in
    viewModel.move(habits, from: indices, to: destination, using:modelContext)
}
```

```swift
.sheet(isPresented: $showingCreateHabit) {
    NavigationStack {
        CreateHabitView { newHabit in
            viewModel.add(newHabit, using: modelContext, currentCount: habits.count)
        }
    }
}
```

## Our Architecture now
```
HabitListView
├── Render UI
├── Observe @Query
└── Send user actions


HabitListView.ViewModel
├── add()
├── toggle()
├── delete()
├── move()
└── save()
```

## Git checkpoint
```bash
git add .
git commit -m "refactor: move habit operations into view model"
```

## Git History Now

### Everything
```
main
 |
 ● chore: create SwiftUI project
 |
 ● feat: create habit list
 |
 ● feat: toggle habit completion
 |
 ● feat: add habit creation flow
 |\
 | \
 |  └── feat:add-habit
 |        |
 |        └── merge back to main
 |
 ● feat: add SwiftData persistence
 |\
 | \
 |  └── feat:swiftdata-persistence
 |        |
 |        └── merge back to main
 |
 ● feat: add empty state + preview support
 |\
 | \
 |  └── feat:swiftdata-preview-support
 |        |
 |        └── merge back to main
 |
 ● feat: add habit deletion
 |\
 | \
 |  └── feat:delete-habit
 |        |
 |        └── merge back to main
 |
 ● feat: add habit reordering
 |\
 | \
 |  └── feat:reorder-habits
 |        |
 |        └── merge back to main
 |
 ● refactor: extract habit list view model
 |\
 | \
 |  └── refactor:habit-list-view-model
 |        |
 |        └── merge back to main
```

### Major milestones
```
main

│
├── feat:add-habit
│     └── CreateHabitView
│     └── Sheet presentation
│     └── onCreate closure
│
├── feat:swiftdata-persistence
│     └── @Model Habit
│     └── ModelContainer
│     └── @Query
│
├── feat:swiftdata-preview-support
│     └── PreviewContainer
│     └── SampleData
│
├── feat:delete-habit
│     └── EditMode
│     └── swipe delete
│
├── feat:reorder-habits
│     └── order property
│     └── drag and drop
│
└── refactor:habit-list-view-model
      └── HabitListView.ViewModel
      └── move business actions out of View
```

## Next up
- 