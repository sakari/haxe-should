using sakari.should.Should;
import massive.munit.Assert;

class ShouldTest {
    @Test
    public function test_integer_equality() {
        1.should().eql(1);
    }

    @Test
    public function test_negation() {
        1.should().not.eql(2);
    }

    @Test
    public function test_type_matching() {
        1.should().not.eql('1');
    }

    @Test
    public function test_string_equality() {
        'a'.should().eql('a');
    }

    @Test
    public function test_fail_if_strings_do_not_match() {
        var failed = false;
        try {
            'b'.should().eql('a');
        } catch(e: String) {
            failed = true;
        }
        Assert.isTrue(failed);
    }

    @Test
    public function test_should_throw() {
        (function() {
            throw 'abc';
        }).should().throwException();
    }

    @Test
    public function test_should_throw_specific_exception() {
        (function() {
            throw 'abc';
        }).should().throwException('abc');
    }

    @Test
    public function test_fails_if_wrong_exception_is_thrown() {
        var x;
        try {
            (function() {
                throw 'abc';
            }).should().throwException('error');
        } catch(e: Dynamic) {
            x = true;
        }
        Assert.isTrue(x);
    }

    @Test
    public function test_should_not_throw() {
        var r;
        try {
            (function() {
                throw 'abc';
            }).should().not.throwException();
        } catch(e: String) {
            r = true;
        }
        Assert.isTrue(r);
    }
}