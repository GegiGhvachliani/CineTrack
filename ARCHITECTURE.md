# CineTrack Architecture / CineTrack-ის არქიტექტურა

This document describes CineTrack as an application: how its features are separated, how dependencies are composed, and how data reaches the UI.

ეს დოკუმენტი აღწერს CineTrack-ის არქიტექტურას აპლიკაციის ჭრილში: როგორ არის დაყოფილი ფუნქციები, როგორ ეწყობა დამოკიდებულებები და როგორ აღწევს მონაცემი UI-მდე.

---

## English

### Overview

CineTrack is a modular iOS application for discovering movies and actors, reading entertainment news, watching trailers, and maintaining a personal library. It combines UIKit navigation with SwiftUI feature screens and uses a feature-first, Clean Architecture-inspired design.

The aim is practical separation of responsibility:

- UI code renders state and forwards user actions.
- View models own screen state, presentation decisions, and user intent.
- Use cases express application operations.
- Repositories isolate business logic from API, Firebase, and persistence details.
- Coordinators own navigation.
- Factories and the app dependency container create concrete objects.

### System map

```text
App
├── AppCoordinator
├── MainTabBarCoordinator
├── AppDIContainer
├── Features
│   ├── Home, Search, Profile
│   ├── Authentication, Onboarding
│   ├── MovieDetails, ActorDetails, NewsDetails
│   └── SeeAll, VideosList
├── SharedKit
│   ├── SharedCore, SharedNetworking
│   ├── SharedStorage, SharedAuth
│   └── LibraryDomain, LibraryData
├── TMDBData and NewsData
└── DesignSystem
```

`AppCoordinator` starts one of three flows: onboarding, authentication, or the main application. `MainTabBarCoordinator` creates the Home, Search, and Profile navigation stacks, then routes into details, playlists, and full-list screens.

### Feature modules

Features are local Swift packages. Where relevant, each feature is separated into these targets:

| Target | Responsibility |
| --- | --- |
| `FeatureDomain` | Entities, repository contracts, use-case contracts, and use cases. |
| `FeatureData` | Repository implementations, DTOs, mappers, and provider-specific adaptation. |
| `FeaturePresentation` | SwiftUI views, view models, screen resources, and feature coordinators. |
| `FeaturePresentationAPI` | Public factory, coordinator, and routing contracts exposed to the app or other features. |
| `FeatureAssembly` | Construction of repositories, use cases, view models, views, and coordinators. |

This keeps a feature self-contained without forcing every small type to have a protocol. Contracts are introduced at meaningful replacement boundaries: view models, use cases, repositories, factories, coordinators, and external services.

### Data and dependency flow

```text
User action
  → SwiftUI View
    → ViewModel protocol
      → Use-case protocol
        → Repository protocol
          → API client / Firestore / Firebase Auth
```

The call flow is not the same as implementation ownership. The Domain layer declares a repository protocol; the Data layer conforms to it. A view model can therefore fetch or save something without knowing whether the data comes from TMDB, NewsAPI, Firestore, or a future replacement.

For example, saving a movie follows this shape:

```text
MovieDetailsView
  → MovieDetailsViewModel
    → AddWatchlistedMovieUseCase
      → WatchlistRepository
        → RemoteDocumentStore (Firestore)
```

### Shared capabilities

`SharedKit` contains cross-feature capabilities rather than allowing one feature to become a dependency for every other feature.

| Module | Purpose |
| --- | --- |
| `SharedCore` | Shared entities, constants, and coordinator abstractions. |
| `SharedNetworking` | API request and API-client abstractions, with a URLSession implementation. |
| `SharedStorage` | Remote document-store abstraction and Firestore implementation. |
| `SharedAuth` | Account-session abstraction and Firebase-backed session. |
| `LibraryDomain` | Contracts and use cases for watchlist, favourite actors, and recently viewed content. |
| `LibraryData` | Firestore-backed implementations and DTOs for the personal library. |

