#!/bin/bash
# Verwaltung für Docker: Service + Socket (mit sauberer Reihenfolge)
set -euo pipefail

SERVICE="docker.service"
SOCKET="docker.socket"

need_root() {
  if [[ $EUID -ne 0 ]]; then
    echo "❌ Bitte als Root oder mit sudo ausführen!"
    exit 1
  fi
}

has_unit() {
  systemctl list-unit-files --type=service --type=socket | grep -q "^$1"
}

status_line() {
  local u="$1"
  if systemctl is-active --quiet "$u"; then
    echo "✅ $u aktiv"
  else
    echo "❌ $u inaktiv"
  fi
}

usage() {
  echo "Verwendung: $0 {start|stop|restart|status|enable|disable|mask|unmask}"
  exit 1
}

[[ $# -ge 1 ]] || usage
need_root

CMD="$1"

# Existenz-Check (macht nichts kaputt, falls Socket auf dem System nicht existiert)
HAS_SOCKET=false
if has_unit "$SOCKET"; then HAS_SOCKET=true; fi

case "$CMD" in
  start)
    echo "▶️  Starte Docker (Socket → Service)..."
    $HAS_SOCKET && systemctl start "$SOCKET"
    systemctl start "$SERVICE"
    systemctl --no-pager status "$SERVICE"
    ;;
  stop)
    echo "⏹  Stoppe Docker (Socket → Service)..."
    $HAS_SOCKET && systemctl stop "$SOCKET" || true
    systemctl stop "$SERVICE" || true
    systemctl reset-failed "$SERVICE" || true
    ;;
  restart)
    echo "🔁  Starte Docker neu..."
    systemctl restart "$SERVICE"
    ;;
  status)
    echo "ℹ️  Status:"
    status_line "$SERVICE"
    $HAS_SOCKET && status_line "$SOCKET" || echo "ℹ️ $SOCKET nicht vorhanden"
    ;;
  enable)
    echo "✅  Aktiviere Autostart..."
    $HAS_SOCKET && systemctl enable "$SOCKET"
    systemctl enable "$SERVICE"
    ;;
  disable)
    echo "🚫  Deaktiviere Autostart & stoppe..."
    # --now stoppt gleich mit
    $HAS_SOCKET && systemctl disable --now "$SOCKET" || true
    systemctl disable --now "$SERVICE" || true
    systemctl reset-failed "$SERVICE" || true
    ;;
  mask)
    echo "🧱  Maskiere Units (verhindert jeglichen Auto-Start)..."
    $HAS_SOCKET && systemctl mask "$SOCKET" || true
    systemctl mask "$SERVICE"
    ;;
  unmask)
    echo "🧩  Entmaske Units..."
    $HAS_SOCKET && systemctl unmask "$SOCKET" || true
    systemctl unmask "$SERVICE"
    ;;
  *)
    usage
    ;;
esac
