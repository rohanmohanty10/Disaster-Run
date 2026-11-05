  

 

local TweenService = game:GetService("TweenService");

return function() -- Line: 2
    -- upvalues: TweenService (copy)
    local EqualizerSoundEffect = Instance.new("EqualizerSoundEffect");
    EqualizerSoundEffect.Parent = game:GetService("SoundService").StandSounds;
    local v1 = EqualizerSoundEffect:Clone();
    v1.Parent = game:GetService("SoundService").Music;
    TweenService:Create(EqualizerSoundEffect, TweenInfo.new(0.3), {
        HighGain = -30,
        LowGain = 10,
        MidGain = -30
    }):Play();
    TweenService:Create(v1, TweenInfo.new(0.3), {
        HighGain = -30,
        LowGain = 10,
        MidGain = -30
    }):Play();
end;