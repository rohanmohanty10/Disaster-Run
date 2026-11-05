  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local v1 = script:FindFirstAncestor("ReplicatedModules");
require(v1.EffectsHandler).GetEffect("Emit Particle V3");

return function(p2) -- Line: 8
    -- upvalues: ParticleHandler (copy)
    local AbilityModel = p2.AbilityModel;
    local v3 = p2.Value or false;

    if not (AbilityModel and AbilityModel.Parent) then
        return;
    end;

    local Sword = AbilityModel:FindFirstChild("Sword");

    if not Sword then
        return;
    end;

    local Player = p2.Player;
    local u4 = 0;

    if Player and Player.Data.Skin:GetAttribute("UnusualHueId") then
        u4 = u4 + Player.Data.Skin:GetAttribute("UnusualHueId") * 5;
    end;

    local v5 = not Player and "" or Player.Data.Skin:GetAttribute("SkinName");

    if p2.AuraEffects then
        local v6 = p2.AuraEffects:Clone();
        local v7 = ParticleHandler.GetSkinInfo(v5);

        if u4 > 0 and (v7 and (v7.Metadata and v7.Metadata.SaturationThreshold)) then
            ParticleHandler.HSVShiftParticles(v6, {
                SaturationThreshold = v7.Metadata.SaturationThreshold
            });
        end;

        if u4 > 0 then
            ParticleHandler.HSVShiftParticles(v6, {
                HueShift = u4
            });
        end;

        for _, child in AbilityModel.Parent:GetChildren() do
            if child:IsA("BasePart") then
                for _, child2 in v6:GetChildren() do
                    if child2:IsA("ParticleEmitter") then
                        local v8 = child2:Clone();
                        v8.Name = "AWAKENAURA";
                        v8.Parent = child;
                    end;
                end;
            end;
        end;

        v6:Destroy();
    end;

    if v3 then
        local function Emit(p9) -- Line: 74
            -- upvalues: u4 (ref), ParticleHandler (ref)
            if not p9:IsA("ParticleEmitter") then
                return;
            end;

            local u10 = p9:Clone();
            u10.Parent = p9.Parent;

            if u4 > 0 then
                ParticleHandler.HSVShiftParticles(u10, {
                    HueShift = u4
                });
            end;

            u10:Emit(u10:GetAttribute("EmitCount"));
            task.delay(2, function() -- Line: 86
                -- upvalues: u10 (copy)
                u10:Destroy();
            end);
        end;

        for _, descendant in Sword:GetDescendants() do
            if descendant.Name == "SummonedAura" then
                if descendant:IsA("ParticleEmitter") then
                    Emit(descendant);
                else
                    for _, child in descendant:GetChildren() do
                        Emit(child);
                    end;
                end;
            end;
        end;
    else
        for _, child in AbilityModel.Parent:GetChildren() do
            if child:IsA("BasePart") then
                for _, child2 in child:GetChildren() do
                    if child2:IsA("ParticleEmitter") and child2.Name == "AWAKENAURA" then
                        child2.Enabled = false;
                        task.delay(1, function() -- Line: 66
                            -- upvalues: child2 (copy)
                            child2:Destroy();
                        end);
                    end;
                end;
            end;
        end;
    end;

    for _, descendant in Sword:GetDescendants() do
        if descendant.Name == "Awakened" then
            descendant.Enabled = v3;
        end;
    end;
end;