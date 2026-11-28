import 'package:flutter_hbb/desktop/pages/remote_cursor_visibility.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('keeps a visible pointer unless the remote cursor is rendered', () {
    expect(
      shouldRenderRemoteCursor(
        optionEnabled: false,
        viewOnly: false,
        remoteCursorMoved: true,
      ),
      isFalse,
    );
    expect(
      shouldRenderRemoteCursor(
        optionEnabled: true,
        viewOnly: false,
        remoteCursorMoved: true,
      ),
      isTrue,
    );
    expect(
      shouldRenderRemoteCursor(
        optionEnabled: false,
        viewOnly: true,
        remoteCursorMoved: true,
      ),
      isTrue,
    );
    expect(
      shouldRenderRemoteCursor(
        optionEnabled: true,
        viewOnly: false,
        remoteCursorMoved: false,
      ),
      isFalse,
    );
  });
}
