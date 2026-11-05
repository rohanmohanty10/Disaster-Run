  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Highlight = Instance.new("Highlight");
task.delay(0.3, function() -- Line: 9
    -- upvalues: Highlight (ref), AssetHandler (copy)
    Highlight = AssetHandler.GetAsset("Glitched/Error", {
        AbilityName = "KillEffects"
    }):WaitForChild("Highlight");

    if game:GetService("RunService"):IsClient() then
        Highlight.Parent = nil;
    end;
end);

return function(p1) -- Line: 14
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), Highlight (ref), ParticleHandler (copy), TweenService (copy)
    local v2 = p1 or {};
    local TargetCharacter = v2.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local v3 = { v2.KillerPlayer, game.Players:GetPlayerFromCharacter(TargetCharacter) };
    local u4 = Random.new();
    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    local v5 = AssetHandler.CloneAsset("Glitched/Glitch", {
        AbilityName = "KillEffects"
    });
    v5.CFrame = HumanoidRootPart.CFrame;
    v5.Parent = workspace.Effects;
    local v6 = {
        Color3.fromRGB(255, 0, 0),
        Color3.fromRGB(28, 168, 255),
        Color3.fromRGB(86, 56, 255),
        Color3.fromRGB(61, 255, 17),
        Color3.fromRGB(255, 255, 17)
    };
    local v7 = {};

    for i = 1, #v6 do
        local v8 = AssetHandler.CloneAsset("Glitched/Error", {
            AbilityName = "KillEffects"
        });
        Highlight:Clone().Parent = v8;
        v8.Highlight.FillColor = v6[i];
        v8.Highlight.FillTransparency = u4:NextNumber(0.35, 0.75);
        v8.Parent = workspace.Effects;
        v8:PivotTo(HumanoidRootPart.CFrame);
        table.insert(v7, v8);
    end;

    print(v2.KillerPlayer);
    local v9;

    if table.find(v3, game.Players.LocalPlayer) then
        v9 = AssetHandler.CloneAsset("Glitched/Distort", {
            AbilityName = "KillEffects"
        });
        v9.Parent = workspace.Effects;
    else
        v9 = nil;
    end;

    local v10 = os.clock();

    while true do
        for _, v in v7 do
            task.delay(u4:NextNumber(0.01, 0.05), function() -- Line: 68
                -- upvalues: v (copy), HumanoidRootPart (copy), u4 (copy)
                v:PivotTo(HumanoidRootPart.CFrame * CFrame.new(u4:NextNumber(-0.25, 0.25), u4:NextNumber(-0.25, 0.25), u4:NextNumber(-0.1, 0.1)));
            end);
        end;

        EffectsHandler.Wait(u4:NextNumber(0.03, 0.08));

        if v9 then
            v9.CFrame = workspace.CurrentCamera.CFrame;

            if os.clock() - v10 > 0.3 then
                v10 = os.clock();
                v9.Particle.Color = ColorSequence.new(Color3.fromRGB(math.random(255), math.random(255), math.random(255)));
            end;
        end;

        if not TargetCharacter:IsDescendantOf(game) then
            ParticleHandler.DestroyEmit(v5, 3);
            ParticleHandler.EnableAllParticles(v5, false);

            for _, v in v7 do
                ParticleHandler.DestroyEmit(v, 0.25);
                TweenService:Create(v.Highlight, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    FillTransparency = 1
                }):Play();
            end;

            if v9 then
                v9:Destroy();
            end;

            return;
        end;
    end;
end;