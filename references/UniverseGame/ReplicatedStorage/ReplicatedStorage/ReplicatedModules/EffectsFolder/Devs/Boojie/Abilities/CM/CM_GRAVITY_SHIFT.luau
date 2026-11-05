  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local GenericModule = require(PathShortcuts.GenericModule);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
game.ReplicatedStorage:WaitForChild("Client Assets");
game:GetService("TweenService");
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
EffectsHandler.GetEffect("Emit Particle V3");

return function(p1, p2, p3) -- Line: 15
    -- upvalues: ParticleHandler (copy), GenericModule (copy), AssetHandler (copy)
    local v4 = p3 or {};
    local v5 = ParticleHandler.GetSkinInfo(v4.SkinName) or {};
    local v6 = nil;

    if v5.GravityShift then
        v6 = v5.GravityShift.HSVShift;
    elseif v5.Metadata then
        v6 = v5.Metadata.HSVShift;
    end;

    local v7 = v6 or {};
    local v8 = p1:FindFirstChildOfClass("Humanoid");
    local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and v8) then
        return;
    end;

    if p2 == "Reflect" then
        local GravityShift = p1:FindFirstChild("GravityShift");

        if GravityShift then
            ParticleHandler.HSVShiftParticles(GravityShift, v7);

            for _, descendant in pairs(GravityShift:GetDescendants()) do
                if descendant.Name:match("Activated") then
                    GenericModule.Emit(descendant);
                end;
            end;
        end;

        return;
    end;

    if not p2 then
        local GravityShift = p1:FindFirstChild("GravityShift");

        if GravityShift then
            GravityShift.Name = "GravityShiftOff";
            GravityShift.Highlight.Enabled = false;
            GravityShift.PointLight.Enabled = false;

            for _, descendant in pairs(GravityShift:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(2.5, function() -- Line: 80
                -- upvalues: GravityShift (copy)
                GravityShift:Destroy();
            end);
        end;

        return;
    end;

    local v9 = AssetHandler.GetAsset("Particles/GravityShift", v4):Clone();
    v9.CFrame = HumanoidRootPart.CFrame;
    v9.Parent = p1;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillTransparency = 0.5;
    Highlight.FillColor = Color3.fromRGB(125, 0, 255);
    Highlight.OutlineTransparency = 0;
    Highlight.OutlineColor = Color3.fromRGB(175, 0, 255);
    Highlight.Adornee = p1;
    Highlight.Enabled = true;
    Highlight.Parent = v9;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = HumanoidRootPart;
    WeldConstraint.Part1 = v9;
    WeldConstraint.Parent = v9;
    ParticleHandler.HSVShiftParticles(v9, v7);
    v9.Parent = p1;
end;