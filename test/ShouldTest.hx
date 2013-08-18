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

    @Test
    public function test_succeeds_if_same_objects() {
        var a = new TestObject();
        a.should().eql(a);
    }

    @Test
    public function test_fails_if_not_same_objects() {
        var a = new TestObject();
        var b = new TestObject();
        a.should().not.eql(b);
    }

    @Test
    public function test_throws_if_not_same_objects() {
        var a = new TestObject();
        var b = new TestObject();
        var x = false;

        try {
            a.should().eql(b);
        } catch(e: Dynamic) {
            x = true;
        }
        Assert.isTrue(x);
    }

    @Test
    public function test_arrays_with_equal_content_are_equal() {
        [1, 2].should().eql([1, 2]);
    }

    @Test
    public function test_differing_arrays_fail() {
        var x = false;
        try {
            [1].should().eql([1, 2]);
        } catch(e: Dynamic) {
            x = true;
        }
        Assert.isTrue(x);
    }

    @Test
    public function test_non_matching_arrays() {
        [1, 2].should().not.eql([1, 2, 3]);
    }

}

private class TestObject {
    public function new() {
    }
}