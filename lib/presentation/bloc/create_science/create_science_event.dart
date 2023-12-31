part of 'create_science_bloc.dart';

abstract class CreateScienceEvent extends Equatable {
  const CreateScienceEvent();
}

class CreateScienceNameEvent extends CreateScienceEvent{
  late String name;
  late bool isPrivate;
  late int scienceTypeId;
  late int userId;
  // late File? phoroUrl;

  CreateScienceNameEvent({
    required this.name,
    required this.isPrivate,
    required this.scienceTypeId,
    required this.userId,
    // required this.phoroUrl,
});

  @override
  List<Object?> get props =>[name,isPrivate,scienceTypeId,userId];
}
