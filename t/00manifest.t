#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use Test::NoWarnings;

# Make sure we're on the developer's system
BEGIN{
  # Change to the dist root directory
  for(1..3){
    -e 'MANIFEST'
      or chdir '..';
  }
  -e 'MANIFEST'
    or BAIL_OUT("Can't find the MANIFEST file");

  -d '.git'
    or plan skip_all => 'Only useful on dev system';
}

plan tests => 4;
use ExtUtils::Manifest qw(manifind manicheck filecheck);

# Check the manifest is accurate
{
  local $ExtUtils::Manifest::Quiet=1;

  my @missing=manicheck();
  ok(!@missing,'manicheck')
    or diag "    Files listed in MANIFEST not found: @missing";

  my @extra=filecheck();
  ok(!@extra,'filecheck')
    or diag "    Files not listed in MANIFEST: @extra";
}

# Check that everything's in git
{
  open my $fh,'git status 2>&1 |'
    or fail("Can't open git status: $? $!"), last;
  my @files;
  local $/="\n#\n";
  while(<$fh>){
    if(!@files){
      if(/\A# Untracked files/){
        push @files,undef;
	$/="\n";
      }
    }else{
      my($file)=/\A#\s+(.+)\s+\z/
        or fail("Can't parse git status line: $_"), last;
      push @files,$file;
    }
  }
  close $fh
    or fail("Can't close git status: $? $!"), last;
  shift @files;
  ok(!@files,'git check')
    or diag "    Files not in git: @files";
}

