 
 

local u1 = print(script.Parent:WaitForChild("Type"));
local v2 = {};

local function Modify(p3, p4) -- Line: 9
    local v5 = type(p4) == "table";
    assert(v5, "Values is not a table");

    for i, v in next, p4 do
        if type(i) == "number" then
            v.Parent = p3;
        else
            p3[i] = v;
        end;
    end;

    return p3;
end;

local function Make(p6, p7) -- Line: 24
    -- upvalues: Modify (copy)
    return Modify(Instance.new(p6), p7);
end;

local u8 = {
    StringValue = true,
    IntValue = true,
    NumberValue = true,
    BrickColorValue = true,
    BoolValue = true,
    Color3Value = true,
    Vector3Value = true,
    IntConstrainedValue = true
};

local function TypeIsAcceptable(p9) -- Line: 41
    -- upvalues: u8 (copy)
    return u8[p9];
end;

v2.TypeIsAcceptable = TypeIsAcceptable;
v2.typeIsAcceptable = TypeIsAcceptable;

local function AddSubDataLayer(p10, p11) -- Line: 47
    -- upvalues: Modify (copy)
    return p11:FindFirstChild(p10) or Modify(Instance.new("Configuration"), {
        Archivable = true,
        Name = p10,
        Parent = p11
    });
end;

v2.AddSubDataLayer = AddSubDataLayer;
v2.addSubDataLayer = AddSubDataLayer;
local u12 = {};
setmetatable(u12, {
    __mode = "k"
});

local function MakeEasyConfiguration(u13) -- Line: 64
    -- upvalues: u12 (copy), Modify (copy), u8 (copy), u1 (copy)
    if u12[u13] then
        return u12[u13];
    end;

    local v14 = {};

    local function Get(p15) -- Line: 70
        -- upvalues: u13 (copy)
        return u13:FindFirstChild(p15);
    end;

    setmetatable(v14, {
        __index = function(p16, p17) -- Line: 75, Name: __index
            -- upvalues: u13 (copy), Modify (ref), Get (copy), u8 (ref), u1 (ref)
            if not type(p17) == "string" then
                error("Only Indexing with strings is supported with easyConfiguration", 2);
            end;

            local v18 = p17:lower();

            if v18 == "add" or v18 == "addvalue" then
                return function(p19, p20) -- Line: 91
                    -- upvalues: u13 (ref), Modify (ref)
                    local v21 = nil;

                    if p20 and (p20.Name and type(p20.Name) == "string") then
                        v21 = u13:FindFirstChild(p20.Name);

                        if v21 and v21.ClassName ~= p19 then
                            print("[EasyConfiguration] - Invalid class \'" .. v21.ClassName .. "\' in configuration, being replaced by new data \'" .. p19 .. "\'");
                            v21:Destroy();
                            v21 = nil;
                        end;
                    else
                        error(
                            "[EasyConfiguration] - No values received in the add method of easy configuration. Please give a table of default properties including the name. ",
                            2
                        );
                    end;

                    if not v21 then
                        local Instance_new_ret = Instance.new(p19);
                        Modify(Instance_new_ret, p20);
                        Instance_new_ret.Parent = u13;
                    end;
                end;
            end;

            if v18 == "get" or v18 == "getvalue" then
                return function(p22) -- Line: 112
                    -- upvalues: Get (ref)
                    return Get(p22);
                end;
            end;

            if v18 == "getcontainer" then
                return function(p23) -- Line: 116
                    -- upvalues: Get (ref)
                    return Get(p23);
                end;
            end;

            local v24 = u13:FindFirstChild(p17);

            if v24 and u8[v24.ClassName] then
                return v24.Value;
            end;

            error("[EasyConfiguration] - " .. (v24 and "Object \'" .. p17 .. "\' was a " .. u1.getType(v24) .. " value, and not acceptable, so no return was given" or "Could not find Object \'" .. p17 .. "\' in the configuration"), 2);
        end,

        __newindex = function(p25, p26, p27) -- Line: 128, Name: __newindex
            -- upvalues: u13 (copy), u8 (ref)
            if type(p26) ~= "string" then
                error("[EasyConfiguration] - Index with a string");

                return;
            end;

            local v28 = u13:FindFirstChild(p26);

            if v28 and u8[v28.ClassName] then
                v28.Value = p27;

                return;
            end;

            error("[EasyConfiguration] - Value \'" .. p26 .. "\' was not accepted, or wasn\'t in the configuration", 2);
        end
    });
    u12[u13] = v14;

    return v14;
end;

v2.Make = MakeEasyConfiguration;
v2.MakeEasyConfiguration = MakeEasyConfiguration;

return v2;