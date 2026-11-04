 
 

return function(u1) -- Line: 1
    local MovementController = u1.MovementController;
    local Animations = u1.Animations;
    local AbilityService = u1.AbilityService;
    MovementController.States.Ability = true;
    MovementController.States.NoWalk = true;
    u1.AC:Add(function() -- Line: 10
        -- upvalues: MovementController (copy)
        MovementController.States.Ability = false;
        MovementController.States.NoWalk = false;
    end);
    u1.AC:Add(task.delay(1.3166666666666667, function() -- Line: 15
        -- upvalues: u1 (copy)
        u1.AC:Clean();
    end));
    Animations:PlayChar("Ninja", "KuramaBeam", Enum.AnimationPriority.Action, true);
    AbilityService.Ability:Fire("NinjaAbility4", {
        TailBomb = true,
        TimeSent = workspace:GetServerTimeNow()
    });
end;