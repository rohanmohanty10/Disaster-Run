 
 

local script_Parent = script.Parent;
local Parent = script_Parent.Parent.Parent;
local React = require(Parent.Shared.React);
local u1 = require(Parent);
local useEffect = React.useEffect;
local useSignal = require(script_Parent.useSignal);

return function() -- Line: 13, Name: useSettings
    -- upvalues: React (copy), u1 (copy), useSignal (copy), useEffect (copy)
    local u2, u3 = React.useState(u1.GetCachedSettings);
    useSignal(u1.SettingChanged, function(p4: string, p5: boolean) -- Line: 16
        -- upvalues: u2 (copy), u3 (copy)
        local table_clone_ret = table.clone(u2);
        table_clone_ret[p4] = p5;
        u3(table_clone_ret);
    end, { u2 });
    useEffect(function() -- Line: 22
        -- upvalues: u1 (ref), u3 (copy)
        u3((u1.GetSettingsAsync()));
    end, {});

    return u2;
end;