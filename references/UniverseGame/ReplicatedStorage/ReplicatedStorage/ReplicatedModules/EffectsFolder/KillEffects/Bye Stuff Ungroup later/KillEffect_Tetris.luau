  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 8
    -- upvalues: AssetHandler (copy), EffectsHandler (copy)
    local TargetCharacter = (p1 or {}).TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local u2 = CFrame.new(TargetCharacter.HumanoidRootPart.Position) * CFrame.new(0, -2.75, 0);
    local v3 = AssetHandler.CloneAsset("Tetris/Blocks", {
        AbilityName = "KillEffects"
    });
    v3.Parent = workspace.Effects;
    task.delay(3.4, v3.Destroy, v3);
    v3:SetPrimaryPartCFrame(u2 * CFrame.new(0, 50, 0));

    for _, descendant in v3:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Transparency = 1;
        end;
    end;

    task.delay(0.44999999999999996, function() -- Line: 33
        -- upvalues: EffectsHandler (ref), TargetCharacter (copy)
        EffectsHandler.CallEffect("FadeCharacter", TargetCharacter);
    end);
    local v4 = os.clock();

    for i = 1, 4 do
        local u5 = v3[tostring(i)];

        for _, child in u5:GetChildren() do
            if child:IsA("BasePart") then
                child.Transparency = 0;
            end;

            game.TweenService:Create(child, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                Position = child.Position - Vector3.new(0, 50, 0)
            }):Play();
        end;

        task.delay(0.3 + (1.4 - (os.clock() - v4)), function() -- Line: 54
            -- upvalues: u5 (copy)
            for _, child in u5:GetChildren() do
                if child:IsA("BasePart") then
                    child.Material = Enum.Material.ForceField;
                    game.TweenService:Create(child, TweenInfo.new(0.7, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        Transparency = 1,
                        Size = child.Size * 1.7,
                        Color = Color3.fromRGB(255, 255, 255)
                    }):Play();
                end;
            end;
        end);
        task.wait(0.075);
    end;

    task.delay(1.4, function() -- Line: 71
        -- upvalues: EffectsHandler (ref), u2 (copy)
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Tetris/Explosion",
            AbilityName = "KillEffects",
            Origin = u2
        });
    end);
end;