# 4. Add a Habit

Users add their own habits.

## Design of this feature
- <doc:AddHabitDesign>


## Create new Git branch

Create a new branch for this feature:
```bash
git checkout -b feat/add-habit
```

Or, just use GitHub Desktop.

Now it looks like this:
```
main
│
├── chore: create initial SwiftUI project
│
└── feat: allow users to complete habits

            ↓ merged

main
│
└── feat/add-habit   ← We're here
```

## Created the CreateHabitView

### First, we added the necessary state which this view needs

```swift
@State private var habitName = ""
```

### Inside the body, we're collecting information

So, using the **Form** here is a good idea.
```swift
Form {
    Section("Habit") {
        TextField("name", text: $habitName)
    }
}
```

### We give the user the ability to cancel or create a new Habit

> According to Apple Human Interface Guidelines, even though the user could swipe down to dismiss the model, **we should provide an explicit way to dismiss a modal**.

```swift
.navigationTitle("New Habit")
.toolbar {
    ToolbarItem(placement: .cancellationAction) {
        Button("Cancel", role: .cancel) { dismiss() }
    }
    
    ToolbarItem(placement: .confirmationAction) {
        Button("Create", role: .confirm) {
            let newHabit = Habit(name: habitName.trimmedString, isCompleted: false)
            
            onCreate(newHabit)
            
            dismiss()
        }
        .disabled(habitName.isTrimmedEmpty)
    }
}
```

When the **Create Button** get's pressed, we all the **onCreate** closure to notify the parent that new habit has been created.

We create a property for that closure like this:
```swift
let onCreate: (Habit) -> Void
```

I created this **helper extension** to make code concise and readable:
```swift
extension String {
    var isTrimmedEmpty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var trimmedString: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
```

### Where to put the NavigationStack

To make sure our view remains **reusable** it's better to add the **NavigationStack** when we create the model in the **.sheet** modifier.

This way, whether our view is added to another navigation stack, tab-view or anywhere, it works.

To preview the navigation bar, you can put the **NavigationStack** in the preivew:
```swift
#Preview {
    NavigationStack {
        CreateHabitView(onCreate: { _ in })
    }
}
```

## Now integrating with ContentView

ContentView is gonna show a modal of the **CreateHabitView**.

I need state to track visibility of this view:
```swift
@State private var showingCreateHabit = false
```

Then, I present the modal view:
```swift
.toolbar {
    ToolbarItem(placement: .primaryAction) {
        Button("Add", systemImage: "plus") {
            showingCreateHabit = true
        }
    }
}
.sheet(isPresented: $showingCreateHabit) {
    NavigationStack {
        CreateHabitView(onCreate: addHabit(_:))
    }
}
```

To keep thing **clean**, and **organized**, I create a method to add the new habit:
```swift
private func addHabit(_ newHabit: Habit) {
    habits.append(newHabit)
}
```

## ContentView now

It currently contains:
- Habit list UI
- Completion logic
- Adding logic
- Sheet presentation
- State management

```
ContentView
 |
 ├── displays habits
 ├── modifies habits
 ├── creates habits
 └── owns app state
```

## Git Checkpoint

### Commit message
```
git add .
git commit -m "feat: add habit creation flow"
```

- **Pull Request**
- **Merge current branch into main**
- **Delete current branch**

## Git History now
```
main
 |
 ├── chore: create initial SwiftUI project
 |
 ├── feat: allow users to complete habits
 |
 └── feat: add habit creation flow
```

## Next up
- <doc:PersistHabits>
