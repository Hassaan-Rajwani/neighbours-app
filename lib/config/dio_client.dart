import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:neighbour_app/utils/envs.dart';

final Dio dioClient = Dio();

final String baseUrl = dotenv.env[EnvKeys.apiURL].toString();
