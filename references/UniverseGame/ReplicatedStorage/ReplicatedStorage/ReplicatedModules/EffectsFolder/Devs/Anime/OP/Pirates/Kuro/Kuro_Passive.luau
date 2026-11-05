  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ClientAssets = PathShortcuts.ClientAssets;
local TweenService = game:GetService("TweenService");
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };

return function(u2) -- Line: 18
    -- upvalues: Trove (copy), ClientAssets (copy), ParticleHandler (copy), AssetHandler (copy), EffectsHandler (copy), TweenService (copy), u1 (copy)
    local v3 = u2:WaitForChild("Kuro Passive", 5);

    if not v3 then
        return;
    end;

    local v4 = Trove.new();
    v4:AttachToInstance(v3);
    local v5 = v4:Construct(Instance, "Highlight");
    v5.FillTransparency = 1;
    v5.OutlineTransparency = 0;
    v5.OutlineColor = Color3.fromRGB(255, 255, 255);
    v5.DepthMode = Enum.HighlightDepthMode.Occluded;
    v5.Adornee = u2;
    v5.Parent = workspace.Effects;
    v5.Name = "KuroClawsHighlight";
    local u6 = {};
    local v7 = ClientAssets.Kuro.Passive:Clone();
    v7.Parent = u2;
    table.insert(u6, v7);
    ParticleHandler.AttachTo(v7, {
        Part = u2.Torso,
        Offset = CFrame.identity
    });

    for i = 1, 2 do
        local v8 = i == 1 and "Leg" or "Arm";

        for i2 = 1, 2 do
            local v9 = ClientAssets.Kuro.LimbTrail:Clone();
            v9.Parent = u2;
            table.insert(u6, v9);
            ParticleHandler.AttachTo(v9, {
                Part = u2[(i2 == 1 and "Left " or "Right ") .. v8],
                Offset = CFrame.identity
            });
        end;
    end;

    local SkinName = AssetHandler.GetAbilityData(u2).SkinName;
    v4:Add(function() -- Line: 67
        -- upvalues: u6 (copy), ParticleHandler (ref), SkinName (copy), EffectsHandler (ref), u2 (copy)
        for _, v in u6 do
            task.delay(ParticleHandler.EnableAllParticles(v, false), v.Destroy, v);
        end;

        if SkinName ~= "Wolverine" then
            EffectsHandler.CallEffect("MIH_AFTERIMAGES", u2, false, {
                Attribute = "KURO_FLASHSPEED"
            });
        end;

        EffectsHandler.CallEffect("EoLAfterimages", u2, false);
    end);
    TweenService:Create(v5, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut, (1 / 0), true), {
        OutlineTransparency = 0.5
    }):Play();

    if SkinName ~= "Wolverine" then
        task.spawn(EffectsHandler.CallEffect, "MIH_AFTERIMAGES", u2, true, {
            Transparency = 0.5,
            Attribute = "KURO_FLASHSPEED"
        });
    end;

    EffectsHandler.CallEffect("EoLAfterimages", u2, true);

    while true do
        local v10 = workspace:Raycast(u2.HumanoidRootPart.Position, Vector3.new(0, -4, 0), u1);

        if v10 and (v7:FindFirstChild("Feet") and v7.Feet:FindFirstChild("Dust")) then
            local v11, v12, v13 = v10.Instance.Color:ToHSV();
            ParticleHandler.HSVShiftParticles(v7.Feet.Dust, {
                Hue = v11,
                Saturation = v12,
                Value = v13
            });
        end;

        local v14;

        if v10 == nil then
            v14 = false;
        else
            v14 = u2.Humanoid.MoveDirection ~= Vector3.new(0, 0, 0);
        end;

        if v7:FindFirstChild("Feet") then
            ParticleHandler.EnableParticles(v7.Feet, v14);
        end;

        task.wait(0.1);

        if not (v3:IsDescendantOf(game) and v7:IsDescendantOf(game)) then
            return;
        end;
    end;
end;