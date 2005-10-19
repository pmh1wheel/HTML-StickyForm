# $Id: 00manifest.t,v 1.1 2005/10/19 13:56:14 pmh Exp $

use Test::More;
use File::Find;
use strict;

# Make sure we're on the developer's system
BEGIN{
  # Change to the dist root directory
  for(1..3){
    -e 'MANIFEST'
      or chdir '..'
      or BAIL_OUT("Can't find the MANIFEST file");
  }

  -e '.cvsignore'
    or plan skip_all => 'Only useful on dev system';
}

plan tests => 3;
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

# Check that everything's in CVS
{
  open my $fh,'<','.cvsignore'
    or BAIL_OUT("Can't open .cvsignore: $!");
  my %ignore;
  while(<$fh>){
    chomp;
    ++$ignore{$_};
  }

  my %missing;
  my $all_files=manifind();
  while(my $filename=each %$all_files){
    next if $filename=~m#(?:\A|/)CVS/#
      || $filename=~m#(?:\A|/)\.[^/]+\.swp\z#
      || $ignore{$filename};
    if(my($dir1)=$filename=~m#\A([^/]+)/#){
      next if $ignore{$dir1};
    }
    ++$missing{$filename};
    my($dir,$file)=$filename=~m#\A(.*?)([^/]+)\z#;
    chop $dir or $dir='.';
    open my $fh,'<',"$dir/CVS/Entries" or next;
    while(<$fh>){
      m#\A/\Q$file\E/[^0]# or next;
      delete $missing{$filename};
      last;
    }
  }
  my @missing=sort keys %missing;
  ok(!@missing,'CVS check')
    or diag "    Files not in CVS: @missing";
}

