import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/features/location/presentation/cubit/location_cubit.dart';
import 'package:weather/core/sl/injection_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocProvider(
        create: (context) => sl<LocationCubit>()..getLocation(),
        child: BlocBuilder<LocationCubit, LocationState>(
          builder: (context, state) {
            if (state is LocationError) {
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message, textAlign: TextAlign.center),
                    ElevatedButton(
                      onPressed:
                          () => context.read<LocationCubit>().getLocation(),
                      child: Text("Request Permission Location Again"),
                    ),
                  ],
                ),
              );
            } else if (state is LocationLoaded) {
              return Center(child: Text(state.position.latitude.toString()));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
