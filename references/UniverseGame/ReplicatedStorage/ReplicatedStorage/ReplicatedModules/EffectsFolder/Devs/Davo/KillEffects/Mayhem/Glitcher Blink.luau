  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(u1) -- Line: 4
    -- upvalues: AssetHandler (copy)
    local u2 = AssetHandler.CloneAsset("Mayhem/Models/SymbolHeader", {
        AbilityName = "KillEffects"
    });
    u2.Enabled = true;
    local Symbol = u2.Symbol;
    Symbol.Image = "rbxassetid://" .. u1.Image;
    Symbol.ImageColor3 = u1.Color;
    u2.Size = UDim2.fromScale(u1.Size, u1.Size);
    u2.Parent = u1.Parent;
    local BonusSize = u1.BonusSize;
    local v3 = u1.Delay or u1.BonusSpeed;
    local _ = u1.Rotate;
    local u4 = Random.new():NextInteger(1, 2);
    local RotationSpeed = u1.RotationSpeed;
    local u5 = 0.04 / v3;
    local u6 = 1 * BonusSize / v3;
    task.spawn(function() -- Line: 21
        -- upvalues: u2 (copy), u6 (copy), Symbol (copy), u5 (copy), RotationSpeed (copy), u4 (copy), u1 (copy)
        repeat
            local v7 = task.wait() * 60;
            local v8 = u2;
            v8.Size = v8.Size + UDim2.fromScale(u6 * v7, u6 * v7);
            local v9 = Symbol;
            v9.ImageTransparency = v9.ImageTransparency + u5 * v7;
            local v10 = Symbol;
            v10.Rotation = v10.Rotation + (RotationSpeed and (RotationSpeed * v7 * (u4 == 1 and 1 or -1) or 0) or 0);
        until Symbol.ImageTransparency >= 1 or Symbol.ImageTransparency <= 0;

        if u2 then
            u2:Destroy();
        end;

        table.clear(u1);
    end);
end;