  

 

return function() -- Line: 1
    local createReducer = require(script.Parent.createReducer);
    it("should handle actions", function() -- Line: 4
        -- upvalues: createReducer (copy)
        local v5 = createReducer({
            a = 0,
            b = 0
        }, {
            a = function(p1, p2) -- Line: 9, Name: a
                return {
                    a = p1.a + 1,
                    b = p1.b
                };
            end,

            b = function(p3, p4) -- Line: 15, Name: b
                return {
                    a = p3.a,
                    b = p3.b + 2
                };
            end
        });
        local v6 = v5({
            a = 0,
            b = 0
        }, {
            type = "a"
        });
        expect(v6.a).to.equal(1);
        local v7 = v5(v6, {
            type = "b"
        });
        expect(v7.b).to.equal(2);
    end);
    it("should return the initial state if the state is nil", function() -- Line: 39
        -- upvalues: createReducer (copy)
        local v8 = createReducer({
            a = 0,
            b = 0
        }, {})(nil, {});
        expect(v8).to.be.ok();
        expect(v8.a).to.equal(0);
        expect(v8.b).to.equal(0);
    end);
    it("should still run action handlers if the state is nil", function() -- Line: 52
        -- upvalues: createReducer (copy)
        local u9 = 0;
        local v12 = createReducer(0, {
            foo = function(p10, p11) -- Line: 56, Name: foo
                -- upvalues: u9 (ref)
                u9 = u9 + 1;

                return nil;
            end
        });
        expect(u9).to.equal(0);
        local v13 = v12(nil, {
            type = "foo"
        });
        expect(u9).to.equal(1);
        expect(v13).to.equal(nil);
        local v14 = v12(v13, {
            type = "foo"
        });
        expect(u9).to.equal(2);
        expect(v14).to.equal(nil);
    end);
    it("should return the same state if the action is not handled", function() -- Line: 79
        -- upvalues: createReducer (copy)
        local v15 = {
            a = 0,
            b = 0
        };
        local v20 = createReducer(v15, {
            a = function(p16, p17) -- Line: 86, Name: a
                return {
                    a = p16.a + 1,
                    b = p16.b
                };
            end,

            b = function(p18, p19) -- Line: 92, Name: b
                return {
                    a = p18.a,
                    b = p18.b + 2
                };
            end
        })(v15, {
            type = "c"
        });
        expect(v20).to.equal(v15);
    end);
end;