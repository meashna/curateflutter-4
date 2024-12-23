import 'package:curate/src/data/models/response/profile/PersonalInfo.dart';

/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjoiVTJGc2RHVmtYMS81SHZaRWl3aHU2ZnBvamphanBNTlpEcW1XdkpDZTZrMnovYW0vakhGdElnT21zVGZodjNiWmRYTHNDK0ZtUndyOTF6UmJHMVVEQkFNb2VZOFJCUWdaZmM0cmZtRVhsczJPOXFaYXhGSXFBV3dQeE1PZlY1b094Z0xiSmJQaVM0STNjUFkyaTd4VGtHYnlBRTc1SGRiUWQ0N2xBUnltZWxrK1JIa3JUZG5HZWpuMFlza0hjZXN1QU1ZcXZ6M1k1VDlzMUN6Y3pXZml2RGl5dTdmSmgzZTExTGI0R1pMT1Y3RWRxOGhBZFZGc1lTcmZKM21oOHdiRUk5blZsZzVmNTA4UzdCMmRtUDFoSGFPakloUnhwYjV2akdaYTMzU3pHSytkYkpRemJkNkJWRHdHOVlYTlp3dFkiLCJpYXQiOjE2ODA1Mjc5Nzd9.40coUKnENEGoXABjs3PHdlerUwcy4JqKKxWiPNVzUHk"
/// refreshToken : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjoiVTJGc2RHVmtYMTg2UkZpc1V3WjB5emFGVXU4WFJYdHdvUHFnQis5ZG9lSWJGMitGQm1BRjZUd05ZRUw5ZUJ4N1BWb0JibGRaRlRyeDB5aUZzQk5UZW5NR2NnQU9mTThtZlN0T2FpYTJ4dW1JV2dTOGtjRG9rUjlwand2WndOdGVZbVhYQlJGbjJsSkxnZ3RBSmVXTk0xalkyMlVKb1NSQnF0R1Z6UVFPWDA3SFhNdVdES0wwdWxiRkVaaDhMMUsrZVNPcUtIOXVHdXZrRzMwalVLdXdVL3ArSTF2bkxTRUJMc2xTR2lNdWYyZnROdHNCMWdwanZxd0JFRGg2TEt5NHRZUUdSL0lJT3RVaFB4TE8xaTMvRlo4Q0l5cDZGbjZXUjdLMWZZci82UTBtN2p0SitLY0pmaTUvTSt2VXZnekpoZWdsTHBLaEVOZVhFYjBNR0VOTmc3VlpVVFFhNkdlWkdjclpmWmhPdlkwOEZMdm1qTTh2c3RFWXUwbnpNWlpGTm5aMnlQcG9EN1dtQlAvL0V4YXdURGUxaTlyME42OFdjMFlTcXo2VFJJU0w2MThhaWExQi9BdDBUS1Z0WHBlY0hSa25KUGZKTDdLV05FZTNCcWxBNWR1QXBXbG5zdjA5R2lMZFp1WjlMQURJMGx2eWZnNU9NWFlEcVdLY2I2YkVXY0Y2MEd5WWhpVnlxVTJDUm9oRlNLQ1RmdXVXRXZPSy93M2IzSXVTYXdXVWR2N25BQjY1N0p3YWVLK2xBUTZBai9vMnM5aWpmWEJmSGg3K2d6NUZSb2dRcW53UFZCNkdvOEo3WnBOQUF1QUxJT0cwWHUwUDBDeGcvSHpTT1hVZEhUZnU1TWNObUtuTEhnZE54MGgrTFA0WFhQY3BnZDBKdEZXWWJKREo0RG82V3dKWlFPMERGa3F2UXZkNjFHRXNGZ1dPcEhhM2lMckp5NGRDcmlYWmxtSXBmNWdBOVpqNm0rRU4wWnYrTXdVVUp4K09xWUx4T21aL2hmejlLOG9oL0JKVFQ4M2pZYVl5V2ZVdlNoUVBhYm9OWEpSMHN3VFRrdnN6UTBxejV4dz0iLCJpYXQiOjE2ODA1Mjc5Nzd9.HkT7KvNULrC5PB4Z-r8CqeX5cE2WsCY-QIIY_lIQMSo"
/// profile : {"id":2,"userId":2,"name":"Harsh","dob":"2000-03-01T00:00:00.000Z","height":180,"weight":55,"createdAt":"2023-04-03T12:52:29.000Z","updatedAt":"2023-04-03T12:52:29.000Z","deletedAt":null}

class VerifyOtpResponse {
  VerifyOtpResponse({
    String? token,
    String? uuid,
    String? refreshToken,
    PersonalInfo? profile,
  }) {
    _token = token;
    _uuid = uuid;
    _refreshToken = refreshToken;
    _profile = profile;
  }

  VerifyOtpResponse.fromJson(dynamic json) {
    _token = json['token'];
    _uuid = json['uuid'];
    _refreshToken = json['refreshToken'];
    _profile =
        json['profile'] != null ? PersonalInfo.fromJson(json['profile']) : null;
  }
  String? _token;
  String? _uuid;
  String? _refreshToken;
  PersonalInfo? _profile;
  VerifyOtpResponse copyWith({
    String? token,
    String? uuid,
    String? refreshToken,
    PersonalInfo? profile,
  }) =>
      VerifyOtpResponse(
        token: token ?? _token,
        refreshToken: refreshToken ?? _refreshToken,
        uuid: uuid ?? _uuid,
        profile: profile ?? _profile,
      );
  String? get token => _token;
  String? get uuid => _uuid;
  String? get refreshToken => _refreshToken;
  PersonalInfo? get profile => _profile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    map['uuid'] = _uuid;
    map['refreshToken'] = _refreshToken;
    if (_profile != null) {
      map['profile'] = _profile?.toJson();
    }
    return map;
  }
}
