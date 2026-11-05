  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Trove = require(game.ReplicatedStorage.ReplicatedRoot.Libraries.Classes.Trove);
local u1 = {};

return function(p2) -- Line: 10
    -- upvalues: u1 (copy), AssetHandler (copy), ParticleHandler (copy), Trove (copy)
    local Player = p2.Player;
    local Character = p2.Character;
    local Parent = p2.Parent;
    local Origin = p2.Origin;
    local ReferencePart = p2.ReferencePart;
    local Path = p2.Path;
    local Id = p2.Id;
    local Enabled = p2.Enabled;
    local Offset = p2.Offset;
    local Unlock = p2.Unlock;
    local EnableAll = p2.EnableAll;
    local AttributeColors = p2.AttributeColors;
    local v3 = p2.ParentToAttach or false;
    local Ref = p2.Ref;

    if u1[Id] or not Enabled then
        if u1[Id] and not Enabled then
            local v4 = u1[Id];

            if Unlock then
                for _, descendant in v4:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.LockedToPart = false;
                    end;
                end;
            end;

            ParticleHandler.EnableAllParticles(v4, false);
            ParticleHandler.DestroyEmit(v4);
            u1[Id] = nil;
        end;
    else
        if not ReferencePart and Path then
            ReferencePart = AssetHandler.GetAsset(Path, AssetHandler.GetAbilityData(Character));
        end;

        local v5 = ReferencePart:Clone();
        local v6 = 0;

        if Player and Player.Data.Skin:GetAttribute("UnusualHueId") then
            v6 = v6 + Player.Data.Skin:GetAttribute("UnusualHueId") * 5;
        end;

        if ParticleHandler.IsUnusualValue(v6) then
            ParticleHandler.HSVShiftParticles(v5, {
                HueShift = v6
            });
        end;

        if p2.HSVShift then
            ParticleHandler.HSVShiftParticles(v5, p2.HSVShift);

            if p2.HSVShift.Chroma then
                ParticleHandler.Chromaify(v5, {
                    Player = Player
                });
            end;
        end;

        if p2.Scale then
            ParticleHandler.ScaleParticle(v5, p2.Scale);
        end;

        if AttributeColors then
            ParticleHandler.UpdateAttributeColors(v5, AttributeColors);
        end;

        if EnableAll then
            ParticleHandler.EnableAllParticles(v5, true);
        else
            ParticleHandler.EnableParticle(v5, true);
        end;

        if Origin then
            v5.CFrame = Origin;
            v5.Parent = workspace.Effects;
        elseif v3 then
            v5.Parent = Parent;
        else
            ParticleHandler.AttachTo(v5, {
                Part = Parent,
                Offset = Offset or CFrame.identity
            });
            v5.Parent = workspace.Effects;
        end;

        if p2.EmitOnCreate then
            ParticleHandler.EmitFromAttribute(v5);
        end;

        u1[Id] = v5;

        if Ref then
            local v7 = Trove.new();
            v7:AttachToInstance(Ref);
            v7:Add(function() -- Line: 89
                -- upvalues: u1 (ref), Id (copy), Unlock (copy), ParticleHandler (ref)
                local v8 = u1[Id];

                if Unlock then
                    for _, descendant in v8:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") then
                            descendant.LockedToPart = false;
                        end;
                    end;
                end;

                ParticleHandler.EnableAllParticles(v8, false);
                ParticleHandler.DestroyEmit(v8);
                u1[Id] = nil;
            end);
        end;

        if p2.Return then
            return v5;
        end;
    end;
end;