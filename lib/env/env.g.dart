// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env.dart';

// **************************************************************************
// EnviedGenerator
// **************************************************************************

class _Env {
  static const List<int> _enviedkeyserverAddress = [
    47954767,
    4262124648,
    2534405552,
    3822240798,
    950394538,
    344703001,
    203318731,
    2056435456,
    3620398139
  ];
  static const List<int> _envieddataserverAddress = [
    47954723,
    4262124551,
    2534405587,
    3822240895,
    950394566,
    344703089,
    203318692,
    2056435571,
    3620398159
  ];
  static final serverAddress = String.fromCharCodes(
    List.generate(_envieddataserverAddress.length, (i) => i, growable: false)
        .map((i) => _envieddataserverAddress[i] ^ _enviedkeyserverAddress[i])
        .toList(growable: false),
  );
  static const List<int> _enviedkeyport = [
    3658615284,
    2604836771,
    969012669,
    2585465806
  ];
  static const List<int> _envieddataport = [
    3658615244,
    2604836755,
    969012613,
    2585465854
  ];
  static final port = String.fromCharCodes(
    List.generate(_envieddataport.length, (i) => i, growable: false)
        .map((i) => _envieddataport[i] ^ _enviedkeyport[i])
        .toList(growable: false),
  );
  static const List<int> _enviedkeydbHost = [
    833564351,
    1941591358,
    3434677308,
    1805035366,
    3746826394,
    760349645,
    734663283,
    3308901874,
    2681789506,
    3977143939,
    708977451,
    1716899875
  ];
  static const List<int> _envieddatadbHost = [
    833564302,
    1941591305,
    3434677262,
    1805035336,
    3746826411,
    760349690,
    734663261,
    3308901831,
    2681789555,
    3977143981,
    708977434,
    1716899866
  ];
  static final dbHost = String.fromCharCodes(
    List.generate(_envieddatadbHost.length, (i) => i, growable: false)
        .map((i) => _envieddatadbHost[i] ^ _enviedkeydbHost[i])
        .toList(growable: false),
  );
  static const List<int> _enviedkeydbPort = [
    734234960,
    2489835464,
    1399732211,
    1367548792
  ];
  static const List<int> _envieddatadbPort = [
    734234979,
    2489835515,
    1399732163,
    1367548750
  ];
  static final dbPort = String.fromCharCodes(
    List.generate(_envieddatadbPort.length, (i) => i, growable: false)
        .map((i) => _envieddatadbPort[i] ^ _enviedkeydbPort[i])
        .toList(growable: false),
  );
  static const List<int> _enviedkeydbUser = [
    2299813190,
    953831672,
    4141288457,
    4206750507,
    3744559973,
    3159914776,
    2385103793,
    2294576890,
    747575832
  ];
  static const List<int> _envieddatadbUser = [
    2299813154,
    953831577,
    4141288571,
    4206750559,
    3744559930,
    3159914861,
    2385103810,
    2294576799,
    747575914
  ];
  static final dbUser = String.fromCharCodes(
    List.generate(_envieddatadbUser.length, (i) => i, growable: false)
        .map((i) => _envieddatadbUser[i] ^ _enviedkeydbUser[i])
        .toList(growable: false),
  );
  static const List<int> _enviedkeydbPassword = [
    2086751656,
    856436972,
    2056081367,
    2608722712,
    1782063308,
    2824235692,
    2505109292,
    2670290350,
    145088389
  ];
  static const List<int> _envieddatadbPassword = [
    2086751692,
    856436877,
    2056081317,
    2608722796,
    1782063251,
    2824235740,
    2505109325,
    2670290397,
    145088502
  ];
  static final dbPassword = String.fromCharCodes(
    List.generate(_envieddatadbPassword.length, (i) => i, growable: false)
        .map((i) => _envieddatadbPassword[i] ^ _enviedkeydbPassword[i])
        .toList(growable: false),
  );
  static const List<int> _enviedkeydbSchema = [
    1272535413,
    1499893313,
    3727506670,
    1366932496,
    2041485004,
    2924597264,
    2536305116,
    647889536,
    523949978,
    820283465,
    2831087426,
    3227946048
  ];
  static const List<int> _envieddatadbSchema = [
    1272535315,
    1499893293,
    3727506561,
    1366932578,
    2041484965,
    2924597363,
    2536305065,
    647889644,
    523950062,
    820283452,
    2831087408,
    3227946017
  ];
  static final dbSchema = String.fromCharCodes(
    List.generate(_envieddatadbSchema.length, (i) => i, growable: false)
        .map((i) => _envieddatadbSchema[i] ^ _enviedkeydbSchema[i])
        .toList(growable: false),
  );
  static const List<int> _enviedkeyjwtKey = [
    1426720401,
    2919727262,
    2736021326,
    4096639140,
    591856503,
    4092003824,
    1066203701,
    1220476982,
    829738649,
    3758574163,
    719464197,
    2903731312
  ];
  static const List<int> _envieddatajwtKey = [
    1426720496,
    2919727342,
    2736021287,
    4096639223,
    591856402,
    4092003731,
    1066203719,
    1220477011,
    829738733,
    3758574104,
    719464288,
    2903731209
  ];
  static final jwtKey = String.fromCharCodes(
    List.generate(_envieddatajwtKey.length, (i) => i, growable: false)
        .map((i) => _envieddatajwtKey[i] ^ _enviedkeyjwtKey[i])
        .toList(growable: false),
  );
}
