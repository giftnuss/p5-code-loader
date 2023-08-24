  package Shari::Code::Loader::Unit
# *********************************
; our $VERSION='0.02'
# *******************
; use strict; use warnings

; use Carp ()
; use Shari::Code::Loader ()

# Private real constructor
; sub _new
    { my ($pack,@args) = @_
    ; my $class = ref $pack || $pack
    ; return bless 
        { is_empty     => 1, 
          errors       => [],
          is_loaded    => 0, 
          loadattempts => 0,
          loadcount    => 0,
          was_loaded   => 0,
          returnvalue  => undef, @args 
        }, $class
    }

# if there is no source or the source is empty
sub is_empty { $_[0]->{'is_empty'} }
sub set_not_empty { $_[0]->{'is_empty'} = 0 }

# store and handle errors
sub add_error { my ($self,@err)=@_; push @{$self->{'errors'}},@err }
sub has_error { my ($self)=@_; return scalar @{$self->{'errors'}} }
sub get_error { my ($self)=@_; return join "\n",@{$self->{'errors'}} }
sub clear_error { my ($self)=@_; @{$self->{'errors'}} = () }

# code is already loaded, possible with errors
sub is_loaded { $_[0]->{'is_loaded'} }
sub set_is_loaded { $_[0]->{'is_loaded'} = 1 }

# counts how often a unit was loaded
sub loadcount { $_[0]->{'loadcount'} }
sub inc_loadcount { $_[0]->{'loadcount'} += 1 }

# was_loaded is true if the last attempt to load the unit was successfull
sub was_loaded { $_[0]->{'was_loaded'} }
sub reset_was_loaded { $_[0]->{'was_loaded'} = 0 }
sub set_was_loaded { $_[0]->{'was_loaded'} = 1 }

# The return value when unit was loaded.
sub returnvalue { $_[0]->{'returnvalue'} }
sub set_returnvalue { $_[0]->{'returnvalue'} = $_[1] }

# Counts the attempts to load a unit
sub loadattempts { $_[0]->{'loadattempts'} }
sub inc_loadattempts { $_[0]->{'loadattempts'} += 1 }

# Store and retrieve methode should be overwritable because in some
# cenarious a central storage for all units isn't appropriate.
; sub _retrieve
    { Carp::croak("Have to be called with an object, and not with class: $_[0]")
        unless ref $_[0]
    ; return Shari::Code::Loader::_retrieve($_[0])
    }
    
; sub _store
    { Carp::croak("Have to be called with an object, and not with class: $_[0]")
        unless ref $_[0]
    ; Shari::Code::Loader::_store($_[0])
    }

# Public constructs a new object or retrieves a existing one.
; sub create
    { my ($pack,@args)=@_
    ; my $temp=$pack->_new(@args)
    ; if(my $exists=$temp->_retrieve)
       { return $exists }
    ; return $temp->_store
    }

####################################
#        Abstract Methods
####################################
; sub load
    { # Don't forget to set the new state.
    }

; sub is_uptodate
    { # negation of needs_reload
    }

; sub identifier
    { # Should be unique
    ; Carp::carp("Abstract method 'identifier' in base class called.")
    ; return ''
    }
    
####################################
# Shortcuts and Aliase
####################################
; sub is_ready
    { my ($self) = @_
    ; $self->is_loaded && !$self->has_error
    }

; 1
  
__END__

=head1 NAME

Code::Loader::Unit - a chunk of of which is loaded dynamically

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

   package Code::Loader::Unit::Spreadsheet;
   use parent 'Code::Loader::Unit';

=head1 DESCRIPTION

=head1 TODO

=head1 AUTHOR

=head1 BUGS

=head1 SEE ALSO

=head1 COPYRIGHT & LICENSE

Copyright 2007 Sebastian Knapp, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
