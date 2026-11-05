  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Trove = require(PathShortcuts.KnitPath.Trove);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = game.ReplicatedStorage["Client Assets"];

return function(u2, p3) -- Line: 6
    -- upvalues: Trove (copy), u1 (copy), ParticleHandler (copy)
    if not (p3 and p3:IsDescendantOf(workspace)) then
        return;
    end;

    local u4 = Trove.new();
    task.delay(5, u4.Destroy, u4);
    u4:AttachToInstance(u2);
    local u5 = u1.Locke.Particles.MovingIllusion:Clone();
    u4:Add(function() -- Line: 13
        -- upvalues: ParticleHandler (ref), u5 (copy)
        task.delay(ParticleHandler.EnableParticle(u5, false), u5.Destroy, u5);
    end);
    u5.PrimaryPart.CFrame = p3.CFrame * CFrame.new(0, -2.5, 0);
    u5.Parent = workspace.Effects;
    u4:Connect(u2:GetAttributeChangedSignal("LockeRocks"), function() -- Line: 19
        -- upvalues: u2 (copy), u4 (copy)
        if u2:GetAttribute("LockeRocks") then
            return;
        end;

        u4:Destroy();
    end);
    u4:BindToRenderStep("LockeRocks", 1, function(p6) -- Line: 23
        -- upvalues: u5 (copy)
        local PrimaryPart = u5.PrimaryPart;
        PrimaryPart.CFrame = PrimaryPart.CFrame * CFrame.Angles(0, 0.017453292519943295 * p6 * 60, 0);
    end);
end;