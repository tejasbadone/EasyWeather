import 'package:easyweather_v2/data/model/forecast_model.dart';
import 'package:easyweather_v2/logic/current_weather/current_weather_bloc.dart';
import 'package:easyweather_v2/logic/weather_forecast/weather_forecast_bloc.dart';
import 'package:easyweather_v2/presentation/home_screen.dart';
import 'package:easyweather_v2/presentation/widgets/background_gradient.dart';
import 'package:easyweather_v2/presentation/widgets/snackbar.dart';
import 'package:easyweather_v2/utils/constants.dart';
import 'package:easyweather_v2/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: BlocConsumer<WeatherForecastBloc, WeatherForecastState>(
                  listener: (context, state) {
                    if (state is WeatherForecastErrorS) {
                      CustomSnackBar().getSnackBar(
                        context: context,
                        message:
                            '${state.errorString}\nRedirecting to homepage...',
                      );
                      context
                          .read<CurrentWeatherBloc>()
                          .add(GetCurrentWeatherE());

                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    if (state is WeatherForecastSuccessS) {
                      return ForecastWidget(
                        todaysForecastList: state.todaysForecastList,
                        fiveDaysForecastList: state.fiveDaysForecastList,
                      );
                    }

                    if (state is WeatherForecastErrorS) {
                      return SizedBox(
                        height: kheight(context) - 100,
                        width: kwidth(context),
                        child: Center(
                          child: Text(state.errorString, style: kTextStyle),
                        ),
                      );
                    }

                    return const LoadingWidget();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForecastWidget extends StatelessWidget {
  const ForecastWidget({
    super.key,
    required this.todaysForecastList,
    required this.fiveDaysForecastList,
  });

  final List<Forecast> todaysForecastList;
  final List<Forecast> fiveDaysForecastList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        SizedBox(height: kheight(context) * 0.02),
        Text('Today',
            style:
                kTextStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 22)),
        SizedBox(height: kheight(context) * 0.03),
        SizedBox(
          height: kheight(context) * 0.2,
          child: ListView.builder(
            itemCount: todaysForecastList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return TodayWeatherWidget(forecast: todaysForecastList[index]);
            },
          ),
        ),
        SizedBox(height: kheight(context) * 0.035),
        Text('Next Few Days',
            style:
                kTextStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 22)),
        const SizedBox(height: 6),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: fiveDaysForecastList.length,
            itemBuilder: (context, index) {
              final forecast = fiveDaysForecastList[index];
              return NextDayWeatherWidget(forecast: forecast);
            })
      ],
    );
  }
}

class NextDayWeatherWidget extends StatelessWidget {
  const NextDayWeatherWidget({
    required this.forecast,
    super.key,
  });

  final Forecast forecast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: kheight(context) * 0.08,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                formatDay(forecast.dateTime),
                style: kTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/weather_icons/${forecast.icon}.png',
                    height: 36,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    forecast.condition,
                    style: kTextStyle.copyWith(
                        color: Colors.white60,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Text(
                '${forecast.temperature}°',
                style: kTextStyle.copyWith(
                    fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        const Divider(
          color: Colors.white60,
          thickness: 0.1,
          indent: 15,
          endIndent: 15,
        )
      ],
    );
  }
}

class TodayWeatherWidget extends StatelessWidget {
  const TodayWeatherWidget({super.key, required this.forecast});

  final Forecast forecast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          height: kheight(context) * 0.2,
          width: kwidth(context) * 0.23,
          decoration: BoxDecoration(
              // color: Colors.black.withOpacity(0.1),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(45)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${forecast.temperature}°',
                style: kTextStyle.copyWith(
                    fontSize: 20, height: 0.9, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Image.asset(
                'assets/images/weather_icons/${forecast.icon}.png',
                width: 50,
              ),
              const SizedBox(height: 4),
              Text(
                formatTime(forecast.dateTime),
                textAlign: TextAlign.center,
                style: kTextStyle.copyWith(
                    height: 1.2, fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        )
      ],
    );
  }
}
