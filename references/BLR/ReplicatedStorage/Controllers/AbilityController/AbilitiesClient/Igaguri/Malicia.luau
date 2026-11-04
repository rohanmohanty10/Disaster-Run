  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local script_MaliciaAir = require(script.MaliciaAir);
local script_MaliciaGround = require(script.MaliciaGround);

return function(p1, p2, p3) -- Line: 19, Name: Malicia
    -- upvalues: script_MaliciaAir (copy), script_MaliciaGround (copy)
    if p1.AbilityOne <= tick() then
        if p1.ABC then
            p1.ABC:Clean();
        end;

        if p3.Humanoid:GetState() == Enum.HumanoidStateType.Freefall or p3.Humanoid:GetState() == Enum.HumanoidStateType.Jumping then
            return script_MaliciaAir(p1, p2, p3);
        end;

        return script_MaliciaGround(p1, p2, p3);
    end;
end;