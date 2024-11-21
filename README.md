# State Management and Stack Navigation with WebView in Flutter

This aplication combines page-based navigation and a web browsing experience with persistent state. It features a simple and efficient interface to interact with content and URLs in a WebView, alongside an initial screen that displays configurable options.

## 📋 Features

- Dynamic Navigation:
    - Switches between screens using IndexedStack.
    - Efficient navigation between the home screen and the WebView.

- WebView with Persistent State:
    - Displays web pages in a WebView widget.
    - Maintains the last selected URL and handles loading states.

- Home Screen:
    - Displays a list of options with images and names, where each option navigates to a different URL in the WebView.

- Pull to Refresh:
    - Implements a refresh controller for WebView to reload content.


## ⚙️ Setup and Installation

To get started with this project, follow these steps:

### Prerequisites

1. ***Flutter***: Make sure you have Flutter installed on your machine. You can follow the instructions on the official Flutter website to install it.
2. ***Dependencies***: This project uses the flutter_inappwebview package for displaying web content. Ensure that the necessary dependencies are added to your pubspec.yaml file.

#### Installation

1. Clone the repository:
```bash
git clone https://github.com/your-username/empilhamento.git 
```

2. Navigate to the project directory:
```bash
cd empilhamento
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## 💡 How it Works

### 1. CoreScreen - ```CoreScreen.dart```

- Navigation: CoreScreen serves as the main screen of the app, which contains two child screens, the Home Screen and the WebView Screen. It utilizes a ValueNotifier<int> to switch between these screens.

- State Management: It uses a CoreStore to manage navigation state. The CoreStore provides methods for changing the active screen and updating the last selected URL.
```dart
ValueNotifier<int> screenIndex = ValueNotifier<int>(0);
```
The screen index determines which screen to display, while the URL of the last selected option is stored in a ValueNotifier<String>.

### 2. HomeScreen - ```HomeScreen.dart```
- Options Display: The HomeScreen displays a list of items (like web page links) with their corresponding images. Each item, when tapped, updates the current URL and navigates to the WebView screen.

- HomeStore: This class manages the logic for handling items on the home screen, including getting the option's name, image, and URL.
```dart
void goToWebView(int index) async {
  String newUrl = optionUrl(index);
  coreStore.urlUpdate(newUrl);
  coreStore.navigate();
}
```

### 3. WebViewScreen - ```WebViewScreen.dart```

- WebView Integration: The WebView screen uses the flutter_inappwebview package to display web pages. It manages the loading state and provides a refresh functionality with a pull-to-refresh controller.

- WebviewStore: This store is responsible for managing the WebView's state, such as handling URL loading, managing the refresh controller, and showing the loading indicator during page load.

```dart
ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
```

- URL Handling: The WebView screen listens for URL updates from the HomeScreen and loads the new URL when the user navigates.


### 4. State Management - ```CoreStore.dart```
- CoreStore: Manages the main application state, including screen navigation and the last selected URL.

```dart
void navigate() {
  switch (screenIndex.value) {
    case 0:
      screenIndex.value++;
      break;
    case 1:
      screenIndex.value--;
      break;
  }
  notifyListeners();
}
```


## 🛠️ Technologies Used

- Flutter: The main framework for building the app.
- flutter_inappwebview: Used for embedding WebView functionality.
- Provider: Manages state in the app (via ChangeNotifier and ValueNotifier).
- Dart: The programming language used to write the app.


## 🏗️ Contributing

Contributions to the project are welcome! If you want to contribute, please fork the repository, create a new branch, and submit a pull request with your changes.