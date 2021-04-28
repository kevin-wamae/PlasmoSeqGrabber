#!/bin/bash
#********************************************************
# a bash script for downloading genome datafiles from
# PlasmoDB.org using wget (https://www.gnu.org/software/wget/)
#********************************************************
# specify the version you want or use "Current_Release" for the latest
releaseVersion="release-51"

#-------------------------------------------------------
# start by creating a list of target genomes and you can
# include/exlude others based on available genomes, look
# up here https://plasmodb.org/common/downloads/Current_Release/
#-------------------------------------------------------
targetGenomes=(
               Pfalciparum3D7
               Pfalciparum7G8
               PfalciparumCD01
               PfalciparumDd2
               PfalciparumGA01
               PfalciparumGB4
               PfalciparumGN01
               PfalciparumHB3
               PfalciparumIT
               PfalciparumKE01
               PfalciparumKH01
               PfalciparumKH02
               PfalciparumML01
               PfalciparumSD01
               PfalciparumSN01
               PfalciparumTG01
               # PvivaxP01
               )

#********************************************************
# loop through targetGenomes, create directories and populate them
#********************************************************
for value in ${targetGenomes[@]} # loop through array
  do
    #------------------------------------------------------
    # create parent dir and subdirectories
    #------------------------------------------------------
    mkdir -p $value/{fasta,gff}

    #------------------------------------------------------
    # download fasta files
    #------------------------------------------------------
    wget -e \
      robots=off \
      --cut-dirs=3 \
      --user-agent=Mozilla/5.0 \
      --reject="index.html*" \
      --no-parent \
      --recursive \
      --relative \
      --level=1 \
      --no-directories \
      -N \
      -q \
      --show-progress \
      https://plasmodb.org/common/downloads/release-51/$value/fasta/data/ \
      -P $value/fasta

    #------------------------------------------------------
    # download gff annotation files, ignoring "Orf50.gff" files
    #------------------------------------------------------
    wget -e \
      robots=off \
      --cut-dirs=3 \
      --user-agent=Mozilla/5.0 \
      --reject="index.html*" \
      --no-parent \
      --recursive \
      --relative \
      --level=1 \
      --no-directories \
      --reject Orf50.gff \
      -N \
      -q \
      --show-progress \
      https://plasmodb.org/common/downloads/release-51/$value/gff/data/ \
      -P $value/gff
done
