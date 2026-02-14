# Eco-Tracker

Eco-Tracker is a Flutter application designed to help users track their eco-friendly activities, calculate their CO2 impact, and visualize their contribution to a greener planet.

## Features

- **Activity Tracking**: Log activities in transport, food, energy, and waste categories.
- **CO2 Calculation**: Instant feedback on CO2 saved based on your activities.
- **Visual Dashboard**: Weekly charts and total savings overview.
- **Localization**: Support for English, Spanish, and French.
- **Theming**: Light and Dark mode support.
- **Mock Authentication**: Simple login/logout flow for demonstration.

## Prerequisites

Before you begin, ensure you have the following installed:
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (Version 3.6.0 or higher)
- [Dart SDK](https://dart.dev/get-dart)

## Installation

1.  **Clone the repository:**
    ```bash
    git clone <repository_url>
    cd EcoTracker
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Environment Setup:**
    Create a file named `env.json` in the root directory (same level as `pubspec.yaml`) if it doesn't exist. Add the following keys (replace with your actual keys or placeholders for testing):
    ```json
    {
        "SUPABASE_URL": "YOUR_SUPABASE_URL",
        "SUPABASE_ANON_KEY": "YOUR_SUPABASE_ANON_KEY",
        "OPENAI_API_KEY": "YOUR_OPENAI_API_KEY",
        "GEMINI_API_KEY": "YOUR_GEMINI_API_KEY",
        "ANTHROPIC_API_KEY": "YOUR_ANTHROPIC_API_KEY",
        "PERPLEXITY_API_KEY": "YOUR_PERPLEXITY_API_KEY"
    }
    ```
    *Note: For basic UI testing with mock data, dummy values may suffice if backend services aren't fully integrated.*

## Running the App

To run the application on your connected device or emulator:

```bash
flutter run
```

## Testing Instructions

### Automated Tests
Run the unit and widget tests using:
```bash
flutter test
```

### Manual Verification Steps

Follow these steps to verify the core functionality of the app:

#### 1. Authentication (Mock)
- **Launch the App**: Ensure the app starts on the Login screen (if not logged in).
- **Login**: Tap the "Login" button. You should be redirected to the main dashboard.
- **Logout**: Navigate to the Profile/Settings section and tap "Logout". Confirm you are returned to the Login screen.

#### 2. Dashboard & Home
- **View Dashboard**: Check that the dashboard displays your "Total CO2 Saved" and weekly progress chart.
- **Check Chart**: Verify the chart renders bars representing daily data.

#### 3. Activity Logging
- **Navigate to Add Activity**: Go to the "Tips" or "Log Activity" section (depending on current UI navigation).
- **Log Transport**: Select "Transport". Enter a distance (e.g., 10km). Submit.
    - *Verify*: Check if a new entry appears in your history/logs with correct CO2 calculation (approx 0.15kg * km).
- **Log Food**: Select "Food". Enter number of meals (e.g., 1). Submit.
    - *Verify*: Check for "Plant-Based Meal" log.
- **Log Energy**: Select "Energy". Enter hours (e.g., 5). Submit.
    - *Verify*: Check for "Energy Savings" log.
- **Log Waste**: Select "Waste". Enter weight (e.g., 2kg). Submit.
    - *Verify*: Check for "Recycling" log.

#### 4. Features & Settings
- **Theme Toggle**: Switch between Dark and Light mode in settings. Verify the UI colors update immediately.
- **Localization**: Change the language (e.g., to Spanish). Verify that text elements (headings, buttons) translate correctly.

## Project Structure
- `lib/`: Contains the main source code.
    - `main.dart`: Entry point.
    - `core/`: Core utilities, theme, and data layers (MockDatabase).
    - `presentation/`: UI screens and widgets.
    - `widgets/`: Reusable widgets.
- `test/`: Unit and widget tests.
