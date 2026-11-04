  

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
local script_DirectPass = require(script.DirectPass);
local script_Omnivision = require(script.Omnivision);
local script_BlindSpot = require(script.BlindSpot);

return function(p1, p2, p3) -- Line: 20
    -- upvalues: script_DirectPass (copy), script_BlindSpot (copy), script_Omnivision (copy)
    if p1.AbilityTwo > tick() then
        return;
    end;

    if p1.ABC then
        p1.ABC:Clean();
    end;

    if not p3.Values.HasBall.Value then
        if p3:GetAttribute("Omnivision") then
            return script_BlindSpot(p1, p2, p3);
        end;

        return script_Omnivision(p1, p2, p3);
    end;

    script_DirectPass(p1, p2, p3);
end;