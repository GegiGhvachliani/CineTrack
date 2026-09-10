# CineTrack — არქიტექტურა და რეფაქტორინგის სრული მიმოხილვა

განახლებულია: 2026-09-10.

ეს დოკუმენტი აერთიანებს წინა რეფაქტორინგს, News-ის ფოტოს შესწორებასა და Actor ფექიჯების გაერთიანებას: რა შეიცვალა, რატომ, რა დარჩა უცვლელი და რა შეზღუდვები აქვს მიმდინარე გადაწყვეტას. საწყისი შედარების წერტილია Git commit `0d0a1fc`; ცვლილებები სამუშაო ხეშია და ახალი commit არ შემიქმნია.

## 1. მთავარი შედეგი

Home გამოყენებულია ორგანიზებისა და წერის სტილის საფუძვლად. მისი პასუხისმგებლობების განაწილება გავავრცელე სხვა ეკრანებზე, თუმცა Home-შიც შევასწორე დუბლირება და აღმოჩენილი პრობლემები.

ძირითადი გამოძახების ჯაჭვია:

```text
View
  → ViewModelProtocol
    → UseCaseProtocol
      → RepositoryProtocol
        → პროვაიდერის პროტოკოლი
```

ეს არის გამოძახების ჯაჭვი და არა მოდულების import-ების მიმართულება: Repository-ის კონტრაქტს Domain განსაზღვრავს, ხოლო Data ამ კონტრაქტს ასრულებს. ViewModel-ს Data-ის იმპლემენტაციის ცოდნა არ სჭირდება.

რაც შეიცვალა:

- ViewModel-ებს დაემატა/შეუვსო საკუთარი პროტოკოლები; მთავარი Views მუშაობს generic ViewModel-ით, რომელიც ამ პროტოკოლს აკმაყოფილებს.
- Profile-ის ViewModel აღარ იღებს repository-ებს და აღარ ქმნის UseCase-ებს საკუთარ მეთოდებში.
- საერთო Watchlist/Favourites/RecentlyViewed კოდი გადავიდა LibraryDomain/LibraryData-ში.
- Coordinator/Factory/DI კონტრაქტები და დამოკიდებულებების აწყობა მოწესრიგდა.
- View-ების სექციები, ViewModel-ის extensions, Strings, MARK-ები და ფორმატირება გაერთიანდა.
- SeeAll დარჩა საერთო სიებისა და გალერეის ეკრანად.
- გასწორდა ძიების პარალელური მოთხოვნების მდგომარეობა, Firestore-ის ჩაწერის მოლოდინი და ნავიგაციის რამდენიმე პრობლემა.
- News-ის სურათები ახლა საბოლოო, ფიქსირებული სიმაღლის კონტეინერში იჭრება.

ყველა შეცვლილი ფაილი ახალ ლოგიკას არ შეიცავს: ცვლილებების დიდი ნაწილი ფოლდერების გადანაწილება, ფაილის გადარქმევა, imports, MARK-ები და ფორმატირებაა.

## 2. თითოეული შრის მოვალეობა

| შრე | რა ეკუთვნის | რა არ უნდა აკეთებდეს |
| --- | --- | --- |
| Domain | მოდელები, RepositoryProtocol, UseCaseProtocol და UseCase-ები | არ უნდა აგებდეს View-ს, URLSession-ს, Firestore-ს ან UIKit ნავიგაციას |
| Data | Repository-ის იმპლემენტაცია, DTO, Mapper, პროვაიდერთან ადაპტაცია | არ უნდა მართავდეს ეკრანის layout-ს ან ნავიგაციას |
| Presentation | ViewModel, View, სექციები, ეკრანის ტექსტები, Coordinator | ViewModel-მა არ უნდა გამოიძახოს Repository/API უშუალოდ |
| PresentationAPI | Factory/Coordinator/Routing კონტრაქტები | არ უნდა აწყობდეს კონკრეტულ Data იმპლემენტაციებს |
| Assembly | Repository-ების, UseCase-ების, ViewModel-ისა და View-ს აწყობა | არ უნდა იქცეს ბიზნესლოგიკის საცავად |
| AppDIContainer | საერთო კლიენტების, კონფიგურაციის, storage/session-ის დაკავშირება | Feature-ის ViewModel-ში არ უნდა გადავიდეს ობიექტების შექმნის ეს პასუხისმგებლობა |

Factory/Assembly-ში კონკრეტული კლასის შექმნა ნორმალურია. მაგალითად, `ProfileFactory` ქმნის `ProfileRepository`-ს, მაგრამ UseCase მას `ProfileRepositoryProtocol`-ით იღებს.

ყველა value type-ს არ დამატებია ხელოვნური პროტოკოლი. მონაცემის მოდელს, DTO-ს, enum-ს ან SwiftUI-ის პატარა ვიზუალურ კომპონენტს მხოლოდ არსებობის გამო ცალკე პროტოკოლი არ სჭირდება.

## 3. რა არის LibraryDomain / LibraryData

### ეს ჩვენი კოდია, არა მესამე მხარის ბიბლიოთეკა

ორივე არის ადგილობრივი Swift მოდული, რომელიც [SharedKit-ის Package.swift-ში](/Users/gegighvachliani/Desktop/CineTrack/CineTrack/CineTrack/Packages/SharedKit/Package.swift) არის განსაზღვრული.

ტერმინების განსხვავება:

