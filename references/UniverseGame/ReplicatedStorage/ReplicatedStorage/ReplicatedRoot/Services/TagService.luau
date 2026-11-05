  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
require(ReplicatedRoot.Core);
local Signal = require(ReplicatedRoot.Libraries.Classes.Signal);
local Trove = require(ReplicatedRoot.Libraries.Classes.Trove);
local CommonUtil = require(ReplicatedRoot.Libraries.Utility.CommonUtil);
local u1 = {
    Name = "TagService",
    ContainerCache = {},
    SignalCache = {}
};
local TagConstructor = require(script.TagConstructor);
local TweenService = game:GetService("TweenService");

local function FindContainer(p2) -- Line: 33
    -- upvalues: FindContainer (copy)
    if p2:IsA("Folder") and p2.Name == "Tags" then
        return p2;
    end;

    if p2:IsA("ObjectValue") and p2.Name == "Tags" then
        return FindContainer(p2.Value);
    end;

    local Tags = p2:FindFirstChild("Tags");

    if Tags then
        return FindContainer(Tags);
    end;

    local v3 = game.Players:GetPlayerFromCharacter(p2);

    if v3 then
        return FindContainer(v3);
    end;
end;

function u1.GetContainer(u4) -- Line: 53
    -- upvalues: u1 (copy), FindContainer (copy)
    local v5 = u1.ContainerCache[u4];

    if v5 ~= nil then
        return v5;
    end;

    local u6 = FindContainer(u4);

    if u6 ~= nil and u6:IsDescendantOf(game) then
        local u7 = nil;
        u7 = u6.AncestryChanged:Connect(function() -- Line: 62
            -- upvalues: u6 (copy), u7 (ref), u1 (ref), u4 (copy)
            if not u6:IsDescendantOf(game) then
                u7:Disconnect();
                u1.ContainerCache[u4] = nil;
            end;
        end);
        u1.ContainerCache[u4] = u6;
    end;

    return u6;
end;

function u1.CreateTag(...) -- Line: 74
    -- upvalues: TagConstructor (copy)
    local v8 = ...;

    if typeof(v8) ~= "Instance" then
        if typeof(v8) ~= "string" then
            return nil;
        end;

        local v9, v10, v11 = ...;

        return TagConstructor.Create(v9, v10, v11);
    end;

    local v12, v13, v14, v15 = ...;
    local v16 = TagConstructor.Create(v13, v14, v15, v12);

    if string.find(v13, "Multiplier") then
        local v17 = debug.info(3, "s");

        if string.find(v17, "AbilityMoves") then
            v16:SetAttribute("Source", "Moves");

            return v16;
        end;

        if string.find(v17, "Commands") then
            v16:SetAttribute("Source", "Commands");

            return v16;
        end;

        if string.find(v17, "CustomAddoms") then
            v16:SetAttribute("Source", "Other");
        end;
    end;

    return v16;
end;

u1.Add = u1.CreateTag;

function u1.GetTag(p18, p19) -- Line: 102
    local v20 = p18:FindFirstChild(p19);

    if v20 then
        return v20;
    end;
end;

u1.Get = u1.GetTag;

function u1.GetTags(p21) -- Line: 110
    local v22 = {};

    if typeof(p21) == "Instance" then
        p21 = p21:GetChildren();
    end;

    for _, v in pairs(p21) do
        if v:IsA("ValueBase") then
            table.insert(v22, v);
        end;
    end;

    return v22;
end;

function u1.GetTagsWithName(p23, p24) -- Line: 123
    local v25 = {};

    if typeof(p23) == "Instance" then
        p23 = p23:GetChildren();
    end;

    for _, v in pairs(p23) do
        if v:IsA("ValueBase") and v.Name == p24 then
            table.insert(v25, v);
        end;
    end;

    return v25;
end;

