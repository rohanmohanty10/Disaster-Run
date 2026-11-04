 
 

local React = require(script.Parent.Parent.Parent.Shared.React);
local useRef = React.useRef;
local useState = React.useState;
local useEffect = React.useEffect;
local useSignal = require(script.Parent.useSignal);

return function(u1: any, u2: function) -- Line: 24, Name: useProperty
    -- upvalues: useRef (copy), useState (copy), useEffect (copy), useSignal (copy)
    local u3 = useRef(nil);
    local v4, u5 = useState(nil);
    local v6 = u1 == nil and true or typeof(u1) == "Instance";
    assert(v6, "useProperty must be called with an instance");

    if u3.current == nil then
        local u7 = false;
        v4 = u2((setmetatable({}, {
            __index = function(p8: any, p9: string) -- Line: 37, Name: __index
                -- upvalues: u7 (ref), u1 (copy), u3 (copy)
                assert(not u7, "useProperty can only read one property.");
                local v10;

                if u1 == nil then
                    v10 = nil;
                else
                    v10 = u1[p9];
                    local v11 = type(v10) ~= "function";
                    assert(v11, "useProperty cannot read functions.");
                    local v12 = typeof(v10) ~= "RBXScriptSignal";
                    assert(v12, "useProperty cannot read events.");
                end;

                u3.current = p9;
                u7 = true;

                return v10;
            end
        })));
        u5(v4);
    end;

    local current = u3.current;
    local v13 = u1 and current and u1:GetPropertyChangedSignal(current);
    useEffect(function() -- Line: 64
        -- upvalues: u1 (copy), u5 (copy), u2 (copy)
        if u1 then
            u5(u2(u1));
        end;
    end, { u1 });
    useSignal(v13, function() -- Line: 70
        -- upvalues: u5 (copy), u2 (copy), u1 (copy)
        u5(u2(u1));
    end, { u1, current });

    return v4;
end;