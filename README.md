# CineTrack

**CineTrack** is a modular iOS application for discovering films and people, following entertainment news, watching trailers, and maintaining a personal movie library. It is built as a UIKit + SwiftUI codebase with an explicit focus on dependency direction, testability, and keeping feature boundaries clear.

> The project is a portfolio-style reference for a scalable iOS architecture—not only an app UI.

## What it does

- Browse curated movie content, people, and entertainment news.
- Search movies and actors, including advanced discovery filters and pagination.
- View movie and actor details, media, credits, and video playlists.
- Save movies to a watchlist, favourite actors, and revisit recently viewed items.
- Sign in with Firebase Authentication and Google Sign-In; persist account data with Cloud Firestore.
- Complete an onboarding flow and use the app in light or dark appearance.

## Technology

| Area | Choice |
| --- | --- |
| Platform | iOS 17+, Swift 6.3 packages, Xcode 26+ |
| UI | UIKit navigation and SwiftUI feature views using Observation |
| Concurrency | Swift Concurrency (`async`/`await`) and Combine where debouncing is useful |
| Dependencies | Swift Package Manager |
| Backend | Firebase Authentication and Cloud Firestore |
| External data | [TMDB API](https://developer.themoviedb.org/) and [NewsAPI](https://newsapi.org/) |
| Supporting libraries | Firebase iOS SDK, Google Sign-In, Kingfisher, SwiftLint |

## Architecture at a glance

CineTrack follows a feature-first, Clean Architecture-inspired modular design. A feature owns its presentation and business rules; shared capabilities have their own modules instead of being hidden inside an arbitrary feature.

```text
App
├── AppCoordinator + MainTabBarCoordinator
├── AppDIContainer
├── Features
│   ├── Home, Search, Profile, Authentication, Onboarding
│   ├── MovieDetails, ActorDetails, NewsDetails
│   └── SeeAll, VideosList
├── SharedKit
│   ├── SharedCore, SharedNetworking, SharedStorage, SharedAuth
│   └── LibraryDomain, LibraryData
├── TMDBData and NewsData
└── DesignSystem
```

Each feature is split into deliberately narrow targets where applicable:

```text
FeatureDomain            entities, repository contracts, use cases
FeatureData              DTOs, mappers, repository implementations
FeaturePresentation      views, view models, screen resources, coordinators
FeaturePresentationAPI   public factory/coordinator/routing contracts
FeatureAssembly          composition of a feature's concrete dependencies
```

The invocation path is:

```text
View → ViewModel protocol → Use-case protocol → Repository protocol → provider/client
```

The arrows describe the call path, not a reversal of dependency ownership: the Domain layer declares repository contracts, while the Data layer implements them. This keeps UI state and business rules independent of URLSession, Firestore, and concrete API providers.

### Composition and navigation

`AppDIContainer` creates the shared infrastructure once—configuration, API client, Firestore store, and account session—and passes it to feature factories. A factory assembles the repository, use cases, view model, and view for its feature. This gives composition roots a place to know concrete types, while a view model only receives the use-case protocols it needs.

`AppCoordinator` selects the onboarding, authentication, or main flow. `MainTabBarCoordinator` owns the three root navigation stacks and routes into detail, playlist, and "see all" flows. Views and view models express an intent; coordinators create and present view controllers. No navigation-controller code belongs in view models.

### Shared library boundaries

Watchlist, favourite actors, and recently viewed items are intentionally not owned by `Home`, `Search`, or a detail screen. They live in `LibraryDomain` and `LibraryData`, which are targets inside the local `SharedKit` package. This avoids duplicated collection logic and lets any feature use the same contracts without depending on another feature’s implementation.

### Principles applied

- **Dependency inversion:** Domain protocols isolate use cases and repositories from external providers.
- **Single responsibility:** Views render; view models manage presentation state; use cases express one operation; repositories adapt data sources; coordinators navigate; assemblies compose.
- **Protocol-oriented boundaries:** Feature factories, coordinators, view models, repositories, and use cases have explicit contracts where substitution matters.
- **Feature isolation:** Presentation targets do not import data/storage/networking implementation modules; Domain targets do not import UI or data modules.
- **Reusable design:** Colours, spacing, typography, assets, and common components are centralised in `DesignSystem`.
- **Predictable asynchronous state:** Search protects against stale concurrent responses, debounces input, and merges paginated results by identity.

The repository also includes an architecture guard script that checks the important import and responsibility rules:

```bash
ruby Scripts/check_architecture.rb
```

## Getting started

### Requirements

- macOS with Xcode 26 or newer
- iOS 17.0 deployment target
- A TMDB read access token
- A NewsAPI key
- A Firebase project configured for Authentication, Firestore, and Google Sign-In

### Configuration

1. Clone the repository and open `CineTrack/CineTrack.xcodeproj` in Xcode.
2. Copy the secrets template:

   ```bash
   cp Config/Secrets.example.plist CineTrack/CineTrack/App/Config/Secrets.plist
   ```

3. Set `TMDB_ACCESS_TOKEN` and `NEWS_API_KEY` in `Secrets.plist`.
4. Replace `CineTrack/CineTrack/App/Config/GoogleService-Info.plist` with the configuration file for your Firebase project, then enable the required authentication providers and create Firestore rules suitable for your environment.
5. Resolve Swift packages when prompted, select the `CineTrack` scheme, and run on an iOS 17+ simulator or device.

`Secrets.plist` is excluded from version control. Never commit live API keys.

## Development checks

```bash
# Validates the architectural rules and package paths.
ruby Scripts/check_architecture.rb

# Builds the iOS application without code signing.
xcodebuild -project CineTrack/CineTrack.xcodeproj \
  -scheme CineTrack \
  -sdk iphoneos \
  -destination 'generic/platform=iOS' \
  CODE_SIGNING_ALLOWED=NO \
  build
```

Xcode also runs SwiftLint when it is installed on the machine. The project contains unit-test targets for the app and individual Swift packages, plus UI-test targets for the application flow.

## Project structure

```text
CineTrack/
├── CineTrack/
│   ├── App/                    application lifecycle, DI, root coordinators
│   ├── Packages/
│   │   ├── Features/           independently assembled user-facing features
│   │   ├── SharedKit/          shared domain, networking, storage, auth, library
│   │   ├── TMDBData/           TMDB request, DTO, mapping, repository code
│   │   ├── NewsData/           NewsAPI request, DTO, mapping, repository code
│   │   └── DesignSystem/       semantic tokens and reusable UI components
│   └── Resources/
├── Config/Secrets.example.plist
├── Scripts/check_architecture.rb
├── ARCHITECTURE.md
└── APPEARANCE.md
```

## Credits

Movie metadata and imagery are provided by [TMDB](https://www.themoviedb.org/). News content is supplied through [NewsAPI](https://newsapi.org/). This product uses the TMDB API but is not endorsed or certified by TMDB.
