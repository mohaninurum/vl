abstract class ImageSliderEvent {}

class StartSliderEvent extends ImageSliderEvent {}

class NextImageEvent extends ImageSliderEvent {}

class SelectImageEvent extends ImageSliderEvent {
  final int index;
  SelectImageEvent(this.index);
}
