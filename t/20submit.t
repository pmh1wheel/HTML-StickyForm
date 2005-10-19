# $Id: 20submit.t,v 1.1 2005/10/19 14:02:43 pmh Exp $

use Test::More no_plan;
use Test::XML;
use strict;

use CGI;
my $Form;
BEGIN{ use_ok($Form='HTML::StickyForm'); }

isa_ok(my $empty=$Form->new,$Form,'empty object');
isa_ok(my $full=$Form->new(CGI->new({fred => 'bloggs'})),$Form,'full object');

for(
  [{},'empty',
    '<input type="submit" />',
    '<input type="submit" />',
  ],
  [{value=>'Hit Me!'},'value',
    '<input type="submit" value="Hit Me!" />',
    '<input type="submit" value="Hit Me!" />',
  ],
  [{name=>'fred'},'fred/empty',
    '<input type="submit" name="fred" />',
    '<input type="submit" name="fred" />',
  ],
  [{name=>'fred', value=>'Hit Me!'},'fred/value',
    '<input type="submit" name="fred" value="Hit Me!"/>',
    '<input type="submit" name="fred" value="Hit Me!"/>',
  ],
  [{name=>'fr&d', value=>'""',},'escape',
    '<input type="submit" name="fr&#38;d" value="&#34;&#34;"/>',
    '<input type="submit" name="fr&#38;d" value="&#34;&#34;"/>',
  ],
  [{random=>'wiffle nuts'},'random',
    '<input type="submit" random="wiffle nuts"/>',
    '<input type="submit" random="wiffle nuts"/>',
  ],
){
  my($args,$name,$expect_empty,$expect_full)=@$_;

  my $out;
  is_xml($out=$empty->submit(%$args),$expect_empty,"$name (empty)")
    or diag $out;
  is_xml($out=$full->submit(%$args),$expect_full,"$name (full)")
    or diag $out;
}


