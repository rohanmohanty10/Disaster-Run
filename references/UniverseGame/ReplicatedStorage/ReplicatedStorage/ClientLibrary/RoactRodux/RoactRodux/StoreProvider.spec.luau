  

 

return function() -- Line: 1
    local StoreProvider = require(script.Parent.StoreProvider);
    local Roact = require(script.Parent.Parent.Roact);
    local Rodux = require(script.Parent.Parent.Rodux);
    it("should be instantiable as a component", function() -- Line: 7
        -- upvalues: Rodux (copy), Roact (copy), StoreProvider (copy)
        local v1 = Rodux.Store.new(function() -- Line: 8
            return 0;
        end);
        local v2 = Roact.createElement(StoreProvider, {
            store = v1
        });
        expect(v2).to.be.ok();
        local v3 = Roact.mount(v2, nil, "StoreProvider-test");
        Roact.unmount(v3);
        v1:destruct();
    end);
    it("should expect a \'store\' prop", function() -- Line: 23
        -- upvalues: Roact (copy), StoreProvider (copy)
        local u4 = Roact.createElement(StoreProvider);
        expect(function() -- Line: 26
            -- upvalues: Roact (ref), u4 (copy)
            Roact.mount(u4);
        end).to.throw();
    end);
end;