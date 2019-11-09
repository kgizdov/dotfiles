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

# REPOSITORY=emiko:/mnt/xpsbackup/borg
REPOSITORY=dantooine:/mnt/xps/borg

# check for more recent bup in /usr/local/
# PATH=$PATH:/usr/local/bin

# custom tag for manual backups
tag=$1

# this is how you bootstrap the repo
# borg init $REPOSITORY # todo: -e keyfile?

# if [ ! -d $REPOSITORY ]; then
#     mail -s "backups failed" root <<EOF
# $REPOSITORY not mounted, nightly backups failed

# you're on you're own buddy.

# email fired from $0
# EOF
# else
borg create                                                \
        -verbose --stats --progress                        \
        $REPOSITORY::$(hostname)-$(date +%Y-%m-%d)-$tag  / \
        --exclude-from ./borg.exclude                      \
        --exclude-caches
# fi
