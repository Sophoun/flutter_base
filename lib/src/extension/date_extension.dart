// ignore_for_file: constant_identifier_names

extension DateExtension on DateTime? {
  static const String ddMMyyyy = "dd-MM-yyyy";
  static const String ddMMyy = "dd-MM-yy";
  static const String MMyyyy = "MM-yyyy";
  static const String yyyyMMdd = "yyyy-MM-dd";
  static const String yyMMdd = "yy-MM-dd";
  static const String ddMMyyyyHHmmss = "dd-MM-yyyy HH:mm:ss";
  static const String ddMMyyyyHHmm = "dd-MM-yyyy HH:mm";
  static const String HHmmss = "HH:mm:ss";
  static const String HHmm = "HH:mm";
  static const String HHmma = "HH:mm a";
  static const String ssmmHH = "ss:mm:HH";
  static const String ddMMyyyyTHHmmss = "dd-MM-yyyy'T'HH:mm:ss";
  static const String yyyyMMddTHHmmss = "yyyy-MM-dd'T'HH:mm:ss";
  static const String hhmma = "hh:mm a";
  static const String EEEEddMMyyyy = "EEEE, dd MMMM yyyy";
  static const String EEEddMMyyyy = "EEE, dd MMMM yyyy";
  static const String EEddMMyyyy = "EE, dd MMMM yyyy";
  static const String EddMMyyyy = "E, dd MMMM yyyy";
  static const String MMMMyyyy = "MMMM yyyy";
  static const String MMMyyyy = "MMM yyyy";
  static const String yyyy = "yyyy";
  static const String ddMMyyyy_hhmma = "dd-MM-yyyy hh:mm a";
  static const String ddMMyyyy_hhmms_a = "dd-MM-yyyy hh:mm:ss a";
  static const String hhmms_a = "hh:mm:ss a";
  static const String a = "a";

  static const List<String> _weekdays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];
  static const List<String> _shortWeekdays = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun",
  ];
  static const List<String> _months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  static const List<String> _shortMonths = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  /// Format date
  String format(String format) {
    if (this == null) return "";
    final date = this!;
    String result = format;

    // Placeholders
    const String p01 = '@@p01@@'; // yyyy
    const String p02 = '@@p02@@'; // yy
    const String p03 = '@@p03@@'; // MMMM
    const String p04 = '@@p04@@'; // MMM
    const String p05 = '@@p05@@'; // MM
    const String p06 = '@@p06@@'; // M
    const String p07 = '@@p07@@'; // EEEE
    const String p08 = '@@p08@@'; // EEE
    const String p09 = '@@p09@@'; // EE
    const String p10 = '@@p10@@'; // E
    const String p11 = '@@p11@@'; // dd
    const String p12 = '@@p12@@'; // d
    const String p13 = '@@p13@@'; // HH
    const String p14 = '@@p14@@'; // H
    const String p15 = '@@p15@@'; // hh
    const String p16 = '@@p16@@'; // h
    const String p17 = '@@p17@@'; // mm
    const String p18 = '@@p18@@'; // m
    const String p19 = '@@p19@@'; // ss
    const String p20 = '@@p20@@'; // s
    const String p21 = '@@p21@@'; // a

    // Replace format patterns with placeholders (longest first)
    result = result.replaceAll('EEEE', p07);
    result = result.replaceAll('EEE', p08);
    result = result.replaceAll('EE', p09);
    result = result.replaceAll('E', p10);
    result = result.replaceAll('yyyy', p01);
    result = result.replaceAll('yy', p02);
    result = result.replaceAll('MMMM', p03);
    result = result.replaceAll('MMM', p04);
    result = result.replaceAll('MM', p05);
    result = result.replaceAll('M', p06);
    result = result.replaceAll('dd', p11);
    result = result.replaceAll('d', p12);
    result = result.replaceAll('HH', p13);
    result = result.replaceAll('H', p14);
    result = result.replaceAll('hh', p15);
    result = result.replaceAll('h', p16);
    result = result.replaceAll('mm', p17);
    result = result.replaceAll('m', p18);
    result = result.replaceAll('ss', p19);
    result = result.replaceAll('s', p20);
    result = result.replaceAll('a', p21);

    // Replace placeholders with actual values
    result = result.replaceAll(p01, date.year.toString());
    result = result.replaceAll(p02, date.year.toString().substring(2));
    result = result.replaceAll(p03, _months[date.month - 1]);
    result = result.replaceAll(p04, _shortMonths[date.month - 1]);
    result = result.replaceAll(p05, date.month.toString().padLeft(2, '0'));
    result = result.replaceAll(p06, date.month.toString());
    result = result.replaceAll(p07, _weekdays[date.weekday - 1]);
    result = result.replaceAll(p08, _shortWeekdays[date.weekday - 1]);
    result = result.replaceAll(p09, _shortWeekdays[date.weekday - 1]);
    result = result.replaceAll(p10, _shortWeekdays[date.weekday - 1]);
    result = result.replaceAll(p11, date.day.toString().padLeft(2, '0'));
    result = result.replaceAll(p12, date.day.toString());
    result = result.replaceAll(p13, date.hour.toString().padLeft(2, '0'));
    result = result.replaceAll(p14, date.hour.toString());
    final h12 = date.hour % 12 == 0 ? 12 : date.hour % 12;
    result = result.replaceAll(p15, h12.toString().padLeft(2, '0'));
    result = result.replaceAll(p16, h12.toString());
    result = result.replaceAll(p17, date.minute.toString().padLeft(2, '0'));
    result = result.replaceAll(p18, date.minute.toString());
    result = result.replaceAll(p19, date.second.toString().padLeft(2, '0'));
    result = result.replaceAll(p20, date.second.toString());
    result = result.replaceAll(p21, date.hour < 12 ? 'AM' : 'PM');

    return result;
  }
}
