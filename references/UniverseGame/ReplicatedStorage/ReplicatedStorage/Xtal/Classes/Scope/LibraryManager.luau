  

 

local u1 = {};

local function GetFullName(p2, p3) -- Line: 3
    if type(p2) ~= "string" then
        p2 = p2:GetFullName();
    end;

    if type(p3) ~= "string" then
        p3 = p3:GetFullName();
    end;

    local v4 = string.gsub(p2, p3, "");

    return string.sub(v4, 2);
end;

function u1.AddLibrary(p5, p6, p7) -- Line: 14
    -- upvalues: u1 (copy)
    if not p5.Libraries then
        return;
    end;

    local v8 = p7 or p6;

    if typeof(p6) ~= "Instance" then
        return;
    end;

    if not p6:IsA("ModuleScript") then
        if p6:IsA("Folder") or p6:IsA("Configuration") then
            for _, child in pairs(p6:GetChildren()) do
                u1.AddLibrary(p5, child, v8);
            end;
        end;

        return;
    end;

    p5.Libraries[p6.Name] = p6;
    local Libraries = p5.Libraries;
    local v9;

    if type(p6) == "string" then
        v9 = p6;
    else
        v9 = p6:GetFullName();
    end;

    if type(v8) ~= "string" then
        v8 = v8:GetFullName();
    end;

    local v10 = string.gsub(v9, v8, "");
    Libraries[string.sub(v10, 2)] = p6;
end;

function u1.AddClass(p11, p12, p13) -- Line: 37
    -- upvalues: u1 (copy)
    if not p11.Classes then
        return;
    end;

    local v14 = p13 or p12;

    if typeof(p12) ~= "Instance" then
        return;
    end;

    if not p12:IsA("ModuleScript") then
        if p12:IsA("Folder") or p12:IsA("Configuration") then
            for _, child in pairs(p12:GetChildren()) do
                u1.AddClass(p11, child, v14);
            end;
        end;

        return;
    end;

    p11.Classes[p12.Name] = p12;
    local Classes = p11.Classes;
    local v15;

    if type(p12) == "string" then
        v15 = p12;
    else
        v15 = p12:GetFullName();
    end;

    if type(v14) ~= "string" then
        v14 = v14:GetFullName();
    end;

    local v16 = string.gsub(v15, v14, "");
    Classes[string.sub(v16, 2)] = p12;
end;

function u1.Require(p17, p18) -- Line: 60
    if typeof(p18) == "Instance" or type(p18) == "number" then
        return require(p18);
    end;

    if type(p18) == "string" then
        if not p17.Libraries then
            return;
        end;

        local v19 = p17.Libraries[p18];

        if v19 then
            if typeof(v19) == "Instance" then
                return require(v19);
            end;

            return v19;
        end;
    end;
end;

function u1.Class(p20, p21, ...) -- Line: 78
    if not p20.Classes then
        return;
    end;

    local v22 = p20.Classes[p21];

    if typeof(v22) == "Instance" then
        v22 = require(v22);
    end;

    if type(v22) == "function" then
        return v22(...);
    end;

    if type(v22) == "table" and v22.new then
        return v22.new(...);
    end;
end;

return u1;