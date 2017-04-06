use 5.006;
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Shari::Code::Loader',
    license             => 'perl',
    dist_author         => q{Mike Würfel <SKNPP@CPAN.ORG>},
    dist_version_from   => 'lib/Shari/Code/Loader.pm',
    configure_requires => {
	'Module::Build' => 0.4 
    },
    build_requires => {
        'Test::More' => 0,
	'Module::Build' => '0.40'
    },
    requires => {
        'perl' => 5.006,
	'File::Monitor' => 0
    },
    add_to_cleanup      => [ 'Shari-Code-Loader' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
