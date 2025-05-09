// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/models/weather.dart';
import 'package:flutter_mvvm_template/utils/date_utility.dart';
import 'package:flutter_mvvm_template/utils/utilities.dart';

// ignore: must_be_immutable
class DailyForecast extends StatelessWidget {
  List<Daily> dailyList;
  DailyForecast({
    Key? key,
    required this.dailyList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffD0BCFF).withAlpha(80),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(children: [
              Image.asset(
                'assets/images/ic-hour.png',
                width: 32,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Hourly forecast',
                style: TextStyle(color: Colors.black),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100,
              child: 
                ListView.builder(
                  itemBuilder: (context, index) => weatherHourly(dailyList[index]),
                  itemCount: dailyList.length,
                  scrollDirection: Axis.horizontal,
                ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget weatherHourly(Daily? daily) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          DateUtility.formatTime(daily?.dt ?? 0, format: 'HH:mm'),
          style: const TextStyle(color: Colors.black),
        ),
        Image.network(
          'http://openweathermap.org/img/wn/${daily?.weather?[0].icon ?? ''}@2x.png',
          // width: 120,
          scale: 2,
        ),
        Text(
          '${Utilities.convertTemp(daily?.temp?.day ?? 0)}°',
          style: const TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
