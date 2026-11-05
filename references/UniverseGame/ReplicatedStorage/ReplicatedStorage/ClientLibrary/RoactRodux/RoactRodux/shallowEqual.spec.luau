  

 

return function() -- Line: 1
    local shallowEqual = require(script.Parent.shallowEqual);
    it("should compare dictionaries", function() -- Line: 4
        -- upvalues: shallowEqual (copy)
        local v1 = {
            a = "a",
            c = 6,
            b = {}
        };
        local v2 = {
            b = v1.b,
            c = v1.c,
            a = v1.a
        };
        local v3 = {
            b = {},
            a = v1.a,
            c = v1.c
        };
        local v4 = {
            d = "hello",
            a = v1.a,
            b = v1.b,
            c = v1.c
        };
        expect(shallowEqual(v1, v1)).to.equal(true);
        expect(shallowEqual(v1, v2)).to.equal(true);
        expect(shallowEqual(v1, v3)).to.equal(false);
        expect(shallowEqual(v2, v3)).to.equal(false);
        expect(shallowEqual(v1, v4)).to.equal(false);
        expect(shallowEqual(v2, v4)).to.equal(false);
    end);
    it("should handle nil for either argument", function() -- Line: 38
        -- upvalues: shallowEqual (copy)
        local v5 = {};
        expect(shallowEqual(nil, nil)).to.equal(true);
        expect(shallowEqual(v5, nil)).to.equal(false);
        expect(shallowEqual(nil, v5)).to.equal(false);
    end);
end;