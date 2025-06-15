# Project Architecture Explanation

## Overview
This project implements a **modular, layered architecture** for a Flutter movie app. The design follows Clean Architecture and best practices for separation of concerns, testability, and scalability.

---

## Purpose & Rationale
The main purpose of this architecture is to create a robust, maintainable, and scalable Flutter application that is easy to develop, test, and extend. By separating the application into distinct layers and modules, each with a clear responsibility, the codebase becomes easier to understand, modify, and grow over time. This approach is especially beneficial for teams, long-term projects, and apps that may evolve with new features or platforms.

---

## Layered Structure

### 1. Presentation Layer (`lib/app/`)
**Purpose:** Handles everything related to the user interface, user experience, and interaction logic.
- **Widgets**: Reusable UI components for consistency and DRY code
- **Themes**: Centralized styling and color schemes for a unified look
- **Modules**: Feature-based screens (dashboard, now playing, favorite, detail movie, onboarding/empty)
- **Routes**: Navigation configuration for easy, maintainable routing
- **State Management:** Uses GetX for efficient, reactive state and navigation

### 2. Data Layer (`lib/data/`)
**Purpose:** Abstracts and manages all data operations, whether from remote APIs or local storage.
- **api/**: Data models and interfaces exposed to the presentation layer
- **implementation/**: Local (e.g., Hive) and remote (API) data sources, mappers, and repository implementations
- **di/**: Dependency injection for the data layer, enabling flexible and testable code
- **Repositories:** Bridge between the presentation and data sources, enforcing a contract and hiding implementation details

### 3. Core Layer (`lib/core/`)
**Purpose:** Provides foundational utilities and cross-cutting concerns used by all other layers.
- **network/**: Network configuration, interceptors, and flavor (environment) management
- **exceptions/**: Custom exception types and error handling for robust error management
- **storage/**: Local storage abstraction for caching and persistence
- **Utilities:** Shared helpers, constants, and interfaces

---

## Folder Structure (Simplified)
```
lib/
├── app/
│   ├── common/       # Shared widgets, themes, routes
│   ├── module/       # Feature modules
│   └── ...
├── core/
│   ├── exceptions/
│   ├── network/
│   └── storage/
├── data/
│   ├── api/
│   ├── implementation/
│   └── di/
└── main.dart         # App entry point
```

---

## Advantages
- **Separation of Concerns:** Each layer has a single, well-defined responsibility, making the codebase easier to reason about and maintain.
- **Modularity:** Features and utilities are grouped logically, so new features can be added or existing ones modified with minimal risk of breaking unrelated code.
- **Testability:** Clear boundaries, interfaces, and dependency injection make unit and integration testing straightforward.
- **Reusability:** Common widgets, themes, and utilities are centralized, reducing duplication and promoting consistency.
- **Scalability:** The structure supports growth—new modules, data sources, or platforms can be integrated with minimal refactoring.
- **Team Collaboration:** Clear folder and responsibility separation allows multiple developers to work in parallel with minimal conflicts.
- **Maintainability:** Bugs and issues are easier to locate and fix thanks to the clear structure and single-responsibility approach.
- **Flexibility:** Swapping out implementations (e.g., changing API endpoints, local storage, or theming) is easier due to abstraction and dependency injection.

---

This architecture ensures a robust, maintainable, and scalable Flutter application, suitable for both small and large teams. By following these principles, the project is ready for rapid development, easy onboarding of new developers, and confident long-term evolution.

---

## Optional Improvements

### 1. No Caching Feature & API Response Limitations

#### a. No Caching Feature
Currently, the application **does not implement a caching mechanism** for data fetched from the API. Data is stored locally only to support **offline mode**—that is, local data is accessed only when the device has no internet connection. As long as the device is online, the app will **always make requests (hit) to the API** every time the user opens or refreshes data, even if the same data was previously retrieved.

**Consequences:**
- Higher bandwidth usage, as data is always fetched anew from the server.
- Slower response times, since the app always waits for an API response.
- Increased load on the API server.

#### b. API Response Limitations for Cache Validation
In addition to the lack of a caching feature, there is a limitation in the current API response: **there is no information provided to allow the app to validate whether local data is still valid or has expired**.

**Details:**
- There are no fields like `last_updated`, `ETag`, or `version` in the API response.
- Standard HTTP headers for cache validation such as `Cache-Control`, `Expires`, or `ETag` are not provided.
- There is no mechanism for automatic data invalidation from the server.

**Impact:**
- If caching were implemented, the app would not be able to ensure that local data is up-to-date, leading to the risk of showing stale information to users.
- The only possible cache validation strategy would be time-based (e.g., consider data expired after X minutes/hours), not based on the actual data status on the server.

**Summary:**  
The current application always fetches the latest data from the API on every user request and only uses local data when offline. Additionally, due to limitations in the API response, the app cannot optimally validate cached data. For future improvements, it is recommended to implement caching in the app and to adjust the API response to support cache validation (e.g., by adding a timestamp or ETag field).

### 2. Limitation: Cannot Determine Favorite Status in Movie Detail

When navigating from the Now Playing movie list to the detail movie screen, the application **cannot determine whether a movie is already in the user's favorites list**. This is because the current API response **does not include a flag or indicator showing the favorite status** for each movie.

**Root Cause:**
- The API does not provide a boolean flag or any field in the movie detail or list response that indicates if the movie is marked as favorite by the user.

**Impact:**
- Users do not see real-time favorite status on the movie detail page, which can lead to confusion or redundant actions (e.g., trying to add a movie that's already a favorite).

**Possible Mobile-side Improvement:**
- The mobile app could attempt to track favorite status locally (e.g., by maintaining a local list of favorite IDs and checking against it when opening the detail screen).
- **However, this introduces the risk of data inconsistency** between the local state on the device and the backend (BE), especially if the favorite list is modified from another device or via another API call.

**Recommendation:**
- For a robust solution, it is recommended that the API be enhanced to include a favorite status flag in the movie detail (and/or list) response.
- If mobile-side tracking is implemented as a temporary workaround, users and developers should be aware of the potential for data mismatch between local and backend data.

### 3. Unit Testing Scope

For this project, **unit tests are created only for the repository implementation classes**. This decision was made for reasons of simplicity and time efficiency.

**Rationale:**
- The repository layer is the most critical integration point between data sources (remote APIs, local storage) and the rest of the app, making it the highest-value target for unit testing.
- By focusing tests on repository implementations, we ensure that the core data-fetching and business logic are verified without the overhead of duplicating tests for other layers.
- Limiting the scope of tests allows for faster development and easier maintenance within project time constraints.

**Note:**
While broader test coverage (including data models, mappers, and API clients) is ideal for long-term robustness, this focused approach provides a practical balance between code quality and development speed for the current phase of the project.

### 4. Safe Storage of Sensitive Data in `network_flavor.dart`

Currently, sensitive information such as API keys and account IDs are stored directly in the file [`lib/app/network_flavor/network_flavor.dart`]. While this is convenient for development, it poses a security risk if the codebase is shared or published, as secrets can be exposed.

**Risks:**
- API keys and credentials may be leaked if the repository is made public or shared with unauthorized parties.
- Exposed secrets can lead to abuse, quota exhaustion, or unauthorized access to backend services.

**Recommended Improvements:**
- Move sensitive data to secure storage mechanisms (such as environment variables, encrypted files, or secret management services).
- Use a tool like [`flutter_dotenv`](https://pub.dev/packages/flutter_dotenv) to load secrets from a `.env` file that is excluded from version control.
- Never commit secrets directly to the repository; use placeholders or mock values in code, and document the need to provide real secrets securely.

By following these practices, you can help protect sensitive information and reduce the risk of accidental exposure.

### 5. Improved Loading State with Shimmer Effect

Currently, the loading state is handled with a basic indicator or placeholder. The user experience can be enhanced by implementing a **shimmering effect** (skeleton loading) during data fetches. This provides a more modern and visually appealing indication that content is loading, reducing perceived wait times and improving overall polish.

- **Recommendation:** Integrate a shimmer/skeleton loading package (such as [shimmer](https://pub.dev/packages/shimmer)) for movie lists, detail screens, and other data-heavy UI components.