 
 

local Players = game:GetService("Players");
local script_Parent = script.Parent;
local Shared = script_Parent.Parent.Parent.Shared;
local React = require(Shared.React);
local Promise = require(Shared.Promise);
local useTagged = require(script_Parent.useTagged);
local useAttribute = require(script_Parent.useAttribute);
local u1 = {};

local function getAccessory(u2: number, p3: any) -- Line: 26
    -- upvalues: Promise (copy), Players (copy)
    local u4 = p3 or Enum.AccessoryType.Back;

    return Promise.new(function(p5, p6) -- Line: 29
        -- upvalues: u2 (copy), u4 (copy), Players (ref)
        local HumanoidDescription = Instance.new("HumanoidDescription");
        HumanoidDescription:SetAccessories({
            {
                IsLayered = false,
                AssetId = u2,
                AccessoryType = u4
            }
        }, true);
        local v7 = Players:CreateHumanoidModelFromDescription(HumanoidDescription, Enum.HumanoidRigType.R15):FindFirstChildWhichIsA("Accoutrement");

        if not v7 then
            p6("Accessory not found!");

            return;
        end;

        local Model = Instance.new("Model");

        for _, child in v7:GetChildren() do
            if child:IsA("MeshPart") then
                child.Size = child.MeshSize;
            end;

            child.Parent = Model;

            if child:IsA("BasePart") then
                Model.PrimaryPart = child;
            end;
        end;

        Model:PivotTo(CFrame.identity);
        p5(Model);
    end);
end;

local function getBoombox(p8: number) -- Line: 66
    -- upvalues: u1 (copy), Promise (copy), getAccessory (copy)
    if not u1[p8] then
        u1[p8] = Promise.retry(getAccessory, 5, p8);
    end;

    return u1[p8];
end;

return function() -- Line: 74, Name: useBoomboxData
    -- upvalues: useTagged (copy), React (copy), useAttribute (copy), u1 (copy), Promise (copy), getAccessory (copy)
    local v9 = (-1 / 0);
    local v10 = {};
    local v11 = nil;

    for _, v in useTagged("RelicsBoombox") do
        local v12 = tonumber(v:GetAttribute("Priority")) or 0;
        local v13 = tonumber(v:GetAttribute("AccessoryId")) or 0;

        if v9 < v12 then
            v11 = v;
        else
            v12 = v9;
        end;

        if v13 then
            table.insert(v10, v13);
            v9 = v12;
        else
            v9 = v12;
        end;
    end;

    local u14, u15 = React.useState(nil);
    local u17 = useAttribute(v11, "AccessoryId", function(p16) -- Line: 97
        return type(p16) == "number" and p16 // 1 or nil;
    end);
    local v19 = useAttribute(v11, "AccessoryType", function(p18) -- Line: 101
        if typeof(p18) == "EnumItem" and p18:IsA("AccessoryType") then
            return p18;
        end;

        return nil;
    end);
    local u21 = useAttribute(v11, "RenderOffset", function(p20) -- Line: 109
        return typeof(p20) == "CFrame" and p20 and p20 or CFrame.identity;
    end);
    local u23 = useAttribute(v11, "RenderZoomScale", function(p22) -- Line: 113
        return typeof(p22) == "number" and p22 and p22 or 1;
    end);
    local u25 = useAttribute(v11, "RenderAmbient", function(p24) -- Line: 117
        return typeof(p24) == "Color3" and p24 and p24 or Color3.new(1, 1, 1);
    end);
    React.useEffect(function() -- Line: 121
        -- upvalues: u17 (copy), u1 (ref), Promise (ref), getAccessory (ref), u25 (copy), u23 (copy), u15 (copy)
        if u17 then
            local v26 = u17;

            if not u1[v26] then
                u1[v26] = Promise.retry(getAccessory, 5, v26);
            end;

            u1[v26]:andThen(function(p27: userdata) -- Line: 123
                -- upvalues: u25 (ref), u23 (ref), u15 (ref)
                local v28 = p27:Clone();
                v28:SetAttribute("Ambient", u25);
                v28:SetAttribute("ZoomScale", u23);
                u15(v28);
            end);
        end;
    end, {
        u25,
        u23,
        u17,
        v19
    });
    React.useEffect(function() -- Line: 137
        -- upvalues: u14 (copy), u21 (copy)
        local v29 = u14 and u14.PrimaryPart;

        if v29 then
            v29.PivotOffset = u21;
        end;
    end, { u14, u21 });

    return {
        OwnershipIds = v10,
        AssetId = u17,
        Model = u14
    };
end;