  

 

local TableKit = require(script.Parent.Parent.Parent.TableKit);

return function(p1) -- Line: 4
    -- upvalues: TableKit (copy)
    if typeof(p1) == "table" then
        if TableKit.IsArray(p1) then
            return TableKit.ToArrayString(p1);
        end;

        return TableKit.ToString(p1);
    end;

    local v2 = "";
    local v3 = "";

    if typeof(p1) == "CFrame" then
        v2 = "CFrame(";
        v3 = ")";
    elseif typeof(p1) == "Vector3" then
        v2 = "Vector3(";
        v3 = ")";
    end;

    return `{v2}{tostring(p1)}{v3}`;
end;