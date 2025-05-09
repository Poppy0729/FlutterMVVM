import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/models/weather.dart';
import 'package:flutter_mvvm_template/views/base_screen.dart';
import 'package:flutter_mvvm_template/views/home/widgets/daily_forecast.dart';
import 'package:flutter_mvvm_template/views/home/widgets/hourly_forecast.dart';
import 'package:provider/provider.dart';
import '../../utils/date_utility.dart';
import '../../utils/utilities.dart';
import '../../view_models/providers/home_view_model.dart';

class HomeScreen extends BaseScreen {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseScreenState<HomeScreen> with BasePageScreen {
  final HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => viewModel),
        ],
        child: Consumer<HomeViewModel>(
          builder: (context, data, widget) {
            return Column(
              children: [
                Container(
                  height: 370,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bg.png'),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.weather?.timezone ?? '',
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                              GestureDetector(
                                child: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  data.fetchWeather();
                                },
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.ideographic,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    '${Utilities.convertTemp(data.weather?.current?.temp ?? 273)}\u00B0',
                                    style: const TextStyle(fontSize: 90),
                                  ),
                                  const SizedBox(width: 10,),
                                  Text('Feels like ${Utilities.convertTemp(data.weather?.current?.feelsLike ?? 273)}'+ '\u00B0'),
                                ],
                              ),
                              Column(
                                children: [
                                  if (data.weather?.current?.weather?.isNotEmpty ?? false)
                                  Image.network(
                                    'http://openweathermap.org/img/wn/${data.weather?.current?.weather?[0].icon ?? ''}@2x.png',
                                    // width: 120,
                                    scale: 0.9,
                                  ),
                                  Text(
                                    data.weather?.current?.weather?[0].main ?? '',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 20,)
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                DateUtility.formatTime(data.weather?.current?.dt ?? 0),
                                style: const TextStyle(fontSize: 16),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Day ${data.dayTemp}\u00B0',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Night ${data.nightTemp}\u00B0',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  child: 
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: weatherDaily("Wind speed", "${data.weather?.current?.windSpeed} m/s", "2 km/h", 'ic-wind')
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: weatherDaily("Rain chance", "24%", "10%", 'ic-rain')
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: weatherDaily("Pressure", "${data.weather?.current?.pressure} hpa", "32 hpa", 'ic-pressure')
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: weatherDaily("UV Index", "2.3", "0.3", 'ic-sun')
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // if (data.weather?.daily != null) DailyForecast(dailyList: data.weather?.daily ?? [],),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          if (data.weather?.hourly != null) HourlyForecast(hourlyList: data.weather?.hourly ?? [],),
                        ],
                      ),
                    ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget weatherDaily( String type, String value, String percent, String icon) {
    return Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
        color: const Color(0xffD0BCFF).withAlpha(80),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset('assets/images/$icon.png', width: 32,),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type,
                style: const TextStyle(color: Colors.black),
              ),
              Text(
                value,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
