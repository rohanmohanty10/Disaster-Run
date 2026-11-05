  

 

local CollectionService = game:GetService("CollectionService");

return function(u1) -- Line: 3
    -- upvalues: CollectionService (copy)
    local SoundGroups = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("SoundGroups"));
    local Settings = u1.Player:WaitForChild("Settings");
    local SoundService = game:GetService("SoundService");
    local SoundGroup = Instance.new("SoundGroup");
    SoundGroup.Name = "Master";
    SoundGroup.Volume = 1;
    SoundGroup.Parent = SoundService;
    SoundGroups:AddSoundGroup(SoundGroup, "Master");
    local SoundGroup2 = Instance.new("SoundGroup");
    SoundGroup2.Name = "Music";
    SoundGroup2.Volume = 1;
    SoundGroup2.Parent = SoundService;
    SoundGroups:AddSoundGroup(SoundGroup2, "Music");
    local SoundGroup3 = Instance.new("SoundGroup");
    SoundGroup3.Name = "SoundEffect";
    SoundGroup3.Volume = 1;
    SoundGroup3.Parent = SoundService;
    SoundGroups:AddSoundGroup(SoundGroup3, "SoundEffect");
    local SoundGroup4 = Instance.new("SoundGroup");
    SoundGroup4.Name = "Footsteps";
    SoundGroup4.Volume = 1;
    SoundGroup4.Parent = SoundService;
    SoundGroups:AddSoundGroup(SoundGroup4, "Footsteps");
    local SoundGroup5 = Instance.new("SoundGroup");
    SoundGroup5.Name = "PlayerEmote";
    SoundGroup5.Volume = 1;
    SoundGroup5.Parent = SoundService;
    SoundGroups:AddSoundGroup(SoundGroup5, "PlayerEmote");
    local SoundGroup6 = Instance.new("SoundGroup");
    SoundGroup6.Name = "OtherEmote";
    SoundGroup6.Volume = 1;
    SoundGroup6.Parent = SoundService;
    SoundGroups:AddSoundGroup(SoundGroup6, "OtherEmote");
    local SoundGroup7 = Instance.new("SoundGroup");
    SoundGroup7.Name = "Ambience";
    SoundGroup7.Volume = 1;
    SoundGroup7.Parent = SoundService;
    SoundGroups:AddSoundGroup(SoundGroup7, "Ambience");
    local StandSounds = SoundService:FindFirstChild("StandSounds");
    SoundGroups:AddSoundGroup(StandSounds, "SoundStands");

    function u1.UpdateVolumes(p2) -- Line: 53
        -- upvalues: SoundGroup (copy), Settings (copy), SoundGroup2 (copy), SoundGroup3 (copy), SoundGroup4 (copy), StandSounds (copy), SoundGroup5 (copy), SoundGroup6 (copy), SoundGroup7 (copy)
        SoundGroup.Volume = Settings.MasterVolume.Value / 100;
        SoundGroup2.Volume = Settings.MusicVolume.Value / 100 * SoundGroup.Volume;
        SoundGroup3.Volume = Settings.SoundEffectVolume.Value / 100 * SoundGroup.Volume;
        SoundGroup4.Volume = Settings.FootstepsVolume.Value / 100 * SoundGroup.Volume;
        StandSounds.Volume = Settings.SoundEffectVolume.Value / 100 * SoundGroup.Volume;
        SoundGroup5.Volume = Settings.ClientEmoteVolume.Value / 100 * SoundGroup.Volume;
        SoundGroup6.Volume = Settings.OtherEmoteVolume.Value / 100 * SoundGroup.Volume;
        SoundGroup7.Volume = Settings.AmbienceVolume.Value / 100 * SoundGroup.Volume;
    end;

    local function GetSoundGroup(p3) -- Line: 64
        -- upvalues: SoundGroup2 (copy), u1 (copy), SoundGroup5 (copy), SoundGroup6 (copy), SoundGroup3 (copy)
        local Parent = p3.Parent;

        if Parent and Parent.Name == "MusicPlayer" or p3:GetAttribute("MusicSound") then
            return SoundGroup2;
        end;

        local Name = p3.Name;

        if Name ~= "QuoteSound" and not (string.find(string.lower(Name), "posemusic", 1, true) or p3:GetAttribute("EmoteSound")) then
            return SoundGroup3;
        end;

        if u1.Character and p3:IsDescendantOf(u1.Character) then
            return SoundGroup5;
        end;

        return SoundGroup6;
    end;

    local function Add(p4) -- Line: 80
        -- upvalues: GetSoundGroup (copy)
        local v5 = GetSoundGroup(p4);

        if v5 then
            p4.SoundGroup = v5;
        end;
    end;

    for _, v in pairs(CollectionService:GetTagged("Sound")) do
        local v6 = GetSoundGroup(v);

        if v6 then
            v.SoundGroup = v6;
        end;
    end;

    CollectionService:GetInstanceAddedSignal("Sound"):Connect(Add);
end;