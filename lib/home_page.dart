import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/amphibians_bloc.dart';
import 'models/amphibian.dart';

class HomePage extends StatelessWidget {
  HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Amphibians'),
      ),
      body: BlocBuilder<AmphibiansBloc, AmphibiansState>(
        builder: (context, state) {
          if (state is AmphibiansLoadingState) {
            return _loadingWidget();
          } else if (state is AmphibiansUnAvailableState) {
            return _emptyContentWidget();
          } else if (state is AmphibiansErrorState) {
            return _errorWidget(state.errorMsg);
          } else if (state is AmphibiansAvailableState) {
            return RefreshIndicator(
              child: _availableContentWidget(state.amphibians),
              onRefresh: () async {
                BlocProvider.of<AmphibiansBloc>(context).add(
                  GetAllAmpibiansEvent(),
                );
              },
            );
          }
          return Container(
            child: Text("Default state"),
          );
        },
      ),
    );
  }

  Widget _availableContentWidget(List<Amphibian> amphibians) {
    return ListView.builder(
      itemCount: amphibians.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text("${amphibians[index].name}"),
          subtitle: Text("${amphibians[index].type}"),
        );
      },
    );
  }

  Widget _errorWidget(String message) {
    return Center(
      child: Text("There has been an error\n${message}"),
    );
  }

  Widget _emptyContentWidget() =>
      Center(child: Text("No content to show, try again"));

  Widget _loadingWidget() => Center(child: CircularProgressIndicator());
}
