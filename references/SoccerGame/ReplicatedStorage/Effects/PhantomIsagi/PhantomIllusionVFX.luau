  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
game:GetService("CollectionService");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.EmitModule);

return function(p1) -- Line: 15
    -- upvalues: SoundManager (copy), Essentials (copy)
    local Char = p1.Char;
    Char:FindFirstChild("HumanoidRootPart");
    SoundManager.SpawnSound("PhantomIllusion", 0.9, Char.HumanoidRootPart, 130, false);
    local Ring = Char:FindFirstChild("Ring");

    if Ring then
        Ring.LocalTransparencyModifier = 1;
    end;

    local u2 = Essentials:HideCosmetics(Char);
    task.delay(2, function() -- Line: 32
        -- upvalues: Ring (copy), Essentials (ref), u2 (copy)
        if Ring then
            Ring.LocalTransparencyModifier = 0;
        end;

        Essentials:UnhideCosmetics(u2);
    end);
end;