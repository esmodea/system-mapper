import 'package:flutter/material.dart';
import 'package:system_mapper/data/hive_objects/front/archive_types/standard/front.dart';
import 'package:system_mapper/data/hive_objects/front/archive_types/standard/front_archive.dart';
import 'package:system_mapper/data/model_classes/base_model.dart';
import 'package:system_mapper/utils/current.dart';

enum SystemFrontType {
  onlyTrackFront(
    currentId: 'current-front-id',
    currentArchiveId: 'current-front-archive-id',
    label: 'Default',
    icon: Icons.self_improvement,
  ),
  trackSingleFront(
    currentId: '',
    currentArchiveId: 'current-single-front-archive-id',
    label: 'Only track one fronter',
    icon: Icons.account_circle,
  ),
  trackMultipleFronts(
    currentId: '',
    currentArchiveId: 'current-track-multiple-fronts-archive-id',
    label: '',
    icon: Icons.self_improvement,
  ),
  trackSingleFrontNoCoConscious(
    currentId: '',
    currentArchiveId: 'current-track-single-front-no-cc-archive-id',
    label: '',
    icon: Icons.account_circle_outlined,
  ),
  trackMultipleFrontsNoCoConscious(
    currentId: '',
    currentArchiveId: 'current-track-multiple-fronts-no-cc-archive-id',
    label: '',
    icon: Icons.self_improvement,
  );

  final String currentId;
  final String currentArchiveId;
  final String label;
  final IconData icon;
  const SystemFrontType({
    required this.currentId,
    required this.currentArchiveId,
    required this.label,
    required this.icon,
  });

  BaseModel archiveBoxType() {
    switch (this) {
      case onlyTrackFront:
        return StandardFrontArchive();
      case trackSingleFront:
        return StandardFrontArchive();
      case trackMultipleFronts:
        return StandardFrontArchive();
      case trackSingleFrontNoCoConscious:
        return StandardFrontArchive();
      case trackMultipleFrontsNoCoConscious:
        return StandardFrontArchive();
    }
  }

  BaseModel boxType() {
    switch (this) {
      case onlyTrackFront:
        return StandardFront();
      case trackSingleFront:
        return StandardFront();
      case trackMultipleFronts:
        return StandardFront();
      case trackSingleFrontNoCoConscious:
        return StandardFront();
      case trackMultipleFrontsNoCoConscious:
        return StandardFront();
    }
  }

  BaseModel? current() {
    return Current.standardFrontArchive;
  }

  static SystemFrontType parse(String str) {
    if (str != '') {
      return values.firstWhere((type) => type.name == str);
    } else {
      return SystemFrontType.onlyTrackFront;
    }
  }

  @override
  String toString() {
    return name;
  }
}
