import '/components/buttons/suggestion_button/suggestion_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'empty_chat_state_widget.dart' show EmptyChatStateWidget;
import 'package:flutter/material.dart';

class EmptyChatStateModel extends FlutterFlowModel<EmptyChatStateWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for SuggestionButton component.
  late SuggestionButtonModel suggestionButtonModel1;
  // Model for SuggestionButton component.
  late SuggestionButtonModel suggestionButtonModel2;
  // Model for SuggestionButton component.
  late SuggestionButtonModel suggestionButtonModel3;
  // Model for SuggestionButton component.
  late SuggestionButtonModel suggestionButtonModel4;

  @override
  void initState(BuildContext context) {
    suggestionButtonModel1 =
        createModel(context, () => SuggestionButtonModel());
    suggestionButtonModel2 =
        createModel(context, () => SuggestionButtonModel());
    suggestionButtonModel3 =
        createModel(context, () => SuggestionButtonModel());
    suggestionButtonModel4 =
        createModel(context, () => SuggestionButtonModel());
  }

  @override
  void dispose() {
    suggestionButtonModel1.dispose();
    suggestionButtonModel2.dispose();
    suggestionButtonModel3.dispose();
    suggestionButtonModel4.dispose();
  }
}
