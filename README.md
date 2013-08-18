# Should style assertions for Haxe tests

For rationale and intuition see the excellent https://github.com/visionmedia/should.js

The library itself is test framework agnostic. The tests for the
library itself use https://github.com/massiveinteractive/MassiveUnit
and https://github.com/openfl/openfl

# Features

 * throw assertions
 * equality
 * negation

# Usage

    using sakari.should.Should;
    ..
	'a'.should().eql('a');

See the tests at `test/ShouldTest.hx` for more examples.

# Testing

We use openfl to run the tests (but there really is no other reason than convenience)

    openfl test test.xml cpp

# Contributing

Please do. 

# License

MIT
