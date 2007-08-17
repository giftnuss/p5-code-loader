  package Code::Loader::Unit::File
# ********************************
; our $VERSION='0.01'
# *******************
; use strict; use warnings
  
; use base 'Code::Loader::Unit'
  
; __PACKAGE__->mk_accessor qw/filename loadtime/
 
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
    ; return $self->filename
    }

; sub is_uptodate
    { my ($self)=@_
    ; return 0 unless $self->is_loaded
    ; my $realfile = $INC{$self->filename}
    
    # be paranoid, the file could be deleted now, in this case it is uptodate
    ; return 1 unless -r $realfile
	  
    ; my $filetime = (stat $realfile)[9]
    ; return 0 if $filetime > $self->loadtime
    ; return 1
    }

# wenn im @INC Pfad eine andere Version auftaucht ist das ok?
# Meine Antwort ist nein, ein reload verwendet den kompletten Pfad.
; sub load
    { my ($self,@dirs)=@_
    ; my $self->was_loaded(0)
    ; return $self if $self->is_uptodate
    ; $self->loadattempts($self->loadattempts + 1)
	
    ; $self->clear_errors
    ; if($self->is_loaded)
	{ return $self->do_reload }
      else
	{ return $self->do_load(@dirs) }
    }
	
; sub do_reload
    { my ($self)=@_
    ; my $realfile = $INC{$self->filename}
    
    ; my $self->returnvalue(scalar do $realfile)
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
	  
    ; $self->returnvalue(scalar do $self->filename)
    ; if($@)
	{ $self->add_error("Parse Error: ".$@) 
	; $self->is_empty(0)
	; $self->is_loaded(1) 
	}
      # it is not an error to not exist, but nothing changed
      elsif(!defined $self->returnvalue)
        {  
        }
      else
	{ $self->was_loaded(1)
	; $self->loadcounter($self->loadcounter + 1)
	; $self->is_loaded(1)
	}
    ; return $self
    }

; 1

__END__