- **Package:** SharedKit — აქვს თავისი Package.swift და რამდენიმე target.
- **Target / Module:** LibraryDomain და LibraryData — ცალ-ცალკე კომპილირებადი კოდის ნაწილები. `import LibraryDomain` შესაბამის მოდულს ხდის ხელმისაწვდომს.
- **Library product:** ამ target-ების სხვა ფექიჯებისთვის გამოტანის ფორმა, აღწერილი `.library(...)`-ით.

ეს არ არის ჩამოტვირთული Apple framework ან ცალკე გარე SDK. ასევე, ამჟამად არ არსებობს ცალკე `Library/Package.swift`: ეს ორი მოდული SharedKit-ის შიგნითაა. სიტყვა Library აქ ნიშნავს მომხმარებლის პირად კოლექციას და არა ზოგადი დანიშნულების ყველა დამხმარე ფუნქციას.

### კონკრეტული მოვალეობები

| მოდული | შიგთავსი |
| --- | --- |
| LibraryDomain | Watchlist-ის, საყვარელი მსახიობებისა და ნახვის ისტორიის RepositoryProtocol-ები და UseCase-ები; RecentlyViewedMovie/Actor/Item მოდელები |
| LibraryData | WatchlistRepository, FavouriteRepository, RecentlyViewedRepository და შესანახ მონაცემთან შესაბამისი DTO-ები |

ამჟამინდელი ფუნქციური საზღვარი:

- Watchlist — შენახული ფილმები.
- Favourites — საყვარელი მსახიობები.
- Recently Viewed — ნანახი ფილმებისა და მსახიობების ისტორია.

Library არ მართავს ფილმების კატალოგს, ძიებას, სიახლეების API-ს, ვიდეოპლეერს ან ეკრანებს.

### რატომ გახდა საჭირო

ადრე ეს ფუნქციონალი Home-ის შიგნით იყო, თუმცა მას Search, Profile, ActorDetails და MovieDetails-იც იყენებდა. ActorDetails/MovieDetails-ში მსგავსი repository/usecase/DTO კოდის ასლებიც იყო.

ამის გამო:

1. Profile-ის მსგავს ფექიჯს საერთო კოლექციის გამოსაყენებლად Home-ის მოდულზე დამოკიდებულება სჭირდებოდა.
2. ერთი ფუნქციის რამდენიმე ასლის სინქრონულად შეცვლა იყო საჭირო.
3. Home ფექიჯი ფაქტობრივად სხვა ფექიჯების საერთო ინფრასტრუქტურის მფლობელი ხდებოდა.

გადატანის შემდეგ ფუნქციას ერთი საერთო იმპლემენტაცია აქვს. მონაცემის შენახვის არსებული collection-ების სახელები ამ გადატანის გამო არ შეცვლილა.

### ვინ რას იმპორტირებს

- Home/Search/Profile/ActorDetails/MovieDetails-ის ViewModel-ები იღებს LibraryDomain-ის UseCase პროტოკოლებს.
- მათი Assembly-ები იმპორტირებს LibraryData-ს, რადგან repository-ებს სწორედ ისინი ქმნის.
- ამ ფექიჯების Presentation-ში `import LibraryData` არ არის.
- DesignSystem-ის საერთო ისტორიის კომპონენტებს შეიძლება სჭირდებოდეს LibraryDomain-ის მოდელები, მაგრამ არა LibraryData.

მაგალითად:

```text
ProfileView
  → ProfileViewModel.toggleWatchlist(...)
    → AddWatchlistedMovieUseCaseProtocol.execute(...)
      → WatchlistRepositoryProtocol.addWatchlistedMovie(...)
        → RemoteDocumentStore.set(...)
```

ViewModel-მა არ იცის, `RemoteDocumentStore` რეალურად Firestore-ით მუშაობს თუ სხვა იმპლემენტაციით.

მნიშვნელოვანი ნიუანსი: რამდენიმე FeatureFactory-ს კვლავ შეუძლია ცალ-ცალკე repository ობიექტის შექმნა. გაერთიანებულია მათი კოდი და საერთო storage/session დამოკიდებულებები; არ შემიქმნია ყველა ეკრანის state-ის სინქრონიზაციის ახალი გლობალური cache ან event bus.

## 4. ActorMedia / ActorVideos / ActorDetails — გაერთიანებული ფექიჯი

მომხმარებლის მოთხოვნით, სამივე გაერთიანდა ერთ **ActorDetails** ფექიჯში. ActorMedia და ActorVideos აღარ არის ცალკე Swift Package ან ცალკე Domain/Data მოდული.

მანამდე სამივე ფექიჯი არსებობდა, მაგრამ ActorMedia-სა და ActorVideos-ს მხოლოდ ActorDetails იყენებდა. ამიტომ ცალკე manifests და imports დამატებით სირთულეს ქმნიდა დამოუკიდებელი გამოყენების სარგებლის გარეშე.

### შესრულებული გადანაწილება

| ძველი შრე | ახალი მდებარეობა ActorDetails-ის შიგნით |
| --- | --- |
| ActorMediaDomain-ის მოდელები | ActorDetailsDomain/Entities/Media |
| ActorMediaDomain-ის კონტრაქტები და UseCase | ActorDetailsDomain/RepositoryProtocols/Media და UseCases/Media |
| ActorMediaData-ის Repository და DTO | ActorDetailsData/Repositories/Media და DTOs/Media |
| ActorVideosDomain-ის მოდელები | ActorDetailsDomain/Entities/Videos |
| ActorVideosDomain-ის კონტრაქტები და UseCase | ActorDetailsDomain/RepositoryProtocols/Videos და UseCases/Videos |
| ActorVideosData-ის Repository | ActorDetailsData/Repositories/Videos |

