  

 

return {
    Falling = {
        Track = 1,
        Priority = 100,

        Check = function(p1, p2) -- Line: 7, Name: Check
            local v3 = p1.Humanoid:GetState();
            local v4 = p1:GetCurrentAnimation(p2);

            if v3 ~= Enum.HumanoidStateType.Jumping and v3 ~= Enum.HumanoidStateType.Freefall then
                if p1.Jumped == true then
                    p1.Jumped = false;
                end;

                return nil;
            end;

            if p1.Jumped or v3 ~= Enum.HumanoidStateType.Jumping then
                if v4 == nil or (not p1.Jumped or (v4.Name ~= "Jump" or not v4.Track.IsPlaying)) then
                    return "Fall";
                end;

                return true, "Jump";
            end;

            p1.Jumped = true;

            return "Jump";
        end
    },
    Moving = {
        Track = 1,
        Priority = 200,

        Check = function(p5, p6) -- Line: 32, Name: Check
            if (p5.Humanoid:GetState() == Enum.HumanoidStateType.Running or p5.Humanoid:GetState() == Enum.HumanoidStateType.Landed) and p5.Humanoid.WalkSpeed > 0 then
                local Magnitude = (p5.RootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude;
                local v7 = false;
                local v8;

                if p5.Player and (game.Players.LocalPlayer and p5.Player == game.Players.LocalPlayer) then
                    v8 = Magnitude >= 0.01 and p5.Humanoid.MoveDirection ~= Vector3.new(0, 0, 0) and true or v7;
                else
                    v8 = Magnitude >= 0.5 and true or v7;
                end;

                if v8 then
                    return p5.Character:GetAttribute("Running") and not p5.Character:GetAttribute("Backpedaling") and "Run" or "Walk";
                end;
            end;
        end,

        Update = function(p9, p10) -- Line: 57, Name: Update
            local v11 = p9:GetCurrentAnimation(p10);

            if v11 ~= nil then
                v11.Track:AdjustSpeed((p9.RootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude * (v11.Animation:GetAttribute("Speed") or 1) / 16);
            end;
        end
    },
    Idle = {
        Track = 1,
        Priority = 300,

        Check = function(p12, p13) -- Line: 68, Name: Check
            return p12.Humanoid:GetState() == Enum.HumanoidStateType.Running and true or p12.Humanoid:GetState() == Enum.HumanoidStateType.Landed;
        end
    },
    Climbing = {
        Track = 1,
        Priority = 400,

        Check = function(p14, p15) -- Line: 75, Name: Check
            return p14.Humanoid:GetState() == Enum.HumanoidStateType.Climbing;
        end
    },
    Sitting = {
        Track = 1,
        Priority = 500,

        Check = function(p16, p17) -- Line: 82, Name: Check
            return p16.Humanoid:GetState() == Enum.HumanoidStateType.Seated;
        end
    },
    Tool = {
        Track = 2,
        Priority = 100,

        Check = function(p18, p19) -- Line: 90, Name: Check
            return p18.Character:FindFirstChildWhichIsA("Tool");
        end
    },
    StandIdle = {
        Track = 3,
        Priority = 100,

        Check = function(p20, p21) -- Line: 98, Name: Check
            return p20.Character:GetAttribute("Summoned") == true;
        end
    }
};