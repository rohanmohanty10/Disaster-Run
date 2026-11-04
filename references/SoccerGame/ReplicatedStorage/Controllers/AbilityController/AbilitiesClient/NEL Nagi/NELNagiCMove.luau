  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage2.AbilityBalancing);
require(ReplicatedStorage.Shared.Popup);
local script_Trap = require(script.Trap);
local script_TrapShot = require(script.TrapShot);
local script_SideTrapShot = require(script.SideTrapShot);

local function isPointInVolume(p1: vector, p2, p3: vector) -- Line: 18
    local v4 = p2:PointToObjectSpace(p1);
    local v5;

    if v4.X >= -p3.X / 2 and (v4.X <= p3.X / 2 and (v4.Y >= -p3.Y / 2 and (v4.Y <= p3.Y / 2 and v4.Z >= -p3.Z / 2))) then
        v5 = v4.Z <= p3.Z / 2;
    else
        v5 = false;
    end;

    return v5;
end;

return function(p6, p7, p8) -- Line: 28
    -- upvalues: isPointInVolume (copy), script_SideTrapShot (copy), script_TrapShot (copy), script_Trap (copy)
    if isPointInVolume(p8.HumanoidRootPart.Position, p7.Team == "Away" and workspace.PenaltyArea.Home.CFrame or workspace.PenaltyArea.Away.CFrame, p7.Team == "Away" and workspace.PenaltyArea.Home.Size or workspace.PenaltyArea.Away.Size) and p8:GetAttribute("Trapped") then
        script_SideTrapShot(p6, p7, p8);

        return;
    end;

    if p8:GetAttribute("Trapped") then
        script_TrapShot(p6, p7, p8);

        return;
    end;

    script_Trap(p6, p7, p8);
end;