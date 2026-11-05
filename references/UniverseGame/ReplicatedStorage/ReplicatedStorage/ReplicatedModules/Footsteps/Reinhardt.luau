  

 

return {
    NormalSounds = { "rbxassetid://17561992143", "rbxassetid://17561992688", "rbxassetid://17561992263", "rbxassetid://17561992945", "rbxassetid://17561992376" },
    Movement = {
        Walk = 17562349889,
        Run = 17562351766
    },

    UpdateRunningSound = function(u1) -- Line: 15, Name: UpdateRunningSound
        local FootstepInfo = u1.FootstepInfo;
        local Running = u1.Running;
        local _ = u1.Character;
        local Trove = u1.Trove;
        local RootPart = u1.RootPart;
        local u2 = {};
        local Animator = u1.Humanoid:WaitForChild("Animator");
        local u3 = FootstepInfo.NormalSounds or {};
        local u4 = Random.new();

        local function PlayFootstep() -- Line: 31
            -- upvalues: u3 (copy), u4 (copy), RootPart (copy)
            local Sound = Instance.new("Sound");
            task.delay(1, Sound.Destroy, Sound);
            Sound.Name = "ReinhardtFootstep";
            Sound.Volume = 1;
            Sound.PlaybackSpeed = 1;
            Sound.Looped = false;
            Sound.SoundId = u3[u4:NextInteger(1, #u3)];
            Sound.Parent = RootPart;
            Sound.SoundGroup = game:GetService("SoundService").Footsteps;
            Sound:Play();
        end;

        Trove:Add(Animator.AnimationPlayed:Connect(function(p5) -- Line: 44
            -- upvalues: u2 (copy), u1 (copy), Trove (copy), PlayFootstep (copy)
            if not u2[p5] then
                local v6 = p5.Animation.AnimationId:match("%d+$");

                if v6 and tonumber(v6) then
                    local v7 = tonumber(v6);

                    for _, v in u1.FootstepInfo.Movement do
                        if v == v7 then
                            u2[p5] = { Trove:Connect(p5:GetMarkerReachedSignal("Step"), PlayFootstep) };
                        end;
                    end;
                end;
            end;
        end));

        return function() -- Line: 60
            -- upvalues: Running (copy)
            Running.PlaybackSpeed = 0;
        end;
    end
};