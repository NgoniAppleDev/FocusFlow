# 8. ReOder Habits

## Git Checkpoint
```bash
git checkout -b feat/reorder-habits
```

## Habit model

At the moment, the **Habit** model looks like this:
```swift
@Model
final class Habit {
    var name: String
    var isCompleted: Bool
    
    init(name: String, isCompleted: Bool = false) {
        self.name = name
        self.isCompleted = isCompleted
    }

    ...
}
```

To introduce ordering to the habits, I need to add a property to the Habits model:
```swift
@Model
final class Habit {
    var name: String
    var isCompleted: Bool
    var order: Int
    
    init(name: String, isCompleted: Bool = false) {
        self.name = name
        self.isCompleted = isCompleted
        self.order = 0
    }
    
    ...
}
```

And then use that property to keep track of habits order.

## Modify PreviewContainer

```swift
let context = ModelContext(container)
        
    SampleData.habits.enumerated().forEach { index, habit in
        habit.order = index
        context.insert(habit)
    }
```

## ContentView

### Update Query
```swift
@Query(sort: \Habit.order)
private var habits: [Habit]
```

### Add movement

Now I attached the **.onMove** modifier to **ForEach**:
```swift
.onMove { indices, newOffset in
    moveHabit(from: indices, to: newOffset)
}
```

### The moveHabits function
```swift
private func moveHabit(from indexSet: IndexSet, to newOffset: Int) {
    if let index = indexSet.first {
        let habitToMove = habits[index]
    }
}
```

## To perform a move operation

A move operation has two parts:
1. **Remove** the item from its old position
2. **Insert** it at its new position

### With a normal Swift array
```swift
let habit = habits.remove(at: index)
habits.insert(habit, at: newOffset)
```

### But, wait..

I am using **SwiftData**, which means I have:
```swift
@Query private var habits: [Habit]
```

Which is not a normal mutable array.

### Solution

I used a temporary array:
```swift
private func moveHabit(from indexSet: IndexSet, to newOffset: Int) {
    var reorderedHabits = habits
    
    reorderedHabits.move(fromOffsets: indexSet, toOffset: newOffset)
    
    for (index, habit) in reorderedHabits.enumerated() {
        habit.order = index
    }
    
    try? modelContext.save()
}
```

So, when I run above:
```swift
try? modelContext.save()
```

The **@Query** will fetch habits sorting them by **order** property.

## Git checkpoint
```bash
git add .
git commit -m "feat: add habit reordering"
```

## Next Up
- <doc:FirstDesignPattern_MVVM>
