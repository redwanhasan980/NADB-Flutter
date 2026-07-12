# Quiz App Improvements

## 1. Runnable Web Demo and Local Auth

- Added a Flutter web runner so the app can launch in Chrome from this checkout.
- Replaced the missing Firebase startup dependency with a local demo auth flow.
- Adjusted package constraints to match the installed Flutter/Dart SDK.
- Updated the smoke test so it verifies the quiz app login screen instead of the default counter app.

## 2. Customizable Quiz Start

- Added category and difficulty selectors on the home screen.
- Filtered the local Flutter question bank based on the selected settings.
- Passed a typed `QuizSettings` object through the router so the quiz screen receives the selected title and question set.

## 3. Better Quiz-Taking Feedback

- Added a live progress panel with question count and current score.
- Added category, difficulty, and points chips to each question.
- Added a skip action for unanswered questions.
- Shows the explanation immediately after an answer is selected.

## 4. Persistent Best Score and Attempts

- Added `shared_preferences` storage for local quiz stats.
- Records every completed quiz attempt from the result screen.
- Tracks the best score by percentage and score.
- Shows best score and total attempts in the home header.

## 5. Result Screen Retake Flow

- Added a `Retake Quiz` action that restarts the same question set.
- Replaced stack popping with router-safe navigation back to home.
- Cleaned the shared result message so it works consistently across platforms.

Verification:

```powershell
flutter pub get
flutter analyze
flutter test
flutter build web
```
