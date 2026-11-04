 

 

local TypeRegistry = require(script.Parent.TypeRegistry);
local u1 = {};

local function getConfig(p2) -- Line: 15
    -- upvalues: TypeRegistry (copy)
    if not p2 then
        return nil;
    end;

    local TypeFor = TypeRegistry.getTypeFor(p2);

    if TypeFor and not TypeFor.directAccess then
        return TypeRegistry.getConfig(p2);
    end;

    return nil;
end;

local function readExcludes(p3, p4) -- Line: 22
    if not p3 then
        return p4;
    end;

    for _, child in ipairs(p3:GetChildren()) do
        if child:IsA("ObjectValue") and child.Value then
            table.insert(p4, child.Value);
        end;
    end;

    return p4;
end;

local function legacyEventCfg(p5) -- Line: 31
    local Events = p5:FindFirstChild("Events");

    if Events then
        Events = Events:FindFirstChild("OnHit");
    end;

    if Events and Events:IsA("Configuration") then
        return Events;
    end;

    return nil;
end;

function u1.read(p6) -- Line: 40
    -- upvalues: TypeRegistry (copy), u1 (copy)
    local v7;

    if p6 then
        local TypeFor = TypeRegistry.getTypeFor(p6);

        if TypeFor and not TypeFor.directAccess then
            v7 = TypeRegistry.getConfig(p6);
        else
            v7 = nil;
        end;
    else
        v7 = nil;
    end;

    if v7 then
        return u1.readConfig(v7);
    end;

    return "", {};
end;

local u8 = {
    Reactor = true
};

function u1.appliesWithoutEvents(p9) -- Line: 51
    -- upvalues: TypeRegistry (copy), u8 (copy)
    local _, v10 = TypeRegistry.getTypeFor(p9);

    return u8[v10] == true;
end;

function u1.readConfig(p11) -- Line: 57
    -- upvalues: readExcludes (copy)
    local Attribute = p11:GetAttribute("HitFilterGroup");
    local v12 = type(Attribute) ~= "string" and "" or Attribute;
    local v13 = readExcludes(p11:FindFirstChild("HitFilterExclude"), {});
    local v14;

    if v12 == "" and #v13 == 0 then
        local Events = p11:FindFirstChild("Events");

        if Events then
            Events = Events:FindFirstChild("OnHit");
        end;

        if not (Events and Events:IsA("Configuration")) then
            Events = nil;
        end;

        if Events then
            v14 = Events:GetAttribute("CollisionGroup");

            if type(v14) ~= "string" then
                v14 = v12;
            end;

            readExcludes(Events:FindFirstChild("ExcludeList"), v13);
        else
            v14 = v12;
        end;
    else
        v14 = v12;
    end;

    return v14, v13;
end;

function u1.setGroup(p15, p16) -- Line: 73
    -- upvalues: TypeRegistry (copy)
    local v17;

    if p15 then
        local TypeFor = TypeRegistry.getTypeFor(p15);

        if TypeFor and not TypeFor.directAccess then
            v17 = TypeRegistry.getConfig(p15);
        else
            v17 = nil;
        end;
    else
        v17 = nil;
    end;

    if not v17 then
        return false;
    end;

    if type(p16) ~= "string" or p16 == "" then
        p16 = nil;
    end;

    v17:SetAttribute("HitFilterGroup", p16);

    return true;
end;

local function excludeFolder(p18, p19) -- Line: 81
    local HitFilterExclude = p18:FindFirstChild("HitFilterExclude");

    if HitFilterExclude or not p19 then
        return HitFilterExclude;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "HitFilterExclude";
    Folder.Parent = p18;

    return Folder;
end;

function u1.addExclude(p20, p21) -- Line: 90
    -- upvalues: TypeRegistry (copy)
    local v22;

    if p20 then
        local TypeFor = TypeRegistry.getTypeFor(p20);

        if TypeFor and not TypeFor.directAccess then
            v22 = TypeRegistry.getConfig(p20);
        else
            v22 = nil;
        end;
    else
        v22 = nil;
    end;

    if not (v22 and p21) then
        return false;
    end;

    local HitFilterExclude = v22:FindFirstChild("HitFilterExclude");

    if not HitFilterExclude then
        HitFilterExclude = Instance.new("Folder");
        HitFilterExclude.Name = "HitFilterExclude";
        HitFilterExclude.Parent = v22;
    end;

    for _, child in ipairs(HitFilterExclude:GetChildren()) do
        if child:IsA("ObjectValue") and child.Value == p21 then
            return false;
        end;
    end;

    local ObjectValue = Instance.new("ObjectValue");
    ObjectValue.Name = "Exclude";
    ObjectValue.Value = p21;
    ObjectValue.Parent = HitFilterExclude;

    return true;
end;

function u1.removeExclude(p23, p24) -- Line: 104
    -- upvalues: TypeRegistry (copy)
    local v25;

    if p23 then
        local TypeFor = TypeRegistry.getTypeFor(p23);

        if TypeFor and not TypeFor.directAccess then
            v25 = TypeRegistry.getConfig(p23);
        else
            v25 = nil;
        end;
    else
        v25 = nil;
    end;

    if v25 then
        v25 = v25:FindFirstChild("HitFilterExclude");
    end;

    if not v25 then
        return false;
    end;

    local v26 = false;

    for _, child in ipairs(v25:GetChildren()) do
        if child:IsA("ObjectValue") and child.Value == p24 then
            child.Parent = nil;
            v26 = true;
        end;
    end;

    if #v25:GetChildren() == 0 then
        v25.Parent = nil;
    end;

    return v26;
end;

function u1.migrateFromEvent(p27, p28) -- Line: 123
    -- upvalues: TypeRegistry (copy), readExcludes (copy), u1 (copy)
    local v29;

    if p27 then
        local TypeFor = TypeRegistry.getTypeFor(p27);

        if TypeFor and not TypeFor.directAccess then
            v29 = TypeRegistry.getConfig(p27);
        else
            v29 = nil;
        end;
    else
        v29 = nil;
    end;

    if not v29 then
        return false;
    end;

    if not p28 then
        p28 = v29:FindFirstChild("Events");

        if p28 then
            p28 = p28:FindFirstChild("OnHit");
        end;

        if not (p28 and p28:IsA("Configuration")) then
            p28 = nil;
        end;
    end;

    if not p28 then
        return false;
    end;

    local Attribute = p28:GetAttribute("CollisionGroup");
    local v30;

    if Attribute == nil then
        v30 = false;
    else
        if type(Attribute) == "string" and (Attribute ~= "" and v29:GetAttribute("HitFilterGroup") == nil) then
            v29:SetAttribute("HitFilterGroup", Attribute);
        end;

        p28:SetAttribute("CollisionGroup", nil);
        v30 = true;
    end;

    local ExcludeList = p28:FindFirstChild("ExcludeList");

    if ExcludeList then
        for _, v in ipairs((readExcludes(ExcludeList, {}))) do
            u1.addExclude(p27, v);
        end;

        ExcludeList.Parent = nil;
        v30 = true;
    end;

    return v30;
end;

return u1;