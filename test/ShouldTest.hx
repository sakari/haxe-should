using sakari.should.Should;
import sakari.should.Should;
import massive.munit.Assert;

class ShouldTest {
    @Test
    public function test_existance_check_succeeds() {
        1.should().exist;
    }

    @Test
    public function test_existance_check_fails_if_null() {
        (function() {
            Should.should(null).exist;
        }).should().throwException();
    }

    @Test
    public function test_negated_existance_check() {
        Should.should(null).not.exist;
    }

    @Test
    public function test_negated_existance_check_fails() {
        (function() {
            1.should().not.exist;
        }).should().throwException();
    }

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

    @Test
    public function test_enum_matching() {
        Foo(1).should().eql(Foo(1));
    }

    @Test
    public function test_enum_matching_throws_on_fail() {
        var x = false;
        try {
            Foo(1).should().eql(Foo(2));
        } catch(e: Dynamic) {
            x = true;
        }
        Assert.isTrue(x);
    }

    @Test
    public function test_enum_not_matching() {
        Foo(1).should().not.eql(Bar(1));
    }

    @Test
    public function test_enum_matching_with_different_args() {
        Foo(1).should().not.eql(Foo(2));
    }

    @Test
    public function test_passing_comparison_function() {
        1.should().eql(2, function(l, r) {
                Assert.isTrue(l == 1);
                Assert.isTrue(r == 2);
                return true;
            });
    }

    @Test
    public function test_passing_comparison_method_name() {
        var p = new ComparableObject(1);
        var q = new ComparableObject(1);
        p.should().eql(q, 'equalityTest');
    }

    @Test
    public function test_passing_comparison_method_name_to_not() {
        var p = new ComparableObject(1);
        var q = new ComparableObject(2);
        p.should().not.eql(q, 'equalityTest');
    }
}

private class ComparableObject {
    private var i: Int;

    public function equalityTest(rhs) {
        return i == rhs.i;
    }

    public function new(i) {
        this.i = i;
    }
}

private enum TestEnum {
    Foo(p: Int);
    Bar(v: Int);
}

private class TestObject {
    public function new() {
    }
}