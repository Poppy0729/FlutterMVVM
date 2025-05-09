// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/models/weather.dart';
import 'package:flutter_mvvm_template/utils/date_utility.dart';
import 'package:flutter_mvvm_template/utils/utilities.dart';

// ignore: must_be_immutable
class HourlyForecast extends StatelessWidget {
  List<Hourly> hourlyList;
  HourlyForecast({
    Key? key,
    required this.hourlyList,
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
                  itemBuilder: (context, index) => weatherHourly(hourlyList[index], index),
                  itemCount: 10,
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

  Widget weatherHourly(Hourly? hourly, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              (index == 0) ? 'Now' : DateUtility.formatTime(hourly?.dt ?? 0, format: 'HH'),
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
            Text(
              (index == 0) ? '' : DateUtility.formatTime(hourly?.dt ?? 0, format: 'a'),
              style: const TextStyle(color: Colors.black, fontSize: 10),
            ),
          ],
        ),
        Image.network(
          'http://openweathermap.org/img/wn/${hourly?.weather?[0].icon ?? ''}@2x.png',
          // width: 120,
          scale: 2,
        ),
        Text(
          '${Utilities.convertTemp(hourly?.temp ?? 0)}°',
          style: const TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
