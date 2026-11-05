  

 

local Roact = require(script.Parent.Parent.Roact);
local storeKey = require(script.Parent.storeKey);
local v1 = Roact.Component:extend("StoreProvider");

function v1.init(p2, p3) -- Line: 7
    -- upvalues: storeKey (copy)
    local store = p3.store;

    if store == nil then
        error("Error initializing StoreProvider. Expected a `store` prop to be a Rodux store.");
    end;

    p2._context[storeKey] = store;
end;

function v1.render(p4) -- Line: 17
    -- upvalues: Roact (copy)
    return Roact.oneChild(p4.props[Roact.Children]);
end;

return v1;