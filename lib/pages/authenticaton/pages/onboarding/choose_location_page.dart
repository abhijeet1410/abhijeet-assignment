import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/app_configs/environment.dart';
import 'package:flutter_mobile_template/utils/app_auth_helper.dart';
import 'package:flutter_mobile_template/utils/check_permissions.dart';
import 'package:flutter_mobile_template/utils/snackbar_helper.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_primary_button.dart';
import 'package:flutter_mobile_template/widgets/app_loader.dart';
import 'package:flutter_mobile_template/widgets/place_picker.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:location/location.dart' as myLocation;

///
/// Created by Kumar Sunil from Boiler plate
///
class ChooseLocationPage extends StatefulWidget {
  static const routeName = '/ChooseLocationPage';
  @override
  _ChooseLocationPageState createState() => _ChooseLocationPageState();
}

class _ChooseLocationPageState extends State<ChooseLocationPage> {
  late GoogleMapsGeocoding _geocoding;

  String? _pinCode;

  @override
  void initState() {
    super.initState();
    _geocoding = GoogleMapsGeocoding(apiKey: Environment.mapApiKey);
  }

  @override
  void dispose() {
    _geocoding.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                Center(
                  child: Text('See which services are available\nnear you.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24)),
                ),
                SizedBox(height: 22),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                  child: Material(
                    color: Colors.grey[500],
                    shape: StadiumBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () async {
                        final value = await Get.to(PlacePicker());
                        if (value != null && value is GeocodingResult) {
                          setState(() {
                            _pinCode =
                                _validatePinCode(value.addressComponents);
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Icon(Icons.location_on_rounded, size: 34),
                            Flexible(
                                child: Text(
                              _pinCode ?? 'Address or Zip Code',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                    child: AppPrimaryButton(
                        child: Text('Submit'),
                        onPressed: _pinCode == null
                            ? null
                            : () {
                                Navigator.push(context, LoaderOverlay());
                                _updatePinCode(_pinCode!);
                              })),
                SizedBox(height: 22),
                Center(
                  child: Text('OR',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                  child: Material(
                    color: Color(0xffA59FFF),
                    shape: StadiumBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        Navigator.push(context, LoaderOverlay());
                        try {
                          myLocation.LocationData data =
                              await CheckPermissions.requestLocation();

                          final geocodingResult =
                              await _geocoding.searchByLocation(
                                  Location(data.latitude, data.longitude));
                          // Navigator.pop(context);
                          final result = _validatePinCode(
                              geocodingResult.results[0].addressComponents);
                          if (result != null) {
                            _updatePinCode(result);
                          }
                        } catch (e) {
                          Navigator.pop(context);
                          SnackBarHelper.show('Error', e.toString());
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Icon(Icons.add_location, size: 26),
                            SizedBox(width: 12),
                            Flexible(
                                child: Text(
                              'Use current location',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  String? _validatePinCode(List<AddressComponent?> addressComponents) {
    final String? _pin = addressComponents
        .lastWhere(
            (element) => ListEquality().equals(element!.types, ["postal_code"]),
            orElse: () => null)
        ?.longName;
    log('$_pin');
    if (_pin == null) {
      SnackBarHelper.show('Error', 'Unable to get postal code.');
      return null;
    } else {
      return _pin;
    }
  }

  _updatePinCode(String pin) {
    AuthHelper.updateUserPinCode(pin).then((value) {
      // if (Get.previousRoute == UserDashboardPage.routeName) {
      Get.back();
      // } else
      //   Get.offAllNamed(UserDashboardPage.routeName);
    }).catchError((e, s) {
      Navigator.pop(context);
      log('Error', stackTrace: s, error: e);
      SnackBarHelper.show('Error', e.toString());
    });
  }
}
