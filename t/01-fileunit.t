#!/usr/bin/perl

; use strict
; package main

; use Test::More tests => 8

# 01 -- loadable
; BEGIN { use_ok( 'Code::Loader::Unit::File' ) }
; diag( "Testing Code::Loader $Code::Loader::Unit::File::VERSION, Perl $], $^X" )

; my $testfile1 = 't/code/one.pl'
; my $unit = Code::Loader::Unit::File
    ->create(filename => $testfile1)
    
# 02 -- unit is created but not loaded
; ok($unit->is_empty,'new units are empty')

# 03 -- has no error 
; ok(!$unit->has_error,'no error so far')

# 04 -- testfile exists
; ok(-f $testfile1)

# 05 -- filename as identifier
# this may change in future
; is($unit->identifier,$testfile1,'identifier=filename')

# 06 -- not up to date
; ok(!$unit->is_uptodate,'not uptodate')

; $unit->load

# 07 -- if no package is given the unit is used as namespace
# this may change in future
; is(Code::Loader::Unit::File::one(),1)

# 08 -- is uptodate
; ok($unit->is_uptodate,'is uptodate')



; use Data::Dumper
; print Dumper($unit)

