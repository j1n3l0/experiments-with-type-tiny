on test => sub {
    requires 'Test2::V0';
};

on runtime => sub {
    requires 'Moo';
    requires 'Type::Tiny';
    requires 'URI';
};
