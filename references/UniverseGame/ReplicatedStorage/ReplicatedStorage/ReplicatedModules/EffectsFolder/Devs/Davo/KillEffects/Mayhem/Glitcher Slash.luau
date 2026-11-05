  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local _ = game.ReplicatedStorage:WaitForChild("Client Assets").Assets.Abilities.KillEffects.Mayhem;

return function(u1) -- Line: 8
    -- upvalues: AssetHandler (copy)
    local u2 = AssetHandler.CloneAsset("Mayhem/Models/Glitcher Slash " .. (u1.MeshType or "Normal"), {
        AbilityName = "KillEffects"
    });
    u2.Size = u1.Scale or u1.Size;
    u2.Color = u1.Color;
    u2.CFrame = u1.CFrame or u1.Position;
    u2.Transparency = u1.Transparency == "In" and 1 or 0;
    u2.Parent = workspace.Effects;
    local BonusSpeed = u1.BonusSpeed;
    local Value = u1.Value;
    local u3 = BonusSpeed / 10;
    local u4 = (u1.Type == "Divide" and 1 / Value or 1 * Value) / 10;
    local u5 = (u1.Type == "Divide" and 0.01 / Value or 0.01 * Value) * u3;
    local u6 = Random.new():NextInteger(1, 2);
    local u7 = 0.01 * BonusSpeed;
    local u8 = (u1.RotationSpeed or 1) * BonusSpeed / 2;
    task.spawn(function() -- Line: 25
        -- upvalues: u4 (ref), u3 (copy), u5 (copy), u2 (copy), u1 (copy), u8 (copy), u6 (copy), u7 (copy)
        repeat
            local v9 = task.wait() * 60;
            local v10 = u4 * u3 * v9;
            u4 = u4 - u5 * v9;
            local v11 = u2;
            v11.CFrame = v11.CFrame * (u1.RotationSpeed and CFrame.Angles(0, math.rad(u8 * (u6 == 1 and -1 or 1) * v9), 0) or CFrame.new());
            local v12 = u2;
            v12.Size = v12.Size + Vector3.new(v10, 0, v10);
            local v13 = u2;
            v13.Transparency = v13.Transparency + u7 * (u1.Transparency == "In" and -1 or 1) * v9;
        until not u2 or (u2.Transparency < 0 or u2.Transparency > 1);

        if u2 then
            u2:Destroy();
        end;

        table.clear(u1);
    end);
end;