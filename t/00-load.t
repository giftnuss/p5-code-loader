#!/usr/bin/perl

; use strict
; package main

; use Test::More tests => 11

; BEGIN 
    { use_ok( 'Shari::Code::Loader' ) 
    ; diag( "Testing Code::Loader $Code::Loader::VERSION, Perl $], $^X" )
    }

; BEGIN {
    use_ok( 'Shari::Code::Unit' );
    use_ok( 'Shari::Code::Loader::Unit' );
    use_ok( 'Shari::Code::Loader::Unit::File' );
    use_ok( 'Shari::Code::Loader::Unit::Module' );
    }

; my @accessors =
    qw/is_empty
       is_loaded 
       was_loaded 
       returnvalue 
       loadattempts
       loadcount/
       
; ok(Shari::Code::Loader::Unit->can($_),"Accessor: $_") for @accessors

