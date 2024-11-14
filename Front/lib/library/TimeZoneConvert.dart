import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TimeZoneConverter {
  final tz.Location seoulTimeZone;
  final tz.Location newYorkTimeZone;

  // 생성자
  TimeZoneConverter()
      : seoulTimeZone = tz.getLocation('Asia/Seoul'),
        newYorkTimeZone = tz.getLocation('America/New_York') {
    tz.initializeTimeZones();  // 초기화
  }

  // 한국 시간 -> 미국 시간
  DateTime convertToUSATime(DateTime seoulTime) {
    final nyTime = tz.TZDateTime.from(seoulTime, newYorkTimeZone);
    print('korTime : $seoulTime / nyTime : $nyTime');
    return nyTime;
  }
}