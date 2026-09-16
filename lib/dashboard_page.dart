import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'data/demo_data.dart';
import 'domain/fantasy_team.dart';
import 'domain/player.dart';
import 'domain/scoring_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  static const ScoringService _scoring = ScoringService();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final bool wide = constraints.maxWidth >= 920;
            return Row(
              children: <Widget>[
                if (wide)
                  _DesktopNavigation(
                    selectedIndex: _selectedIndex,
                    onSelect: _select,
                  ),
                Expanded(
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(
                          wide ? 42 : 20,
                          24,
                          wide ? 42 : 20,
                          44,
                        ),
                        sliver: SliverList.list(
                          children: <Widget>[
                            _Header(compact: !wide),
                            const SizedBox(height: 28),
                            if (_selectedIndex == 0)
                              const _Overview(scoring: _scoring),
                            if (_selectedIndex == 1)
                              const _Squad(scoring: _scoring),
                            if (_selectedIndex == 2) const _Standings(),
                            if (_selectedIndex == 3) const _AdminDemo(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: MediaQuery.sizeOf(context).width < 920
          ? NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _select,
              destinations: const <NavigationDestination>[
                NavigationDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  label: 'Overview',
                ),
                NavigationDestination(
                  icon: Icon(Icons.groups_outlined),
                  label: 'Squad',
                ),
                NavigationDestination(
                  icon: Icon(Icons.leaderboard_outlined),
                  label: 'Table',
                ),
                NavigationDestination(
                  icon: Icon(Icons.tune_outlined),
                  label: 'Admin',
                ),
              ],
            )
          : null,
    );
  }

  void _select(int index) {
    setState(() => _selectedIndex = index);
  }
}

class _DesktopNavigation extends StatelessWidget {
  const _DesktopNavigation({
    required this.selectedIndex,
    required this.onSelect,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      decoration: const BoxDecoration(
        color: Color(0xFF0E1728),
        border: Border(right: BorderSide(color: Color(0xFF223049))),
      ),
      padding: const EdgeInsets.fromLTRB(22, 30, 22, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _Brand(),
          const SizedBox(height: 42),
          _NavItem(
            index: 0,
            icon: Icons.dashboard_outlined,
            label: 'Overview',
            selected: selectedIndex == 0,
            onSelect: onSelect,
          ),
          _NavItem(
            index: 1,
            icon: Icons.groups_outlined,
            label: 'My squad',
            selected: selectedIndex == 1,
            onSelect: onSelect,
          ),
          _NavItem(
            index: 2,
            icon: Icons.leaderboard_outlined,
            label: 'Standings',
            selected: selectedIndex == 2,
            onSelect: onSelect,
          ),
          _NavItem(
            index: 3,
            icon: Icons.tune_outlined,
            label: 'Admin demo',
            selected: selectedIndex == 3,
            onSelect: onSelect,
          ),
          const Spacer(),
          const _DemoBadge(),
        ],
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: <Widget>[
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.mint,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: EdgeInsets.all(9),
            child: Icon(Icons.sports_soccer, color: AppColors.navy, size: 23),
          ),
        ),
        SizedBox(width: 12),
        Text(
          'Fantasy\nSoccer',
          style: TextStyle(
            fontSize: 18,
            height: 1.05,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.index,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onSelect,
  });

  final int index;
  final IconData icon;
  final String label;
  final bool selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        selected: selected,
        selectedTileColor: const Color(0x2443E6A0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Icon(icon, color: selected ? AppColors.mint : AppColors.muted),
        title: Text(
          label,
          style: TextStyle(
            color: selected ? AppColors.text : AppColors.muted,
            fontWeight: FontWeight.w700,
          ),
        ),
        onTap: () => onSelect(index),
      ),
    );
  }
}

