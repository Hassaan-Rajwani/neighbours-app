import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:neighbour_app/config/environments.dart';

final awsConfig = {
  'UserAgent': 'aws-amplify-cli/2.0',
  'Version': '1.0',
  'auth': {
    'plugins': {
      'awsCognitoAuthPlugin': {
        'UserAgent': 'aws-amplify-cli/0.1.0',
        'Version': '0.1.0',
        'IdentityManager': {'Default': {}},
        'CredentialsProvider': {
          'CognitoIdentity': {
            'Default': {
              'Region': dotenv.env[Environments.awsRegion],
              'PoolId': dotenv.env[Environments.awsCognitoPoolID],
            },
          },
        },
        'CognitoUserPool': {
          'Default': {
            'Region': dotenv.env[Environments.awsRegion],
            'PoolId': dotenv.env[Environments.awsCognitoPoolID],
            'AppClientId': dotenv.env[Environments.awsCognitoClientID],
            'AppClientSecret': dotenv.env[Environments.awsCognitoPoolSecret],
          },
        },
        'Auth': {
          'Default': {
            'OAuth': {
              'WebDomain': dotenv.env[Environments.awsCognitoURL],
              'AppClientId': dotenv.env[Environments.awsCognitoClientID],
              'AppClientSecret': dotenv.env[Environments.awsCognitoPoolSecret],
              'SignInRedirectURI': '${dotenv.env[Environments.awsCognitoCallbackRedirect]}://',
              'SignOutRedirectURI': '${dotenv.env[Environments.awsCognitoCallbackRedirect]}://',
              'Scopes': [
                'email',
                'openid',
              ],
            },
            'authenticationFlowType': 'USER_SRP_AUTH',
          },
        },
      },
    },
  },
  'storage': {
    'plugins': {
      'awsS3StoragePlugin': {
        'bucket': dotenv.env[Environments.awsBucketName],
        'region': dotenv.env[Environments.awsRegion],
      },
    },
  },
};