რეალური სტრუქტურა:

```text
ActorDetails
  ActorDetailsDomain
    Entities
      არსებული Actor ტიპები
      Media
      Videos
    RepositoryProtocols
      ActorDetailsRepositoryProtocol.swift
      Media
      Videos
    UseCases
      Actor
      Media
      Videos
  ActorDetailsData
    Repositories
      ActorDetailsRepository.swift
      Media
      Videos
    DTOs
      Media
    Mappers
  ActorDetailsPresentation
  ActorDetailsPresentationAPI
  ActorDetailsAssembly
```

### რა შენარჩუნდა და რა მოიშალა

- გადატანილია 10 Swift source ფაილი; მათში არსებული ტიპების სახელები და ოპერაციების კონტრაქტები შენარჩუნებულია.
- ActorMediaRepositoryProtocol და ActorVideosRepositoryProtocol კვლავ არსებობს — უბრალოდ ActorDetailsDomain-ში.
- FetchActorMediaUseCase/FetchActorVideosUseCase კვლავ დამოუკიდებელი UseCase-ებია.
- WikimediaActorMediaRepository/ActorVideosRepository კვლავ ცალკე იმპლემენტაციებია ActorDetailsData-ში.
- ViewModel კვლავ იღებს მხოლოდ UseCase პროტოკოლებს; მას networking/storage არ დამატებია.
- სურათების pagination და ვიდეოების მიღება/გაერთიანება არ გადაკეთებულა.
- imports შეიცვალა ActorDetailsDomain/ActorDetailsData-ით.
- ActorDetails-ის manifest-იდან ამოღებულია ორი local package dependency და ძველი ოთხი მოდულის product references.
- წაშლილია ActorMedia/ActorVideos-ის ცალკე Package.swift ფაილები.
- ActorDetails-ის არსებული PresentationAPI/Assembly პროდუქტები და ხუთი ძირითადი შრე შენარჩუნებულია.
- ტესტები არ დამატებულა და არ შეცვლილა.

გაერთიანების შემდეგ iOS build და არქიტექტურული შემოწმება წარმატებით დასრულდა. ძველი მოდულების imports/product dependencies აღარ დარჩა. ძველი ფექიჯების მხოლოდ ლოკალური Xcode metadata სარეზერვოდ ინახება `/private/tmp/cinetrack-actor-package-metadata.uyoIgW`-ში; იმპლემენტაციის ფაილები ActorDetails-შია და არ დაკარგულა.

ერთ ფექიჯში გაერთიანება არ ნიშნავს ერთ დიდ Repository-ს ან ViewModel-ს: გაერთიანდა განთავსება და build-ის საზღვარი, არა ყველა პასუხისმგებლობა. ცალკე API პროვაიდერი თავისთავად ცალკე Package-ს არ მოითხოვს.

თუ მომავალში სურათები/ვიდეოები სხვა დამოუკიდებელ Feature-საც დასჭირდება, მათი ხელახლა გამოყოფა შესაძლებელი იქნება შენარჩუნებული კონტრაქტების წყალობით.

## 5. ViewModel-ების შენს ოთხ წესთან შესაბამისობა

შემოწმდა 63 ViewModel/Protocol/Extension ფაილი, Preview mock-ების გარეშე. ეკრანების ViewModel-ებია: Home, Search, Profile, ActorDetails, MovieDetails, VideosList, SeeAll, NewsDetails, Onboarding, SignIn და SignUp.

| მოთხოვნა | კოდში ნანახი მდგომარეობა |
| --- | --- |
| ViewModel არ იცნობს UIView/UIViewController/UILabel/Color/View-ს | ამ ტიპების გამოყენება და UIKit/SwiftUI import არ აღმოჩნდა |
| არ წყვეტს რომელი UIViewController უნდა შეიქმნას | გადასვლას ითხოვს action closure-ით; კონტროლერს Factory/Coordinator ქმნის |
| არ იცნობს Repository/API-client/Data source-ს | დამოკიდებულებები UseCase პროტოკოლებია; უშუალო Repository/URLSession/Firestore წვდომა არ აღმოჩნდა |
| არ იცნობს AutoLayout/Storyboard/SwiftUI layout-ს | layout კოდი Views/UIComponents-შია და არა ViewModel-ში |

### რა იცის ViewModel-მა და ეს რატომ არის ნორმალური

ViewModel-ს შეუძლია იცოდეს:

- რომელი ელემენტია არჩეული;
- მიმდინარეობს თუ არა ჩატვირთვა;
- რომელი შეცდომა ან ტექსტი უნდა გამოჩნდეს;
- უნდა გამოითხოვოს თუ არა შემდეგი გვერდი;
- რომ მომხმარებელმა ფილმის დეტალების ან SeeAll-ის გახსნა მოითხოვა.

მაგალითად, `onMovieDetails?(movie)` ნავიგაციის განზრახვაა. `UIHostingController(rootView: ...)` ან `navigationController.pushViewController(...)` კი კონკრეტული UI ნავიგაციაა და ViewModel-ში არ გვხვდება.

`SeeAllContent` და `VideoPlaylistContext` მონაცემის/მარშრუტის payload-ებია; UIViewController-ს არ შეიცავს. შესაბამისად, ViewModel ნავიგაციისგან აბსოლუტურად მოწყვეტილი არ არის — იცის განზრახვა, მაგრამ არა ეკრანის შექმნის ტექნოლოგია.

