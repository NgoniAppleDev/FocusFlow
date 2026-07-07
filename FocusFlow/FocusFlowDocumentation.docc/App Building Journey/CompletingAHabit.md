# Completing a Habit

Toggle between completed and not-completed when a habit is pressed.

## Design choice

**Question:** "How to flip isCompleted?"

### Option A - in the View
```swift
habits[index].isCompleted.toggle()
```

### Option B - in the Model
```swift
habits[index].toggle()
```
whereby `Habit` struct implements:
```swift
mutating func toggle() {
    isCompleted.toggle()
}
```

## Option B: The Chosen One

First of all, it reads more like English:
```swift
habit.toggle()
```
Second, the view doesn't care how the habit is going to change itself. 

It simply asks the habit to change its own state.

## Implementation

I updated Habit.swift to:
```swift
struct Habit {
    let name: String
    var isCompleted: Bool
    
    mutating func toggle() {
        isCompleted.toggle()
    }
}
```

> When modifying a property on a struct, the `struct` keyword is required.

When then add a `onTapGesture` to the `HStack` in `ContentView`:
```swift
HStack {
    Text(habits[index].name)
    
    Spacer()
    
    Image(systemName: habits[index].isCompleted ? "checkmark.circle.fill" : "circle")
}
.onTapGesture {
    habits[index].toggle()
}
```

> That was the **first design decision** there: 
> "**Where can I place this behavior?**"


## What else shows the User the habit is complete?

At this point, the user sees the checkmark.
But the text did not change.

I can do something about that.

So I choose to strikethrough the text, and also gray it out:
```swift
Text(habits[index].name)
    .strikethrough(habits[index].isCompleted)
    .foregroundStyle(habits[index].isCompleted ? .secondary : .primary)
```

It's not perfect yet, but **it works**.


## Next Up
- 
