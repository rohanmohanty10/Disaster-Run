 
 

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");

function v1.playSound(p2: table, p3: table) -- Line: 17
    -- upvalues: ReplicatedStorage (copy)
    local Sound = p3.Sound;

    if tostring(Sound) and typeof(Sound) ~= "Instance" then
        local v4 = ReplicatedStorage.Assets.SFX:FindFirstChild(Sound, true);

        if not v4 then
            warn("Sound: " .. Sound .. " not found");

            return;
        end;

        Sound = v4:Clone();
    elseif not p3.PlaySound then
        Sound = Sound:Clone();
    end;

    if not p3.PlaySound then
        Sound.Parent = p3.Parent;
        Sound.RollOffMinDistance = p3.Min or Sound.RollOffMinDistance;
        Sound.RollOffMaxDistance = p3.Max or Sound.RollOffMaxDistance;
        Sound.Volume = p3.Volume or Sound.Volume;
        Sound.PlaybackSpeed = p3.RandomPitch and Sound.PlaybackSpeed + math.random() * 0.4 or Sound.PlaybackSpeed;
    end;

    Sound:Play();

    if p3.Duration then
        task.delay(p3.Duration, function() -- Line: 44
            -- upvalues: Sound (ref)
            if not Sound then
                return;
            end;

            Sound:Stop();
            Sound:Destroy();
        end);
    else
        Sound.Ended:Once(function() -- Line: 50
            -- upvalues: Sound (ref)
            Sound:Destroy();
        end);
    end;

    table.clear(p3);

    return Sound;
end;

return v1;