package sakari.should;

class Should {
    public static function should(lhs: Dynamic): ShouldExpr {
        return new ShouldExpr(lhs);
    }
}

class ShouldNotExpr {
    public var lhs: Dynamic;
    public var exist(get, never): ShouldNotExpr;

    private function get_exist() {
        if(lhs != null) {
            throw 'exists';
        }
        return this;
    }
    
    public function new(lhs: Dynamic) {
        this.lhs = lhs;
    }
    
    public function throwException() {
        lhs();
    }

    public function eql(rhs: Dynamic, ?eql: Dynamic) {
        if(Compare.eql(lhs, rhs, eql)) {
            throw 'eql: $lhs $rhs';
        }
    }
}

class ShouldExpr {
    public var lhs: Dynamic;

    public var not(get, never): ShouldNotExpr;
    public var exist(get, never): ShouldExpr;

    private function get_not() {
        return new ShouldNotExpr(lhs);
    }

    private function get_exist() {
        if(lhs == null) {
            throw 'does not exist';
        }
        return this;
    }

    public function new(lhs: Dynamic) {
        this.lhs = lhs;
    }

    public function throwException(?e: Dynamic) {
        var thrown = false;
        var exception: Dynamic = null;
        try {
            lhs();
        } catch(e: Dynamic) {
            exception = e;
            thrown = true;
        }
        if(!thrown) {
            throw 'Expected to throw';
        }
        if(e != null) 
            new ShouldExpr(exception).eql(e);
    }

    public function eql(rhs: Dynamic, ?eql: Dynamic) {
        if(!Compare.eql(lhs, rhs, eql)) {
            throw 'not eql: $lhs, $rhs';
        }
    }
}

private class Compare {
    public static function eql(lhs, rhs, ?eql: Dynamic) {
        if(eql != null) {
            if(Reflect.isFunction(eql)) {
                return eql(lhs, rhs);
            }
            if(Type.getClassName(Type.getClass(eql)) == 'String') {
                return Reflect.callMethod(lhs, Reflect.field(lhs, eql), [rhs]);
            }
            throw 'illegal equality test';
        }

        if(!Compare.isComparable(lhs)) {
            if(lhs != rhs) {
                return false;
            }
            return true;
        }
        
        if(Std.string(rhs) != Std.string(lhs)) {
            return false;
        }
        if(Type.getClassName(Type.getClass(lhs)) !=  
           Type.getClassName(Type.getClass(rhs))) {
            return false;
        }
        return true;
    }
    public static function isComparable(a: Dynamic) {
        if(Reflect.isFunction(a)) {
            return false;
        }
        if(!Reflect.isObject(a)) {
            return true;
        }
        var c = Type.getClassName(Type.getClass(a));
        return c == 'Array' || c == 'Map';
    }
}