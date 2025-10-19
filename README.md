# WebView Playground

A development tool for web frontend developers to test and debug web pages in iOS WebView locally.

## Purpose

This iOS application is designed specifically for web frontend developers who need to test how their web applications behave in an iOS WebView environment. This is **not a production app** - it's a local development and testing tool.

## Features

### Configuration Options
- **Custom URL Input**: Load any web page by entering a URL
- **Preset URLs**: Quick access to common test pages (Apple, Google, JSFiddle)
- **Toggleable UI Elements**:
  - Navigation buttons (back, forward, reload)
  - URL bar
  - Console button
  - Dark theme support

### WebView Capabilities
- **Web Inspector Enabled**: Debug web pages using Safari's Web Inspector (`isInspectable = true`)
- **Navigation Controls**: Back, forward, and reload functionality
- **URL Tracking**: Real-time URL updates as you navigate
- **Theme Support**: Toggle between light and dark themes
- **Loading Indicator**: Visual feedback during page loads

## Requirements

- **Xcode**: 15.0 or later
- **iOS**: 17.0 or later
- **macOS**: Required for running Xcode and iOS Simulator

## How to Run

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd WebViewPlayground
   ```

2. Open the project in Xcode:
   ```bash
   open WebViewPlayground.xcodeproj
   ```

3. Select your target device (Simulator or physical iOS device)

4. Build and run the project (⌘ + R)

## Using the App

1. **Initial Configuration Screen**:
   - Enter a URL or select a preset
   - Configure which UI elements to display
   - Toggle dark theme if needed
   - Tap "Open" to launch the WebView

2. **WebView Screen**:
   - Use navigation buttons to move back/forward
   - Enter new URLs in the URL bar (if enabled)
   - Tap "Back to setting" to return to configuration

3. **Debugging with Web Inspector**:
   - Run the app on a Simulator or physical device
   - Open Safari on your Mac
   - Go to Develop > [Your Device] > WebView Playground
   - Use Safari's developer tools to inspect and debug

## Project Structure

```
WebViewPlayground/
├── WebViewPlaygroundApp.swift      # App entry point
├── ContentView.swift               # Main view controller
├── InitialConfigView.swift         # Configuration screen
├── WebViewScreen.swift             # WebView display screen
├── WebView.swift                   # Custom WebView implementation
└── Persistence.swift               # Core Data persistence
```

## Key Implementation Details

- **WKWebView**: Uses WebKit's `WKWebView` for rendering web content
- **SwiftUI**: Built entirely with SwiftUI for modern iOS development
- **Inspection Enabled**: `webView.isInspectable = true` allows Safari Web Inspector connection
- **Theme Support**: WebView respects system dark/light mode via `overrideUserInterfaceStyle`

## License

This is a development tool intended for local use only.
