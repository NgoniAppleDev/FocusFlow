# 5. Persist Habits

Save habits across app launches with SwiftData.

## Product Story
```
"As a user, I expect my habits to still be thee when I reopen the app."
```

## Introducing SwiftData

SwiftData works with classes and the **@Observable** macro.

At the moment, our **Habit** model looks like this:
```swift
struct Habit {
    let name: String
    var isCompleted: Bool
    
    mutating func toggle() {
        isCompleted.toggle()
    }
}
```

Converted to a **SwiftData** class,
```swift
@Model
final class Habit {
    var name: String
    var isCompleted: Bool
    
    init(name: String, isCompleted: Bool) {
        self.name = name
        self.isCompleted = isCompleted
    }
    
    func toggle() {
        isCompleted.toggle()
    }
}
```

Back in **ContentView**, we switch
```swift
@State private var habits: [Habit] = [ ... ]
```

with
```swift
@Query private var habits: [Habit]
```

This no longer works:
```swift
private func addHabit(_ habit: Habit) {
    habits.append(habit)
}
```

That's where the **context** comes in:
```swift
@Environment(\.modelContext) private var modelContext
```

The context is responsible for:
- inserting
- deleting
- saving 
- and more...

So the mental model here becomes...
```
User taps Create
        │
        ▼
addHabit()
        │
        ▼
modelContext.insert(habit)
        │
        ▼
SwiftData stores it
        │
        ▼
@Query automatically updates
        │
        ▼
List refreshes
```

### What if there are no habits?

I used **ContentUnavailableView**:

```swift
Group {
    if habits.isEmpty {
        ContentUnavailableView {
            Label("No Habits", systemImage: "checklist")
        } description: {
            Text("Create a habit to get started")
        } actions: {
            Button("Add Habit", systemImage: "plus") {
                showingCreateHabit = true
            }
            .buttonStyle(.glassProminent)
            .controlSize(.extraLarge)
        }
    } else {
        List { ... }
    }
}
```

Because I now use **SwiftData**, my **ForEach** changes since **models** are **Identifiable**

I now use **habit object** instead of **habits[index]**:
```swift
List {
    ForEach(habits) { habit in
        HStack {
            Text(habit.name)
                .strikethrough(habit.isCompleted)
                .foregroundStyle(habit.isCompleted ? .secondary : .primary)
            
            Spacer()
            
            Image(systemName: habit.isCompleted ? "checkmark.circle.fill" : "circle")
        }
        .onTapGesture {
            habit.toggle()
        }
    }
}
```

The **addHabit(_ newHabit:)** function becomes:
```swift
private func addHabit(_ newHabit: Habit) {
    modelContext.insert(newHabit)
    do {
        try modelContext.save()
    } catch {
        // FIXME: should remove print statement when going into production.
        print(error)
    }
}
```

> The **FIXME:** comment will show up in Xcode and will remind to remove that print statement.


## What Architecture I have at the moment.

```
                 SwiftData
                     ▲
                     │
                 ModelContext
                     ▲
                     │
+--------------------------------------+
|            ContentView               |
|--------------------------------------|
| • Renders UI                         |
| • Presents sheets                    |
| • Adds habits                        |
| • Toggles habits                     |
| • Talks to SwiftData                 |
+--------------------------------------+
```


## Next Up
