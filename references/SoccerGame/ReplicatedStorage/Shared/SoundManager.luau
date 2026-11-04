  

local v1 = {};
game:GetService("TweenService");
game:GetService("Debris");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");

local function destroyAfterPlayed(u2: userdata) -- Line: 8
    task.spawn(function() -- Line: 9
        -- upvalues: u2 (copy)
        if not u2.IsLoaded then
            u2.Loaded:Wait();
        end;

        task.wait(u2.TimeLength);
        u2:Destroy();
    end);
end;

function v1.SpawnSound(p3, p4, p5, p6, p7, p8) -- Line: 18
    -- upvalues: ReplicatedStorage (copy), SoundService (copy)
    local v9 = ReplicatedStorage.Assets.Sfx:FindFirstChild(p3, true);
    local u10 = v9:Clone();
    u10.RollOffMode = Enum.RollOffMode.Linear;
    u10.Volume = p4 and p4 * 2.35 or v9.Volume;

    if p6 then
        u10.RollOffMinDistance = p6 / 2.5;
        u10.RollOffMaxDistance = p6 * 1.5;
    end;

    if p7 then
        u10.Looped = true;
    end;

    u10.Parent = p5 or SoundService.SFX;

    if p8 then
        return u10;
    end;

    u10:Play();
    task.spawn(function() -- Line: 9
        -- upvalues: u10 (copy)
        if not u10.IsLoaded then
            u10.Loaded:Wait();
        end;

        task.wait(u10.TimeLength);
        u10:Destroy();
    end);

    return u10;
end;

function v1.SpawnSoundId(p11, p12, p13, p14, p15, p16) -- Line: 41
    -- upvalues: SoundService (copy)
    local Sound = Instance.new("Sound");
    Sound.SoundId = "rbxassetid://" .. p11;
    Sound.RollOffMode = Enum.RollOffMode.Linear;
    Sound.Volume = p12 and p12 * 2.35 or 1;

    if p14 then
        Sound.RollOffMinDistance = p14 / 2.5;
        Sound.RollOffMaxDistance = p14 * 1.5;
    end;

    if p15 then
        Sound.Looped = true;
    end;

    Sound.SoundGroup = SoundService.SFX;
    Sound.Parent = p13 or SoundService.SFX;

    if p16 then
        return Sound;
    end;

    Sound:Play();
    task.spawn(function() -- Line: 9
        -- upvalues: Sound (copy)
        if not Sound.IsLoaded then
            Sound.Loaded:Wait();
        end;

        task.wait(Sound.TimeLength);
        Sound:Destroy();
    end);

    return Sound;
end;

return v1;