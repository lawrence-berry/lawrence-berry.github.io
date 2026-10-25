#!/bin/sh
# Smoke-tests the installer's Linux path in a throwaway Ubuntu container:
# runs the live bootstrap, then checks each cross-platform repo left its hook.
# Needs Docker. The macOS path (brew, iTerm, Karabiner) can't run in a
# container, so test that on a real Mac.
#
#   ./smoke-test.sh [url]        # defaults to the live Pages URL
set -eu
url="${1:-https://lawrence-berry.github.io/setup}"

docker run --rm "ubuntu:24.04" bash -c '
  set -e
  # git present so the bootstrap skips its git-install branch; curl to fetch it.
  apt-get update -qq && apt-get install -y -qq curl git ca-certificates >/dev/null

  curl -fsSL '"$url"' | sh

  echo "--- checks ---"
  fail=0
  grep -q "# setup-shell$" ~/.bashrc                                   && echo "ok  setup-shell rc line"      || { echo "FAIL setup-shell";  fail=1; }
  git config --global --get-all include.path | grep -q "setup-git/gitconfig$" && echo "ok  setup-git include"  || { echo "FAIL setup-git";    fail=1; }
  grep -q "setup-ssh/config$" ~/.ssh/config                           && echo "ok  setup-ssh include"       || { echo "FAIL setup-ssh";    fail=1; }
  [ -L ~/.irbrc ]                                                     && echo "ok  setup-ruby symlink"      || { echo "FAIL setup-ruby";   fail=1; }
  [ -f ~/.secrets/secrets.sh ]                                        && echo "ok  setup-secrets file"      || { echo "FAIL setup-secrets"; fail=1; }
  # Named packages install only those, and an unknown name stops the run.
  rm -rf ~/Projects/util ~/.secrets
  curl -fsSL '"$url"' | sh -s -- git ssh
  [ -d ~/Projects/util/setup-git ] && [ ! -d ~/Projects/util/setup-ruby ]  && echo "ok  package args" || { echo "FAIL package args"; fail=1; }
  curl -fsSL '"$url"' | sh -s -- nope 2>/dev/null                     && { echo "FAIL unknown package"; fail=1; } || echo "ok  unknown package stops"
  exit $fail
'
echo "smoke test passed"
