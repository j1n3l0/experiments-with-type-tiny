package DemoTypes;

use Type::Library -base, -utils,
    -extends => [ 'Types::Standard' ],
    -declare => qw< PathlessUri >;

declare PathlessUri, as class_type('URI'), where {
    !grep { length $_ } $_->path_segments()
};

coerce PathlessUri, from Str, via { URI->new($_) };

1;
