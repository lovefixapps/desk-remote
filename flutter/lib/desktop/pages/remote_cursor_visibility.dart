bool shouldRenderRemoteCursor({
  required bool optionEnabled,
  required bool viewOnly,
  required bool remoteCursorMoved,
}) =>
    remoteCursorMoved && (optionEnabled || viewOnly);
