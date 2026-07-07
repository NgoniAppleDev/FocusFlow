# AddHabit Design

Things to consider for users to add a new habit.



### Imagine thinking to yourself:
```
“This is looking good! 
But every user has different habits. 
I don’t want to be stuck with Workout, Read, and Practice Swift. 
I want to add my own habits.”
```

### So, you might ask questions like:
- Where would the "Add" button go?
- What SwiftUI view would you present?
- How would the user enter the habit name?
- How would we add it to the habits array?

### My Response

#### Where would the "Add" button go?
"**I would put an Add button in the top right of the navigation bar.**"

That's where iOS users expect it.
```swift
.navigationTitle("FocusFlow")
.toolbar {
    ToolbarItem(placement: .confirmationAction) {
        Button("Add") {
            // Present sheet
        }
    }
}
```

#### What SwiftUI view would you present?

"**I would create a dedicated SwiftUI to create a new Habit.**"

#### How would the user enter the habit name?

"**I would present it as a sheet**"
This is in line with Apple's Human Interface Guidelines.
The user:
- starts creating something
- finishes,
- returns to the list.
    
A sheet is a natural fit.

#### How would we add it to the habits array?

- "**I would pass a binding of the whole array into the add habit view**"
```swift
@Binding var habits: [Habit]

...

habits.append(newHabit)
```

- "**or, I would pass back the new habit object through a closure.**"
```swift
let onCreate: (Habit) -> Void

...

onCreate(newHabit)
```

#### Imagine six months from now, I have:
- analytics
- validation
- duplicate checking
- saving to disk
- syncing with the cloud

**Using the closure method** means that the parent decides:
- append it
- reject it
- save it
- upload it
- log analytics
- anything else.

**That's pretty good!**


## Next Up: The Implementation
- <doc:AddHabit>
