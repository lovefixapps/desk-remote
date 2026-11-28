import 'package:flutter/material.dart';
import 'package:flutter_hbb/common.dart';
import 'package:flutter_hbb/consts.dart';
import 'package:flutter_hbb/desktop/pages/desktop_setting_page.dart';
import 'package:flutter_hbb/desktop/pages/desktop_tab_page.dart';
import 'package:flutter_hbb/desktop/widgets/tabbar_widget.dart';
import 'package:flutter_hbb/models/platform_model.dart';
import 'package:flutter_hbb/models/peer_tab_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:window_manager/window_manager.dart';

class DesktopMenuBar extends StatelessWidget {
  const DesktopMenuBar({Key? key, required this.controller}) : super(key: key);

  final DesktopTabController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _MenuGroup(
          label: 'File',
          items: [
            _MenuAction(
              label: 'New connection',
              icon: Icons.add_link_rounded,
              onPressed: _showHome,
            ),
            _MenuAction(
              label: 'Settings',
              icon: Icons.settings_outlined,
              onPressed: () => DesktopTabPage.onAddSetting(),
            ),
            _MenuAction(
              label: 'Quit',
              icon: Icons.exit_to_app_rounded,
              onPressed: windowManager.close,
            ),
          ],
        ),
        _MenuGroup(
          label: 'View',
          items: [
            _MenuAction(
              label: 'Home',
              icon: Icons.home_outlined,
              onPressed: _showHome,
            ),
            _MenuAction(
              label: 'Full Screen',
              icon: Icons.fullscreen_rounded,
              onPressed: _toggleFullScreen,
            ),
          ],
        ),
        _MenuGroup(
          label: 'Tools',
          items: [
            _MenuAction(
              label: 'Address Book',
              icon: Icons.contacts_outlined,
              onPressed: _showAddressBook,
            ),
            _MenuAction(
              label: 'Settings',
              icon: Icons.tune_rounded,
              onPressed: () => DesktopTabPage.onAddSetting(),
            ),
          ],
        ),
        _MenuGroup(
          label: 'Help',
          items: [
            _MenuAction(
              label: 'Documentation',
              icon: Icons.menu_book_outlined,
              onPressed: () => launchUrl(
                Uri.parse('https://rustdesk.com/docs/'),
              ),
            ),
            _MenuAction(
              label: 'About',
              icon: Icons.info_outline_rounded,
              onPressed: () => DesktopTabPage.onAddSetting(
                initialPage: SettingsTabKey.about,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showHome() {
    controller.jumpToByKey(kTabLabelHomePage);
  }

  void _showAddressBook() {
    _showHome();
    if (!bind.isDisableAb() && !bind.isDisableAccount()) {
      gFFI.peerTabModel.setCurrentTab(PeerTabIndex.ab.index);
    }
  }

  Future<void> _toggleFullScreen() async {
    await windowManager.setFullScreen(!(await windowManager.isFullScreen()));
  }
}

class _MenuAction {
  const _MenuAction({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
}

class _MenuGroup extends StatefulWidget {
  const _MenuGroup({required this.label, required this.items});

  final String label;
  final List<_MenuAction> items;

  @override
  State<_MenuGroup> createState() => _MenuGroupState();
}

class _MenuGroupState extends State<_MenuGroup> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PopupMenuButton<_MenuAction>(
      tooltip: translate(widget.label),
      onSelected: (action) => action.onPressed(),
      color: theme.cardColor,
      elevation: 12,
      surfaceTintColor: Colors.transparent,
      offset: const Offset(0, 8),
      constraints: const BoxConstraints(minWidth: 184, maxWidth: 216),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: theme.dividerColor.withOpacity(0.7)),
      ),
      menuPadding: const EdgeInsets.symmetric(vertical: 4),
      itemBuilder: (context) => widget.items
          .map(
            (action) => PopupMenuItem<_MenuAction>(
              value: action,
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: MyTheme.accent.withOpacity(
                          theme.brightness == Brightness.dark ? 0.16 : 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      action.icon,
                      size: 14,
                      color: MyTheme.accent,
                    ),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      translate(action.label),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 1),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _isHovered
                ? MyTheme.accent.withOpacity(
                    theme.brightness == Brightness.dark ? 0.16 : 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Text(
            translate(widget.label),
            style: TextStyle(
              color: _isHovered ? MyTheme.accent : theme.hintColor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.15,
            ),
          ),
        ),
      ),
    );
  }
}
