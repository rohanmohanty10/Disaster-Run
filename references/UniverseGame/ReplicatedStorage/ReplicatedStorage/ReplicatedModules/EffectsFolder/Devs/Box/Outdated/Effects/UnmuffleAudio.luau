  

 

local TweenService = game:GetService("TweenService");

return function() -- Line: 2
    -- upvalues: TweenService (copy)
    if game:GetService("SoundService").StandSounds:FindFirstChildWhichIsA("EqualizerSoundEffect") then
        local v1 = game:GetService("SoundService").StandSounds:FindFirstChildWhichIsA("EqualizerSoundEffect");
        local v2 = game:GetService("SoundService").Music:FindFirstChildWhichIsA("EqualizerSoundEffect");
        TweenService:Create(v1, TweenInfo.new(0.3), {
            HighGain = 0,
            LowGain = 0,
            MidGain = 0
        }):Play();
        TweenService:Create(v2, TweenInfo.new(0.3), {
            HighGain = 0,
            LowGain = 0,
            MidGain = 0
        }):Play();
        task.wait(0.3);
        v1:Destroy();
        v2:Destroy();
    end;
end;