The personal library is intentionally shared. Home, Search, Profile, MovieDetails, and ActorDetails can use the same watchlist, favourites, and history logic without importing one another or duplicating repositories.

### Design and presentation

`DesignSystem` centralises semantic colours, spacing, typography, image handling, and reusable UI components. Feature-specific strings and complex screen sections remain inside their respective feature packages. This preserves a consistent visual language while keeping a feature in control of its own content and layout.

Views use generic view-model protocols rather than concrete view-model classes. View models use `Observation` for state, and Search uses Combine where input debouncing is needed. View models do not call repositories, URLSession, Firestore, or navigation controllers directly.

### Composition and navigation

`AppDIContainer` owns shared concrete infrastructure:

```text
AppConfiguration
URLSessionAPIClient
FirestoreClient
FirebaseUserSession
```

It passes only the required dependencies to feature factories. A feature factory assembles its repository, use cases, view model, SwiftUI view, and coordinator. Concrete types are known at this composition boundary; feature presentation code depends on protocols instead.

Coordinators receive navigation intent from a feature and create or present the next screen. This prevents view models from knowing about `UINavigationController`, `UIHostingController`, tab selection, or presentation mechanics.

### Important application decisions

- **Search consistency:** Debouncing, request-generation checks, cancellation, and ID-based pagination merging prevent stale responses from overwriting newer results.
- **Personalisation:** Watchlist, favourites, and history use a single shared domain/data implementation instead of copies inside Home or detail features.
- **Authentication isolation:** Firebase Auth and Google Sign-In are accessed through service and repository adapters, not from presentation code.
- **Media flows:** Movie and actor details can route to video playlists while retaining the originating context for correct back navigation.
- **Adaptive UI:** Semantic design tokens support light and dark appearance without scattering fixed colours through feature views.

### Architecture rules

- Domain code must not import UI, networking, storage, authentication, or data modules.
- Presentation code must not import data, storage, networking, Firebase, or authentication implementations.
- View models receive use-case protocols; they do not construct use cases or access repositories/providers directly.
- Repositories conform to Domain contracts and hide third-party/provider details.
- Factories and `AppDIContainer` are the permitted composition roots for concrete dependencies.

The rules are checked with:

```bash
ruby Scripts/check_architecture.rb
```

This is a focused static guard, not a replacement for unit tests, UI tests, or manual testing.

---

## ქართული

### მიმოხილვა

CineTrack არის მოდულური iOS აპლიკაცია ფილმებისა და მსახიობების აღმოსაჩენად, გასართობი სიახლეების სანახავად, ტრეილერების საყურებლად და პირადი კინობიბლიოთეკის სამართავად. იგი აერთიანებს UIKit-ზე დაფუძნებულ ნავიგაციასა და SwiftUI-ის feature ეკრანებს; არქიტექტურა feature-first და Clean Architecture-inspired მიდგომას მიჰყვება.

მიზანია პასუხისმგებლობების პრაქტიკული გამიჯვნა:

- UI აჩვენებს state-ს და გადასცემს მომხმარებლის მოქმედებებს.
- ViewModel მართავს ეკრანის state-ს, პრეზენტაციის გადაწყვეტილებებსა და მომხმარებლის განზრახვას.
- UseCase აღწერს აპლიკაციის კონკრეტულ ოპერაციას.
- Repository ბიზნესლოგიკას აშორებს API, Firebase და persistence დეტალებს.
- Coordinator მართავს ნავიგაციას.
- Factory და აპის dependency container ქმნის კონკრეტულ ობიექტებს.

### სისტემის რუკა

```text
App
├── AppCoordinator
├── MainTabBarCoordinator
├── AppDIContainer
├── Features
│   ├── Home, Search, Profile
│   ├── Authentication, Onboarding
│   ├── MovieDetails, ActorDetails, NewsDetails
│   └── SeeAll, VideosList
├── SharedKit
│   ├── SharedCore, SharedNetworking
│   ├── SharedStorage, SharedAuth
│   └── LibraryDomain, LibraryData
├── TMDBData და NewsData
└── DesignSystem
```

