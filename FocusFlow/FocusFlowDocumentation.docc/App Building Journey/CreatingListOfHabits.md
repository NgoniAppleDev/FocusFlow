# 2. Create a list of habits

Users can view a list of habits.

## First I created a feature branch
```bash
git checkout -b feat/habit-list
```

> You can do the same operation of creating a new branch in GitHub Desktop.

Effectively, it looks like this:
```
main
|
|
└── feat/habit-list
```

## The simplest implementation

The first thing was to just display a list of habits.

Nothing fancy yet, and refactor later to apply good architecture.

For now, I just wrote code that works!

### Created first model: Habit

Implemented this model in `Habit.swift`
```swift
import Foundation

struct Habit {
    let name: String
    var isCompleted: Bool
}
```

### Display Habits

So, `ContentView` effectively becomes:

```swift
struct ContentView: View {
    @State private var habits: [Habit] = [
        .init(name: "Workout", isCompleted: false),
        .init(name: "Read", isCompleted: false),
        .init(name: "Practice Swift", isCompleted: false)
    ]
    
    var body: some View {
        List {
            ForEach(habits.indices, id: \.self) { index in
                HStack {
                    Text(habits[index].name)
                    
                    Spacer()
                    
                    Image(
                        systemName: habits[index].isCompleted ? "checkmark.circle.fill" : "circle"
                    )
                }
            }
        }
    }
}
```

That's it.

The simplest implementation of a habit tracking app.

Of course, user's can't completed them yet.

We're going to do that next.


## Next Up
- <doc:CompletingAHabit>
