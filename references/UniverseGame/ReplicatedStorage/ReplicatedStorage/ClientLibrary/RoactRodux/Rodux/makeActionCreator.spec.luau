  

 

return function() -- Line: 1
    local makeActionCreator = require(script.Parent.makeActionCreator);
    it("should set the name of the actionCreator creator", function() -- Line: 4
        -- upvalues: makeActionCreator (copy)
        local v1 = makeActionCreator("foo", function() -- Line: 5
            return {};
        end);
        expect(v1.name).to.equal("foo");
    end);
    it("should return a table when called as a function", function() -- Line: 12
        -- upvalues: makeActionCreator (copy)
        local v2 = makeActionCreator("foo", function() -- Line: 13
            return {};
        end);
        expect(v2()).to.be.a("table");
    end);
    it("should set the type of the action creator", function() -- Line: 20
        -- upvalues: makeActionCreator (copy)
        local v3 = makeActionCreator("foo", function() -- Line: 21
            return {};
        end);
        expect(v3().type).to.equal("foo");
    end);
    it("should set values", function() -- Line: 28
        -- upvalues: makeActionCreator (copy)
        local v5 = makeActionCreator("foo", function(p4) -- Line: 29
            return {
                value = p4
            };
        end);
        expect(v5(100).value).to.equal(100);
    end);
    it("should throw when its result does not return a table", function() -- Line: 38
        -- upvalues: makeActionCreator (copy)
        local v6 = makeActionCreator("foo", function() -- Line: 39
            return function() -- Line: 40
            end;
        end);
        expect(v6).to.throw();
    end);
    it("should throw if the first argument is not a string", function() -- Line: 46
        -- upvalues: makeActionCreator (copy)
        expect(function() -- Line: 47
            -- upvalues: makeActionCreator (ref)
            makeActionCreator(nil, function() -- Line: 48
                return {};
            end);
        end).to.throw();
        expect(function() -- Line: 53
            -- upvalues: makeActionCreator (ref)
            makeActionCreator(100, function() -- Line: 54
                return {};
            end);
        end).to.throw();
    end);
    it("should throw if the second argument is not a function", function() -- Line: 60
        -- upvalues: makeActionCreator (copy)
        expect(function() -- Line: 61
            -- upvalues: makeActionCreator (ref)
            makeActionCreator("foo", nil);
        end).to.throw();
        expect(function() -- Line: 65
            -- upvalues: makeActionCreator (ref)
            makeActionCreator("foo", {});
        end).to.throw();
    end);
end;