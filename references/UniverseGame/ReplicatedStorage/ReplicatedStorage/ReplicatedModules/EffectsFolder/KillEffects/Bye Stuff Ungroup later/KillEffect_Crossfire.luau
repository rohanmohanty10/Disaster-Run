  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 8
    -- upvalues: AssetHandler (copy), TweenService (copy), EffectsHandler (copy)
    local v2 = p1 or {};
    local TargetCharacter = v2.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local _ = { v2.KillerPlayer, game.Players:GetPlayerFromCharacter(TargetCharacter) };
    Random.new();
    local CFrame2 = TargetCharacter.HumanoidRootPart.CFrame;
    local u3 = AssetHandler.CloneAsset("Crossfire/BurningArea", {
        AbilityName = "KillEffects"
    });
    local BurningAreaMain = u3.BurningAreaMain;
    BurningAreaMain.Position = CFrame2.Position + Vector3.new(0, -3.85, 0);
    u3.Parent = workspace.Effects;

    for _, descendant in BurningAreaMain:GetDescendants() do
        if descendant:IsA("Sound") then
            descendant:Play();
        end;
    end;

    local Middle1 = BurningAreaMain.Middle1;
    TweenService:Create(Middle1, TweenInfo.new(1), {
        CFrame = CFrame.new(0, 31, 0)
    }):Play();

    for _, child in pairs(BurningAreaMain:GetChildren()) do
        if child.Name == "Explosion" then
            task.delay(0.02, function() -- Line: 37
                -- upvalues: child (copy)
                for _, descendant in child:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") then
                        descendant:Emit(descendant:GetAttribute("EmitCount") or 5);
                    end;
                end;
            end);
        end;
    end;

    EffectsHandler.CallEffect("FadeCharacter", TargetCharacter);

    for _, descendant in pairs(BurningAreaMain:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") and descendant.Parent.Name ~= "Explosion" or descendant:IsA("Beam") then
            descendant.Enabled = true;
        end;
    end;

    task.delay(5, function() -- Line: 55
        -- upvalues: u3 (copy), TweenService (ref), Middle1 (copy)
        for _, descendant in pairs(u3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            elseif descendant:IsA("Beam") then
                task.delay(1, function() -- Line: 60
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;

        TweenService:Create(Middle1, TweenInfo.new(1), {
            CFrame = CFrame.new(0, 0, 0)
        }):Play();
        task.delay(2.5, u3.Destroy, u3);
    end);
end;