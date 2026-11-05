  

 

local Players = game:GetService("Players");
local Knit = require(script.Parent.Parent.KnitPackage.Knit);
local Trove = require(Knit.Util.Trove);
local Signal = require(Knit.Util.Signal);
local u1 = {
    Name = "TagService"
};
local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);

if Core.Flags.UseNewTagService == true then
    return require(Core.ReplicatedServices.TagService);
end;

local Tag = require(script:WaitForChild("Tag"));

function u1.Add(p2, ...) -- Line: 72
    -- upvalues: Tag (copy)
    local v3 = ...;

    if typeof(v3) == "Instance" then
        local v4, v5, v6, v7, v8 = ...;

        return Tag.new(v5, v6, v7, v4, v8);
    end;

    if typeof(v3) == "string" then
        local v9, v10, v11 = ...;

        return Tag.new(v9, v10, v11);
    end;
end;

function u1.AddStatTag(p12, p13, p14, p15, p16) -- Line: 86
    -- upvalues: Tag (copy)
    return Tag.new("StatTag", p15, "number", p13, {
        StatType = p14,
        MathType = p16
    });
end;

local u17 = {};

local function _GetContainer(p18) -- Line: 94
    -- upvalues: _GetContainer (copy), Players (copy)
    if (p18:IsA("Folder") or p18:IsA("Configuration")) and p18.Name == "Tags" then
        return p18;
    end;

    if p18:IsA("ObjectValue") and p18.Name == "Tags" then
        return _GetContainer(p18.Value);
    end;

    local Tags = p18:FindFirstChild("Tags");

    if Tags then
        return _GetContainer(Tags);
    end;

    local v19 = Players:GetPlayerFromCharacter(p18);

    if v19 then
        return _GetContainer(v19);
    end;

    local v20 = p18:GetAttribute("Player") ~= nil and Players:FindFirstChild(p18:GetAttribute("Player"));

    if v20 then
        return _GetContainer(v20);
    end;
end;

function u1.GetContainer(p21, u22) -- Line: 121
    -- upvalues: u17 (copy), _GetContainer (copy)
    local v23 = u17[u22];

    if v23 then
        return v23;
    end;

    local v24 = _GetContainer(u22);

    if v24 then
        u17[u22] = v24;
        local u25 = nil;
        u25 = v24.AncestryChanged:Connect(function(p26, p27) -- Line: 131
            -- upvalues: u25 (ref), u17 (ref), u22 (copy)
            if p26:IsDescendantOf(workspace) ~= true then
                u25:Disconnect();
                u17[u22] = nil;
            end;
        end);

        return v24;
    end;
end;

function u1.Get(p28, p29, p30) -- Line: 141
    local v31 = p29:FindFirstChild(p30);

    if v31 then
        return v31;
    end;
end;

function u1.GetTags(p32, p33) -- Line: 148
    local v34 = {};

    if typeof(p33) == "Instance" then
        p33 = p33:GetChildren();
    end;

    for _, v in pairs(p33) do
        table.insert(v34, v);
    end;

    return v34;
end;

function u1.GetTagsWithName(p35, p36, p37, p38) -- Line: 159
    if typeof(p36) == "Instance" then
        p36 = p36:GetChildren();
    end;

    if not p37 then
        return p36;
    end;

    local v39 = {};

    if typeof(p37) == "table" then
        for _, v in pairs(p36) do
            if table.find(p37, v.Name) or p37[v.Name] then
                table.insert(v39, v);
            end;
        end;

        return v39;
    end;

    if typeof(p37) == "string" then
        for _, v in pairs(p36) do
            if p38 and v.Name:match(p37) or v.Name == p37 then
                table.insert(v39, v);
            end;
        end;
    end;

    return v39;
end;

