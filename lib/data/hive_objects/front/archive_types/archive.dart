import 'package:system_mapper/data/hive_objects/front/archive_types/single_front/single_front_archive.dart';
import 'package:system_mapper/data/hive_objects/front/archive_types/standard/front_archive.dart';

class Archive {
  final StandardFrontArchive standardArchive;
  final SingleFrontArchive singleArchive;

  const Archive({required this.standardArchive, required this.singleArchive});
}
