  

 

local TweenCallback = _G.Petal("Util").TweenCallback;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.Types);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local LocalPlayer = Players.LocalPlayer;
local u1 = {};

local function ParseArmorData(p2) -- Line: 25
    if not p2 then
        return 0, 100;
    end;

    local v3 = string.split(p2, "/");

    return tonumber(v3[1]) or 0, tonumber(v3[2]) or 100;
end;

return function(p4) -- Line: 38
    -- upvalues: u1 (copy), Trove (copy), TweenCallback (copy), AssetHandler (copy), LocalPlayer (copy)
    local _ = p4.Player;
    local Character = p4.Character;

    if u1[Character] then
        return;
    end;

    if not (Character and Character.Parent) then
        return;
    end;

    if not Character:GetAttribute("HyperArmorData") then
        return;
    end;

    if not Character:WaitForChild("HumanoidRootPart", 2) then
        return;
    end;

    u1[Character] = true;
    local v5 = Trove.new();
    local v6 = v5:Construct(Instance, "Folder");
    v6.Parent = workspace.Effects;
    v6.Name = "HyperArmorParts";
    local u7 = {};
    local u8 = {};
    local u9 = false;
    local u10 = v5:Construct(Instance, "NumberValue");
    u10.Value = 0;

    local function BeginDestroy() -- Line: 63
        -- upvalues: u9 (ref), u7 (copy), TweenCallback (ref), u10 (copy)
        if u9 then
            return;
        end;

        u9 = true;

        for _, v in u7 do
            TweenCallback(v, {
                Transparency = 1
            }, nil, 0.25);
        end;

        TweenCallback(u10, {
            Value = 0
        }, function() -- Line: 69
        end, 0.25);
    end;

    for i = 1, 3 do
        local v11 = AssetHandler.CloneAsset("Universal/Combat/Misc/HyperArmor");

        if v11 then
            v11.Transparency = 1;
            v11.CFrame = Character:GetPivot();
            v11.Parent = v6;
            u8[i] = v11.Color;
            table.insert(u7, v11);
            v5:Add(v11);
        end;
    end;

    TweenInfo.new(0.25);

    for _, v in u7 do
        TweenCallback(v, {
            Transparency = 0.65
        }, nil, 0.25);
    end;

    TweenCallback(u10, {
        Value = 1
    }, nil, 0.25);

    local function UpdateVisuals() -- Line: 93
        -- upvalues: Character (copy), u7 (copy), u8 (copy)
        local v12 = Character:GetAttribute("HyperArmorData");
        local v13, v14;

        if v12 then
            local v15 = string.split(v12, "/");
            v13 = tonumber(v15[1]) or 0;
            v14 = tonumber(v15[2]) or 100;
        else
            v13 = 0;
            v14 = 100;
        end;

        local v16 = math.clamp(v13 / v14, 0, 1);

        for i, v in u7 do
            v.Color = u8[i]:Lerp(Color3.new(0.294118, 0.294118, 0.294118), 1 - v16);
        end;
    end;

    v5:Connect(Character:GetAttributeChangedSignal("HyperArmorData"), function() -- Line: 102
        -- upvalues: Character (copy), BeginDestroy (copy), UpdateVisuals (copy)
        local v17 = Character:GetAttribute("HyperArmorData");

        if not v17 then
            BeginDestroy();

            return;
        end;

        local v18;

        if v17 then
            local v19 = string.split(v17, "/");
            v18 = tonumber(v19[1]) or 0;
            local _ = tonumber(v19[2]) or 100;
        else
            v18 = 0;
        end;

        UpdateVisuals();

        if v18 <= 0 then
            BeginDestroy();
        end;
    end);
    UpdateVisuals();
    local v20 = 0;

    while Character and Character.Parent do
        local v21 = task.wait();

        if not (Character and Character.Parent) then
            break;
        end;

        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

        if not HumanoidRootPart then
            break;
        end;

        if not u9 then
            if Character:GetAttribute("HyperArmorData") then
                if LocalPlayer:DistanceFromCharacter(HumanoidRootPart.Position) >= 250 then
                    BeginDestroy();
                end;
            else
                BeginDestroy();
            end;
        end;

        local Value = u10.Value;

        for i, v in u7 do
            if Value >= 0.05 then
                local v22 = math.rad(120 * (i - 1)) + math.rad(v20 * 60);
                local Position = HumanoidRootPart.Position;
                local v23 = math.cos(v22) * 4;
                local v24 = math.sin(v22) * 4;
                local v25 = Position + Vector3.new(v23, 0, v24);
                local v26 = HumanoidRootPart.Position:Lerp(v25, Value);
                v.CFrame = v.CFrame:Lerp(CFrame.new(v26, HumanoidRootPart.Position) * CFrame.Angles(0, 1.5707963267948966, 0), 0.55);
            end;
        end;

        if u9 and Value <= 0.01 then
            break;
        end;

        v20 = v20 + v21;
    end;

    u1[Character] = nil;
    v6:Destroy();
    v5:Destroy();
    table.clear(u7);
end;