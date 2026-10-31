import 'package:bookia/core/networking/api_endpoints.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/features/profile/data/model/profile_data_model.dart';

class ProfileRepo {
  static getProfileData() async {
    try {
      final response = await DioFactory.dio?.get(ApiEndpoints.profile);
      if (response?.statusCode == 200) {
        ProfileDataModel profiledata = ProfileDataModel.fromJson(
          response?.data,
        );
        return profiledata;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
