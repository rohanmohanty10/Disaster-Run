 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
game:GetService("UserInputService");
local SoundService = game:GetService("SoundService");
local LocalPlayer = Players.LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Packages.Signal);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local AllMusic = SoundService:WaitForChild("AllMusic");
local u1 = nil;
local u2 = nil;
local v3 = Knit.CreateController({
    CurrentSong = 0,
    Name = script.Name,
    MusicIds = { "rbxassetid://107163985945507" }
});

function v3.SetMusicEnabled(p4, p5) -- Line: 31
    if not p5 then
        p4:AdjustGroupVolume(0, false);
    end;

    p4.musicEnabled = p5;

    if p5 then
        p4:AdjustGroupVolume(p4.desiredMusicVolume, false);
    end;
end;

function v3.AdjustVolume(p6, p7, p8) -- Line: 43
    -- upvalues: AllMusic (copy), TweenService (copy)
    TweenService:Create(AllMusic:WaitForChild("Music"):WaitForChild("Sound"), TweenInfo.new(0.3), {
        Volume = p7 or 0.5
    }):Play();
end;

function v3.AdjustGroupVolume(p9, p10, p11) -- Line: 52
    -- upvalues: TweenService (copy), AllMusic (copy)
    local v12 = p10 or 0.5;

    if p11 == nil and true or p11 then
        p9.desiredMusicVolume = v12;
    end;

    if not p9.musicEnabled then
        return;
    end;

    TweenService:Create(AllMusic, TweenInfo.new(0.3), {
        Volume = v12
    }):Play();
end;

function v3.Speaker(p13) -- Line: 70
    -- upvalues: AllMusic (copy), LocalPlayer (copy), VfxManager (copy)
    task.spawn(function() -- Line: 71
        -- upvalues: AllMusic (ref), LocalPlayer (ref), VfxManager (ref)
        local Sound = AllMusic.Music.Sound;
        local PlaybackLoudness = Sound.PlaybackLoudness;

        local function speakerThread() -- Line: 75
            -- upvalues: LocalPlayer (ref), Sound (copy), PlaybackLoudness (ref), VfxManager (ref)
            while task.wait() and LocalPlayer.Team == game.Teams.Visitor do
                if math.round(Sound.PlaybackLoudness - PlaybackLoudness) >= 20 then
                    VfxManager.Emit(workspace:WaitForChild("Lobby"):WaitForChild("Misc"):WaitForChild("Speakers"));
                    task.wait(0.15);
                end;

                PlaybackLoudness = Sound.PlaybackLoudness;
            end;
        end;

        speakerThread();
        LocalPlayer:GetPropertyChangedSignal("Team"):Connect(function() -- Line: 88
            -- upvalues: LocalPlayer (ref), speakerThread (copy)
            if LocalPlayer.Team == game.Teams.Visitor then
                speakerThread();
            end;
        end);
    end);
end;

function v3.UnpauseMusic(p14) -- Line: 96
    -- upvalues: AllMusic (copy)
    AllMusic:WaitForChild("Music"):WaitForChild("Sound"):Resume();
end;

function v3.PauseMusic(p15) -- Line: 103
    -- upvalues: AllMusic (copy)
    AllMusic:WaitForChild("Music"):WaitForChild("Sound"):Pause();
end;

function v3.StopAwakeningMusic(p16) -- Line: 110
    -- upvalues: TweenService (copy)
    local CurrentAwakening = p16.CurrentAwakening;

    if CurrentAwakening then
        p16.CurrentAwakening = nil;
        TweenService:Create(CurrentAwakening, TweenInfo.new(1), {
            Volume = 0
        }):Play();
        task.delay(1, function() -- Line: 115
            -- upvalues: CurrentAwakening (copy)
            CurrentAwakening:Destroy();
        end);
    end;
end;

