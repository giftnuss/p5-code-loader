  package Shari::Code::Unit;
# **************************
  our $VERSION = '0.1';
# *********************
; use Shari::Code::Loader::Unit::Module

; my $_in_inc = sub
    { my ($inc,$ns) = @_
    ; my @proceed
    ; foreach my $part (@$ns)
        { push @proceed, $part
        ; return unless -d File::Spec->catdir($inc,@proceed)
        }
    ; return 1
    }

#######################
# Utility functions
#######################

; sub spawn
    { shift
    ; my $unit = create Shari::Code::Loader::Unit::Module::
        (namespaces => [map { split /::/ } @_])
    ; if( $unit->is_ready )
        { $unit->load unless $unit->is_uptodate
        ; return $unit
        }
      else
        { $unit->do_load
	    }
    ; $unit
    }

; sub discover
    { shift
    ; my $unit = create Shari::Code::Loader::Unit::Module::
        (filename => $_[0], skipdirs => 0)
    ; $unit->load if $unit->is_ready && $unit->is_uptodate
    ; $unit
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
            ; my $unit = create Shari::Code::Loader::Unit::Module::
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
    ; my @name
    ; if(ref $name)
        { @name = @$name
        }
      else
        { @name = ($name)
        }
    ; my @units
    ; INC:
      foreach my $inc (@INC)
        { # don't know how to deal with hooks
        ; next if ref $inc
		; next unless $_in_inc->($inc,\@ns)
		
        ; opendir DIR, File::Spec->catdir($inc,@ns)
        ; DIR:
          while(defined(my $e = readdir(DIR)))
            { my $entry = File::Spec->catdir($inc,@ns,$e)
            ; next unless -d $entry
            ; next if $e eq '..' or $e eq '.'

            ; foreach my $name (@name) 
                { my $filename = File::Spec->catfile($entry,$name . '.pm')
                ; next unless -f $filename
                
                ; my @skip = File::Spec->splitdir($inc)
                ; shift @skip if $skip[0] eq '.'
                ; pop @skip unless $skip[-1]

                ; my $unit = create Shari::Code::Loader::Unit::Module::
                    (filename => $filename, skipdirs => 0+@skip)
                ; $unit->load unless $unit->is_uptodate
                ; push @units, $unit
                }
            }
        }
    ; @units
    }

; 1

__END__
