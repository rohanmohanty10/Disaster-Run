  

 

return function() -- Line: 1
    local Store = require(script.Parent.Store);
    local loggerMiddleware = require(script.Parent.loggerMiddleware);
    it("should print whenever an action is dispatched", function() -- Line: 5
        -- upvalues: Store (copy), loggerMiddleware (copy)
        local u1 = 0;
        local u2 = nil;
        local v5 = Store.new(function(p3, p4) -- Line: 9, Name: reducer
            return p3;
        end, {
            fooValue = 12345,
            barValue = {
                bazValue = "hiBaz"
            }
        }, { loggerMiddleware.middleware });

        function loggerMiddleware.outputFunction(p6) -- Line: 20
            -- upvalues: u1 (ref), u2 (ref)
            u1 = u1 + 1;
            u2 = p6;
        end;

        v5:dispatch({
            type = "testActionType"
        });
        expect(u1).to.equal(1);
        expect(u2:find("testActionType")).to.be.ok();
        expect(u2:find("fooValue")).to.be.ok();
        expect(u2:find("12345")).to.be.ok();
        expect(u2:find("barValue")).to.be.ok();
        expect(u2:find("bazValue")).to.be.ok();
        expect(u2:find("hiBaz")).to.be.ok();
        loggerMiddleware.outputFunction = print;
    end);
end;