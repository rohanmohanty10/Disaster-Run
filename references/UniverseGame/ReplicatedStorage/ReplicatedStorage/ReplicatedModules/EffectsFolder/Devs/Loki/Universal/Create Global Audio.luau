  

 

local ContentProvider = game:GetService("ContentProvider");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Players");
game:GetService("Lighting");
local _ = ReplicatedStorage.ReplicatedRoot;
require(ReplicatedStorage.ReplicatedModules.Types);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
local SoundGroups = require(ReplicatedStorage:WaitForChild("ReplicatedModules"):WaitForChild("SoundGroups"));

local function TweenCallback(p1, p2, u3, p4, p5, p6, p7, p8, p9) -- Line: 19
    -- upvalues: TweenService (copy)
    local v10 = TweenService:Create(p1, TweenInfo.new(p4 or 0.5, p5 or Enum.EasingStyle.Quad, p6 or Enum.EasingDirection.Out, p7 or 0, p8 or false, p9 or 0), p2);
    v10.Completed:Connect(function() -- Line: 29
        -- upvalues: u3 (copy)
        if u3 then
            u3();
        end;
    end);
    v10:Play();
end;

return function(p11) -- Line: 43
    -- upvalues: SoundGroups (copy), ContentProvider (copy), TweenCallback (copy)
    if p11.Sound then
        local Reference = p11.Reference;
        local Sound = p11.Sound;
        local FadeInTime = p11.FadeInTime;
        local FadeOutTime = p11.FadeOutTime;

        if typeof(Sound) == "string" then
            local Sound2 = Instance.new("Sound");
            Sound2.SoundId = Sound;
            Sound = Sound2;
        elseif typeof(Sound) == "Instance" then
            Sound = Sound:Clone();
        end;

        if Sound.IsPlaying then
            Sound.Playing = false;
            Sound.TimePosition = 0;
        end;

        Sound.PlaybackSpeed = p11.PlaybackSpeed or Sound.PlaybackSpeed;
        local u12 = p11.Volume or Sound.Volume;
        Sound.Looped = p11.Looped or false;
        Sound.Name = "Sound";
        SoundGroups:AssignSoundTag(Sound);
        Sound.Parent = workspace.Effects;

        if not Sound.TimeLength or Sound.TimeLength == 0 then
            ContentProvider:PreloadAsync({ Sound.SoundId });

            if not Sound.IsLoaded then
                Sound.Loaded:Wait();
            end;
        end;

        Sound:SetAttribute("OriginalVolume", u12);
        local u13 = false;

        if FadeInTime then
            TweenCallback(Sound, {
                Volume = u12
            }, nil, FadeInTime, Enum.EasingStyle.Linear);
        else
            Sound.Volume = u12;
        end;

        Sound:Play();

        if Sound.Looped and (Sound.TimeLength > 0 and FadeOutTime) then
            task.spawn(function() -- Line: 102
                -- upvalues: Sound (ref), FadeOutTime (copy), u13 (ref), TweenCallback (ref), u12 (copy), FadeInTime (copy)
                while Sound.Parent do
                    local v14 = math.max(0, Sound.TimeLength / Sound.PlaybackSpeed - FadeOutTime);
                    task.wait(v14);

                    if Sound.Parent then
                        u13 = true;
                        TweenCallback(Sound, {
                            Volume = 0
                        }, function() -- Line: 111
                            -- upvalues: u13 (ref)
                            u13 = false;
                        end, FadeOutTime, Enum.EasingStyle.Linear);
                        task.wait(FadeOutTime);

                        if Sound.Parent then
                            TweenCallback(Sound, {
                                Volume = u12
                            }, nil, FadeInTime or 0.1, Enum.EasingStyle.Linear);
                            task.wait(FadeInTime or 0.1);
                        end;
                    end;
                end;
            end);
        end;

        if not Sound.Looped and Sound.TimeLength > 0 then
            local v15 = Sound.TimeLength / Sound.PlaybackSpeed;

            if FadeOutTime then
                local v16 = math.max(0, v15 - FadeOutTime);
                task.delay(v16, function() -- Line: 128
                    -- upvalues: Sound (ref), u13 (ref), TweenCallback (ref), u12 (copy), FadeOutTime (copy)
                    if Sound.Parent then
                        u13 = true;
                        TweenCallback(Sound, {
                            Volume = 0
                        }, function() -- Line: 134
                            -- upvalues: Sound (ref), u12 (ref), u13 (ref)
                            Sound.Volume = u12;
                            u13 = false;
                        end, FadeOutTime, Enum.EasingStyle.Linear);
                    end;
                end);
            end;

            task.delay(v15, function() -- Line: 145
                -- upvalues: Sound (ref)
                if Sound.Parent then
                    Sound:Destroy();
                end;
            end);
        end;

        if Reference then
            task.spawn(function() -- Line: 153
                -- upvalues: Reference (copy), Sound (ref), u13 (ref), FadeOutTime (copy), TweenCallback (ref)
                while Reference:IsDescendantOf(workspace) and Sound.Parent do
                    task.wait(0.016666666666666666);
                end;

                if u13 then
                    while u13 and Sound.Parent do
                        task.wait(0.016666666666666666);
                    end;
                elseif FadeOutTime then
                    u13 = true;
                    TweenCallback(Sound, {
                        Volume = 0
                    }, function() -- Line: 163
                        -- upvalues: u13 (ref)
                        u13 = false;
                    end, FadeOutTime, Enum.EasingStyle.Linear);

                    while u13 and Sound.Parent do
                        task.wait(0.016666666666666666);
                    end;
                end;

                if Sound.Parent then
                    Sound:Destroy();
                end;
            end);
        end;

        return Sound;
    end;
end;