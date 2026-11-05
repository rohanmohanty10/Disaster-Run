  

 

local Petal = _G.Petal;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.GenericModule);
local Players = game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
local LocalPlayer = Players.LocalPlayer;
local u1 = Petal("New");
local Tween = Petal("Util").Tween;
local Trove = require(Knit.Util.Trove);
local _ = Instance.new;
local _ = Vector3.new;
local new = CFrame.new;
local _ = CFrame.Angles;

local function Normalise(p2) -- Line: 19
    return p2:gsub("(%l)(%w*)", function(p3, p4) -- Line: 20
        return string.upper(p3) .. p4;
    end);
end;

return function(...) -- Line: 23
    -- upvalues: Trove (copy), LocalPlayer (copy), Normalise (copy), new (copy), u1 (copy), Tween (copy), CollectionService (copy)
    local v5, v6, v7 = ...;
    local u8 = Trove.new();
    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    if v5 ~= "Create" then
        local u9 = unpack(CollectionService:GetTagged(LocalPlayer.Name .. "TimeAnchor"));

        if u9 then
            Tween(u9:FindFirstChild("HL"), 0.5, "Quad", "InOut", {
                FillTransparency = 1,
                OutlineTransparency = 1
            }).Completed:Once(function() -- Line: 94
                -- upvalues: u9 (copy)
                u9:Destroy();
            end);
        end;

        return;
    end;

    local u10 = script.Duplicate:Clone();
    u10.Parent = workspace.Effects;
    local v11 = next;
    local v12, v13 = u10:GetChildren();

    for _, v in v11, v12, v13 do
        if v:IsA("BasePart") and v.Name ~= "Invis" then
            v.CFrame = Character:FindFirstChild(Normalise(v.Name)).CFrame;
            script.Empty:Clone();
            local v14 = next;
            local v15, v16 = Enum.NormalId:GetEnumItems();

            for _, v2 in v14, v15, v16 do
                local v17 = script.Empty:Clone();
                v17.Face = v2;
                v17.Parent = v;
            end;

            v.Transparency = 0.99999;
        end;
    end;

    if v7 == 2 then
        u10:SetPrimaryPartCFrame(v6 * CFrame.fromEulerAnglesXYZ(Character.Torso.CFrame:ToEulerAnglesXYZ()));
    else
        local v18 = table.pack(select(4, u10.torso.CFrame:GetComponents()));
        u10:SetPrimaryPartCFrame(new(v6.X, v6.Y, v6.Z, unpack(v18)));
    end;

    local Halo = Character:FindFirstChild("Halo");
    local v19;

    if Halo then
        v19 = Halo.Inner.Color;
    else
        v19 = nil;
    end;

    Tween(u1("Highlight")({
        Name = "HL",
        FillTransparency = 0,
        Parent = u10,
        DepthMode = Enum.HighlightDepthMode.Occluded,
        FillColor = v19,
        OutlineColor = Color3.new(1, 1, 1)
    }), 0.5, "Quad", "InOut", {
        FillTransparency = 0.725
    });
    CollectionService:AddTag(u10, LocalPlayer.Name .. "TimeAnchor");
    u8:Connect(u10.AncestryChanged, function() -- Line: 75
        -- upvalues: Character (copy), u10 (ref), u8 (copy)
        if Character.Parent and u10.Parent == nil then
            u8:Destroy();
        end;
    end);
    u8:Connect(Character.AncestryChanged, function() -- Line: 80
        -- upvalues: Character (copy), Tween (ref), u10 (ref)
        if not Character.Parent then
            Tween(u10:FindFirstChild("HL"), 0.5, "Quad", "InOut", {
                FillTransparency = 1,
                OutlineTransparency = 1
            }).Completed:Once(function() -- Line: 82
                -- upvalues: u10 (ref)
                u10:Destroy();
                u10 = nil;
            end);
        end;
    end);
end;