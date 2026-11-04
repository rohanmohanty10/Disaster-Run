  

local CollectionService = game:GetService("CollectionService");
local script_Parent = script.Parent;
local React = require(script_Parent.Parent.Parent.Shared.React);
local useSignal = require(script_Parent.useSignal);

return function(u1: string) -- Line: 12, Name: useTagged
    -- upvalues: React (copy), CollectionService (copy), useSignal (copy)
    local v2, u3 = React.useState(function() -- Line: 13
        -- upvalues: CollectionService (ref), u1 (copy)
        return CollectionService:GetTagged(u1);
    end);
    local InstanceAddedSignal = CollectionService:GetInstanceAddedSignal(u1);
    local InstanceRemovedSignal = CollectionService:GetInstanceRemovedSignal(u1);
    local u4 = nil;

    local function update() -- Line: 21
        -- upvalues: u4 (ref), CollectionService (ref), u1 (copy), u3 (copy)
        if u4 then
            return;
        end;

        u4 = task.defer(function() -- Line: 26
            -- upvalues: CollectionService (ref), u1 (ref), u4 (ref), u3 (ref)
            local Tagged = CollectionService:GetTagged(u1);
            u4 = nil;
            u3(Tagged);
        end);
    end;

    useSignal(InstanceAddedSignal, update);
    useSignal(InstanceRemovedSignal, update);

    return v2;
end;