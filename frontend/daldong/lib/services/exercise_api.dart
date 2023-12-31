import 'dart:ffi';

import 'package:daldong/services/api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String? baseUrl = dotenv.env['SPRING_API_URL'];
String? fastUrl = dotenv.env['FAST_API_URL'];
String? weatherUrl = dotenv.env['WEATHER_API_URL'];
String? weatherApiKey = dotenv.env['WEATHER_API_KEY'];

// 운동 메인 페이지(오늘 운동 로그) 조회
void getTodayExerciseLog({
  required dynamic Function(dynamic) success,
  required Function(String error) fail,
}) {
  apiInstance(
    path: '${baseUrl}/exercise/',
    method: Method.get,
    success: success,
    fail: fail,
  );
}

// 1개월 치 운동 기록 조회
void getMonthlyExerciseLog({
  required dynamic Function(dynamic) success,
  required Function(String error) fail,
  required int yearMonth,
}) {
  apiInstance(
    path: '${baseUrl}/exercise/monthly/${yearMonth}',
    method: Method.get,
    success: success,
    fail: fail,
  );
}

// 추천 운동 조회
void getRecommendExercise({
  required dynamic Function(dynamic) success,
  required Function(String error) fail,
  required String uid,
  required String weather,
  required double temperature,
}) {
  apiInstance(
    path: '${fastUrl}/user/${uid}?whether=$weather&temperature=$temperature',
    method: Method.get,
    success: success,
    fail: fail,
  );
}

// 날씨 정보 조회
void getWeatherInfo({
  required dynamic Function(dynamic) success,
  required Function(String error) fail,
  Map<String, String>? body,
  required double lat,
  required double lon,
}) {
  apiInstance(
    path:
        '${weatherUrl}?lat=${lat}&lon=${lon}&appid=${weatherApiKey}&units=metric&lang=kr',
    method: Method.get,
    body: body,
    success: success,
    fail: fail,
  );
}
