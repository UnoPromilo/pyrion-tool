import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:function_tree/function_tree.dart';
import 'package:logging/logging.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../styles/app_sizes.dart';

class NumberInput extends StatefulWidget {
  const NumberInput({
    super.key,
    this.decimalDigits = 0,
    this.maxValue,
    this.minValue,
    this.step = 1,
    this.unit = '',
    this.enabled = true,
    this.onChanged,
    this.value,
  });

  final String unit;
  final double step;
  final double? maxValue;
  final double? minValue;
  final int decimalDigits;
  final bool enabled;
  final num? value;
  final ValueChanged<num>? onChanged;

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController(text: '0');
  NumberFormat _format = NumberFormat();

  @override
  void initState() {
    super.initState();
    _refreshFormat();
    _reformat();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant NumberInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    _refreshFormat();
    if (widget.value != null && widget.value != oldWidget.value) {
      _replace(widget.value!);
    }
    _reformat();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          spacing: AppSizes.extraSpacingSmall,
          children: [
            Expanded(
              child: ShadInput(
                enabled: widget.enabled,
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                ),
                controller: _controller,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9\-+*/,. ]')),
                ],
                trailing: Text(widget.unit),
                focusNode: _focusNode,
              ),
            ),
            SizedBox(
              height: 38,
              child: Column(
                spacing: AppSizes.extraSpacingSmall,
                children: [
                  Expanded(
                    child: ShadIconButton.outline(
                      enabled: widget.enabled,
                      width: 20,
                      iconSize: 10,
                      icon: const Icon(LucideIcons.arrowUp),
                      onPressed: () => _step(widget.step),
                    ),
                  ),
                  Expanded(
                    child: ShadIconButton.outline(
                      enabled: widget.enabled,
                      width: 20,
                      iconSize: 10,
                      icon: const Icon(LucideIcons.arrowDown),
                      onPressed: () => _step(-widget.step),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _step(double delta) {
    _replace(_tryParse() + delta);
    _reformat();
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus == false) {
      _reformat();
    }
  }

  num _tryParse() {
    // TODO work a bit about culture safety
    final text = _controller.text
        .replaceAll(_format.symbols.DECIMAL_SEP, '.')
        .replaceAll(',', '')
        .trim();
    if (text.isEmpty) {
      return 0;
    }
    try {
      final value = text.interpret();
      final lowerLimit = widget.minValue ?? 0;
      final upperLimit = widget.maxValue ?? double.infinity;
      return value.clamp(lowerLimit, upperLimit);
    } catch (e) {
      Logger('NumberInput').warning('Invalid input: $text', e);
      return 0;
    }
  }

  void _reformat() {
    _replace(_tryParse());
  }

  void _replace(num value) {
    final newValue = _format.format(value);
    if (newValue == _controller.text) {
      return;
    }

    _controller.text = newValue;
    widget.onChanged?.call(value);
  }

  void _refreshFormat() {
    _format = NumberFormat.decimalPatternDigits(
      decimalDigits: widget.decimalDigits,
    );
  }
}
