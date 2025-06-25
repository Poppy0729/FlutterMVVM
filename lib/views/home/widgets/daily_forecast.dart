// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/models/weather.dart';
import 'package:flutter_mvvm_template/utils/date_utility.dart';
import 'package:flutter_mvvm_template/utils/utilities.dart';

// ignore: must_be_immutable
class DailyForecast extends StatelessWidget {
  List<Daily> dailyList;
  DailyForecast({
    super.key,
    required this.dailyList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
            'Day forecast',
            style: TextStyle(color: Colors.black),
          ),
        ]),
        ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => weatherHourly(dailyList[index], index),
          itemCount: dailyList.length,
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  Widget weatherHourly(Daily? daily, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xffD0BCFF).withAlpha(80),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (index == 0) ? 'Today' : DateUtility.formatTime(daily?.dt ?? 0, format: 'EEEE, MMM dd'),
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      daily?.weather?[0].main ?? '',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${Utilities.convertTemp(daily?.temp?.max ?? 0)}°',
                        style: const TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        '${Utilities.convertTemp(daily?.temp?.min ?? 0)}°',
                        style: const TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    width: 1,
                    height: 45,
                    color: Colors.black,
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Image.network(
                'http://openweathermap.org/img/wn/${daily?.weather?[0].icon ?? ''}@2x.png',
                // width: 120,
                scale: 1.5,
              ),
            ],
          ),
        ),
        if (index != dailyList.length - 1) ...[
          const SizedBox(
            height: 10,
          ),
        ],
      ],
    );
  }
}