`AppCoordinator` იწყებს onboarding, authentication ან მთავარ flow-ს. `MainTabBarCoordinator` ქმნის Home, Search და Profile ჩანართების დამოუკიდებელ navigation stack-ებს, შემდეგ კი მართავს დეტალების, playlist-ისა და სრული სიების ეკრანებზე გადასვლას.

### Feature მოდულები

Feature-ები ადგილობრივი Swift Package-ებია. საჭიროებისამებრ, თითოეული Feature იყოფა შემდეგ target-ებად:

| Target | პასუხისმგებლობა |
| --- | --- |
| `FeatureDomain` | Entities, repository კონტრაქტები, use-case კონტრაქტები და use case-ები. |
| `FeatureData` | Repository-ის იმპლემენტაციები, DTO-ები, mapper-ები და provider-ის ადაპტაცია. |
| `FeaturePresentation` | SwiftUI View-ები, ViewModel-ები, ეკრანის რესურსები და feature coordinator-ები. |
| `FeaturePresentationAPI` | აპისა და სხვა Feature-ებისთვის გამოტანილი factory/coordinator/routing კონტრაქტები. |
| `FeatureAssembly` | Repository, UseCase, ViewModel, View და Coordinator ობიექტების აწყობა. |

ასეთი დაყოფა Feature-ს დამოუკიდებელს ტოვებს, მაგრამ ყველა მცირე ტიპისთვის ხელოვნურად პროტოკოლს არ ქმნის. კონტრაქტი იქმნება მხოლოდ რეალურ შესაცვლელ საზღვარზე: ViewModel, UseCase, Repository, Factory, Coordinator და გარე სერვისი.

### მონაცემისა და დამოკიდებულებების ნაკადი

```text
მომხმარებლის მოქმედება
  → SwiftUI View
    → ViewModel protocol
      → Use-case protocol
        → Repository protocol
          → API client / Firestore / Firebase Auth
```

ეს არის გამოძახების ნაკადი და არა იმპლემენტაციის მფლობელობის მიმართულება. Repository-ის პროტოკოლს Domain layer აცხადებს, Data layer კი მას ახორციელებს. ამიტომ ViewModel-ს შეუძლია მოითხოვოს მონაცემის მიღება ან შენახვა ისე, რომ არ იცოდეს, მონაცემი TMDB-დან, NewsAPI-დან, Firestore-დან თუ სხვა მომავალი წყაროდან მოდის.

მაგალითად, ფილმის watchlist-ში დამატება ასე მიედინება:

```text
MovieDetailsView
  → MovieDetailsViewModel
    → AddWatchlistedMovieUseCase
      → WatchlistRepository
        → RemoteDocumentStore (Firestore)
```

### საერთო შესაძლებლობები

`SharedKit` ინახავს იმ შესაძლებლობებს, რომლებიც რამდენიმე Feature-ს სჭირდება, რათა ერთი Feature სხვა Feature-ების საერთო დამოკიდებულებად არ იქცეს.

| მოდული | დანიშნულება |
| --- | --- |
| `SharedCore` | საერთო entities, კონსტანტები და coordinator აბსტრაქციები. |
| `SharedNetworking` | API request/API-client აბსტრაქციები და URLSession იმპლემენტაცია. |
| `SharedStorage` | Remote document store აბსტრაქცია და Firestore იმპლემენტაცია. |
| `SharedAuth` | Account session აბსტრაქცია და Firebase-ზე დაფუძნებული session. |
| `LibraryDomain` | Watchlist, საყვარელი მსახიობებისა და ნახვის ისტორიის კონტრაქტები და use case-ები. |
| `LibraryData` | პირადი ბიბლიოთეკის Firestore-ზე დაფუძნებული იმპლემენტაციები და DTO-ები. |

პირადი ბიბლიოთეკა განზრახ არის საერთო. Home, Search, Profile, MovieDetails და ActorDetails ერთსა და იმავე Watchlist/Favourites/History ლოგიკას იყენებს, ერთმანეთის იმპორტისა და repository-ების დუბლირების გარეშე.

