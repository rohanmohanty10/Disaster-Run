  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local Sequence_V2 = require(game.ReplicatedStorage.ReplicatedModules.Classes.Sequence_V2);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = game.ReplicatedStorage["Client Assets"];

return function(u2) -- Line: 9
    -- upvalues: EffectsHandler (copy), Sequence_V2 (copy), AssetHandler (copy), u1 (copy), ParticleHandler (copy)
    if not u2.Part then
        return;
    end;

    local u3 = EffectsHandler.GetEffect("Emit Particle V3");
    local v4 = Sequence_V2.new();
    local TeleportVFX = u2.TeleportVFX;
    local BarrageVFX = u2.BarrageVFX;

    for _, v in ipairs(TeleportVFX.Frames) do
        v4:AddFrame(v, function(p5) -- Line: 19
            -- upvalues: u3 (copy), TeleportVFX (copy)
            u3(TeleportVFX.EmitInfo);
        end);
    end;

    local u6 = AssetHandler.GetAsset("Barrage", {
        AbilityName = u2.AbilityName,
        SkinName = u2.SkinName,
        RootFolder = u1
    }):Clone();
    u6.Parent = workspace.Effects;
    local u7 = ParticleHandler.GetSkinInfo(u2.SkinName) or {};
    local u8 = u7.Metadata or {};
    v4:AddFrame(BarrageVFX.StartFrame, function(p9) -- Line: 34
        -- upvalues: u7 (copy), u8 (copy), ParticleHandler (ref), u6 (copy), BarrageVFX (copy)
        local v10 = (u7.Barrage or {}).HSVShift or u8.HSVShift;

        if v10 then
            ParticleHandler.HSVShiftParticles(u6, v10);
        end;

        if BarrageVFX.UnusualHueShift then
            ParticleHandler.HSVShiftParticles(u6, {
                HueShift = BarrageVFX.UnusualHueShift
            });
        end;

        ParticleHandler.EnableParticle(u6, true);
    end);
    v4:AddFrame(BarrageVFX.EndFrame, function(p11) -- Line: 50
        -- upvalues: ParticleHandler (ref), u6 (copy)
        ParticleHandler.EnableParticle(u6, false);
        ParticleHandler.DestroyEmit(u6);
    end);
    v4:AddFrames(BarrageVFX.StartFrame, BarrageVFX.EndFrame, function(p12) -- Line: 55
        -- upvalues: u6 (copy), u2 (copy)
        u6.CFrame = u2.Part.CFrame;
    end);
    v4:Play();
end;