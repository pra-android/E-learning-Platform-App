import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServeryKey() async {
    final scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging",
    ];
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "e-learningapp-ce486",
        "private_key_id": "278b0fc079f61660719aefb23a20202532b4df92",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCIjOcO2DEnpsrB\nuEma0haYvl2pC5730heRgca32yf4atTN8ZHmM3+MadBRPXj8qffsBQ5TjUU0xHRR\nfMwHl/xwH3ILPCFCMANNmw7RFGeH+yupwZM2Hr3BD0yzZyrbNXV3iGH9zIkgeRGZ\n/LyNTYEwGpYqgPzzWQLLke1VeMdu4hnXS2PSOpbkWyY5nd4AWqwYXWGBj5wedLOT\nOiYk/qet36StvXxJCxr48rV0I4IVkj2OM6T0Y15ONl/c/qz/ZM8cAypu/41mbExa\nB8zZKbv/9x/f8iM+l1H4rOkXGBxDU/AyJXeTt9IqEfhhE3oNtLmISBUi8Y5ZGjM0\noRu3mFs3AgMBAAECggEAAavnnJE0/Ewr4fIMdfESN4pfad3C6tV7+E5PAqcTwWmM\nkUEz/fix4F+j4lXmZxK1scagVbOxkSVbsBWr5QjV0IklvTOI3NJiXuZ1G72fgEgg\nUUTAYCKWqoPlh5AA1e4JoPinYZ/Js2V+ZkxBAjdDB2kmCaFblS+rHblqiZ9oTH6G\n/+e7yYKSM7QcEquQ8uZ12NsCAL/J9gUHT0D0UPtw0VuT9Pvzd0wQxtPfdZxx4kda\n3h6b+HX6Rq+JPV+MkwtD+XMrdL96Xw0YSIXlM9y/8+NJ6hwg03hxi2ELnkg1W6Fp\nXnkOhT565ckXOKlzIoma+x016GHRMVTNBEeqY8d5pQKBgQC7XXcGNKgxN2EbyX5Z\ni8wPW/tLwN8z5iOxVlo1OqDIHcx5wc9RAzn5BtqVqMgaOCJD1qJQMp+YJ8d7dge5\nV1ANxqV4sqsdQtFrVJcuTZQMHlNpVx87oZEujnR4QkyhNrQUlyxiWwyv7Kn/izmn\nuKQ4AGuYWa86xoCssA0Qc+Fv6wKBgQC6kjAydUKrUvPLMm1EgYKOXDqKEjEyQYKW\nxzLl0fKA8orstRgdqc4WkPk3oFRCX24ZZDaO7ey5pxrPOJSTlevyJvmGJnyQsIYV\nVrwG+1+KQc5IDHbJqPqf1sje0cPykz67VnZxFP3t5UsO/GtLObxiB0YNa16FwMmZ\nkygWobw65QKBgQCXPtiAyurmZ8Tc8GctE7tSvrZ5LSVAOMuhMIq7Iyt8vwk7VCbt\nR4R5sH2sh8WX3K5UQqNdx6+q3Jmb4OhVRdUaebtDVj7o7PIuCOfM+dTDf4tnomtU\n8JRIl7gPB73h+U2evXWXo9X3AT0tSo7tBBCUIEq6fdMEyA5A2BCDsndNpwKBgBAP\nycpuQeER8R8LJlEBfUXYNsnwKwASl7V3TLBwVJo5RzB9nqffGHjk3i+lw9s67/WL\npQ7E+N46vpocWt4hyAA+zrh30715FPH9V46aUW1LoQCe4hMWUw0zpnNYR7A4cOwb\n03KExh+W39FYdbwyKj+eNK+vEKIfKLvp6UeZgOTpAoGAJI8CplgYmBF8XvSixmC0\n3vOxrblqnnUyq5jPmGylbFQe4u+AyYHYc51bjJ1Vfy0ivK8U+XLoXq5qgS8QFiXj\nT0B3cQ3ZpeeBgpfknmOuGLc4aCMAKu6+x/I4teDHQ2jgz6Zm4Q7MYlZSf+BGvxWg\nEtYy6oAHksum1T32eHyVB9Q=\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-fbsvc@e-learningapp-ce486.iam.gserviceaccount.com",
        "client_id": "117917649260174610162",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40e-learningapp-ce486.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com",
      }),
      scopes,
    );

    final accessServeryKey = client.credentials.accessToken.data;
    return accessServeryKey;
  }
}
