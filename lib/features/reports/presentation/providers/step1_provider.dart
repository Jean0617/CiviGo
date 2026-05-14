import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../config/route_config/route_paths.dart';
import '../../../shared/services/camera_service.dart';
import '../../../shared/services/location_service.dart';
import '../../data/models/step1_state.dart';
import 'new_incident_provider.dart';

part 'step1_provider.g.dart';

@riverpod
class Step1 extends _$Step1 {
  
  @override
  Step1State build() => Step1State();

  void setAnimate(bool value) {
    state = state.copyWith(animate: value);
  }

  void setOpenCamera(bool value) {
    state = state.copyWith(isOpeningCamera: value);
  }

  Future<void> takePhotoFlow(
    BuildContext context,
    WidgetRef ref,
  ) async {

    setOpenCamera(true);

    final result = await CameraService.instance.takePhoto(context);

    if (result == null || !context.mounted) {
      setOpenCamera(false);
      return;
    }

    // Obtener ubicación
    final position = await getCurrentLocation();
    if(position == null)return;

    ref.read(newIncidentProvider.notifier)
      ..setLocation(LatLng(position.latitude, position.longitude))
      ..setImagePath(result.path);
    
    if(!context.mounted)return;

    final bool? repeatPhoto = await context.pushNamed<bool>(
      RoutePaths.photoPreview,
    );

    if (repeatPhoto == true && context.mounted) {
      await takePhotoFlow(context, ref);
    }

    setOpenCamera(false);
  }
}


