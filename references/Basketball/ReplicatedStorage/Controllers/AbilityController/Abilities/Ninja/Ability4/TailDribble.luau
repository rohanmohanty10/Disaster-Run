 
 

local RunService = game:GetService("RunService");
local v1 = require("@game/ReplicatedStorage/Packages/Janitor");
local u2 = require("@game/ReplicatedStorage/Shared/Utility/Effects");
local u3 = v1.new();

return function(u4) -- Line: 10
    -- upvalues: u3 (copy), u2 (copy), RunService (copy)
    u3:Cleanup();
    local AbilityService = u4.AbilityService;
    local MovementController = u4.MovementController;
    local CharValues = u4.Network.CharValues;

    if u4.NinjaRun == true then
        u2:Popup("You can\'t do this right now!", 4);

        return u4:ResetCD(4);
    end;

    AbilityService.Ability:Fire("NinjaAbility4", {
        Transform = true,
        TimeSent = workspace:GetServerTimeNow()
    });
    u4.TailDribble = true;
    u3:Add(RunService.Heartbeat:Connect(function() -- Line: 28
        -- upvalues: CharValues (copy), u3 (ref), MovementController (copy)
        if CharValues.InAwakening ~= true then
            u3:Cleanup();

            return;
        end;

        if CharValues and CharValues.HasBall == true then
            MovementController.Boost = 10;

            return;
        end;

        MovementController.Boost = 0;
    end));
    u3:Add(task.delay(35, function() -- Line: 42
        -- upvalues: u3 (ref)
        u3:Cleanup();
    end));
    u3:Add(function() -- Line: 46
        -- upvalues: u4 (copy), MovementController (copy), AbilityService (copy)
        u4.TailDribble = nil;
        MovementController.Boost = 0;
        AbilityService.Ability:Fire("NinjaAbility4", {
            Transform = false,
            TimeSent = workspace:GetServerTimeNow()
        });
    end);
end;