  package Shari::Code::Loader
# ***************************
; our $VERSION='0.02'
# *******************
; use strict; use warnings
; use File::Spec
#######################
# Utility functions
#######################

; sub spawn
    { shift
    ; my $unit = create Code::Loader::Unit::Module::
        (namespaces => [map { split /::/ } @_])
    ; unless($unit->is_uptodate )
        { $unit->load
        }
    ; $unit
    }

; sub discover
    { shift
    ; my $unit = create Code::Loader::Unit::Module::
        (filename => $_[0], skipdirs => 0)
    ; $unit->load unless $unit->is_uptodate
    ; $unit
    }

; my $_in_inc = sub
    { my ($inc,$ns) = @_
    ; my @proceed
    ; foreach my $part (@$ns)
        { push @proceed, $part
        ; return unless -d File::Spec->catdir($inc,@proceed)
        }
    ; return 1
    }

; sub harvest
    { shift
    ; my @ns = @_
    ; my @units
    ; INC:
      foreach my $inc (@INC)
        { # don't know how to deal with hooks
        ; next if ref $inc
		; next unless $_in_inc->($inc,\@ns)

        ; opendir DIR, File::Spec->catdir($inc,@ns)
        ; while(defined(my $e = readdir(DIR)))
            { my $entry = File::Spec->catfile($inc,@ns,$e)
            ; next unless -f $entry and $e =~ /\.pm$/
            ; my @skip = File::Spec->splitdir($inc)
            ; shift @skip if $skip[0] eq '.'
            ; my $unit = create Code::Loader::Unit::Module::
                (filename => $entry, skipdirs => 0+@skip)
            ; $unit->load unless $unit->is_uptodate
            ; push @units, $unit
            }
        }
    ; @units
    }
    
; sub collect
    { my ($class,@ns) = @_
    ; my $name = pop @ns
    ; my @units
    ; INC:
      foreach my $inc (@INC)
        { # don't know how to deal with hooks
        ; next if ref $inc
		; next unless $_in_inc->($inc,\@ns)
		
        ; opendir DIR, File::Spec->catdir($inc,@ns)
        ; while(defined(my $e = readdir(DIR)))
            { my $entry = File::Spec->catdir($inc,@ns,$e)
            ; next unless -d $entry
            ; next if $e eq '..' or $e eq '.'
            ; my $filename = File::Spec->catfile($entry,$name . '.pm')
            ; next unless -f $filename
            
            ; my @skip = File::Spec->splitdir($inc)
            ; shift @skip if $skip[0] eq '.'
            ; my $unit = create Code::Loader::Unit::Module::
                (filename => $filename, skipdirs => 0+@skip)
            ; $unit->load unless $unit->is_uptodate
            ; push @units, $unit
            }
        }
    ; @units

    }


#######################
# Cache functionality
#######################
; my %storage
  
; sub _store
    { my ($unit)=@_
    ; return $storage{$unit->identifier}=$unit
    }

; sub _retrieve
    { my ($unit)=@_
    ; return $storage{$unit->identifier}
    }
    
; sub _empty_storage
    { %storage = ()
    }

; 1
  
__END__


=head1 NAME

Code::Loader - storage for code units

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

   Code::Loader::_store($unit);
   
   my $loaded = Code::Loader::_retrieve($unit);

=head1 DESCRIPTION

This module contains some utility functions to load code units
dynamically.



This module is also a cache for code units. Each unit class has a method
C<identifier> which is used here as a hash key. The constructor of each unit
needs enough arguments to create the unique identifier for each object. So when
an unit is already loaded it could be retrieved from here.

The functions C<_store>, C<_retrieve> and C<_empty_storage> are used to control
the cache.


=head1 AUTHOR

Sebastian Knapp E<lt>sk@computer-leipzig.comE<gt>

=head1 SEE ALSO

L<Code::Loader::Unit>

=head1 COPYRIGHT & LICENSE

Copyright 2007 Sebastian Knapp, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
