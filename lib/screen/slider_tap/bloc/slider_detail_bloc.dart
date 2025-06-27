// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
//
// part 'slider_detail_event.dart';
// part 'slider_detail_state.dart';
//
// class SliderDetailBloc extends Bloc<SliderDetailEvent, SliderDetailState> {
//   SliderDetailBloc() : super(SliderDetailInitial()) {
//     on<SliderDetailEvent>((_onLoadSteps);
//   }
//   void _onLoadSteps(LoadProcessSteps event, Emitter<ProcessState> emit) {
//     final steps = [
//       ProcessStepModel(
//         title: "1. Research & Analysis",
//         description: "We understand your needs and goals.",
//         imageUrl: "https://example.com/images/research.png",
//       ),
//       ProcessStepModel(
//         title: "2. Design",
//         description: "We create visually appealing and usable UI.",
//         imageUrl: "https://example.com/images/design.png",
//       ),
//       ProcessStepModel(
//         title: "3. Development",
//         description: "We bring your ideas to life with code.",
//         imageUrl: "https://example.com/images/development.png",
//       ),
//     ];
//
//     emit(ProcessState(steps: steps, isLoading: false));
//   }
//
// }
