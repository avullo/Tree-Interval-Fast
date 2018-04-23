use strict;
use warnings;
use FindBin '$Bin';

use constant HAS_LEAKTRACE => eval{ require Test::LeakTrace };
use Test::More HAS_LEAKTRACE ? (tests => 2) : (skip_all => 'require Test::LeakTrace');
use Test::LeakTrace;

use lib "$Bin/../lib", "$Bin/../blib/lib", "$Bin/../blib/arch";

use_ok('Tree::Interval::Fast::Interval');

no_leaks_ok {
  my $i1 = Tree::Interval::Fast::Interval->new(10, 20, 10);
  my ($low, $high, $data) = ($i1->low, $i1->high, $i1->data);
  
  my $i2 = $i1->copy;
  ($low, $high, $data) = ($i2->low, $i2->high, $i2->data);
  
  my $i3 = Tree::Interval::Fast::Interval->new(21, 30, 21);
  $i1->overlap($i3); $i3->equal($i1);
  
  my $i4 = Tree::Interval::Fast::Interval->new(5, 15, 5);
  $i1->equal($i4); $i4->overlap($i1);

  my $i5 = Tree::Interval::Fast::Interval->new(10, 20, { a => 1, b => 2 });
  ($low, $high, $data) = ($i5->low, $i5->high, $i5->data);
  $i1->overlap($i5); $i5->equal($i1);
 
} 'Interval';