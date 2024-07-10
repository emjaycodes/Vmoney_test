# Flutter Blog App

This is a Flutter application that allows users to view, create, update, and bookmark blog posts. The app uses GraphQL for data fetching and mutation, and Provider for state management.

## Features

- View a list of blog posts with random images
- Search blog posts by title
- Bookmark favorite blog posts
- Create new blog posts
- Update existing blog posts
- View detailed information about a blog post

## Getting Started

### Prerequisites

- Flutter SDK
- Dart
- A GraphQL server endpoint

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/flutter-blog-app.git
   cd flutter-blog-app
   
Install dependencies:


```dart
flutter pub get
```
Set up your GraphQL endpoint:

Replace the client initialization in your BlogProvider with your GraphQL server's endpoint.

```dart
final HttpLink httpLink = HttpLink('https://your-graphql-endpoint.com/graphql');
```
Run the app:

```dart
flutter run
```