### Observation-ისა და module-level საზღვრის ნიუანსი

ViewModel-ები იყენებს `Observation`-ს და `@Observable`-ს; Search ასევე იყენებს Combine-ს debounce-ისთვის. Observation layout framework არ არის. მისი გამოყენება არ ნიშნავს, რომ ViewModel-მა SwiftUI View იცის.

ამიტომ ზუსტი ფორმულირებაა: ViewModel იყენებს Foundation/Observation/საჭიროებისამებრ Combine-ს და Domain-ის ტიპებს/კონტრაქტებს — არა მხოლოდ Foundation-ს.

ასევე, ViewModel-ის ფაილი და `FeaturePresentation` target ერთი და იგივე საზღვარი არ არის. ამ target-ში Views და Coordinators-იც შედის, ამიტომ target-ის დამოკიდებულებებში UI მოდულები კანონიერად არსებობს. ViewModel-ის ფაილებში მათი გამოყენება არ ჩანს, მაგრამ იმავე target-ში მომავალში ვინმეს UIKit import-ის დამატებას კომპილატორი თავისთავად არ აკრძალავს.

სრული compile-time აკრძალვისთვის ViewModel-ები ცალკე, UI-ზე დამოკიდებულების არმქონე target-ში უნდა გადავიდეს. ეს დამატებითი დაყოფა არ გამიკეთებია: Home-ის არსებული Presentation სტრუქტურა შენარჩუნებულია.

## 6. ცვლილებები ფექიჯების მიხედვით

### Home

- შეივსო HomeViewModelProtocol რეალურად გამოყენებული state-ითა და მოქმედებებით.
- HomeView გახდა generic ViewModel-ის პროტოკოლზე.
- Watchlist/Favourites/RecentlyViewed კოდი გადაიტანა საერთო Library შრემ.
- გაზიარებული ბარათები/სექციები გადავიდა DesignSystem-ში.
- HomeSection გადავიდა HomePresentation-ში, რადგან Home-ის ეკრანის აღწერაა.
- Home-დან დეტალებში გადასვლისას მოცილდა ისტორიის დამატებითი ჩაწერა; MovieDetails/ActorDetails წარმატებული ჩატვირთვისას შესაბამის UseCase-ს იძახებს.
- ისტორიის SeeAll payload-ში ფილმებთან ერთად მსახიობებიც შედის.
- თარიღის დამხმარე მნიშვნელობა აღარ არის მთელი გაშვების განმავლობაში ერთხელ გამოთვლილი სტატიკური თარიღი.
- შეივსო HomeStrings, გასწორდა რამდენიმე ფაილის სახელი და მოძველებული alias-ები.

მიზანი: Home დარჩეს Feature და არქიტექტურული მაგალითი, მაგრამ არ იყოს სხვა Feature-ების საერთო მონაცემების საცავი.

### Profile

ადრე ViewModel ინახავდა repository პროტოკოლებს, UseCase-ის კონკრეტულ კლასებს ქმნიდა init-ში და დამატებით UseCase-ებს ქმნიდა მეთოდების გამოძახებისას.

ახლა:

- იღებს Profile-ისა და Library-ის UseCase პროტოკოლებს გარედან.
- აქვს ProfileViewModelProtocol და დაყოფილი Loading/Account/Watchlist/Favourites/History/Actions extensions.
- დაემატა FetchProfile, UpdateProfilePhoto და SignOut UseCase კონტრაქტები.
- ProfileRepository იღებს AccountSession, RemoteDocumentStore და ProfilePhotoProcessorProtocol დამოკიდებულებებს.
- ფოტოს მომზადება გადავიდა ImageIOProfilePhotoProcessor-ში: thumbnail-ის შექმნა და JPEG-ში შეკუმშვა ViewModel-ის პასუხისმგებლობა არ არის.
- View არჩევს PhotosPicker-ის ელემენტს და კითხულობს მის Data-ს; იმიჯის შენახვისთვის გარდაქმნა Data შრეშია.
- ViewModel ფოტოს წარმატებით შენახვის შემდეგ იყენებს იმავე დამუშავებულ Data-ს, რომელიც შეინახა, არა დაუმუშავებელ ორიგინალს.
- დამატებულია მიმდინარე ოპერაციების/გასვლის guard-ები.
- Header, Avatar, Favourites და Watchlist ცალკე ვიზუალური კომპონენტებია.

მიზანი: UI state, ანგარიშის ოპერაციები, სურათის დამუშავება და storage ერთმანეთისგან გაიმიჯნოს.

### Search

- დაემატა SearchViewModelProtocol და generic SearchView.
- personalization უკვე LibraryDomain-ის UseCase-ებზე მუშაობს და Home-ის იმპლემენტაცია აღარ სჭირდება.
- მოთხოვნის generation ID ამოწმებს, შედეგი ჯერ კიდევ მიმდინარე ძიებას ეკუთვნის თუ არა.
- query/mode/target-ის შეცვლა ძველ მოთხოვნას აუქმებს/აუქმებს მის აქტუალურობას.
- ძველი პასუხი აღარ უნდა წერდეს ახალ შედეგებს ან ახალი მოთხოვნის loading state-ს.
- pagination-ში შედეგები ID-ებით ერთიანდება.
- SearchMode/SearchTarget-ის საჩვენებელი სათაურები Presentation-ის Strings-შია; სერვისისთვის საჭირო კოდები UI ტექსტად არ გადაიქცა.
- ლოგიკა დაიყო Search/Actions/Pagination/Personalization extensions-ად.

