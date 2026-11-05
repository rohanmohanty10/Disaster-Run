  

 

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
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
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

return function(p11) -- Line: 42
    -- upvalues: SoundGroups (copy), ContentProvider (copy), Fusion (copy)
    if p11.Sound then
        local _ = p11.Reference;
        local Sound = p11.Sound;

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
        local v12 = p11.Volume or Sound.Volume;
        Sound.Looped = true;
        Sound.Volume = 0;
        Sound.Name = "AmbienceMusic";
        SoundGroups:AssignSoundToSoundGroup(Sound, "Ambience");
        Sound.Parent = workspace;

        if not Sound.TimeLength or Sound.TimeLength == 0 then
            ContentProvider:PreloadAsync({ Sound.SoundId });

            if not Sound.IsLoaded then
                Sound.Loaded:Wait();
            end;
        end;

        local u13 = Fusion.Value(0);
        local u14;

        if typeof(p11.TweenInfo) == "TweenInfo" then
            u14 = p11.TweenInfo;
        elseif typeof(p11.TweenInfo) == "table" then
            u14 = TweenInfo.new(unpack(p11.TweenInfo));
        else
            u14 = TweenInfo.new(0.5);
        end;

        Fusion.Hydrate(Sound)({
            Volume = Fusion.Tween(u13, u14)
        });
        local u15 = {
            Sound = Sound,
            Volume = u13
        };

        function u15.Destroy(p16) -- Line: 94
            -- upvalues: u13 (ref), u14 (copy), Sound (ref), u15 (copy)
            u13:set(0);
            task.delay(u14.Time + 0.1, function() -- Line: 97
                -- upvalues: Sound (ref), u13 (ref), u15 (ref)
                Sound:Destroy();
                u13 = nil;
                table.clear(u15);
            end);
        end;

        Sound:Play();
        u13:set(v12);

        return u15;
    end;
end;