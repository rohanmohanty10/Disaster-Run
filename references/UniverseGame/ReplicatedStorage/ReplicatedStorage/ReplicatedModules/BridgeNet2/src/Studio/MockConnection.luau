  

 

local v1 = {};
local u3 = {
    __index = v1,

    __tostring = function(p2) -- Line: 7, Name: __tostring
        return "ClientConnection";
    end
};

function v1.Disconnect(p4) -- Line: 11
    p4.Connected = nil;
    table.clear(p4);
    setmetatable(p4, nil);
end;

return function() -- Line: 18
    -- upvalues: u3 (copy)
    return setmetatable({
        Connected = true,

        _disconnectCallback = function() -- Line: 22, Name: _disconnectCallback
        end
    }, u3);
end;