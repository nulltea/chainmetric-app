///
//  Generated code. Do not modify.
//  source: status.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Status extends $pb.ProtobufEnum {
  static const Status UNKNOWN = Status._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UNKNOWN');
  static const Status OK = Status._(200, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OK');
  static const Status ACCEPTED = Status._(202, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ACCEPTED');
  static const Status NO_CONTENT = Status._(204, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NO_CONTENT');

  static const $core.List<Status> values = <Status> [
    UNKNOWN,
    OK,
    ACCEPTED,
    NO_CONTENT,
  ];

  static final $core.Map<$core.int, Status> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Status? valueOf($core.int value) => _byValue[value];

  const Status._($core.int v, $core.String n) : super(v, n);
}

