on test => sub {
    requires 'Test2::V0';
};

on runtime => sub {
    requires 'Moo';
    requires 'Type::Tiny' => '1.012000';
    requires 'URI';
};
