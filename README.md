# Quicknote Splitter

- Splits a quicknote into separate files.
- Quicknote has H1 header, then blocks with content followed by `----`
- Separate notes get current timestamp (YYMMDDHHMM) plus first three words as title and headline
- Preparation: `cp $QUICKNOTE in.md`
- Usage: `./split.sh`