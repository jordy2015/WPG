## Worldwide Photo Gallery (WPG)

WPG is a great app to see photos taken by photographer around the world, the app consumes services from [unsplash](https://unsplash.com/developers).

<img align="center" src="https://github.com/jordy2015/WPG/blob/develop/images/gallery.png" height=400><img align="center" src="https://github.com/jordy2015/WPG/blob/develop/images/favorites.png" height=400><img align="center" src="https://github.com/jordy2015/WPG/blob/develop/images/profile.png" height=400><img align="center" src="https://github.com/jordy2015/WPG/blob/develop/images/viewer.png" height=400>


### Installation

1. Get the Access Key and Secret key from [unsplash](https://unsplash.com/developers)
2. Clone the repo
3. Open the Terminal and navigate to the project folder
4. In the Terminal run `pod install`
5. Open the file `WPG.xcworkspace` with Xcode > 12
6. With Xcode search the file `Credentials.swift` and put your Access Key and Secret key got in step 1
7. Run the Project

### Features

- [x] Gallery Screen, get photos from [unsplash](https://unsplash.com/developers)
- [x] Pagination
- [x] Add Photos to favorites 
- [x] Favorites screen
- [x] Search screen
- [x] Storing in database
- [x] Working without internet

### ToDo

- [ ] Test 100%

## Tools

| dependency     | Version                      |
| --------- | ---------------------------- |
| Alamofire | 5.1.0 |
| CodableAlamofire | 1.2.1 |
| AlamofireImage | 4.1.0 |
| CoreData | --- |

## Good practics

- [x] MVP pattern
- [x] Repository Pattern
- [x] Clean architecture
- [x] Dependency Injection
- [x] Solid
- [x] Unit test