მიზანი: სწრაფი აკრეფის, რეჟიმის შეცვლისა და პარალელური პასუხების დროს ეკრანის state თანმიმდევრული დარჩეს.

### MovieDetails და ActorDetails

- დაემატა/შეივსო ViewModel-ის საკუთარი კონტრაქტები და Views მათზე მუშაობს.
- დუბლირებული Watchlist/Favourites იმპლემენტაციები ჩანაცვლდა LibraryDomain/LibraryData-ით.
- ნახვის ისტორია იტვირთება/იწერება შესაბამისი UseCase-ებით, არა Factory-ში დამალული repository გამოძახებებით.
- ბიზნესოპერაციები და მოქმედებები გადანაწილდა extensions-ში.
- გამოეყო დამატებითი sections, error components და scroll preference key ფაილები.
- SeeAll/ვიდეო/დეტალების ნავიგაცია გადის Coordinator-ის მოქმედებებზე.
- ActorMedia/ActorVideos-ის შესაძლებლობები შენარჩუნდა და მათი კოდი ActorDetailsDomain/ActorDetailsData-ის Media/Videos ფოლდერებში გაერთიანდა.

მიზანი: დეტალების ViewModel მხოლოდ ეკრანის state-სა და UseCase-ების გამოძახებას მართავდეს, ხოლო საერთო კოლექციის კოდი არ დუბლირდებოდეს.

### VideosList

ზუსტი საწყისი მდგომარეობა: Git-ის საწყის ვერსიაში VideosListViewModel უკვე იღებდა FetchPlaylistVideosUseCaseProtocol-ს. ამიტომ ამ ფექიჯში ცვლილება არ ყოფილა „პირდაპირი URLSession მთლიანად ამოვიღე ViewModel-იდან“.

რეალური ცვლილებები:

- დაემატა ViewModel/Coordinator/Factory/Routing კონტრაქტები.
- playlist-ის მომზადება ViewModel-იდან გადავიდა FetchPlaylistVideosUseCase-ში.
- UseCase იღებს VideoPlaylistContext-ს, ამატებს არჩეულ ვიდეოს საჭიროებისას და დუბლირებულ ID-ებს გამორიცხავს.
- ViewModel-ში დარჩა არჩეული ვიდეო, loading/error და წინა/შემდეგი ელემენტის UI state.
- Player, NowPlaying, Playlist და PlaylistVideoCell ცალკე კომპონენტებია.
- დაემატა VideosListStrings და ცალკე Coordinator.
- შენარჩუნდა ვიდეოდან იმ ფილმზე დაბრუნების/გადასვლის source context.

მიზანი: playlist-ის წესები UseCase-ში იყოს, ხოლო პლეერის ეკრანის მდგომარეობა — ViewModel-ში.

### Authentication

- FirebaseAuth/GoogleSignIn-ის კონკრეტული გამოძახებები გადავიდა FirebaseAuthenticationService-ში.
- AuthenticationRepository მუშაობს AuthenticationServiceProtocol-ით.
- AuthenticationError და Data-ის error mapper გამოყოფს პროვაიდერის შეცდომებს ეკრანის ტექსტებისგან.
- SignIn/SignUp გადავიდა Home-ის მსგავს @Observable/@MainActor მოდელზე და საკუთარ პროტოკოლებზე.
- signup validation-ს აქვს UseCase კონტრაქტი.
- დაემატა authentication status-ის შემოწმების UseCase.
- ViewModel აღარ ინახავს კონკრეტულ Coordinator-ს; Factory აკავშირებს მოქმედებებს weak-captured closures-ით.
- პაროლის აღდგენა წარმატების შედეგს აბრუნებს; sheet არ იკეტება შეცდომისას წარმატების მსგავსად.
- SignIn/SignUp-ის Header/Form/Actions დაიყო სექციებად.
- navigation/factory კონტრაქტები განთავსდა PresentationAPI-ში.
- Authentication-ის დაწყება აყენებს შესაბამის root ეკრანს, დასრულებული onboarding-ის უკან დატოვების გარეშე.

მიზანი: vendor SDK, ფორმის მდგომარეობა, validation, UI და ნავიგაცია სხვადასხვა პასუხისმგებლობად დარჩეს.

Google Sign-In-ის SDK-სთვის UI presentation-ის პოვნა კვლავ კონკრეტული service adapter-ის მხარესაა. ეს პასუხისმგებლობა ViewModel-ში არ გადასულა.

### Onboarding

- OnboardingRepository იღებს OnboardingStorageProtocol-ს.
- UserDefaults-ის კონკრეტული გამოყენება UserDefaultsOnboardingStorage-შია.
- ViewModel გახდა Observable და საკუთარი პროტოკოლით მუშაობს.
- next/finish მოქმედებები გამოყოფილია extension-ში.
- გასწორდა ზოგი ფაილის სახელი და Package.swift-ის local dependency paths.

მიზანი: ViewModel არ იცნობდეს UserDefaults-ს, ხოლო repository არ იყოს პირდაპირ მიბმული მის ერთ იმპლემენტაციაზე.

### SeeAll

