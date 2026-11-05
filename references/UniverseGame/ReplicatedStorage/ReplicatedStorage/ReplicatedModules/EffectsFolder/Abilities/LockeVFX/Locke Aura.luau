  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Trove = require(PathShortcuts.KnitPath.Trove);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = game.ReplicatedStorage["Client Assets"];

return function(p2, u3, p4, p5) -- Line: 6
    -- upvalues: Trove (copy), u1 (copy), ParticleHandler (copy)
    if not (p4 and p4:IsDescendantOf(workspace)) then
        return;
    end;

    local u6 = Trove.new();
    task.delay(5, u6.Destroy, u6);
    u6:AttachToInstance(p2);
    local u7 = u1.Locke.Particles.AuraEffect:Clone();
    local v8 = ParticleHandler.GetUnusualHSVData({
        Character = p2
    });

    if v8 == nil then
        local v9 = ParticleHandler.GetSkinInfo(p5);
        local v10 = type(v9) == "table" and ((v9.UltAura or {}).HSVShift or (v9.Metadata or {}).HSVShift);

        if v10 then
            ParticleHandler.HSVShiftParticles(u7, v10);
        end;
    else
        ParticleHandler.Unusualify(u7, {
            HSVData = v8
        });
    end;

    ParticleHandler.EnableParticle(u7, true);
    u7.Weld.Part1 = p4;
    u7.Parent = workspace.Effects;
    u6:Add(function() -- Line: 32
        -- upvalues: ParticleHandler (ref), u7 (copy)
        task.delay(ParticleHandler.EnableParticle(u7, false), u7.Destroy, u7);
    end);
    u6:Connect(u3:GetAttributeChangedSignal("LockeRocks"), function() -- Line: 36
        -- upvalues: u3 (copy), u6 (copy)
        if u3:GetAttribute("LockeRocks") then
            return;
        end;

        u6:Destroy();
    end);
end;