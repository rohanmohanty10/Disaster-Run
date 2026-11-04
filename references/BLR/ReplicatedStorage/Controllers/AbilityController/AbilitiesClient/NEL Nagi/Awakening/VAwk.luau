  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local script_TwoStageVolley = require(script.TwoStageVolley);
local script_FiveStageVolley = require(script.FiveStageVolley);
require(ReplicatedStorage2.AbilityBalancing);
local Popup = require(ReplicatedStorage.Shared.Popup);

return function(p1, p2, p3) -- Line: 16
    -- upvalues: Popup (copy), script_FiveStageVolley (copy), ReplicatedStorage2 (copy), Players (copy), script_TwoStageVolley (copy)
    if p2.Character.IsRagdoll.Value then
        return;
    end;

    if p3.Values.IsInPenalty.Value then
        Popup.Popup(p2, "Can\'t be in penalty box!");

        return;
    end;

    if p3.Values.HasBall.Value then
        script_FiveStageVolley(p1, p2, p3);

        return;
    end;

    if p3.Values.HasBall.Value == false then
        local Value = ReplicatedStorage2.Football.Value;

        if Value.OnPlayer.Value then
            local Value2 = Value.Char.Value;

            if not Value2 then
                return;
            end;

            if Value2 and (Value2.Values.Goalie.Value and Value2.Values.IsInPenalty.Value) then
                return;
            end;

            local PlayerFromCharacter = Players:GetPlayerFromCharacter(Value2);

            if (Value2.HumanoidRootPart.Position - p3.HumanoidRootPart.Position).Magnitude > 80 then
                Popup.Popup("Ball too far!");

                return;
            end;

            if PlayerFromCharacter.Team == p2.Team then
                Popup.Popup(p2, "Ball must be on an enemy player");

                return;
            end;

            script_TwoStageVolley(p1, p2, p3);

            return;
        end;

        Popup.Popup(p2, "Ball must be on an enemy player");
    end;
end;