function u1.TweenTagValue(p26, p27) -- Line: 136
    -- upvalues: u1 (copy)
    local v28 = p27 or {};
    local v29 = v28.EasingStyle or Enum.EasingStyle.Linear;
    local v30 = v28.EasingDirection or Enum.EasingDirection.Out;
    local v31 = v28.Time or 1;
    local v32 = v28.Value or 0;
    p26:SetAttribute("Started", (workspace:GetServerTimeNow()));
    p26:SetAttribute("Time", v31);
    p26:SetAttribute("EasingStyle", v29.Name);
    p26:SetAttribute("EasingDirection", v30.Name);
    p26:SetAttribute("StartValue", u1.GetTagValue(p26));
    p26.Value = v32;
end;

function u1.GetTagValue(p33) -- Line: 154
    -- upvalues: TweenService (copy)
    local v34 = p33:GetAttribute("Started");
    local v35 = p33:GetAttribute("Time");
    local v36 = p33:GetAttribute("StartValue");

    if not (v36 and (v34 and v35)) then
        return p33.Value;
    end;

    local v37 = workspace:GetServerTimeNow() - v34;
    local v38 = math.abs(v37);

    if v35 <= v38 then
        return p33.Value;
    end;

    local v39 = p33:GetAttribute("EasingStyle");
    local v40 = p33:GetAttribute("EasingDirection");
    local v41 = TweenService:GetValue(v38 / v35, v39, v40);
    local Value = p33.Value;
    local v42 = math.clamp(v41, 0, 1);

    return math.lerp(v36, Value, v42);
end;

function u1.GetLowestTag(p43, p44, p45) -- Line: 172
    -- upvalues: u1 (copy)
    if typeof(p43) == "Instance" then
        p43 = u1.GetTagsWithName(p43, p44);
    end;

    for _, v in pairs(p43) do
        if (v:IsA("NumberValue") or v:IsA("IntValue")) and v.Name == p44 then
            local v46 = u1.GetTagValue(v);

            if not p45 or p45 and v46 < p45 then
                p45 = v46;
            end;
        end;
    end;

    return p45;
end;

u1.GetMin = u1.GetLowestTag;

function u1.GetHighestTag(p47, p48, p49) -- Line: 191
    -- upvalues: u1 (copy)
    if typeof(p47) == "Instance" then
        p47 = u1.GetTagsWithName(p47, p48);
    end;

    for _, v in pairs(p47) do
        if (v:IsA("NumberValue") or v:IsA("IntValue")) and v.Name == p48 then
            local v50 = u1.GetTagValue(v);

            if not p49 or p49 and p49 < v50 then
                p49 = v50;
            end;
        end;
    end;

    return p49;
end;

u1.GetMax = u1.GetHighestTag;

function u1.GetTagTotal(p51, p52, p53) -- Line: 210
    -- upvalues: u1 (copy)
    if typeof(p51) == "Instance" then
        p51 = u1.GetTagsWithName(p51, p52);
    end;

    local v54 = p53 or 0;
    local v55 = 0;

    for _, v in pairs(p51) do
        if (v:IsA("NumberValue") or v:IsA("IntValue")) and v.Name == p52 then
            v54 = v54 + u1.GetTagValue(v);
            v55 = v55 + 1;
        end;
    end;

    return v54, v55;
end;

function u1.GetTagLinearTotal(p56, p57, p58) -- Line: 227
    -- upvalues: u1 (copy)
    local v59, v60 = u1.GetTagTotal(p56, p57, p58);

    return 1 - (v60 - v59);
end;

function u1.CalculateTagTotal(p61, p62, p63) -- Line: 233
    -- upvalues: u1 (copy)
    local v64 = u1.GetTagTotal(p61, p62, p63);
    local v65, v66 = u1.GetTagTotal(p61, `{p62}Multiplier`, 0);
    local v67 = 1 - (v66 - v65);

    if v67 ~= 1 then
        v64 = v64 * v67;
    end;

    local v68, v69 = u1.GetTagTotal(p61, `{p62}Divider`, 0);
    local v70 = 1 - (v69 - v68);

    if v70 ~= 1 then
        v64 = v64 / v70;
    end;

    return v64;
