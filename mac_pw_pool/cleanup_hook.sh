#!/bin/bash
# GitHub Actions Runner Post-Job Cleanup Hook

# Help anybody debugging side-effects, since failures are ignored (by necessity).
set +e -x

CI_DIR="$HOME/ci"
TMPDIR="/private/tmp/ci/"

echo "Post-job cleanup started at $(date -u -Iseconds)"

# Golang will leave behind lots of read-only bits, ref:
# https://go.dev/ref/mod#module-cache
# However other tools/scripts could also set things read-only.
# At this point in CI, we really want all this stuff gone-gone,
# so there's actually zero-chance it can interfere.
chmod -R u+w /private/tmp/ci/* /private/tmp/ci/.??*

# This is defined as $TMPDIR during setup.  Name must be kept
# "short" as sockets may reside here.  Darwin suffers from
# the same limited socket-pathname character-length restriction
# as Linux.
rm -rf "$TMPDIR"/* "$TMPDIR"/.??*

# rm working dir
rm -rf "$CI_DIR"/* "$CI_DIR"/.??*


echo "Post-job cleanup complete at $(date -u -Iseconds)"

# Bash scripts exit with the status of the last command.
true
