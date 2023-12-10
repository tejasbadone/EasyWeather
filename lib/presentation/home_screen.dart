import 'package:easyweather_v2/data/model/weather_model.dart';
import 'package:easyweather_v2/logic/current_weather/current_weather_bloc.dart';
import 'package:easyweather_v2/logic/weather_forecast/weather_forecast_bloc.dart';
import 'package:easyweather_v2/presentation/widgets/background_gradient.dart';
import 'package:easyweather_v2/presentation/widgets/snackbar.dart';
import 'package:easyweather_v2/utils/constants.dart';
import 'package:easyweather_v2/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   systemOverlayStyle:
      //       const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      // ),
      body: SafeArea(
        child: Stack(
          children: [
            const BackgroundGradient(),
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                child: BlocConsumer<CurrentWeatherBloc, CurrentWeatherState>(
                  listener: (context, state) {
                    if (state is CurrentWeatherErrorS) {
                      CustomSnackBar().getSnackBar(
                        context: context,
                        message:
                            '${state.errorString}\nRedirecting to homepage...',
                      );
                      context
                          .read<CurrentWeatherBloc>()
                          .add(GetCurrentWeatherE());
                    }
                  },
                  builder: (context, state) {
                    if (state is CurrentWeatherByNameSuccessS) {
                      return HomeScreenWidget(
                          weather: state.weather,
                          searchController: searchController);
                    }
                    if (state is CurrentWeatherSuccessS) {
                      return HomeScreenWidget(
                          weather: state.weather,
                          searchController: searchController);
                    }
                    if (state is CurrentWeatherErrorS) {
                      return SizedBox(
                        height: kheight(context) - 100,
                        width: kwidth(context),
                        child: Center(
                          child: Text(
                              '${state.errorString}\n Redirecting to homepage...',
                              textAlign: TextAlign.center,
                              style: kTextStyle),
                        ),
                      );
                    }

                    return const LoadingWidget();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kheight(context) - 100,
      width: kwidth(context),
      child: Center(
        child: Lottie.asset('assets/loading.json', height: 120, width: 120),
      ),
    );
  }
}

class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget({
    super.key,
    required this.searchController,
    required this.weather,
  });

  final TextEditingController searchController;
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: const AlignmentDirectional(-0.89, 0),
          child: Text(
            getGreetings(),
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: Colors.white, fontSize: 24),
          ),
        ),
        const SizedBox(height: 14),
        Column(
          children: [
            Image.asset(
              'assets/images/weather_icons/${weather.icon}.png',
              height: 250,
              width: 270,
              fit: BoxFit.fitWidth,
            ),
            Text(
              '${weather.temperature.toStringAsFixed(1)}°C',
              style: const TextStyle(
                  fontSize: 100,
                  height: 0.98,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              weather.condition,
              style: const TextStyle(
                  fontSize: 25,
                  letterSpacing: 1.5,
                  height: 1,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  FontAwesomeIcons.locationDot,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 10),
                Text(
                  weather.cityName,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      height: 0.95,
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 20),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      height: 45,
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.white30)),
                      child: TextFormField(
                        controller: searchController,
                        onFieldSubmitted: (value) {
                          BlocProvider.of<CurrentWeatherBloc>(context)
                              .add(GetCurrentWeatherByNameE(cityName: value));
                        },
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                            suffixIcon: InkWell(
                                onTap: () {
                                  BlocProvider.of<CurrentWeatherBloc>(context)
                                      .add(GetCurrentWeatherByNameE(
                                          cityName: searchController.text));
                                },
                                child: const Icon(Icons.search)),
                            suffixIconColor: Colors.white60,
                            hintText: 'Search',
                            hintStyle: const TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                                fontWeight: FontWeight.w400),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 6)
                                    .copyWith(left: 16),
                            border: InputBorder.none,
                            constraints: const BoxConstraints(minWidth: 60)),
                      )),
                  InkWell(
                    onTap: () {
                      context
                          .read<CurrentWeatherBloc>()
                          .add(GetCurrentWeatherE());
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.white30),
                      ),
                      child: const Icon(Icons.my_location_outlined,
                          color: Colors.white70),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context
                          .read<WeatherForecastBloc>()
                          .add(GetWeatherForecastE(cityName: weather.cityName));
                      context.pushNamed('details-screen');
                    },
                    child: Container(
                      height: 45,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.white30)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                          Text('More',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w400)),
                          Icon(
                            Icons.chevron_right_outlined,
                            color: Colors.white70,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconWidget(
                        iconName: 'sunrise.png',
                        value: formatTime(weather.sunrise),
                        label: 'Sunrise'),
                    IconWidget(
                      iconName: 'feels_like.png',
                      value: '${weather.feelsLike.toString()}°C',
                      label: 'Feels like',
                      height: 50,
                    ),
                    IconWidget(
                        iconName: 'sunset.png',
                        value: formatTime(weather.sunset),
                        label: 'Sunset'),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconWidget(
                        iconName: 'wind.png',
                        value: '${weather.wind.toString()} m/s',
                        label: 'Wind'),
                    IconWidget(
                      iconName: 'min_max.png',
                      value:
                          '${weather.tempMax.toString()} / ${weather.tempMin.toString()}°C',
                      label: 'Min / Max',
                      // height: 62,
                      width: 62,
                    ),
                    IconWidget(
                        iconName: 'humidity.png',
                        value: '${weather.humidity.toString()}%',
                        label: 'Humidity'),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class IconWidget extends StatelessWidget {
  const IconWidget({
    super.key,
    required this.iconName,
    required this.value,
    required this.label,
    this.height = 45,
    this.width = 45,
  });

  final String iconName;
  final String value;
  final String label;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/$iconName',
          height: height,
          width: width,
        ),
        const SizedBox(height: 6),
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400),
        ),
        Text(
          label,
          style: const TextStyle(
              fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
