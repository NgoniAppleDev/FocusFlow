# 7. Delete Habit

Remove habits the user no longer wants to track.

## Git checkpoint
```bash
git checkout -b feat/delete-habits
```

## Product story
```
"As a user, I want to remove habits I no longer want to track."
```

## How should deletion work?

We have a few iOS patterns:

### Option 1 - Swipe to delete
```
Habit row
    swipe left
        Delete
```

### Option 2 - Edit mode

Good for bulk actions
```
Edit button
    select rows
    delete
```

### Option 3 - Detail screen
```
Tap habit -> detail -> delete
```

## Chosen one or ones

I went with both, **Swipe to delete** and **Edit mode**

## With SwiftData

Because we have:
```swift
@Query private var habits: [Habit]
```

We tell **SwiftData**: "Remove this model."

The flow becomes:
```
User swipes row
        |
        ▼
.onDelete
        |
        ▼
deleteHabit(...)
        |
        ▼
modelContext.delete(habit)
        |
        ▼
@Query updates
```

## In ContentView

I appended the **.onDelete** modifier to **ForEach**:
```swift
.onDelete(perform: deleteHabits)
```

Then I added the **deleteHabits** method:
```swift
private func deleteHabits(at offsets: IndexSet) {
    for index in offsets {
        modelContext.delete(habits[index])
    }
}
```

> It's a good thing **ContentView** is getting big handling both UI and business logic. That's pushing us toward considering to use a **Design Pattern** to make our code more thoughtful.

### For bulk delete

I added the **EditButton()** provided by **SwiftUI** to enable edit-mode for bulk deletion:
```swift
ToolbarItem(placement: .secondaryAction) {
    EditButton()
}
```

## Git Checkpoint
```bash
git add .
git commit -m "feat: allow users to delete habits"
```

## Next up
- <doc:ReOrderHabits>
