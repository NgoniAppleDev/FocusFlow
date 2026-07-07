# Creating the SwiftUI Project

Creating the initial project.


## Created SwiftUI Project

Here, I created the SwiftUI project with Xcode 26.3

Options I set where:
- Language: Swift
- Interface: SwiftUI
- Testing System: None
- Storage: None


## Created a Git checkpoint

I initialized a Git repository with:
```bash
git init
```

Then, I create a `.gitignore` file so that Git doesn't track local Xcode user data:
```
FocusFlow.xcodeproj/project.xcworkspace/
FocusFlow.xcodeproj/xcuserdata/
```

And then, I ran these commands:
```bash
git add .
git commit -m "chore: create initial SwiftUI project"
git add remote origin https://github.com/NgoniAppleDev/FocusFlow.git
```

After that, I opened my project in GitHub Desktop, and then pushed my changes to the remote repository.