class _DemoBadge extends StatelessWidget {
  const _DemoBadge();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.panel,
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      child: Padding(
        padding: EdgeInsets.all(14),
        child: Row(
          children: <Widget>[
            Icon(Icons.shield_outlined, color: AppColors.mint),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Portfolio demo\nSynthetic data',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.muted,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (compact) ...<Widget>[const _Brand(), const Spacer()] else
          const Spacer(),
        const Icon(Icons.notifications_none_rounded, color: AppColors.muted),
        const SizedBox(width: 18),
        const CircleAvatar(
          backgroundColor: AppColors.blue,
          child: Text('ZS', style: TextStyle(fontWeight: FontWeight.w800)),
        ),
      ],
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({required this.scoring});

  final ScoringService scoring;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'Good evening, Zvi',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 6),
        const Text('Match cycle 8 · private league overview'),
        const SizedBox(height: 28),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: <Widget>[
            const _MetricCard(
              label: 'League rank',
              value: '#1',
              icon: Icons.emoji_events_outlined,
              accent: AppColors.mint,
            ),
            const _MetricCard(
              label: 'Total points',
              value: '126',
              icon: Icons.bolt_outlined,
              accent: AppColors.blue,
            ),
            _MetricCard(
              label: 'Squad value',
              value: '${demoTeam.budgetUsed}/100',
              icon: Icons.account_balance_wallet_outlined,
              accent: const Color(0xFFF7C948),
            ),
            const _MetricCard(
              label: 'Transfer window',
              value: 'Open',
              icon: Icons.swap_horiz_rounded,
              accent: Color(0xFFB08CFF),
            ),
          ],
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final bool twoColumns = constraints.maxWidth >= 760;
            final Widget team = _TeamPreview(scoring: scoring);
            const Widget table = _StandingsCard();
            if (!twoColumns) {
              return Column(
                children: <Widget>[team, const SizedBox(height: 18), table],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(flex: 6, child: team),
                const SizedBox(width: 18),
                const Expanded(flex: 4, child: table),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.accent,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 205,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(icon, color: accent),
              const SizedBox(height: 18),
              Text(
                value,
                style: const TextStyle(
                  color: AppColors.text,
                  fontSize: 27,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}

class _TeamPreview extends StatelessWidget {
  const _TeamPreview({required this.scoring});

  final ScoringService scoring;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Current squad',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(width: 12),
                DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Color(0x2443E6A0),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    child: Text(
                      '${scoring.teamPoints(demoTeam)} pts',
                      style: const TextStyle(
                        color: AppColors.mint,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: <Color>[Color(0xFF184B35), Color(0xFF0D3828)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 20),
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                spacing: 8,
                runSpacing: 18,
                children: demoTeam.players
                    .map((Player player) {
                      return _PlayerChip(
                        player: player,
                        captain: player.id == demoTeam.captainId,
                        scoring: scoring,
                      );
                    })
                    .toList(growable: false),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlayerChip extends StatelessWidget {
  const _PlayerChip({
    required this.player,
    required this.captain,
    required this.scoring,
  });

  final Player player;
  final bool captain;
  final ScoringService scoring;

  @override
  Widget build(BuildContext context) {
    final bool darkShirt = player.shirtColor.computeLuminance() < 0.45;
    return SizedBox(
      width: 102,
      child: Column(
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              CircleAvatar(
                radius: 28,
                backgroundColor: player.shirtColor,
                child: Icon(
                  Icons.sports_soccer,
                  color: darkShirt ? Colors.white : AppColors.navy,
                ),
              ),
              if (captain)
                const Positioned(
                  right: -5,
                  top: -5,
                  child: CircleAvatar(
                    radius: 11,
                    backgroundColor: Color(0xFFF7C948),
                    child: Text(
                      'C',
                      style: TextStyle(
                        color: AppColors.navy,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            player.name.split(' ').first,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          Text(
            '${player.positionLabel} · ${scoring.playerPoints(player, isCaptain: captain)} pts',
            style: const TextStyle(color: Color(0xFFB9C8DD), fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _StandingsCard extends StatelessWidget {
  const _StandingsCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Top managers',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 18),
            ...demoStandings
                .take(4)
                .map((Standing standing) => _StandingRow(standing: standing)),
          ],
        ),
      ),
    );
  }
}

class _StandingRow extends StatelessWidget {
  const _StandingRow({required this.standing});

  final Standing standing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 28,
            child: Text(
              '${standing.rank}',
              style: const TextStyle(
                color: AppColors.muted,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  standing.team,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(
                  standing.manager,
                  style: const TextStyle(color: AppColors.muted, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            '${standing.points}',
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
          const SizedBox(width: 8),
          Icon(
            standing.trend > 0
                ? Icons.arrow_upward_rounded
                : standing.trend < 0
                ? Icons.arrow_downward_rounded
                : Icons.remove_rounded,
            size: 16,
            color: standing.trend > 0
                ? AppColors.mint
                : standing.trend < 0
                ? Colors.redAccent
                : AppColors.muted,
          ),
        ],
      ),
    );
  }
}

class _Squad extends StatelessWidget {
  const _Squad({required this.scoring});

  final ScoringService scoring;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text('My squad', style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 6),
        Text('${demoTeam.name} · ${demoTeam.budgetUsed}/100 budget used'),
        const SizedBox(height: 26),
        _TeamPreview(scoring: scoring),
        const SizedBox(height: 18),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: demoTeam.players
                  .map((Player player) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: player.shirtColor,
                        child: const Icon(
                          Icons.person_outline,
                          color: AppColors.navy,
                        ),
                      ),
                      title: Text(
                        player.name,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(
                        '${player.positionLabel} · Value ${player.value}',
                      ),
                      trailing: Text(
                        '${scoring.playerPoints(player, isCaptain: player.id == demoTeam.captainId)} pts',
                        style: const TextStyle(
                          color: AppColors.mint,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    );
                  })
                  .toList(growable: false),
            ),
          ),
        ),
      ],
    );
  }
}

class _Standings extends StatelessWidget {
  const _Standings();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'League standings',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 6),
        const Text('Overall table after match cycle 8'),
        const SizedBox(height: 26),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: demoStandings
                  .map((Standing standing) => _StandingRow(standing: standing))
                  .toList(growable: false),
            ),
          ),
        ),
      ],
    );
  }
}

class _AdminDemo extends StatelessWidget {
  const _AdminDemo();

  @override
  Widget build(BuildContext context) {
    const List<(IconData, String, String)> workflows =
        <(IconData, String, String)>[
          (
            Icons.person_add_alt_1_outlined,
            'Player roster',
            'Add players, set team colors and assign values.',
          ),
          (
            Icons.calendar_month_outlined,
            'Match cycles',
            'Open a cycle, schedule the transfer window and lock squads.',
          ),
          (
            Icons.sports_score_outlined,
            'Scoring events',
            'Record goals, assists, wins and clean sheets.',
          ),
          (
            Icons.sync_outlined,
            'Realtime standings',
            'Recalculate player and manager rankings after each match.',
          ),
        ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'Admin workflow',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 6),
        const Text('Read-only portfolio demonstration'),
        const SizedBox(height: 26),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: workflows
              .map(((IconData, String, String) item) {
                return SizedBox(
                  width: 320,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(item.$1, color: AppColors.mint, size: 30),
                          const SizedBox(height: 16),
                          Text(
                            item.$2,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 6),
                          Text(item.$3),
                        ],
                      ),
                    ),
                  ),
                );
              })
              .toList(growable: false),
        ),
      ],
    );
  }
}
