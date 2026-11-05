  

 

return function() -- Line: 1
    local Store = require(script.Parent.Store);
    local thunkMiddleware = require(script.Parent.thunkMiddleware);
    it("should dispatch thunks", function() -- Line: 5
        -- upvalues: Store (copy), thunkMiddleware (copy)
        local v3 = Store.new(function(p1, p2) -- Line: 6, Name: reducer
            return p1;
        end, {}, { thunkMiddleware });
        local u4 = 0;
        v3:dispatch(function(p5) -- Line: 13, Name: thunk
            -- upvalues: u4 (ref)
            u4 = u4 + 1;
        end);
        expect(u4).to.equal(1);
    end);
    it("should allow normal actions to pass through", function() -- Line: 22
        -- upvalues: Store (copy), thunkMiddleware (copy)
        local u6 = 0;
        Store.new(function(p7, p8) -- Line: 25, Name: reducer
            -- upvalues: u6 (ref)
            u6 = u6 + 1;

            return p7;
        end, {}, { thunkMiddleware }):dispatch({
            type = "test"
        });
        expect(u6).to.equal(2);
    end);
    it("should return the value from the thunk", function() -- Line: 42
        -- upvalues: Store (copy), thunkMiddleware (copy)
        local v12 = Store.new(function(p9, p10) -- Line: 43, Name: reducer
            return p9;
        end, {}, { thunkMiddleware }):dispatch(function(p11) -- Line: 50, Name: thunk
            return "test";
        end);
        expect(v12).to.equal("test");
    end);
    it("should report errors captured in thunks via the provided error reporter", function() -- Line: 59
        -- upvalues: Store (copy), thunkMiddleware (copy)
        local u13 = nil;
        local u14 = nil;
        local u15 = nil;

        local function thunk(p16) -- Line: 78
            error("thunk failed");
        end;

        Store.new(function(p17, p18) -- Line: 69, Name: reducer
            return p17;
        end, {
            Value = 1
        }, { thunkMiddleware }, {
            reportReducerError = function(p19, p20, p21) -- Line: 62, Name: reportReducerError
                -- upvalues: u13 (ref), u14 (ref), u15 (ref)
                u13 = p19;
                u14 = p20;
                u15 = p21;
            end
        }):dispatch(thunk);
        expect(u13.Value).to.equal(1);
        expect(u14).to.equal(thunk);
        expect(u15.message).to.equal("Caught error in thunk");
    end);
    it("should recover and continue to update after a thunk errors", function() -- Line: 89
        -- upvalues: Store (copy), thunkMiddleware (copy)
        local u22 = nil;
        local v28 = Store.new(function(p23, p24) -- Line: 97, Name: reducer
            return p23;
        end, {
            Value = 1
        }, { thunkMiddleware }, {
            reportReducerError = function(p25, p26, p27) -- Line: 92, Name: reportReducerError
                -- upvalues: u22 (ref)
                u22 = p27;
            end
        });
        local u29 = false;

        local function safeThunk(p30) -- Line: 110
            -- upvalues: u29 (ref)
            u29 = true;
        end;

        v28:dispatch(function(p31) -- Line: 106, Name: errorThunk
            error("thunk failed");
        end);
        expect(u22.message).to.equal("Caught error in thunk");
        v28:dispatch(safeThunk);
        expect(u29).to.equal(true);
    end);
end;