function u1.GetTotal(p40, p41, p42, p43, p44) -- Line: 184
    -- upvalues: u1 (copy)
    if typeof(p41) == "Instance" then
        p41 = u1:GetTagsWithName(p41, p42, true);
    end;

    local v45 = p43 or 0;

    for _, v in pairs(p41) do
        if (v:IsA("NumberValue") or v:IsA("IntValue")) and (not p42 or string.sub(v.Name, 1, #p42) == p42) then
            if p44 then
                v45 = v45 + v.Value;
            elseif v.Name:find("Multiplier") then
                v45 = v45 * v.Value;
            elseif v.Name:find("Divider") then
                v45 = v45 / v.Value;
            elseif v.Name:find("Modulo") then
                v45 = v45 % v.Value;
            elseif v.Name:find("Subtractor") then
                v45 = v45 - v.Value;
            else
                v45 = v45 + v.Value;
            end;
        end;
    end;

    return v45;
end;

function u1.GetMin(p46, p47, p48, p49) -- Line: 216
    -- upvalues: u1 (copy)
    if typeof(p47) == "Instance" then
        p47 = u1:GetTagsWithName(p47, p48, true);
    end;

    for _, v in pairs(p47) do
        if (v:IsA("NumberValue") or v:IsA("IntValue")) and (v.Name == p48 and (not p49 or p49 and v.Value < p49)) then
            p49 = v.Value;
        end;
    end;

    return p49;
end;

function u1.GetMax(p50, p51, p52, p53) -- Line: 233
    -- upvalues: u1 (copy)
    if typeof(p51) == "Instance" then
        p51 = u1:GetTagsWithName(p51, p52, true);
    end;

    if type(p51) == "table" then
        for _, v in pairs(p51) do
            if (v:IsA("NumberValue") or v:IsA("IntValue")) and (v.Name == p52 and (not p53 or p53 and p53 < v.Value)) then
                p53 = v.Value;
            end;
        end;

        return p53;
    end;
end;

local u54 = {};

function u1.GetEventSignal(p55, u56) -- Line: 260
    -- upvalues: u54 (copy), Signal (copy), Trove (copy)
    local v57 = u54[u56];

    if v57 then
        return v57;
    end;

    local u58 = Signal.new();
    local v59 = Trove.new();
    v59:Add(u58);
    v59:Add(function() -- Line: 268
        -- upvalues: u54 (ref), u56 (copy)
        u54[u56] = nil;
    end);
    v59:AttachToInstance(u56);
    local u60 = {};
    u54[u56] = u58;

    local function Hook(u61) -- Line: 276
        -- upvalues: u60 (copy), u58 (copy)
        if not u60[u61] then
            local Name = u61.Name;
            local Value = u61.Value;
            u60[u61] = {
                Changed = u61:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 281
                    -- upvalues: u61 (copy), Value (ref), u58 (ref)
                    local Value2 = u61.Value;

                    if Value ~= Value2 then
                        u58:Fire("Changed", u61.Name, u61);
                        Value = Value2;
                    end;
                end),
                Name = u61:GetPropertyChangedSignal("Name"):Connect(function() -- Line: 288
                    -- upvalues: u61 (copy), Name (ref), u58 (ref)
                    local Name2 = u61.Name;

                    if Name2 ~= Name then
                        u58:Fire("Removed", Name, u61);
                        u58:Fire("Added", Name2, u61);
                        Name = Name2;
                    end;

                    u58:Fire("Changed", Name2, u61);
                end)
            };
        end;
    end;

    local function Unhook(p62) -- Line: 301
        -- upvalues: u60 (copy)
        if u60[p62] then
            for i, v in pairs(u60[p62]) do
                v:Disconnect();
                u60[p62][i] = nil;
            end;

            u60[p62] = nil;
        end;
    end;

    v59:Add(u56.ChildAdded:Connect(function(p63) -- Line: 311
        -- upvalues: Hook (copy), u58 (copy)
        if not p63:IsA("ValueBase") then
            return;
        end;

        Hook(p63);
        u58:Fire("Added", p63.Name, p63);
    end));
    v59:Add(u56.ChildRemoved:Connect(function(p64) -- Line: 320
        -- upvalues: Unhook (copy), u58 (copy)
        if not p64:IsA("ValueBase") then
            return;
        end;

        Unhook(p64);
        u58:Fire("Removed", p64.Name, p64);
    end));
    v59:Add(function() -- Line: 329
        -- upvalues: u60 (copy)
        for i, v in pairs(u60) do
            for i2, v2 in pairs(v) do
                v2:Disconnect();
                v[i2] = nil;
            end;

            u60[i] = nil;
        end;
    end);

    return u58;
end;

return u1;