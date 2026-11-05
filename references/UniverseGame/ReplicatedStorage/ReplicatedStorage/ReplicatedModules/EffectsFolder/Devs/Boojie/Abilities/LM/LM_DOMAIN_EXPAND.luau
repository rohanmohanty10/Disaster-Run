  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local GenericModule = require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
Random.new();
local TweenService = game:GetService("TweenService");
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
EffectsHandler.GetEffect("Emit Particle V3");

return function(p1, p2) -- Line: 16
    -- upvalues: AssetHandler (copy), GenericModule (copy), TweenService (copy)
    local v3 = p1.Origin or CFrame.new(0, 0, 0);
    local v4 = p1.Size or 100;
    local v5 = p1.Type or "Start";
    local v6 = p1.Time or 5;

    if typeof(v3) == "Vector3" then
        v3 = CFrame.new(v3);
    end;

    local u7 = AssetHandler.CloneAsset("Particles/Domain/Expand", p2);
    u7:ScaleTo(v4 / 50);
    u7:PivotTo(CFrame.new(v3.Position));

    if v5 == "End" then
        for _, child in pairs(u7:GetChildren()) do
            if child:IsA("BasePart") then
                child.Transparency = 0;
            end;
        end;
    end;

    u7.Parent = workspace.Effects;

    local function StartEffect() -- Line: 52
        -- upvalues: u7 (copy), GenericModule (ref), TweenService (ref)
        for _, descendant in pairs(u7:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "In" then
                GenericModule.Emit(descendant);
            end;

            if descendant:IsA("BasePart") then
                TweenService:Create(descendant, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0.4), {
                    Transparency = 0
                }):Play();
            end;
        end;
    end;

    local function EndEffect() -- Line: 65
        -- upvalues: u7 (copy), GenericModule (ref), TweenService (ref)
        for _, descendant in pairs(u7:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "Out" then
                GenericModule.Emit(descendant);
            end;

            if descendant:IsA("BasePart") then
                TweenService:Create(descendant, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            end;
        end;
    end;

    if v5 == "Start" then
        StartEffect();
        task.wait(v6);
        u7:Destroy();

        return;
    end;

    if v5 ~= "End" then
        if v5 == "Both" then
            StartEffect();
            task.wait(v6);

            for _, descendant in pairs(u7:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") and descendant.Name == "In" then
                    descendant:Clear();
                end;
            end;

            EndEffect();
            task.wait(1);
            u7:Destroy();
        end;

        return;
    end;

    task.wait(v6);
    EndEffect();
    task.wait(1);
    u7:Destroy();
end;