### დიზაინი და პრეზენტაცია

`DesignSystem` აერთიანებს semantic ფერებს, spacing-ს, typography-ს, გამოსახულებების მართვასა და განმეორებით UI კომპონენტებს. Feature-ის სპეციფიკური ტექსტები და რთული სექციები კი საკუთარ პაკეტში რჩება. შედეგად, აპს თანმიმდევრული ვიზუალური ენა აქვს, ხოლო Feature საკუთარ კონტენტსა და layout-ს თავად მართავს.

View-ები concrete ViewModel კლასის ნაცვლად generic ViewModel protocol-ზე მუშაობენ. State-ისთვის ViewModel იყენებს `Observation`-ს, ხოლო Search იყენებს Combine-ს, როცა ტექსტის debounce საჭიროა. ViewModel პირდაპირ არ იძახებს Repository-ს, URLSession-ს, Firestore-ს ან navigation controller-ს.

### Composition და ნავიგაცია

`AppDIContainer` ფლობს საერთო კონკრეტულ ინფრასტრუქტურას:

```text
AppConfiguration
URLSessionAPIClient
FirestoreClient
FirebaseUserSession
```

იგი feature factory-ს მხოლოდ საჭირო დამოკიდებულებებს გადასცემს. Factory აწყობს Repository-ს, UseCase-ებს, ViewModel-ს, SwiftUI View-სა და Coordinator-ს. კონკრეტული ტიპები ცნობილია ამ composition საზღვარზე, ხოლო Feature-ის პრეზენტაცია პროტოკოლებზეა დამოკიდებული.

Coordinator იღებს Feature-იდან ნავიგაციის განზრახვას და ქმნის ან აჩვენებს შემდეგ ეკრანს. ამიტომ ViewModel-ს არ სჭირდება `UINavigationController`-ის, `UIHostingController`-ის, tab selection-ის ან presentation მექანიკის ცოდნა.

### მნიშვნელოვანი გადაწყვეტილებები ამ აპისთვის

- **Search-ის თანმიმდევრულობა:** Debounce, request generation, cancellation და ID-ებით pagination merge ხელს უშლის ძველი პასუხის ახალი შედეგების გადაწერას.
- **Personalisation:** Watchlist, Favourites და History-ს აქვს ერთი საერთო Domain/Data იმპლემენტაცია Home-სა და detail feature-ებში ასლების ნაცვლად.
- **Authentication-ის იზოლირება:** Firebase Auth და Google Sign-In ხელმისაწვდომია service/repository adapter-ებით და არა presentation კოდიდან.
- **Media flow:** Movie/Actor details ეკრანები ვიდეოების playlist-ზე გადადის საწყისი კონტექსტის შენარჩუნებით, რაც სწორი back navigation-ისთვის საჭიროა.
- **Adaptive UI:** Semantic design token-ები უზრუნველყოფს light/dark appearance-ს ისე, რომ Feature View-ებში ფიქსირებული ფერები არ გაიფანტოს.

### არქიტექტურული წესები

- Domain კოდმა არ უნდა დააიმპორტოს UI, networking, storage, authentication ან Data module.
- Presentation კოდმა არ უნდა დააიმპორტოს Data, storage, networking, Firebase ან authentication იმპლემენტაციები.
- ViewModel იღებს UseCase protocol-ებს; ის თავად არ ქმნის UseCase-ს და Repository/provider-ს პირდაპირ არ იყენებს.
- Repository ასრულებს Domain კონტრაქტს და მალავს provider/third-party დეტალებს.
- Factory და `AppDIContainer` არის concrete dependency-ების ასაწყობად განკუთვნილი composition root.

წესები მოწმდება ამ ბრძანებით:

```bash
ruby Scripts/check_architecture.rb
```

ეს არის კონკრეტულ არქიტექტურულ წესებზე ორიენტირებული static check და არა unit/UI ტესტების ან ხელით შემოწმების ჩანაცვლება.
