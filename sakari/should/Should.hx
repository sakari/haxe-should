package sakari.should;

class Should {
    public static function should(lhs: Dynamic): ShouldExpr {
        return new ShouldExpr(lhs);
    }
}

class ShouldNotExpr {
    var lhs: Dynamic;
    public function new(lhs: Dynamic) {
        this.lhs = lhs;
    }
    
    public function eql(rhs: Dynamic) {
        if(Type.getClassName(Type.getClass(lhs)) !=  
           Type.getClassName(Type.getClass(rhs))) {
            return;
        }
        if(Std.string(lhs) == Std.string(rhs)) {
            throw 'assert failed';
        }
    }
}

class ShouldExpr {
    var lhs: Dynamic;

    public var not(get, never): ShouldNotExpr;

    private function get_not() {
        return new ShouldNotExpr(lhs);
    }

    public function new(lhs: Dynamic) {
        this.lhs = lhs;
    }

    public function eql(rhs: Dynamic) {
        if(Std.string(rhs) != Std.string(lhs)) {
            throw 'assert failed';
        }
        if(Type.getClassName(Type.getClass(lhs)) !=  
           Type.getClassName(Type.getClass(rhs))) {
            throw 'assert failed';
        }
    }
}