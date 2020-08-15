use Test2::V0;
use Test::TypeTiny;
use URI;
use DemoTypes qw< PathlessUri >;

subtest 'A type "PathlessUri"' => sub {

    should_pass(
        URI->new('http://example.com'),
        PathlessUri, 'should accept class_type(URI)',
    );

    should_pass(
        PathlessUri->coerce('http://example.com'),
        PathlessUri, 'should accept Str (via coercion)',
    );

    should_fail(
        URI->new('http://example.com/path'),
        PathlessUri, 'should not accept class_type(URI) where path_segments > 0',
    );

    should_fail(
        PathlessUri->coerce('http://example.com/path'),
        PathlessUri, 'should not accept Str (via coercion) where path_segments > 0',
    );

};

subtest 'An attribute with the type "PathlessUri"' => sub {

    package App {
        use Moo;
        use DemoTypes qw< PathlessUri >;
        has endpoint => ( coerce => 1, is => 'ro', isa => PathlessUri );
    };

    is( App->new( endpoint => URI->new('http://example.com') ),
        object {
            call endpoint => object { prop blessed => match 'URI' }
        },
        'should accept class_type(URI)',
    );

    is( App->new( endpoint => 'http://example.com' ),
        object {
            call endpoint => object { prop blessed => match 'URI' }
        },
        'should accept Str (via coercion)',
    );

    like(
        dies { App->new( endpoint => URI->new('http://example.com/path') ) },
        qr/path/, 'should not accept class_type(URI) where path_segments > 0',
    );

    like(
        dies { App->new( endpoint => 'http://example.com/path' ) },
        qr/path/, 'should not accept Str (via coercion) where path_segments > 0',
    );

};

done_testing();
