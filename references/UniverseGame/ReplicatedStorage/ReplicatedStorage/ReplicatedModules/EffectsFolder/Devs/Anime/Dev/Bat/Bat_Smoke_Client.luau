  

 

local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
LocalPlayer:GetMouse();
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 19
    -- upvalues: LocalPlayer (copy), EffectsHandler (copy), TweenService (copy)
    local Character = p1.Character;
    local Duration = p1.Duration;
    local Location = p1.Location;
    local Size = p1.Size;
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 0;
    BlurEffect.Parent = game.Lighting;
    local v2 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
    local _ = Character.HumanoidRootPart;

    if v2 == Character then
        local Gravity = workspace.Gravity;
        local v3 = workspace;
        v3.Gravity = v3.Gravity * 0.7;
        task.delay(Duration, function() -- Line: 90
            -- upvalues: Gravity (copy)
            workspace.Gravity = Gravity;
        end);

        return;
    end;

    local v4 = OverlapParams.new();
    v4.FilterType = Enum.RaycastFilterType.Include;
    v4.FilterDescendantsInstances = { v2 };
    local v5 = os.clock();
    Character.HumanoidRootPart.Anchored = true;
    EffectsHandler.CallEffect("SK_VANISH", {
        Transparency = 1,
        Character = Character
    });
    local v6 = false;
    local v7 = nil;

    while os.clock() - v5 <= Duration do
        local v8 = #workspace:GetPartBoundsInBox(Location, Size, v4) > 0;

        if v8 == v6 then
            v8 = v6;
        else
            if v7 and v7.PlaybackState == Enum.PlaybackState.Playing then
                v7:Pause();
            end;

            v7 = TweenService:Create(BlurEffect, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
                Size = v8 and 48 or 0
            });
            v7:Play();
        end;

        task.wait(0.1);
        v6 = v8;
    end;

    if Character and Character:IsDescendantOf(game) then
        EffectsHandler.CallEffect("SK_VANISH", {
            Transparency = 0,
            Character = Character,
            TweenInfo = { 1 }
        });
        Character.HumanoidRootPart.Anchored = false;
    end;

    if v7 then
        v7:Pause();
    end;

    local v9 = TweenService:Create(BlurEffect, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = 0
    });
    v9.Completed:Connect(function() -- Line: 81
        -- upvalues: BlurEffect (copy)
        BlurEffect:Destroy();
    end);
    v9:Play();
end;