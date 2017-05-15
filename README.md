## Project 

**Mobile Application Coding Challenge**

**Objective**: Implement local caching mechanism so that cached posts data can be loaded instantly after app launched. Background data update will still needed and you will required to refresh the UI once the latest data is ready.

## Description

- Using the **Model-View-ViewModel** pattern to develop. Application implemented the cached medhanism to load content instantly as requirements. Basically the caching will save the json contents to disk when it requests to Network and receiving the response. The json contents are cached will be read firstly when application is launching to display UI and it still update content from background at the same time for getting new content.

- Application mainly uses URLSesion class for downloading content form network. The URLSession class natively supports the data, file, ftp, http, and https URL schemes, with transparent support for proxy servers and SOCKS gateways...

- **NetworkManager** class will basically manage downloading contents as well as save the json to cache
- **LocalStore** class will handle read, write file.
- **ImageManager** class will handle downloading image
- **MommentBussinessCtrl** class will handle getting: post, like count, comment count,... from API service

## Framework

**UIKIT**

**Foundation**

## Requirements

- iOS 8.0+ / Mac OS X 10.9+ / watchOS 2
- Xcode 8.3.2+ and Swift 3.0+

### CocoaPods

**No usage**