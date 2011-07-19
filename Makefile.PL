use ExtUtils::MakeMaker;

WriteMakefile(
   NAME => 'ServerControl-DrbWorker',
   VERSION_FROM => 'lib/ServerControl/Module/DrbWorker.pm',
   PREREQ_PM => {'ServerControl' => '0.90'},
   LICENSE => 'bsd'
);

