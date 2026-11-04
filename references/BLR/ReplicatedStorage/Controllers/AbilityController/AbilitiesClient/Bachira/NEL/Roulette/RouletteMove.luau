  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local script_OnBall = require(script.OnBall);
local script_OffBall = require(script.OffBall);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 12, Name: Move
    -- upvalues: AbilityUtils (copy), interface (copy), script_OnBall (copy), LocalPlayer (copy), script_OffBall (copy)
    local Character, _, _, v1 = AbilityUtils.getCharacter();

    if interface.AbilityOne <= tick() then
        if interface.ABC then
            interface.ABC:Clean();
        end;

        if v1.HasBall.Value then
            return script_OnBall(interface, LocalPlayer, Character);
        end;

        return script_OffBall(interface, LocalPlayer, Character);
    end;
end;