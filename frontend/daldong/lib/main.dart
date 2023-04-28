import 'package:daldong/screens/exercise_detail_screen/exercise_detail_screen.dart';
import 'package:daldong/screens/exercise_screen/exercise_screen.dart';
import 'package:daldong/screens/root_screen/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:daldong/screens/home_screen/home_screen.dart';

void main() {
  // 앱 처음 실행 시 flutter 엔진 초기화 메소드 호출
  // flutter 자체의 렌더링 엔진을 사용할 때 필요한 기본적인 설정들을 수행하는 메소드라고 생각하면 됨
  WidgetsFlutterBinding.ensureInitialized();

  // 세로 방향으로 고정
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ],
  // );

  runApp(
    MaterialApp(
      title: 'daldong',
      // 기본 테마 색 및 폰트 설정
      // 테마 색 사용 시 Theme.of(context).{사용하고 싶은 컬러 변수 명}로 사용 가능
      theme: ThemeData(
        fontFamily: 'Pretendard',
        primaryColor: const Color(0xFF6BBD99),
        primaryColorDark: const Color(0xFF46A094),
        // primaryColorLight: const Color(0xFFAECFA4),
        primaryColorLight: const Color(0xFFC4E8C2),
        // canvasColor: const Color(0xFFC4E8C2),
        canvasColor: Colors.white,
        secondaryHeaderColor: const Color(0xFF453F52),
        shadowColor: const Color(0xFFEFEFEF),
        disabledColor: const Color(0xFF999999),
      ),
      themeMode: ThemeMode.system,
      // 앱 시작 시 초기 경로
      initialRoute: '/',
      // 라우팅 이동 지정
      // 이동 방법은 'Navigator.pushName(context, '{하단에 지정해둔 라우팅 경로}')
      // 만약 기존 라우팅 경로를 초기화하고 이동하고 싶다면,
      // Navigator.pushNamedAndRemoveUntil(
      //   context,
      //   {라우팅 경로},
      //   arguments: {
      //     // 넣어줄 arguments 있을 시,
      //   },
      //   ModalRoute.withName({초기화하고 싶은 라우팅 시점),
      // );
      routes: {
        '/': (context) => RootScreen(),
        '/home': (context) => HomeScreen(),
        '/exercise': (context) => ExerciseScreen(),
        '/exercise_detail': (context) => ExerciseDetailScreen(),
      },
      // home: const HomeScreen(),
    ),
  );
}