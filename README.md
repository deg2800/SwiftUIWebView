
# SwiftUIWebView

SwiftUIWebView is a Swift package that provides a customizable, easy-to-use `WebView` for SwiftUI applications. It includes bound properties to manage navigation, loading state, and page title within your SwiftUI views.

## Installation

1. Open your project in Xcode.
2. Go to **File > Swift Packages > Add Package Dependency**.
3. Enter the repository URL: `https://github.com/deg2800/SwiftUIWebView.git`.
4. Select the latest version and add it to your project.

Once installed, import `SwiftUIWebView` in your Swift files:

```swift
import SwiftUIWebView
```

## Usage

### Basic Example

To create a basic web view, use `WebViewModel` to manage the URL, page title, and navigation actions. Here’s an example `ContentView` to get started:

```swift
import SwiftUI
import SwiftUIWebView

struct ContentView: View {
    @StateObject private var webViewModel = WebViewModel(url: URL(string: "http://example.com")!)

    var body: some View {
        VStack {
            // Display WebView
            WebView(model: webViewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Navigation and Status Controls
            HStack {
                Button(action: { webViewModel.goBack() }) {
                    Image(systemName: "arrow.left")
                }
                .disabled(!(webViewModel.backForwardList?.backList.isEmpty ?? true))

                Button(action: { webViewModel.goForward() }) {
                    Image(systemName: "arrow.right")
                }
                .disabled(!(webViewModel.backForwardList?.forwardList.isEmpty ?? true))

                Button(action: { webViewModel.reload() }) {
                    Image(systemName: "arrow.clockwise")
                }
                
                Spacer()

                Text(webViewModel.pageTitle)
                    .font(.caption)
                    .lineLimit(1)
                
                Spacer()

                Toggle("Loading", isOn: $webViewModel.isLoading)
                    .disabled(true) // Display-only
            }
            .padding()
        }
        .navigationTitle("Basic WebView Example")
    }
}
```

### WebViewModel Properties and Methods

The `WebViewModel` class provides several properties and methods for interacting with the `WebView`:

- **Properties**
  - `url`: The URL to load in the `WebView`.
  - `pageTitle`: The title of the current page.
  - `action`: Control navigation actions (`reload`, `stop`, `back`, `forward`).
  - `backForwardList`: List of available back and forward pages.
  - `isLoading`: Indicates if the `WebView` is loading content.

- **Methods**
  - `goBack()`: Navigate to the previous page.
  - `goForward()`: Navigate to the next page.
  - `reload()`: Reload the current page.
  - `stopLoading()`: Stop loading the current page.

### Customization

You can use `WebViewModel` to customize behavior and manage state. This model allows you to control navigation and respond to changes in loading state, making it easy to integrate within a SwiftUI app.
