import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:neighbour_app/utils/envs.dart';

String apiBaseUrl = '${dotenv.env[EnvKeys.apiURL]}';
