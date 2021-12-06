/*
 * Copyright (C) 2019-2021 HERE Europe B.V.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 * License-Filename: LICENSE
 */

import 'package:flutter/material.dart';
import 'package:govan/views/search_result_metadata.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/gestures.dart';
import 'package:here_sdk/mapview.dart';
import 'package:here_sdk/search.dart';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'search_result_metadata.dart';

// A callback to notify the hosting widget.
typedef ShowDialogFunction = void Function(String title, String message);

class GesturesExample {
  final HereMapController _hereMapController;
  final ShowDialogFunction _showDialog;
  MapImage? _poiMapImage;
  List<MapMarker> _mapMarkerList = [];
  late SearchEngine _searchEngine;

  GesturesExample(ShowDialogFunction showDialogCallback, BuildContext context,
      HereMapController hereMapController)
      : _showDialog = showDialogCallback,
        _hereMapController = hereMapController {
    double distanceToEarthInMeters = 8000;
    _hereMapController.camera.lookAtPointWithDistance(
        GeoCoordinates(-21.2231767, -50.4430845), distanceToEarthInMeters);

    _setTapGestureHandler();
    _setDoubleTapGestureHandler();
    _setTwoFingerTapGestureHandler();
    _setLongPressGestureHandler(context);

    _showDialog(
      "Selecione a localização",
      "Toque em um lugar para selecionar a localização",
    );
  }

  void _pickMapMarker(Point2D touchPoint) {
    double radiusInPixel = 2;
    _hereMapController.pickMapItems(touchPoint, radiusInPixel,
        (pickMapItemsResult) {
      if (pickMapItemsResult == null) {
        // Pick operation failed.
        return;
      }
      List<MapMarker> mapMarkerList = pickMapItemsResult.markers;
      if (mapMarkerList.length == 0) {
        print("No map markers found.");
        return;
      }

      MapMarker topmostMapMarker = mapMarkerList.first;
      Metadata? metadata = topmostMapMarker.metadata;
      if (metadata != null) {
        CustomMetadataValue? customMetadataValue =
            metadata.getCustomValue("key_search_result");
        if (customMetadataValue != null) {
          SearchResultMetadata searchResultMetadata =
              customMetadataValue as SearchResultMetadata;
          String title = searchResultMetadata.searchResult.title;
          String vicinity =
              searchResultMetadata.searchResult.address.addressText;
          _showDialog(
              "Picked Search Result", title + ". Vicinity: " + vicinity);
          return;
        }
      }

      double lat = topmostMapMarker.coordinates.latitude;
      double lon = topmostMapMarker.coordinates.longitude;
      _showDialog("Picked Map Marker", "Geographic coordinates: $lat, $lon.");
    });
  }

  void _setTapGestureHandler() {
    _hereMapController.gestures.tapListener = TapListener((Point2D touchPoint) {
      _pickMapMarker(touchPoint);
    });
  }

  // void _setTapGestureHandler() {
  //   _hereMapController.gestures.tapListener = TapListener((Point2D touchPoint) {
  //     var geoCoordinates =
  //         _toString(_hereMapController.viewToGeoCoordinates(touchPoint));
  //     print('Tap at: $geoCoordinates');
  //   });
  // }

  void _setDoubleTapGestureHandler() {
    _hereMapController.gestures.doubleTapListener =
        DoubleTapListener((Point2D touchPoint) {
      var geoCoordinates =
          _toString(_hereMapController.viewToGeoCoordinates(touchPoint));
      print('DoubleTap at: $geoCoordinates');
    });
  }

  void _setTwoFingerTapGestureHandler() {
    _hereMapController.gestures.twoFingerTapListener =
        TwoFingerTapListener((Point2D touchCenterPoint) {
      var geoCoordinates =
          _toString(_hereMapController.viewToGeoCoordinates(touchCenterPoint));
      print('TwoFingerTap at: $geoCoordinates');
    });
  }

  void _setLongPressGestureHandler(BuildContext context) {
    _hereMapController.gestures.longPressListener =
        LongPressListener((GestureState gestureState, Point2D touchPoint) {
      if (gestureState == GestureState.begin) {
        GeoCoordinates? geoCoordinates =
            _hereMapController.viewToGeoCoordinates(touchPoint);
        if (geoCoordinates == null) {
          return;
        }
        _addPoiMapMarker(geoCoordinates);
        _getAddressForCoordinates(geoCoordinates);
        Navigator.of(context).pop(geoCoordinates);
      }
    });
  }

  Future<MapMarker> _addPoiMapMarker(GeoCoordinates geoCoordinates) async {
    // Reuse existing MapImage for new map markers.
    if (_poiMapImage == null) {
      Uint8List imagePixelData = await _loadFileAsUint8List('poi.png');
      _poiMapImage =
          MapImage.withPixelDataAndImageFormat(imagePixelData, ImageFormat.png);
    }

    MapMarker mapMarker = MapMarker(geoCoordinates, _poiMapImage!);
    _hereMapController.mapScene.addMapMarker(mapMarker);
    _mapMarkerList.add(mapMarker);

    return mapMarker;
  }

  Future<Uint8List> _loadFileAsUint8List(String fileName) async {
    // The path refers to the assets directory as specified in pubspec.yaml.
    ByteData fileData = await rootBundle.load('assets/' + fileName);
    return Uint8List.view(fileData.buffer);
  }

  Future<void> _getAddressForCoordinates(GeoCoordinates geoCoordinates) async {
    int maxItems = 1;
    SearchOptions reverseGeocodingOptions =
        SearchOptions(LanguageCode.enGb, maxItems);

    _searchEngine.searchByCoordinates(geoCoordinates, reverseGeocodingOptions,
        (SearchError? searchError, List<Place>? list) async {
      if (searchError != null) {
        _showDialog("Reverse geocoding", "Error: " + searchError.toString());
        return;
      }

      // If error is null, list is guaranteed to be not empty.
      _showDialog("Reverse geocoded address:", list!.first.address.addressText);
    });
  }

  String _toString(GeoCoordinates? geoCoordinates) {
    if (geoCoordinates == null) {
      // This can happen, when there is no map view touched, for example, when the screen was tilted and
      // the touch point is on the horizon.
      return "Error: No valid geo coordinates.";
    }

    return geoCoordinates.latitude.toString() +
        ", " +
        geoCoordinates.longitude.toString();
  }
}