- შენარჩუნდა ფექიჯი, რადგან საერთო სრული სიები და გალერეა რამდენიმე Feature-ს სჭირდება.
- დაემატა SeeAllViewModelProtocol/ViewModel და coordinator/factory/routing კონტრაქტები.
- pagination-ის state გადავიდა ViewModel-ში; მონაცემის მიღება გადის FetchSeeAllPageUseCaseProtocol-სა და SeeAllRepositoryProtocol-ზე.
- SeeAllContent გახდა უცვლელი route input და არა გაზიარებული observable loading state.
- Movies/Actors/News/Library/Gallery, Header, EmptyState და პატარა cells ცალკე ფაილებშია.
- sheet-ის დახურვა და შემდეგ დეტალზე გადასვლა Coordinator-ის მიერ იმართება.
- DesignSystem-ის private fallback gallery/video screens მოცილდა; კომპონენტები ნავიგაციის მოქმედებას გარეთ გადასცემს.

სექციის მოკლე ჰორიზონტალური preview კვლავ თავის Feature-შია. საერთო სრული სია SeeAll-ს ეკუთვნის — ეს ორი View ერთმანეთის დუბლიკატი არ არის.

ნიუანსი: SeeAllRepository ამჟამად route-ით გადაცემული pagination callback-ის ადაპტერია. ის არ ქმნის მეორე API მოთხოვნის სისტემას; ზოგიერთ სიაში შემდეგი გვერდის წყარო კვლავ გამხსნელი Feature-ის callback-ია.

### NewsDetails

- დაემატა ViewModel, UseCase/Repository კონტრაქტები და Coordinator.
- სტატია გადაეცემა route-ით; დამატებითი network request არ შექმნილა.
- metadata-ის ფორმატირება და source URL-ის შემოწმება ViewModel-შია.
- წყაროს გახსნა დაშვებულია HTTP/HTTPS მისამართებისთვის.
- Header/Description/Source ცალკე sections-ია.

აქ route-backed UseCase/Repository მსუბუქი შრეებია. მათი არსებობა შენს ერთიანი Clean შაბლონის მოთხოვნას მიჰყვება; ეს არ ნიშნავს, რომ სტატიის საჩვენებლად აუცილებელი ახალი backend ოპერაცია გაჩნდა.

## 7. News-ის ფოტოს ბოლო შესწორება

პრობლემა: `scaledToFill` სურათის პროპორციას ინარჩუნებს და ჩარჩოს შესავსებად შეიძლება ზედმეტად გაზარდოს. თუ clipping საბოლოო ზომის შეზღუდვამდე ხდება, პორტრეტულ სურათს ვიზუალურად ტექსტის ზონაში გასვლის შესაძლებლობა რჩება.

დაემატა [NewsImageView](/Users/gegighvachliani/Desktop/CineTrack/CineTrack/CineTrack/Packages/DesignSystem/Sources/DesignSystemComponents/NewsImageView.swift):

```swift
Color.clear
    .frame(height: height)
    .overlay {
        PosterImageView(photoURL: photoURL)
    }
    .clipped()
```

სიმაღლეს განსაზღვრავს გარე კონტეინერი. სურათი overlay-ში იხატება და ამ კონტეინერის layout-ის სიმაღლეს ვეღარ ზრდის. clipping საბოლოო საზღვარზე ხდება.

გამოყენების ადგილები:

| ადგილი | ფიქსირებული სიმაღლე |
| --- | --- |
| საერთო NewsCell, რომელსაც Home/ActorDetails/MovieDetails იყენებს | 105 pt |
| SeeAll-ის CompactNewsCell | 54 pt |
| NewsDetails-ის მთავარი სურათი | 225 pt |

ყველა სტატია ერთსა და იმავე კომპონენტში ერთსა და იმავე სიმაღლეს იკავებს. სხვადასხვა ეკრანულ კონტექსტს თავისი ზომა დარჩა. პორტრეტული ფოტო საჭიროებისამებრ იჭრება; არ იწელება და პროპორციას არ კარგავს. ფოტოს loading/error მდგომარეობაც იმავე სივრცეს იკავებს.

NewsCell-ის header-ის სიმაღლეც 105 pt-ს გაუტოლდა, რათა thumbnail-სა და ტექსტის ნაწილს თანმიმდევრული ზედა ზონა ჰქონდეს.

ეს შესწორება მხოლოდ News-ის გამოყენებებს შეეხო. ყველა ფილმის/მსახიობის PosterImageView-ის ქცევა გლობალურად არ შემიცვლია.

## 8. App, DI და კონფიგურაცია

- დაემატა/შეივსო AppCoordinatorProtocol, MainTabBarCoordinatorProtocol და AppDIContainerProtocol-ის გამოყენება.
- AppDIContainer-ში გაერთიანდა საერთო APIClient, RemoteDocumentStore, AccountSession და AppConfigurationProtocol.
- FeatureFactory-ები იღებს საჭირო საერთო დამოკიდებულებებს; ViewModel მათ შექმნაში არ მონაწილეობს.
- დეტალების Coordinator-ების სიცოცხლის ციკლს მთავარი Coordinator ინახავს და navigation stack-იდან გასვლისას ასუფთავებს.
- SeeAll Coordinator ინახება sheet-ის დასრულებამდე.
- API კონფიგურაცია მოცილდა HomeFactory-ში ჩაშენებულ მნიშვნელობას და გადავიდა AppConfiguration-ში.
- გასწორდა local package paths TMDBData-სა და Onboarding-ში და საჭირო product/target dependencies.
- Xcode პროექტს დაემატა App-ისთვის საჭირო პირდაპირი shared/configuration პროდუქტების კავშირები.

