#!/usr/bin/env bash
# 1st National Novel Generation Month Generator.
# by Case Duckworth
# It's super dumb.  It picks 50,000 random words from $corpus and
# puts 'em together into novel.txt (IT'S HARDCODED!).

corpus="${1}"
[[ ! -r "$corpus" ]] && exit 1
volume="$(date '+%s')"
novel="novel_${volume}.txt"
wip=$(mktemp)

nWords=$(wc -l $corpus | cut -d' ' -f1)

echo "DUMB NOVEL ${volume}" >$wip
echo "by CASE DUCKWORTH + COMPUTER" >>$wip
l="==========================================================================="
echo "$l" >>$wip
echo >>$wip

for ((i=1; i<=50000; i++)); do
  n=$((RANDOM % (nWords + 1))) # BAD RANDOM! It's too small :(
  word=$(head -n${n} "${corpus}" | tail -n1)
  echo "${word}" >>$wip
  if ((i % 10 == 0)); then
    echo -n ','
  elif ((i % 100 == 0)); then
    echo -n ';'
  elif ((i % 1000 == 0)); then
    echo -n '@'
  else
    echo -n "."
  fi
done

fmt $wip >$novel
echo "Done!"
