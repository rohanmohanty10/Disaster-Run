  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = Random.new();

return function(p2) -- Line: 11
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), EffectsHandler (copy), TweenService (copy), u1 (copy)
    local v3 = workspace.Effects:WaitForChild(p2.Identifer, 5);

    if not v3 then
        return;
    end;

    local Player = p2.Player;
    local Interval = p2.Interval;
    local Distance = p2.Distance;
    local Ticks = p2.Ticks;
    local u4 = AssetHandler.CloneAsset("Particles/Sables/Tornado", AssetHandler.GetAbilityData(Player));
    u4.CFrame = v3.CFrame;
    p2.Sound:Clone().Parent = u4;
    local v5 = 0;

    if Player and Player.Data.Skin:GetAttribute("UnusualHueId") then
        v5 = v5 + Player.Data.Skin:GetAttribute("UnusualHueId") * 5;
    end;

    if v5 > 0 then
        ParticleHandler.HSVShiftParticles(u4, {
            HueShift = v5
        });
    end;

    u4.Parent = workspace.Effects;
    u4:FindFirstChildOfClass("Sound"):Play();
    local u6 = {};

    for _, descendant in u4:GetDescendants() do
        if descendant:IsA("Beam") then
            table.insert(u6, descendant);
            local Transparency = descendant.Transparency;
            descendant.Transparency = NumberSequence.new(1);
            EffectsHandler.CallEffect("Boat Tween", descendant, {
                Time = 0.2,
                EasingStyle = "EntranceExpressive",
                EasingDirection = "In",
                StepType = "RenderStepped",
                Goal = {
                    Transparency = Transparency
                }
            });
        end;
    end;

    task.delay(Interval * Ticks, function() -- Line: 59
        -- upvalues: ParticleHandler (ref), u4 (copy), u6 (copy), EffectsHandler (ref), TweenService (ref)
        task.delay(ParticleHandler.EnableParticles(u4, false), u4.Destroy, u4);

        for _, v in u6 do
            if v:IsDescendantOf(game) then
                EffectsHandler.CallEffect("Boat Tween", v, {
                    Time = 0.25,
                    EasingStyle = "ExitExpressive",
                    EasingDirection = "Out",
                    StepType = "RenderStepped",
                    Goal = {
                        Transparency = NumberSequence.new(1)
                    }
                });
            end;
        end;

        TweenService:Create(u4, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
    end);
    local v7 = os.clock();
    local v8 = 1;

    while v3:IsDescendantOf(game) do
        local v9 = task.wait(Interval);
        TweenService:Create(u4, TweenInfo.new(v9, Enum.EasingStyle.Linear), {
            CFrame = v3.CFrame
        }):Play();

        if os.clock() - v7 >= Interval * 0.9 then
            task.spawn(EffectsHandler.CallEffect, "Rock Trail", {
                Amount = 2,
                Duration = 3.5,
                DurationOffset = 0.05,
                Down = true,
                Origin = u4.CFrame * CFrame.Angles(0, -1.5707963267948966, 0),
                LookVector = (u4.CFrame * CFrame.Angles(0, -1.5707963267948966, 0)).LookVector,
                Offset = math.max(0, Ticks - v8) / 3,
                Distance = Distance / Ticks,
                Size = u1:NextNumber(1.35, 1.75),
                SpawnDelay = Interval / 2
            });
            v8 = v8 + 1;
            v7 = os.clock();
        end;
    end;
end;