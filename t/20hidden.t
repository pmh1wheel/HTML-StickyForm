#!/usr/bin/perl

use Test::More tests => 20;
use Test::NoWarnings;
use Test::XML::Simple;
use blib;
use strict;
use warnings;

use CGI;
my $Form;
BEGIN{ use_ok($Form='HTML::StickyForm'); }

isa_ok(my $empty=$Form->new,$Form,'empty object');
isa_ok(my $full=$Form->new(CGI->new({fred => 'bloggs'})),$Form,'full object');

for(
  [{},'empty',
    '<input type="hidden" name="" value="" />',
    '<input type="hidden" name="" value="" />',
  ],
  [{name => 'fred'},'fred',
    '<input type="hidden" name="fred" value="" />',
    '<input type="hidden" name="fred" value="bloggs" />',
  ],
  [{name => 'fred',default => 'jones'},'fred/default',
    '<input type="hidden" name="fred" value="jones" />',
    '<input type="hidden" name="fred" value="bloggs" />',
  ],
  [{name => 'fred',value => 'jones'},'fred/value',
    '<input type="hidden" name="fred" value="jones" />',
    '<input type="hidden" name="fred" value="jones" />',
  ],
){
  my($args,$name,$expect_empty,$expect_full)=@$_;

  my $out;
  xml_is_deeply($out=$empty->hidden($args),'/',$expect_empty,"$name (empty, ref)")
    or diag $out;
  xml_is_deeply($out=$empty->hidden(%$args),'/',$expect_empty,"$name (empty, flat)")
    or diag $out;
  xml_is_deeply($out=$full->hidden($args),'/',$expect_full,"$name (full, ref)")
    or diag $out;
  xml_is_deeply($out=$full->hidden(%$args),'/',$expect_full,"$name (full, flat)")
    or diag $out;
}