function v3.AwakeningMusic(p17: table, p18: userdata) -- Line: 121
    -- upvalues: SoundService (copy), AllMusic (copy), Effects (copy)
    local Style = p18:FindFirstChild("Style");

    if not Style then
        return;
    end;

    if p18:GetAttribute("Team") == "Visitor" then
        return;
    end;

    local Value = Style.Value;
    local v19 = script.Awakenings:FindFirstChild((tostring(Value)));

    if not v19 then
        return warn("Music for: " .. Value .. " not found");
    end;

    local CurrentAwakening = p17.CurrentAwakening;

    if CurrentAwakening then
        CurrentAwakening:Stop();
        CurrentAwakening:Destroy();
        p17.CurrentAwakening = nil;
    end;

    local v20 = v19:Clone();
    v20.SoundGroup = SoundService.AllMusic.Awakening;
    v20.Parent = AllMusic.Awakening;
    v20:Play();
    p17.CurrentAwakening = v20;
    local Lyrics = v20:FindFirstChild("Lyrics");

    if Lyrics then
        Effects:MusicSubtitles(v20, require(Lyrics));
    end;
end;

function v3.StartMusic(u21) -- Line: 152
    -- upvalues: AllMusic (copy)
    local Sound = AllMusic:WaitForChild("Music"):WaitForChild("Sound");

    if u21.SongConnection then
        u21.SongConnection:Disconnect();
    end;

    u21.CurrentSong = u21.CurrentSong + 1;

    if u21.CurrentSong > #u21.MusicIds then
        u21.CurrentSong = 1;
    end;

    if Sound.SoundId ~= u21.MusicIds[u21.CurrentSong] or #u21.MusicIds <= 1 then
        Sound.SoundId = u21.MusicIds[u21.CurrentSong];
        Sound:Play();
    end;

    u21.SongConnection = Sound.Ended:Once(function() -- Line: 170
        -- upvalues: u21 (copy)
        u21:StartMusic();
    end);
end;

function v3.KnitStart(u22) -- Line: 175
    -- upvalues: u2 (ref), Knit (copy), LocalPlayer (copy), AllMusic (copy), u1 (ref)
    u2 = Knit.GetController("Network");
    u22:StartMusic();
    u22:Speaker();
    local Team = LocalPlayer.Team;

    if Team == nil or Team.Name ~= "Visitor" then
        u22:AdjustVolume(0);
        AllMusic.Awakening.Volume = 0.45;
    else
        u22:AdjustVolume(0.75);
        AllMusic.Awakening.Volume = 0;
    end;

    if LocalPlayer.Team ~= game.Teams.Visitor then
        local Team2 = LocalPlayer.Team;

        if Team2 == nil or Team2.Name ~= "Visitor" then
            u22:AdjustVolume(0);
            AllMusic.Awakening.Volume = 0.45;
        else
            u22:AdjustVolume(0.75);
            AllMusic.Awakening.Volume = 0;
        end;
    end;

    LocalPlayer:GetPropertyChangedSignal("Team"):Connect(function() -- Line: 200
        -- upvalues: LocalPlayer (ref), u22 (copy), AllMusic (ref)
        local Team2 = LocalPlayer.Team;

        if Team2 == nil or Team2.Name ~= "Visitor" then
            u22:AdjustVolume(0);
            AllMusic.Awakening.Volume = 0.45;

            return;
        end;

        u22:AdjustVolume(0.75);
        AllMusic.Awakening.Volume = 0;
    end);
    LocalPlayer.PlayerGui.Spectate:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 210
        -- upvalues: LocalPlayer (ref), u22 (copy), AllMusic (ref)
        if LocalPlayer.PlayerGui.Spectate.Enabled then
            u22:AdjustVolume(0);
            AllMusic.Awakening.Volume = 0.45;

            return;
        end;

        u22:AdjustVolume(0.75);
        AllMusic.Awakening.Volume = 0;
    end);
    u1.Music:Connect(function(p23) -- Line: 220
        -- upvalues: u22 (copy)
        u22:AwakeningMusic(p23);
    end);
    u1.StopMusic:Connect(function() -- Line: 224
        -- upvalues: u22 (copy)
        u22:StopAwakeningMusic();
    end);
end;

function v3.KnitInit(p24) -- Line: 229
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("AwakeningService");
    p24.musicEnabled = true;
    p24.desiredMusicVolume = 0;
    p24.CurrentSong = #p24.MusicIds > 1 and (math.random(1, #p24.MusicIds) or 1) or 1;
end;

return v3;