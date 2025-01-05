import 'package:eiviznho/app/ui/themes/colors.dart';
import 'package:flutter/material.dart';

class BaseList<T extends Object> extends StatelessWidget {
  final bool isLoading;
  final String emptyMessage;
  final List<T> data;
  final Widget Function(T item) itemBuilder;

  const BaseList({
    super.key,
    required this.isLoading,
    required this.emptyMessage,
    required this.data,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 46),
        child: Column(
          children: [
            isLoading
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.textPrimary,
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : data.isEmpty
                    ? Expanded(
                        child: Center(
                          child: Text(emptyMessage),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 45),
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                              child: itemBuilder(data[index]),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
