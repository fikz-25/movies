abstract class HomeEvent {}

class GetAll implements HomeEvent {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}
