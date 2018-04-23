package Tree::Interval::Fast;

use 5.006;
use strict;
use warnings;

our $VERSION = '0.0.1';
our $ENABLE_DEBUG = 0;

require XSLoader;
XSLoader::load('Tree::Interval::Fast', $VERSION);

1; # End of Tree::Interval::Fast

=head1 NAME

Tree::Interval::Fast - The great new Tree::Interval::Fast!

=head1 VERSION

Version 0.0.1

=head1 DESCRIPTION

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Tree::Interval::Fast;

    my $foo = Tree::Interval::Fast->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 METHODS


=head1 AUTHOR

Alessandro Vullo, C<< <avullo at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-tree-interval-fast at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Tree-Interval-Fast>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Tree::Interval::Fast


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Tree-Interval-Fast>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Tree-Interval-Fast>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Tree-Interval-Fast>

=item * Search CPAN

L<http://search.cpan.org/dist/Tree-Interval-Fast/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2018 Alessandro Vullo.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See L<http://dev.perl.org/licenses/> for more information.


=cut
