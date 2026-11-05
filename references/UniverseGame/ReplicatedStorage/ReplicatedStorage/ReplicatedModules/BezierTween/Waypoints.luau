  

 

game:GetService("RunService");
local v7 = {
    fromVector3 = function(...) -- Line: 19, Name: fromVector3
        local v1 = { ... };
        local v2 = {};

        for i = 1, #v1 do
            if typeof(v1[i]) ~= "Vector3" then
                error(tostring(v1[i]) .. "is not a Vector3 value.");
            end;

            table.insert(v2, v1[i]);
        end;

        return v2;
    end,

    fromCFrame = function(...) -- Line: 29, Name: fromCFrame
        local v3 = { ... };
        local v4 = {};

        for i = 1, #v3 do
            if typeof(v3[i]) ~= "CFrame" then
                error(tostring(v3[i]) .. "is not a CFrame value.");
            end;

            table.insert(v4, v3[i].Position);
        end;

        return v4;
    end,

    fromInstance = function(...) -- Line: 39, Name: fromInstance
        local v5 = { ... };
        local v6 = {};

        for i = 1, #v5 do
            if typeof(v5[i]) ~= "Instance" then
                error(tostring(v5[i]) .. "is not an Instance.");
            end;

            if not v5[i]:IsA("BasePart") then
                error(tostring(v5[i]) .. "is not a BasePart.");
            end;

            table.insert(v6, v5[i].Position);
        end;

        return v6;
    end
};
local u8 = {
    Vector3 = v7.fromVector3,
    CFrame = v7.fromCFrame,
    Instance = v7.fromInstance
};

function v7.new(...) -- Line: 58
    -- upvalues: u8 (copy)
    local v9 = u8[typeof(...)];
    assert(v9, "Parameters are not correct value types, try using value specific functions.");

    return u8[typeof(...)](...);
end;

return v7;