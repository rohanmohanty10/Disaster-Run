  

 

return function() -- Line: 1
    local Roact = require(script.Parent.Parent.Roact);
    local Rodux = require(script.Parent.Parent.Rodux);
    local StoreProvider = require(script.Parent.StoreProvider);
    local getStore = require(script.Parent.getStore);
    it("should return the store when present", function() -- Line: 9
        -- upvalues: Rodux (copy), Roact (copy), getStore (copy), StoreProvider (copy)
        local v1 = Rodux.Store.new(function() -- Line: 10, Name: reducer
            return 0;
        end);
        local u2 = nil;
        local v3 = Roact.Component:extend("StoreConsumer");

        function v3.init(p4) -- Line: 19
            -- upvalues: u2 (ref), getStore (ref)
            u2 = getStore(p4);
        end;

        function v3.render(p5) -- Line: 23
            return nil;
        end;

        local v6 = Roact.createElement(StoreProvider, {
            store = v1
        }, {
            Consumer = Roact.createElement(v3)
        });
        local v7 = Roact.mount(v6);
        expect(u2).to.equal(v1);
        Roact.unmount(v7);
        v1:destruct();
    end);
    it("should return nil when the store is not present", function() -- Line: 41
        -- upvalues: Roact (copy), getStore (copy)
        local u8 = 6;
        local v9 = Roact.Component:extend("StoreConsumer");

        function v9.init(p10) -- Line: 47
            -- upvalues: u8 (ref), getStore (ref)
            u8 = getStore(p10);
        end;

        function v9.render(p11) -- Line: 51
            return nil;
        end;

        local v12 = Roact.createElement(v9);
        local v13 = Roact.mount(v12);
        expect(u8).to.equal(nil);
        Roact.unmount(v13);
    end);
end;