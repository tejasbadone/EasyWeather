
# EasyWeather

![Logo](https://github.com/tejasbadone/EasyWeather/blob/main/images/app_icon.png?raw=true)

EasyWeather is a powerful and intuitive weather app that provides users with real-time weather updates and forecasts for any location. Built using Flutter and OpenWeatherMap API, the app boasts a responsive UI that adapts to different devices and screen sizes, providing a seamless user experience.

One of the key features of EasyWeather is its automatic location detection, which enables the app to automatically detect and display the weather conditions of your current location. Users can also easily search for the weather conditions of any other location, simply by typing in the name of the location. in addition, users can tap on the location icon to get back to their current location's weather data. 




## Features

- Real-time weather data: The app uses OpenWeatherMap API to fetch real-time weather data for any location in the world.

- Automatic location detection: The app automatically detects the user's current location and displays the corresponding weather data.

- Search for weather data of any location: Users can search for the weather conditions of any location by entering the location name.

- Simple and user-friendly design: The app has a simple and user-friendly design that makes it easy to navigate and use.



## Screenshots

![App Screenshot](https://tejasbadone.web.app/assets/img/portfolio/apps/weather/weather0-01.png)

![App Screenshot](https://tejasbadone.web.app/assets/img/portfolio/apps/weather/weather-01.png)


## Setup

To get a local copy up and running follow these simple example steps.

Prerequisite: https://flutter.dev/docs/get-started/install

1. To get started, fork this repository to your GitHub account.

2. Clone the repo.
    ```sh
     git clone https://github.com/tejasbadone/EasyWeather.git
    ```
3. Install packages.
    ```sh
     flutter pub get
    ```
4. Add OpenWeatherMap API KEY on lib/services/weather.dart
    ```dart
   const apikey = "<INSERT YOUR API KEY >";
    ```
5. Run project.
    ```sh
     flutter run
    ```


## Tech Stack

**Client:** Flutter

**Server:** OpenWeatherMap API


## License

[MIT License](https://github.com/tejasbadone/EasyWeather/blob/main/LICENSE)







