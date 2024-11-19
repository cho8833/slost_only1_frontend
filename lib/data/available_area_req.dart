import 'package:json_annotation/json_annotation.dart';
import 'package:slost_only1/widget/select_address_modal.dart';

part 'available_area_req.g.dart';

@JsonSerializable(createFactory: false)
class AvailableAreaCreateReq {
  String sido;

  String sigungu;

  AvailableAreaCreateReq(this.sido, this.sigungu);

  Map<String ,dynamic> toJson() => _$AvailableAreaCreateReqToJson(this);

  factory AvailableAreaCreateReq.from(SelectedSigungu s) {
    return AvailableAreaCreateReq(s.sido, s.sigungu);
  }
}

@JsonSerializable(createFactory: false)
class AreaListReq {
  String sido;

  String sigungu;

  AreaListReq(this.sido, this.sigungu);

  Map<String, dynamic> toJson() => _$AreaListReqToJson(this);
}