### კონფიგურაციის ფაილები

შაბლონია [Secrets.example.plist](/Users/gegighvachliani/Desktop/CineTrack/Config/Secrets.example.plist).

ლოკალური სამუშაო ფაილია `CineTrack/CineTrack/App/Config/Secrets.plist` პროექტის root-თან მიმართებით. არსებული TMDB მნიშვნელობა მასში შენარჩუნდა; ფაილი Git-ის ignore-შია. AppConfiguration ასევე კითხულობს შესაბამის Info.plist პარამეტრებს.

მნიშვნელოვანი უსაფრთხოების შენიშვნა: Git ignore იცავს შემთხვევითი commit-ისგან, მაგრამ აპის bundle-ში მოთავსებულ გასაღებს მომხმარებლისთვის საიდუმლოდ არ აქცევს. ეს ცვლილება server-side secret management არ არის და ძველი Git ისტორიის გასუფთავებასაც არ ნიშნავს.

## 9. მონაცემის შენახვის ცვლილება

[FirestoreClient](/Users/gegighvachliani/Desktop/CineTrack/CineTrack/CineTrack/Packages/SharedKit/Sources/SharedStorage/Remote/Firestore/FirestoreClient.swift)-ში Codable-ის `setData(from:merge:)` overload სინქრონულად ახდენდა encode-ს და write-ს იწყებდა; მის წინ `await` ჩაწერის სერვერულ დასრულებას არ ელოდებოდა.

ახლა:

1. მოდელი ცალკე encode-დება.
2. გამოიყენება dictionary-ის async `setData`.
3. რეალური write-ის შედეგი/error ბრუნდება გამომძახებელთან.

მიზანი: UI-მ ოპერაცია წარმატებულად არ ჩათვალოს მანამდე, სანამ ამ async კონტრაქტის შესრულების შედეგი არ აქვს.

Tradeoff: Firestore-ის offline queued write-ს სერვერის დადასტურებამდე შეიძლება მოცდა დასჭირდეს. ახალი timeout/offline UX ამ რეფაქტორინგში არ დამატებულა.

Data-ის API-ზე დამოკიდებულების ზუსტი საზღვარიც მნიშვნელოვანია: networking repository-ები APIClient პროტოკოლით ურთიერთობს კლიენტთან, მაგრამ ზოგიერთ მათგანს კვლავ აქვს TMDB request builder/DTO/mapper-ის ცოდნა. ეს Home-ის Data შრის მოდელს მიჰყვება. კონკრეტული კლიენტის იმპლემენტაციისგან დამოუკიდებლობა არ უდრის API-ის სქემისგან სრულ დამოუკიდებლობას. მეორე მოთხოვნას დამატებითი provider-specific DataSource საზღვარი დასჭირდებოდა.

## 10. რა გადატანილია, რა დაემატა, რა წაიშალა

### გადატანილი და გაერთიანებული

- Home-ის Watchlist/Favourites/RecentlyViewed domain კოდი → LibraryDomain.
- შესაბამისი repositories/DTO-ები → LibraryData.
- Home-ის გაზიარებული library cards/sections → DesignSystemComponents.
- ViewModel-ის თემატური მეთოდები → შესაბამისი FeatureViewModels/Extensions.
- Authentication-ის navigation/factory კონტრაქტები → PresentationAPI.
- HomeSection → HomePresentation.
- ActorMedia/ActorVideos-ის ტიპები → ActorDetailsDomain/ActorDetailsData-ის Entities/RepositoryProtocols/UseCases/DTOs/Repositories ფოლდერების Media/Videos ქვედანაყოფები.

### დამატებული ძირითადი ნაწილები

- ViewModel/Coordinator/Factory/Routing კონტრაქტები, სადაც აკლდა.
- Profile-ის UseCase კონტრაქტები და photo processor.
- Authentication service protocol/adapter/error mapping/validation UseCase.
- AccountSession და ანგარიშის ნეიტრალური მონაცემის ტიპი.
- OnboardingStorageProtocol და UserDefaults adapter.
- SeeAll/NewsDetails-ის ViewModel-ები და მათი მსუბუქი Domain/Data შრეები.
- FeatureStrings და საჭირო formatted text ფუნქციები.
- AppConfigurationProtocol/AppConfiguration და Secrets-ის შაბლონი.
- NewsImageView.
- ფორმატირებისა და არქიტექტურული შემოწმების ინსტრუმენტები.

### წაშლილი ან ჩანაცვლებული

- ActorDetails/MovieDetails-ში დუბლირებული Watchlist/Favourites კოდი.
- ცარიელი placeholder ფაილები, მათ შორის 1.swift/Untitled.swift-ის მსგავსი ჩანაცვლებული ფაილები.
- გამოუყენებელი BaseViewModel/BaseCoordinator/HomeAction ტიპები.
- მოძველებული Home-ის MovieCell/HomeFooterView alias-ები.
- DesignSystem-ის კერძო fallback gallery/video ეკრანები.
- ძველი, გამოუყენებელი ზედა დონის App ასლი.
- რეალური App-ის ძველი TMDBConfig; მის ნაცვლად გამოიყენება AppConfiguration.

ზედა დონის App ასლი არ მონაწილეობდა მიმდინარე Xcode target-ში. რეალური აპი რჩება [CineTrack/CineTrack/App](/Users/gegighvachliani/Desktop/CineTrack/CineTrack/CineTrack/App)-ში. წაშლილი tracked ფაილები აღდგენადია Git-იდან; repository-ის ისტორია არ წაშლილა.

