# 6. SwiftData Preview Support

Easily show **SwiftData** sample data in previews.

## Git Checkpoint
```bash
git checkout -b chore/preview-support
```

## Previously

I transferred ownership of data from **ContentView** to **SwiftData**

From
```swift
@State private var habits: [Habit] = [ ... ]
```

To
```swift
@Query private var habits: [Habit]
```

This meant that when the app launches for the first time, the habit list would be empty.

But, I want data to work with in my previews.

## Custom ModelContainer

To have sample data for my previews, I created a custom **model container** that stores data **in-memory** only

### First, the sample data
```swift
enum SampleData {
    
    static var habits: [Habit] = [
        .init(name: "Workout", isCompleted: true),
        .init(name: "Read", isCompleted: false),
        .init(name: "Practice Swift", isCompleted: true),
        .init(name: "Walk the dog", isCompleted: false),
    ]
}
```

### Second, the custom model container
```swift
enum PreviewContainer {
    
    static let container: ModelContainer = {
       let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        
        do {
            let container = try ModelContainer(for: Habit.self, configurations: configuration)
            
            let context = ModelContext(container)
            
            SampleData.habits.forEach(context.insert)
            
            try context.save()
            
            return container
        } catch {
            fatalError("Failed to create preview container: \(error)")
        }
    }()
}
```

### Now, easy-peasy

In ContentView, and any other view, to see my sample data, all I neeed is this:

```swift
#Preview {
    ContentView()
        .modelContainer(PreviewContainer.container)
}
```

## Git Checkpoint
```bash
git add .
git commit -m "chore: add SwiftData preview support"
```

## Next Up
- <doc:DeleteHabit>

