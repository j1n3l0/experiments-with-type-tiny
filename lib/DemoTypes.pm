package DemoTypes;

use Type::Library -base, -declare => qw< PathlessUri >;
use Type::Utils -all;
use Types::Standard -types;

declare PathlessUri, as class_type('URI'), where {
    !grep { length $_ } $_->path_segments()
};

coerce PathlessUri, from Str, via { URI->new($_) };

1;
