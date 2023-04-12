import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_admin/blocs/suggestion/suggestion_bloc.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_action_button.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_progress_indicator.dart';
import 'package:onlinediagnostic_admin/ui/widgets/suggestions/suggestion_card.dart';

class FeedbacksScreen extends StatefulWidget {
  const FeedbacksScreen({super.key});

  @override
  State<FeedbacksScreen> createState() => _FeedbacksScreenState();
}

class _FeedbacksScreenState extends State<FeedbacksScreen> {
  SuggestionBloc suggestionBloc = SuggestionBloc();

  @override
  void initState() {
    suggestionBloc.add(GetAllSuggestionEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
        child: BlocProvider<SuggestionBloc>.value(
          value: suggestionBloc,
          child: BlocConsumer<SuggestionBloc, SuggestionState>(
            listener: (context, state) {
              if (state is SuggestionFailureState) {
                showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    title: 'Failure',
                    message: state.message,
                    primaryButtonLabel: 'Ok',
                  ),
                );
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  state is SuggestionLoadingState
                      ? const Center(
                          child: CustomProgressIndicator(),
                        )
                      : Expanded(
                          child: state is SuggestionSuccessState
                              ? state.suggestions.isNotEmpty
                                  ? SingleChildScrollView(
                                      child: Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        alignment: WrapAlignment.start,
                                        children: List<Widget>.generate(
                                          state.suggestions.length,
                                          (index) => SuggestionCard(
                                            suggestionDetails:
                                                state.suggestions[index],
                                          ),
                                        ),
                                      ),
                                    )
                                  : const Center(
                                      child: Text('No Suggestions Found!'),
                                    )
                              : state is SuggestionFailureState
                                  ? Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomActionButton(
                                            iconData: Icons.replay_outlined,
                                            onPressed: () {
                                              suggestionBloc
                                                  .add(GetAllSuggestionEvent());
                                            },
                                            label: 'Retry',
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                        ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
