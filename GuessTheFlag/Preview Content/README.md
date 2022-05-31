#  Buttons
VStack {
    Button("Button 1") { }
        .buttonStyle(.bordered)
    Button("Button 2", role: .destructive) { }
        .buttonStyle(.bordered)
    Button("Button 3") { }
        .buttonStyle(.borderedProminent)
    Button("Button 4", role: .destructive) { }
        .buttonStyle(.borderedProminent)
}

## If you want to customize the colors used for a bordered button, use the tint() modifier like this:

Button("Button 3") { }
    .buttonStyle(.borderedProminent)
    .tint(.mint)
    
## If you want something completely custom, you can pass a custom label using a second trailing closure:
Button {
    print("Button was tapped")
} label: {
    Text("Tap me!")
        .padding()
        .foregroundColor(.white)
        .background(.red)
}

## Image type
SwiftUI has a dedicated Image type for handling pictures in your apps, and there are three main ways you will create them:

Image("pencil") will load an image called “Pencil” that you have added to your project.
Image(decorative: "pencil") will load the same image, but won’t read it out for users who have enabled the screen reader. This is useful for images that don’t convey additional important information.
Image(systemName: "pencil") will load the pencil icon that is built into iOS. This uses Apple’s SF Symbols icon collection, and you can search for icons you like – download Apple’s free SF Symbols app from the web to see the full set.

## buttons can have any kind of views inside them
Button {
    print("Edit button was tapped")
} label: { 
    Image(systemName: "pencil")
}

or (both text and image)

Button {
    print("Edit button was tapped")
} label: {
    Label("Edit", systemImage: "pencil")
}

// That will show both a pencil icon and the word “Edit” side by side, which on the surface sounds exactly the same as what we’d get by using a simple HStack. However, SwiftUI is really smart: when we use a label it will automatically decide whether to show the icon, the text, or both depending on how they are being used in our layout. This makes Label a fantastic choice in many situations, as you’ll see.

# tip
If you find that your images have become filled in with a color, for example showing as solid blue rather than your actual picture, this is probably SwiftUI coloring them to show that they are tappable. To fix the problem, use the renderingMode(.original) modifier to force SwiftUI to show the original image rather than the recolored version.

# alert messages
struct ContentView: View {
    @State private var showingAlert = false

    var body: some View {
        Button("Show Alert") {
            showingAlert = true
        }
        .alert("Important message", isPresented: $showingAlert) {
            Button("OK") { }
        }
    }
}

.alert("Important message", isPresented: $showingAlert) {
    Button("Delete", role: .destructive) { }
    Button("Cancel", role: .cancel) { }
}
Button("Show Alert") {
    showingAlert = true
}
.alert("Important message", isPresented: $showingAlert) {
    Button("OK", role: .cancel) { }
} message: {
    Text("Please read this.")
}
