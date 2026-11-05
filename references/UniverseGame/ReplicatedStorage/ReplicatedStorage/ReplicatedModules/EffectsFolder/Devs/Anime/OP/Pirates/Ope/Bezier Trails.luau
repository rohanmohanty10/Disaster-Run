  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local u1 = EffectsHandler.GetEffect("Emit Particle V3");

return function(p2) -- Line: 16
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), u1 (copy), TableUtil (copy), EffectsHandler (copy)
    local u3 = p2 or {};
    local Trail = u3.Trail;
    local u4 = u3.Origin and (typeof(u3.Origin) == "Vector3" and CFrame.new(u3.Origin) or u3.Origin);
    local u5 = u3.Offset or CFrame.identity;
    local RelativePart = u3.RelativePart;
    local u6 = u3.Lifetime or 0.5;
    local v7 = u3.Amount or math.random(7, 9);
    local v8 = u3.Delay or 0;
    local u9 = u3.Amplitude or 1;
    local v10 = u3.Player or u3.Character;

    if v10 ~= nil and v10:IsA("Model") then
        v10 = game.Players:GetPlayerFromCharacter(v10);
    end;

    if u3.Path and v10 then
        Trail = AssetHandler.GetAsset(u3.Path, u3.AssetData or AssetHandler.GetAbilityData(v10));
    end;

    if not ((u4 or RelativePart) and Trail) then
        return;
    end;

    local u11 = 0;

    if v10 and v10.Data.Skin:GetAttribute("UnusualHueId") then
        u11 = u11 + v10.Data.Skin:GetAttribute("UnusualHueId") * 5;
    end;

    for _ = 1, v7 do
        if not (u4 or RelativePart:IsDescendantOf(game)) then
            break;
        end;

        task.spawn(function() -- Line: 50
            -- upvalues: Trail (ref), u3 (ref), ParticleHandler (ref), u6 (copy), u11 (ref), u4 (copy), RelativePart (copy), u5 (copy), u9 (copy), u1 (ref), TableUtil (ref)
            local v12 = Trail;

            if Trail:IsA("Folder") then
                v12 = Trail:GetChildren()[math.random(1, #Trail:GetChildren())];
            end;

            local v13 = v12:Clone();

            if u3.ScaleLifetime then
                ParticleHandler.ScaleLifetime(v13, u3.ScaleLifetime);
            end;

            v13.Parent = workspace.Effects;
            task.delay(u6 + 0.5, v13.Destroy, v13);

            if u11 > 0 then
                ParticleHandler.HSVShiftParticles(v13, {
                    HueShift = u11
                });
            end;

            local Position = ((u4 or (RelativePart:IsA("Attachment") and RelativePart.WorldCFrame or RelativePart.CFrame)) * u5).Position;
            local v14 = math.random(-1, 1);
            local v15 = math.random(-1, 1);
            local v16 = Position + Vector3.new(v14, v15, math.random(-1, 1)) * 4 * u9;
            local v17 = math.random(-7, 7);
            local v18 = math.random(-7, 7);
            local v19 = Position + Vector3.new(v17, v18, math.random(-7, 7)) * u9;
            local v20 = math.random(-5, 5);
            local v21 = math.random(-5, 5);
            local v22 = Position + Vector3.new(v20, v21, math.random(-5, 5)) * u9;
            local v23 = math.ceil(u6 * 60);

            for i = 1, v23 do
                if not v13:IsDescendantOf(game) or RelativePart and not RelativePart:IsDescendantOf(game) then
                    break;
                end;

                local v24 = i / v23;
                v13.Position = (1 - v24) ^ 3 * v16 + 3 * (1 - v24) ^ 2 * v24 * v19 + 3 * (1 - v24) * v24 ^ 2 * v22 + v24 ^ 3 * Position;
                task.wait();
            end;

            if not v13:IsDescendantOf(game) then
                return;
            end;

            for _, descendant in ipairs(v13:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            if u3.Emit then
                u1(TableUtil.Reconcile({
                    Origin = v13.CFrame,
                    Offset = CFrame.identity
                }, u3.Emit));
            end;
        end);
        EffectsHandler.Wait(v8);
    end;
end;