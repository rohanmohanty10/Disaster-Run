  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.Types);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local _ = Fusion.New;

return function(p1) -- Line: 26
    -- upvalues: Trove (copy), AssetHandler (copy), ParticleHandler (copy), Fusion (copy)
    local Player = p1.Player;
    local Character = p1.Character;

    if not (Character and Character.Parent) then
        return;
    end;

    if not Character:GetAttribute("MomentumData") then
        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    if HumanoidRootPart:FindFirstChild("MomentumMeter") then
        return;
    end;

    local u2 = Trove.new();
    u2:AttachToInstance(Character);
    local v3 = AssetHandler.CloneAsset("Misc/MomentumMeter", AssetHandler.GetAbilityData(Character));

    if not v3 then
        return;
    end;

    u2:Add(v3);
    local Holder = v3:WaitForChild("Holder");
    local Sigil = v3:FindFirstChild("Sigil");
    local Bar = Holder:FindFirstChild("Bar");
    local UIGradient = Bar:FindFirstChild("UIStroke"):FindFirstChild("UIGradient");
    local Meter = Bar:FindFirstChild("Meter");
    (function(p4) -- Line: 54, Name: Unusualify
        -- upvalues: ParticleHandler (ref), Player (copy), Character (copy)
        local v5 = ParticleHandler.GetUnusualHSVData({
            Player = Player,
            Character = Character
        });

        if v5 then
            for _, v in next, p4 do
                if v:IsA("ImageLabel") then
                    v.ImageColor3 = ParticleHandler.HSVShift(v.ImageColor3, v5);
                elseif v:IsA("Frame") then
                    v.BackgroundColor3 = ParticleHandler.HSVShift(v.BackgroundColor3, v5);
                elseif v:IsA("UIGradient") then
                    local v6 = {};

                    for _, v2 in v.Color.Keypoints do
                        table.insert(v6, ColorSequenceKeypoint.new(v2.Time, ParticleHandler.HSVShift(v2.Value, v5)));
                    end;

                    v.Color = ColorSequence.new(v6);
                end;
            end;
        end;
    end)({ Meter, Sigil, UIGradient });

    local function ParseMomentumData(p7) -- Line: 78
        if not p7 then
            return 0, 0.5;
        end;

        local v8 = string.split(p7, "/");

        return tonumber(v8[1]) or 0, tonumber(v8[2]) or 0.5;
    end;

    local v9 = Character:GetAttribute("MomentumData");
    local v10, v11;

    if v9 then
        local v12 = string.split(v9, "/");
        v10 = tonumber(v12[1]) or 0;
        v11 = tonumber(v12[2]) or 0.5;
    else
        v10 = 0;
        v11 = 0.5;
    end;

    local u13 = Fusion.Value(false);
    local u14 = Fusion.Value(v10);
    local u15 = Fusion.Value(v11);
    Fusion.Hydrate(Meter)({
        Size = Fusion.Spring(Fusion.Computed(function() -- Line: 93
            -- upvalues: u14 (copy), u15 (copy)
            local v16 = u14:get() or 0;
            local v17 = u15:get() or 0.5;

            return UDim2.fromScale(1, (math.clamp(v16 / v17, 0, 1)));
        end), 20, 0.8)
    });
    Fusion.Hydrate(Holder)({
        GroupTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 101
            -- upvalues: u13 (copy)
            return u13:get() and 0 or 1;
        end), 10, 0.75)
    });
    Fusion.Hydrate(Sigil)({
        ImageTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 107
            -- upvalues: u13 (copy)
            return u13:get() and 0 or 1;
        end), 10, 0.75)
    });
    Fusion.Hydrate(v3)({
        Enabled = true,
        Parent = HumanoidRootPart,
        Adornee = HumanoidRootPart,
        Size = Fusion.Spring(Fusion.Computed(function() -- Line: 116
            -- upvalues: u13 (copy)
            return u13:get() and UDim2.new(1, 0, 5, 0) or UDim2.new(1, 0, 1, 0);
        end), 10, 0.75)
    });
    u2:Add((Character:GetAttributeChangedSignal("MomentumData"):Connect(function() -- Line: 121
        -- upvalues: Character (copy), u14 (copy), u15 (copy), u13 (copy), u2 (copy)
        local v18 = Character:GetAttribute("MomentumData");
        local v19, v20;

        if v18 then
            local v21 = string.split(v18, "/");
            v19 = tonumber(v21[1]) or 0;
            v20 = tonumber(v21[2]) or 0.5;
        else
            v19 = 0;
            v20 = 0.5;
        end;

        u14:set(v19);
        u15:set(v20);

        if v19 <= 0 then
            u13:set(false);
            task.delay(1.5, function() -- Line: 128
                -- upvalues: u2 (ref)
                u2:Destroy();
            end);
        end;
    end)));
    u13:set(true);
end;