  

 

return function() -- Line: 1
    local combineReducers = require(script.Parent.combineReducers);
    it("should invoke each sub-reducer for every action", function() -- Line: 4
        -- upvalues: combineReducers (copy)
        local u1 = 0;
        local u2 = 0;
        combineReducers({
            a = function(p3, p4) -- Line: 9, Name: a
                -- upvalues: u1 (ref)
                u1 = u1 + 1;
            end,

            b = function(p5, p6) -- Line: 12, Name: b
                -- upvalues: u2 (ref)
                u2 = u2 + 1;
            end
        })({}, {});
        expect(u1).to.equal(1);
        expect(u2).to.equal(1);
    end);
    it("should assign each sub-reducer\'s value to the new state", function() -- Line: 23
        -- upvalues: combineReducers (copy)
        local v11 = combineReducers({
            a = function(p7, p8) -- Line: 25, Name: a
                return (p7 or 0) + 1;
            end,

            b = function(p9, p10) -- Line: 28, Name: b
                return (p9 or 0) + 3;
            end
        })({}, {});
        expect(v11.a).to.equal(1);
        expect(v11.b).to.equal(3);
    end);
    it("should not throw when state is nil", function() -- Line: 38
        -- upvalues: combineReducers (copy)
        local u16 = combineReducers({
            a = function(p12, p13) -- Line: 40, Name: a
                return (p12 or 0) + 1;
            end,

            b = function(p14, p15) -- Line: 43, Name: b
                return (p14 or 0) + 3;
            end
        });
        expect(function() -- Line: 48
            -- upvalues: u16 (copy)
            u16(nil, {});
        end).to.never.throw();
    end);
end;