end;

function u1.GetLegacyTotal(p71, p72, p73, p74) -- Line: 251
    -- upvalues: u1 (copy)
    if typeof(p71) == "Instance" then
        p71 = u1.GetTags(p71);
    end;

    local v75 = p73 or 0;

    for _, v in pairs(p71) do
        if (v:IsA("NumberValue") or v:IsA("IntValue")) and (not p72 or string.sub(v.Name, 1, #p72) == p72) then
            if p74 then
                v75 = v75 + v.Value;
            elseif v.Name:find("Multiplier") then
                v75 = v75 * v.Value;
            elseif v.Name:find("Divider") then
                v75 = v75 / v.Value;
            elseif v.Name:find("Modulo") then
                v75 = v75 % v.Value;
            elseif v.Name:find("Subtractor") then
                v75 = v75 - v.Value;
            else
                v75 = v75 + v.Value;
            end;
        end;
    end;

    return v75;
end;

u1.GetTotal = u1.GetLegacyTotal;

function u1.SetTagValue(p76, p77) -- Line: 281
    p76:SetAttribute("Started", nil);
    p76.Value = p77;
end;

function u1.GetEventSignal(u78) -- Line: 286
    -- upvalues: u1 (copy), Signal (copy), Trove (copy)
    if u1.SignalCache[u78] then
        return u1.SignalCache[u78];
    end;

    local u79 = Signal.new();
    local u80 = Trove.new();
    u80:Add(u79);
    u80:Add(function() -- Line: 294
        -- upvalues: u1 (ref), u78 (copy)
        u1.SignalCache[u78] = nil;
    end);
    u80:Connect(u78.Destroying, function() -- Line: 297
        -- upvalues: u80 (copy)
        u80:Destroy();
    end);
    u1.SignalCache[u78] = u79;
    local u81 = {};

    local function Hook(u82) -- Line: 304
        -- upvalues: u81 (copy), u79 (copy)
        if not u81[u82] then
            local Name = u82.Name;
            local Value = u82.Value;
            u81[u82] = {
                Changed = u82:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 309
                    -- upvalues: Value (ref), u82 (copy), u79 (ref)
                    if Value ~= u82.Value then
                        u79:Fire("Changed", u82.Name, u82);
                        Value = u82.Value;
                    end;
                end),
                Name = u82:GetPropertyChangedSignal("Name"):Connect(function() -- Line: 315
                    -- upvalues: u82 (copy), Name (ref), u79 (ref)
                    if u82.Name ~= Name then
                        u79:Fire("Removed", Name, u82);
                        u79:Fire("Added", u82.Name, u82);
                        Name = u82.Name;
                    end;

                    u79:Fire("Changed", u82.Name, u82);
                end)
            };
        end;
    end;

    local function Unhook(p83) -- Line: 327
        -- upvalues: u81 (copy)
        if u81[p83] then
            for i, v in pairs(u81[p83]) do
                v:Disconnect();
                u81[p83][i] = nil;
            end;

            u81[p83] = nil;
        end;
    end;

    u80:Add(u78.ChildAdded:Connect(function(p84) -- Line: 337
        -- upvalues: Hook (copy), u79 (copy)
        if not p84:IsA("ValueBase") then
            return;
        end;

        Hook(p84);
        u79:Fire("Added", p84.Name, p84);
    end));
    u80:Add(u78.ChildRemoved:Connect(function(p85) -- Line: 346
        -- upvalues: Unhook (copy), u79 (copy)
        if not p85:IsA("ValueBase") then
            return;
        end;

        Unhook(p85);
        u79:Fire("Removed", p85.Name, p85);
    end));
    u80:Add(function() -- Line: 355
        -- upvalues: u81 (copy)
        for i, v in pairs(u81) do
            for i2, v2 in pairs(v) do
                v2:Disconnect();
                v[i2] = nil;
            end;

            u81[i] = nil;
        end;
    end);

    return u79;
end;

CommonUtil.WrapServiceMethods(u1);

return u1;