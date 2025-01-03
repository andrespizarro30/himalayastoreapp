import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis_auth/googleapis_auth.dart';


class AccessTokenFirebase{

  static String firebaseMessagingScope = "https://www.googleapis.com/auth/firebase.messaging";


  Future<String> getAccessToken() async{

    final client = await clientViaServiceAccount(ServiceAccountCredentials.fromJson(
        {
          "type": "service_account",
          "project_id": "himalayastoreapp",
          "private_key_id": "7aacd7c297f30088d2f13f43c8478464c943b610",
          "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC64IIqz9BzJDzZ\nJphS3BwNbfQO7SPpZAs0PDSb+FAkx9vQimofF5c2FtuOozODVNZZkXhHujZe0ohv\npV3MkIbJTz+1gca0AjH6KmzwKCpmSJQbno/L/pWCW1JD5cKRni7Cug35q3ci5orv\nP1a+r43D/3rOGGLZY745VFx+CwdlDopsDQP2iH1DSzeXP6EGU0M4SKwpi6W32r64\nzAHNBJ7Em1a0SpvuQXQOBin3y6+3ZW8DH/ACsvUQlFhuaSTJLmO3JCJ52s+evLYn\nPAMpApfPkaH/x/9ayy/6lX73OiS9+G8jNGNsgeCEQChjN2UPDKfkWj+9l6jA/YIj\n2ntDD+ErAgMBAAECggEAJOTO/fnCKwEz/CEJAI7RAPu8q7e4l8q3BYx/TG2VEPXe\nGUlCUzoakcSoevwQXvTATrWP/AUw176TzgrlPk4oNhUtvD1PR9mJGV0H3c/oMwJQ\nLzW6KOlthetWje4N4CbND4eg27I01pCSTFKCYyoQgGnvSkH5PfbZpsLXcdDmmFYU\ncZEs7QcmmGNwo17QmPmyN8OaX50JYj3WRcaigbIqES8dJX4ELNqvBvhQNQ/c3zu6\nsQJyyO55TFE5/tx1s/MtoaUPRcbN/Z8gNDGGXNuSWy/kEbPxq/BA4Lr9Qug4QKYh\n0aCPRAwQGxaGCEvAbA3FuzHSbc5LasMZnf1x9R7clQKBgQDsUa5pz/VzX49tVcPj\n1dhjj89rgPB9+sgtvTJ6FkKBzulsTs4FY8MONfGkv5B6eWy0NIQhrOQJtlUMxx6K\n8LWtZ5UKBNh6NzvLZGITgmXcRqzOIRsgl2LYDZEYaueLfXGwWL941HxF8/EMavVq\nbU6W2bR2dp28kzXXc1ANxamszQKBgQDKcLkIpqWlFGBjdjvIHYd2rMLGOBhj5GH8\nmJzWs926ovx997EB6/O4ga2hUW/ot9nOSp0x8JklhvkKGdzT1HolIBGqFajG/J4n\nd8dvaSiTPFFHbXXE1hEzNqIfxqbiKm2CTNknZ1oYsiZ3dBeVWgE5ZUaiI2CCE2Ul\nLClwLe7F1wKBgAEAn7LHNQ1WPG+ES55ty8swUvrrwxlltO+su8gUzBds30ScWPdg\n4vTueaXvQhei6Dkjd+QErbr00QuK1LBWMQ8ZP2KZfqmWDmTgeiIHDZOPoTAGp+zN\nd5ffBtyJp43J7G+JENbcX+KUFFOvKHdZG1o8di2Cd0zTewj87jwAuKWJAoGAcF0Q\n1xRobLBar9o4ZGK/hcdudMc+AnQJT0MGCsXbFHTS4LhSr1Zf+NFBpoClNO6XHkGb\n7tQ0rPe10z13rLwK8ABUzasn+wrMXevF7rjXpKGeG59N9us6sMpqQmjoyC/0iJZP\nEefzwjFf2H2/eU5zz3+/LM+mCYzqXy+b8IAOQBECgYEAyXydUaPJTfhBE7GK9/ZL\nKM18nR17QVVwonMsPLbeIzHu61BU1pODqpG/kJEPEzutK5bus6IIccHymKTS+xY2\nmLnuChAG1fZKWEnQ6DDoHO8FNaC47/IWIgJHhzwwXOWZ7mvv4mTCakYcfzyejdhv\nAFReK7Plexpp2TMNo8F75l8=\n-----END PRIVATE KEY-----\n",
          "client_email": "firebase-adminsdk-mm50i@himalayastoreapp.iam.gserviceaccount.com",
          "client_id": "111140534390008009728",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-mm50i%40himalayastoreapp.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }
      ),
      [firebaseMessagingScope]
    );

    final accessToken = client.credentials.accessToken.data;

    return accessToken;

  }

}