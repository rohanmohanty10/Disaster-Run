  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local script_VelocityShot = require(script.VelocityShot);
local script_VelocityDash = require(script.VelocityDash);

return function(p1) -- Line: 12
    -- upvalues: AbilityUtils (copy), script_VelocityShot (copy), script_VelocityDash (copy)
    if AbilityUtils.getCharacter():GetAttribute("VelocityShot") then
        return script_VelocityShot(p1);
    end;

    return script_VelocityDash(p1);
end;