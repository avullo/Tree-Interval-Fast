use 5.008;
use strict;
use warnings;
use Test::More tests => 37, 'die';

use FindBin qw( $Bin );
use Data::Dumper;

BEGIN {
  use lib "$Bin/../lib", "$Bin/../blib/lib", "$Bin/../blib/arch";
  use_ok 'Tree::Interval::Fast';
  use_ok 'Tree::Interval::Fast::Interval';
}

my $tree = Tree::Interval::Fast->new();
isa_ok($tree, 'Tree::Interval::Fast');
ok(!$tree->size(), 'empty tree');

my $intervals = make_intervals();

foreach my $interval (@{$intervals}) {
  ok($tree->insert($interval), 'insert interval');
}
is($tree->size(), 6, 'size after insert');

for my $i (0 .. 5) {
  ok($tree->remove($intervals->[$i]), 'remove interval');
  is($tree->size(), 5-$i, 'size after removal');
}

my $query = Tree::Interval::Fast::Interval->new(6., 7., 10);
my $result = $tree->find($query);
isa_ok($result, 'Tree::Interval::Fast::Interval');
is($result->low, 5, 'result left bound');
is($result->high, 20, 'result right bound');
is($result->data, 40, 'result data');

$query = Tree::Interval::Fast::Interval->new(1, 4, 1);
$result = $tree->find($query);
ok(!$result, 'no results');

$query = Tree::Interval::Fast::Interval->new(18, 25, 50);
$result = $tree->find($query);
isa_ok($result, 'Tree::Interval::Fast::Interval');
is($result->low, 15, 'result left bound');
is($result->high, 20, 'result right bound');
is($result->data, 10, 'result data');

$query = Tree::Interval::Fast::Interval->new(8, 11, 100);
my $results = $tree->findall($query);
is(scalar @$results, 2, 'result set size');
foreach my $item (@{$results}) {
  ok($item->low == 5 || $item->low == 10, 'search item left bound');
  ok($item->high == 20 || $item->high == 30, 'search item left bound');
}

sub make_intervals {
  return [
	  Tree::Interval::Fast::Interval->new(15, 20, 10),
	  Tree::Interval::Fast::Interval->new(10, 30, 20),
	  Tree::Interval::Fast::Interval->new(17, 19, 30),
	  Tree::Interval::Fast::Interval->new(5, 20, 40),
	  Tree::Interval::Fast::Interval->new(12, 15, 50),
	  Tree::Interval::Fast::Interval->new(30, 40, 25)
	 ];
}

diag( "Testing Tree::Interval::Fast $Tree::Interval::Fast::VERSION, Perl $], $^X" );
