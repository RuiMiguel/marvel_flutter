import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/bloc/comics/comics_bloc.dart';
import 'package:marvel/ui/comics/home_grid.dart';
import 'package:marvel/ui/comics/home_list.dart';
import 'package:marvel/ui/commons/error_view.dart';
import 'package:marvel/ui/commons/legal_info.dart';
import 'package:marvel/ui/commons/loading_view.dart';

class ComicsScreen extends StatelessWidget {
  const ComicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<ComicsBloc>(context);

    return BlocBuilder<ComicsBloc, ComicsState>(
      builder: (context, state) {
        var legal = '';
        var count = 0;
        var total = 0;

        if (state is ComicsInitial) bloc.add(LoadComics());

        if (state is ComicsSuccess) {
          legal = state.legal;
          count = state.count;
          total = state.total;
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              bloc.add(GetMore());
              return true;
            }
            return false;
          },
          child: Column(
            children: [
              Expanded(
                child: OrientationBuilder(
                  builder: (context, orientation) {
                    if (state is ComicsLoading) {
                      return const LoadingView();
                    } else if (state is Error) {
                      return const ErrorView();
                    } else if (state is ComicsSuccess) {
                      if (orientation == Orientation.landscape) {
                        return HomeListView(
                          comics: state.comics,
                        );
                      } else {
                        return HomeGridView(
                          comics: state.comics,
                        );
                      }
                    } else {
                      return const ErrorView();
                    }
                  },
                ),
              ),
              LegalInfo(
                legal: legal,
                count: count,
                total: total,
              ),
            ],
          ),
        );
      },
    );
  }
}
