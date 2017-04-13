  package Shari::Code::Loader::Unit::File
# ***************************************
; our $VERSION='0.02'
# *******************
; use strict; use warnings
; use parent 'Shari::Code::Loader::Unit'

# Changes
# 0.2 - 2007/11/27 -- File::Monitor for change watching
# 0.1 - initial VERSION

; use File::Monitor
  
; __PACKAGE__->mk_accessors (qw/filename monitor realpath/)
 
; sub new
    { my ($pack,%args)=@_
    ; my $class = ref $pack || $pack
    ; if($class eq __PACKAGE__)
        { unless(exists $args{'filename'})
            { Carp::croak 
            "No filename specified in constructor of class $class."
            } 
        }
    ; my $self=$pack->SUPER::new(%args)
    ; return $self
    }

; sub identifier
    { my ($self)=@_
    ; return $self->realpath || $self->filename
    }

; sub is_uptodate
    { my ($self)=@_
    ; return 0 unless $self->is_loaded
    
    ; if( my ($change) = $self->monitor->scan )
        { # be paranoid, the file could be deleted now, in this case it is uptodate
        # ????
        ; return 1 if $change->deleted
        # any other change says it is not uptodate
        ; return 0
        }
    ; return 1
    }

# wenn im @INC Pfad eine andere Version auftaucht ist das ok?
# Meine Antwort ist nein, ein reload verwendet den kompletten Pfad.
# Oder doch besser ja?
# Das Verhalten wurde geändert, da sonst ein weiterer Eintrag in %INC produziert 
# wird / Die Funktionalität wird wohl erst richtig entwickelt wenn sie mal 
# gebraucht wird.
; sub load
    { my ($self,@dirs)=@_
    ; $self->was_loaded(0)
    ; return $self if $self->is_uptodate
    ; $self->loadattempts($self->loadattempts + 1)
    
    ; $self->clear_error
    ; if($self->is_loaded)
        { return $self->do_reload }
      else
        { return $self->do_load(@dirs) }
    }
    
; sub do_reload
    { my ($self)=@_
    
    ; $self->returnvalue(scalar do $self->filename)
    ; if($@)
        { $self->add_error("Parse Error: ".$@) }
      else
        { $self->was_loaded(1)
        ; $self->loadcounter($self->loadcounter + 1)
        }

    ; return $self
    }

; sub do_load
    { my ($self,@dirs)=@_
    ; local @INC=(@dirs,@INC)
    ; local $@
      
    ; $self->returnvalue(scalar do $self->filename)
    ; if($@)
        { $self->add_error("Parse Error: ".$@)
        ; $self->is_empty(0)
        ; $self->is_loaded(1)
        ; $self->realpath($INC{$self->filename})
        ; $self->setup_file_monitor
        }
      # it is not an error to not exist, but nothing changed
      elsif(!defined $self->returnvalue)
        {  
        }
      else
        { $self->was_loaded(1)
        ; $self->is_empty(0)
        ; $self->loadcounter($self->loadcounter + 1)
        ; $self->is_loaded(1)
        ; $self->realpath($INC{$self->filename})
        ; $self->setup_file_monitor
        }
    ; return $self
    }
    
# only a quick hack
; sub absfilename
    { my ($self)=@_
    ; $INC{$self->filename}
    }
    
################################
# File Monitor Interface
################################
; sub setup_file_monitor
    { my ($self) = @_
    ; unless($self->monitor)
        {
        ; my $realfile = $self->realpath
        ; $self->monitor ( new File::Monitor::() )
        ; $self->monitor->watch($realfile)
        ; $self->monitor->scan
        }
    }

# this needs more care, is it used?    
; sub add_dependency
    { my $self = shift
    ; $self->setup_file_monitor
    
    ; for my $dep (@_)
        { $self->monitor->watch($dep)
        }
    ; $self->monitor->scan
    }

; 1

__END__

