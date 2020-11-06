#! /bin/sh -e

# this script should not exist. there should instead be a borg cron
# subcommand that reads a freakin config file.
#
# that would need to be implemented in borg/archiver.py, with a hook
# in run() and a def do_cron() that would call do_create() and others.

# features missing from bup-cron:
# snapshots
# parity
# syslog
# timing

# export BORG_REPO=ssh://gizdov@emiko:15287/mnt/xpsbackup/borg
export BORG_REPO=ssh://emiko/mnt/xpsbackup/borg
# Setting this, so you won't be asked for your repository passphrase:
export BORG_PASSPHRASE='1528796xZ'
# check for more recent bup in /usr/local/
# PATH=$PATH:/usr/local/bin

# some helpers and error handling:
info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

info "Starting backup"

# custom tag for manual backups
tag="${1:-1}"

# this is how you bootstrap the repo
# borg init $REPOSITORY # todo: -e keyfile?

# if [ ! -d $REPOSITORY ]; then
#     mail -s "backups failed" root <<EOF
# $REPOSITORY not mounted, nightly backups failed

# you're on you're own buddy.

# email fired from $0
# EOF
# else
borg create                       \
    ::"{hostname}-{now}-${tag}" / \
    --verbose --stats --progress  \
    --compression lz4             \
    --exclude-from ./borg.exclude \
    --exclude-caches
# fi