ფაილის გადარქმევა ან გადატანა Git-ში unstaged/untracked მდგომარეობაში ხშირად ჩანს ძველი ფაილის წაშლად და ახლის დამატებად. ეს ავტომატურად ფუნქციონალის წაშლას არ ნიშნავს.

## 11. Home-ის სტილი, Strings და დეკომპოზიცია

Presentation-ის საერთო მიმართულებაა:

```text
FeaturePresentation
  FeatureViewModels
    FeatureViewModel.swift
    FeatureViewModelProtocol.swift
    Extensions
  FeatureViews
    FeatureView.swift
    Sections
    UIComponents
  FeatureCoordinators
  FeatureResources
    FeatureStrings.swift
```

სტილის წესები:

- ოთხი space;
- ლოგიკურ ჯგუფებს შორის ცარიელი ხაზი;
- `// MARK: - ...`, გამოყოფილი ცარიელი ხაზებით;
- state/dependencies/init ძირითად ViewModel ფაილში;
- თემატური ოპერაციები შესაბამის extensions-ში;
- დიდი UI ნაწილები ცალკე View-ებად, მნიშვნელობებითა და callbacks-ით;
- ეკრანის ფიქსირებული ტექსტების თავმოყრა მის Strings enum-ში;
- სიმბოლოები, URL-ები, API კოდები და ტექნიკური identifiers ავტომატურად UI Strings არ არის.

Strings enum-ები ამ ეტაპზე ცენტრალიზაციაა და არა დასრულებული მრავალენოვანი ლოკალიზაცია. .xcstrings/თარგმანების სისტემა ამ რეფაქტორინგში არ დამატებულა.

ფორმატირება ერთგვაროვანია, მაგრამ ყველა Feature-ის ფაილების რაოდენობა ერთნაირი არ არის: პატარა ეკრანს იმდენივე სექცია არ სჭირდება, რამდენიც Home-ს.

## 12. შემოწმება და დარჩენილი შეზღუდვები

News-ის ბოლო ცვლილების შემდეგ:

- iOS device build წარმატებით დასრულდა, `CODE_SIGNING_ALLOWED=NO`-ით.
- ViewModel-ის ოთხი მოთხოვნა შემოწმდა imports/ტიპების/დამოკიდებულებების კოდური აუდიტით.
- არქიტექტურული checker ამოწმებს შრეების imports-ს, ViewModel-ში repository/usecase construction-ს, კონტრაქტებსა და local package paths-ს.
- Git diff-ის whitespace შემოწმება გავლილია.
- build-ის SwiftLint ანგარიშში დარჩა 20 გაფრთხილება და 0 serious violation.

ეს არ არის მტკიცება, რომ ყველა runtime სცენარი შემოწმებულია. ამ ცვლილებისას News-ის პორტრეტული ფოტო რეალურ ეკრანზე screenshot-ით არ შემიმოწმებია; შესწორება ეფუძნება layout-ის კოდურ მიზეზს და კომპილაციას.

შენი მითითების შესაბამისად, დამატებული ტესტები წინა ეტაპზე ამოღებულია. მიმდინარე ცვლილებებში არსებული ტესტები უცვლელია; ამ ეტაპზე ახალი ტესტები არ დამიწერია და ტესტები არ გამიშვია.

ხელით გადამოწმებისთვის მნიშვნელოვანი სცენარებია:

- News-ის ვერტიკალური, ჰორიზონტალური და კვადრატული ფოტო Home/Details/SeeAll-ში;
- ფოტოს ჩატვირთვისა და შეცდომის placeholder-ის ზომა;
- სწრაფი ძიება და recent/advanced რეჟიმების გადართვა;
- Watchlist/Favourites/History სხვადასხვა ეკრანიდან;
- Profile-ის ფოტო, sign out და ქსელის შეცდომები;
- SeeAll-ის გახსნა/დახურვა და იქიდან დეტალზე გადასვლა.

### დამხმარე ინსტრუმენტები

[Scripts/check_architecture.rb](/Users/gegighvachliani/Desktop/CineTrack/Scripts/check_architecture.rb) — სტატიკური კოდური წესების შემოწმებაა, არა unit/UI ტესტი და არა სრული Swift type-system ანალიზი.

[Scripts/format.rb](/Users/gegighvachliani/Desktop/CineTrack/Scripts/format.rb) — იყენებს swift-format-სა და პროექტის SwiftLint brace/comment წესებს. გამორიცხავს tests-სა და dependency checkouts-ს.

ორივე ბრძანება ეშვება პროექტის root-იდან:

```sh
ruby Scripts/check_architecture.rb
ruby Scripts/format.rb
```

## 13. რომელი დამატებითი ცვლილებები არ შესრულებულა

- ViewModel-ები ცალკე PresentationModel target-ებში არ გადატანილა.
- არ დამატებულა საერთო გლობალური cache/event bus.
- არ შეცვლილა აპის backend/provider-ები ან მონაცემების მიგრაცია.
- არ დამატებულა სრული localization სისტემა.
- არ გასუფთავებულა ძველი Git ისტორია და არ შექმნილა commit.

ამიტომ მიმდინარე შედეგი არის არსებული Clean + MVVM + Coordinator + Protocols სტრუქტურის მოწესრიგება და კონკრეტული პრობლემების შესწორება — არა სრულიად ახალი არქიტექტურის დანერგვა.
