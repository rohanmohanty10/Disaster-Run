  

 

game:GetService("RunService");

return {
    Inherit = "Bike",
    Animator = "HorseAnimator",
    ItemId = "MOUNT_47",
    MovementProperties = {
        CHARACTER_TILT_MULTIPLIER = 0.15,
        MAX_SPEED = 65,
        CAMERA_LOCKED_MOUNT = 2,
        MOTIONAL_ACCELERATION = 3,
        MOTIONAL_DECELERATION = 7
    },

    OnSetup = function(u1) -- Line: 16, Name: OnSetup
        local PrimaryPart = u1.Model.PrimaryPart;
        local u2 = Random.new();
        PrimaryPart.Voiceline:Play();
        PrimaryPart.Equip:Play();
        local u3 = task.spawn(function() -- Line: 23
            -- upvalues: u2 (copy), u1 (copy), PrimaryPart (copy)
            while true do
                repeat
                    task.wait(u2:NextNumber(1.5, 5));
                until (Vector3.new(1, 0, 1) * u1.Character.HumanoidRootPart.Velocity).Magnitude < 2;

                PrimaryPart["Neigh" .. u2:NextInteger(1, 3)]:Play();
            end;
        end);
        u1.Trove:Add(function() -- Line: 32
            -- upvalues: u3 (copy)
            if not u3 then
                return;
            end;

            task.cancel(u3);
        end);
    end,

    OnMove = function(p4, p5) -- Line: 38, Name: OnMove
        local PrimaryPart = p4.Model.PrimaryPart;
        PrimaryPart.JumpCharge:Play();

        if p5 then
            PrimaryPart.MovementLoop:Play();

            return;
        end;

        PrimaryPart.MovementLoop:Stop();
    end
};