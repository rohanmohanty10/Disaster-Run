  

 

return function() -- Line: 1
    local Symbol = require(script.Parent.Symbol);
    describe("named", function() -- Line: 4
        -- upvalues: Symbol (copy)
        it("should give an opaque object", function() -- Line: 5
            -- upvalues: Symbol (ref)
            local v1 = Symbol.named("foo");
            expect(v1).to.be.a("userdata");
        end);
        it("should coerce to the given name", function() -- Line: 11
            -- upvalues: Symbol (ref)
            local v2 = Symbol.named("foo");
            expect(tostring(v2):find("foo")).to.be.ok();
        end);
        it("should be unique when constructed", function() -- Line: 17
            -- upvalues: Symbol (ref)
            local v3 = Symbol.named("abc");
            local v4 = Symbol.named("abc");
            expect(v3).never.to.equal(v4);
        end);
    end);
    describe("unnamed", function() -- Line: 25
        -- upvalues: Symbol (copy)
        it("should give an opaque object", function() -- Line: 26
            -- upvalues: Symbol (ref)
            local v5 = Symbol.unnamed();
            expect(v5).to.be.a("userdata");
        end);
        it("should coerce to some string", function() -- Line: 32
            -- upvalues: Symbol (ref)
            local v6 = Symbol.unnamed();
            expect((tostring(v6))).to.be.a("string");
        end);
        it("should be unique when constructed", function() -- Line: 38
            -- upvalues: Symbol (ref)
            local v7 = Symbol.unnamed();
            local v8 = Symbol.unnamed();
            expect(v7).never.to.equal(v8);
        end);
    end);
end;