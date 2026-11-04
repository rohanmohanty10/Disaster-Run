 

 

local Players = game:GetService("Players");
local SoundService = game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
local LazySound = require(script.Parent.Parent:WaitForChild("LazySound"));
local u1 = {};
u1.__index = u1;

local function usable(p2) -- Line: 10
    -- upvalues: LazySound (copy)
    local v3 = p2:IsA("Sound") and (LazySound.id(p2) or "") or "";
    local v4 = p2:IsA("Sound");

    if v4 then
        if p2:GetAttribute("Enabled") == false or v3 == "" then
            v4 = false;
        else
            v4 = v3 ~= "rbxassetid://0";
        end;
    end;

    return v4;
end;

function u1.new(p5, u6) -- Line: 15
    -- upvalues: Players (copy), SoundService (copy), u1 (copy), TweenService (copy)
    local LocalPlayer = Players.LocalPlayer;
    local Folder = Instance.new("Folder");
    Folder.Name = "LobbyMusicPlayback";
    Folder.Parent = SoundService;
    local math_clamp_ret = math.clamp(u6.MasterVolume or 0.3, 0, 1);

    local function outputVolume() -- Line: 19
        -- upvalues: LocalPlayer (copy), math_clamp_ret (copy)
        local Attribute = LocalPlayer:GetAttribute("MusicVolume");
        local v7 = type(Attribute) == "number" and (Attribute == Attribute and math.clamp(Attribute, 0, 1)) or 1;

        return LocalPlayer:GetAttribute("MusicMuted") == true and 0 or math_clamp_ret * v7;
    end;

    local SoundGroup = Instance.new("SoundGroup");
    SoundGroup.Name = "LocalMusicVolume";
    local Attribute = LocalPlayer:GetAttribute("MusicVolume");
    local v8 = type(Attribute) == "number" and Attribute == Attribute and (math.clamp(Attribute, 0, 1) or 1) or 1;
    SoundGroup.Volume = LocalPlayer:GetAttribute("MusicMuted") == true and 0 or math_clamp_ret * v8;
    SoundGroup.Parent = SoundService;
    local v9 = {
        alive = true,
        themeAttempted = false,
        current = nil,
        lastTrack = nil,
        generation = 0,
        player = LocalPlayer,
        theme = p5,
        config = u6,
        folder = Folder,
        group = SoundGroup,
        bag = {},
        failed = {},
        random = Random.new(),
        connections = {}
    };
    local u10 = setmetatable(v9, u1);

    local function updateVolume() -- Line: 27
        -- upvalues: u10 (copy), TweenService (ref), SoundGroup (copy), u6 (copy), LocalPlayer (copy), math_clamp_ret (copy)
        if u10.muteTween then
            u10.muteTween:Cancel();
        end;

        local TweenInfo_new_ret = TweenInfo.new(u6.MuteFade);
        local v11 = {};
        local Attribute2 = LocalPlayer:GetAttribute("MusicVolume");
        local v12 = type(Attribute2) == "number" and Attribute2 == Attribute2 and (math.clamp(Attribute2, 0, 1) or 1) or 1;
        v11.Volume = LocalPlayer:GetAttribute("MusicMuted") == true and 0 or math_clamp_ret * v12;
        u10.muteTween = TweenService:Create(SoundGroup, TweenInfo_new_ret, v11);
        u10.muteTween:Play();
    end;

    for _, v in { "MusicMuted", "MusicVolume" } do
        local connections = u10.connections;
        local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal(v);
        table.insert(connections, AttributeChangedSignal:Connect(updateVolume));
    end;

    for _, v in { "InMatch", "GameRole" } do
        local connections = u10.connections;
        local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal(v);
        table.insert(connections, AttributeChangedSignal:Connect(function() -- Line: 32
            -- upvalues: u10 (copy)
            u10:updateEligibility();
        end));
    end;

    local connections = u10.connections;
    local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("MusicPaused");
    table.insert(connections, AttributeChangedSignal:Connect(function() -- Line: 34
        -- upvalues: u10 (copy), LocalPlayer (copy)
        local current = u10.current;

        if not current then
            return;
        end;

        if LocalPlayer:GetAttribute("MusicPaused") == true then
            current:Pause();

            return;
        end;

        current:Resume();
    end));
    u10:updateEligibility();
    task.spawn(function() -- Line: 39
        -- upvalues: u10 (copy)
        local Session = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("Game"):WaitForChild("Session");

        if not u10.alive then
            return;
        end;

        local connections2 = u10.connections;
        local AttributeChangedSignal2 = Session:GetAttributeChangedSignal("ActiveMapId");
        table.insert(connections2, AttributeChangedSignal2:Connect(function() -- Line: 43
            -- upvalues: u10 (ref), Session (copy)
            u10:setMap(Session:GetAttribute("ActiveMapId"));
        end));
        u10:setMap(Session:GetAttribute("ActiveMapId"));
    end);
    task.spawn(function() -- Line: 48
        -- upvalues: u10 (copy)
        u10:run();
    end);

    return u10;
end;

function u1.isLobby(p13) -- Line: 51
    local v14;

    if p13.player:GetAttribute("InMatch") == true then
        v14 = false;
    else
        v14 = (p13.player:GetAttribute("GameRole") or "Lobby") == "Lobby";
    end;

    return v14;
end;

function u1.wanted(p15) -- Line: 56
    local HalloweenLobby = p15.config.HalloweenLobby;

    return HalloweenLobby and (p15:isLobby() and workspace:GetServerTimeNow() < HalloweenLobby.EndsAt) and "Halloween" or (p15.playlist and "Map" or (p15:isLobby() and "Lobby" or nil));
end;

function u1.setMap(p16, p17) -- Line: 63
    local MapPlaylists = p16.config.MapPlaylists;
    local v18;

    if type(p17) == "string" and MapPlaylists then
        v18 = MapPlaylists[p17] or nil;
    else
        v18 = nil;
    end;

    if v18 and #v18 == 0 then
        v18 = nil;
    end;

    if v18 == p16.playlist then
        return;
    end;

    p16.playlist = v18;
    local v19;

    if v18 then
        v19 = p16.random:NextInteger(1, #v18) or nil;
    else
        v19 = nil;
    end;

    p16.playIndex = v19;
    p16.folder:SetAttribute("MapPlaylist", v18 and p17 and p17 or nil);

    if p16.current and p16.currentKind ~= "Halloween" then
        local current = p16.current;
        p16.current = nil;
        p16.generation = p16.generation + 1;
        p16:retire(current, p16.config.FadeOut);
    end;
end;

function u1.mapTrack(p20) -- Line: 77
    local playlist = p20.playlist;

    for i = 1, #playlist do
        local v21 = playlist[p20.playIndex];
        p20.playIndex = p20.playIndex % #playlist + 1;

        if not p20.failed["rbxassetid://" .. v21] then
            return v21;
        end;

        local _ = i;
    end;

    return nil;
end;

function u1.updateEligibility(p22) -- Line: 85
    local v23 = p22:wanted();
    p22.folder:SetAttribute("LobbyEligible", v23 ~= nil);

    if p22.current and p22.currentKind ~= v23 then
        local current = p22.current;
        p22.current = nil;
        p22.generation = p22.generation + 1;
        p22:retire(current, p22.config.FadeOut);
    end;
end;

function u1.retire(p24, u25, p26) -- Line: 93
    -- upvalues: TweenService (copy)
    if u25:GetAttribute("Retiring") then
        return;
    end;

    u25:SetAttribute("Retiring", true);

    if p24.fadeIn and p24.fadeInSound == u25 then
        p24.fadeIn:Cancel();
    end;

    TweenService:Create(u25, TweenInfo.new(p26, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Volume = 0
    }):Play();
    task.delay(p26, function() -- Line: 99
        -- upvalues: u25 (copy)
        u25:Stop();
        u25:Destroy();
    end);
end;

function u1.nextTrack(p27) -- Line: 101
    -- upvalues: SoundService (copy), usable (copy), LazySound (copy)
    local GameAudio = SoundService:FindFirstChild("GameAudio");

    if GameAudio then
        GameAudio = GameAudio:FindFirstChild("01_Soundtracks");
    end;

    if GameAudio then
        GameAudio = GameAudio:FindFirstChild("Lobby");
    end;

    if not GameAudio then
        return nil;
    end;

    if #p27.bag == 0 then
        for _, child in GameAudio:GetChildren() do
            if usable(child) and not p27.failed[LazySound.id(child)] then
                table.insert(p27.bag, child);
            end;
        end;

        for i = #p27.bag, 2, -1 do
            local v28 = p27.random:NextInteger(1, i);
            local bag = p27.bag;
            local v29 = p27.bag[i];
            p27.bag[i] = p27.bag[v28];
            bag[v28] = v29;
            local _ = i;
        end;

        if #p27.bag > 1 and LazySound.id(p27.bag[#p27.bag]) == p27.lastTrack then
            local bag = p27.bag;
            local v30 = #p27.bag;
            local v31 = p27.bag[1];
            p27.bag[1] = p27.bag[#p27.bag];
            bag[v30] = v31;
        end;
    end;

    while #p27.bag > 0 do
        local table_remove_ret = table.remove(p27.bag);

        if table_remove_ret.Parent and (usable(table_remove_ret) and not p27.failed[LazySound.id(table_remove_ret)]) then
            return table_remove_ret;
        end;
    end;

    return nil;
end;

function u1.play(p32, p33, p34, p35) -- Line: 114
    -- upvalues: LazySound (copy), TweenService (copy)
    p32.generation = p32.generation + 1;
    local generation = p32.generation;
    p32.currentKind = p35;
    local v36 = LazySound.arm(p33:Clone());
    v36.Name = p34 and "JoiningTheme" or p33.Name;
    v36.Looped = false;
    v36.PlayOnRemove = false;
    v36.TimePosition = 0;
    v36.Volume = 0;
    v36.SoundGroup = p32.group;
    v36.Parent = p32.folder;
    p32.current = v36;
    p32.folder:SetAttribute("CurrentTrack", p33.Name);
    p32.folder:SetAttribute("IsJoiningTheme", p34);
    local u37 = false;
    local v38 = v36.Ended:Connect(function() -- Line: 121
        -- upvalues: u37 (ref)
        u37 = true;
    end);
    v36:Play();

    if p32.player:GetAttribute("MusicPaused") == true then
        v36:Pause();
    end;

    local v39 = os.clock() + p32.config.LoadTimeout;

    while p32.alive and (p32.current == v36 and (not v36.IsLoaded and os.clock() < v39)) do
        task.wait(0.05);
    end;

    if p32.current ~= v36 or not p32.alive then
        v38:Disconnect();

        return;
    end;

    if not v36.IsLoaded then
        p32.failed[LazySound.id(p33)] = true;
        p32.folder:SetAttribute("LastUnavailableTrack", p33.Name);
        p32.current = nil;
        v38:Disconnect();
        v36:Destroy();

        return;
    end;

    p32.fadeInSound = v36;
    p32.fadeIn = TweenService:Create(v36, TweenInfo.new(p32.config.FadeIn), {
        Volume = p33.Volume
    });
    p32.fadeIn:Play();
    p32.folder:SetAttribute("TrackSequence", (p32.folder:GetAttribute("TrackSequence") or 0) + 1);

    if p34 then
        p32.folder:SetAttribute("ThemePlayCount", (p32.folder:GetAttribute("ThemePlayCount") or 0) + 1);
        p32.folder:SetAttribute("ThemeStartedAt", workspace:GetServerTimeNow());
    end;

    p32.lastTrack = LazySound.id(p33);
    local os_clock_ret = os.clock();
    local v40 = v36.TimeLength / math.max(v36.PlaybackSpeed, 0.01);
    local v41 = os_clock_ret + math.max(v40, 1) + 3;

    while p32.alive and (p32.current == v36 and (generation == p32.generation and (not u37 and os.clock() < v41))) do
        task.wait(0.1);

        if p32.player:GetAttribute("MusicPaused") == true then
            v41 = v41 + 0.1;
        end;
    end;

    v38:Disconnect();

    if p32.current == v36 then
        p32.current = nil;
        v36:Destroy();
    end;
end;

function u1.run(p42) -- Line: 147
    -- upvalues: usable (copy)
    while p42.alive do
        local v43 = p42:wanted();

        if p42.player:GetAttribute("MusicPaused") == true then
            task.wait(0.1);
        elseif v43 == "Halloween" and (p42.themeAttempted or p42.playlist) then
            p42.themeAttempted = true;
            local HalloweenLobby = p42.config.HalloweenLobby;
            local v44 = "rbxassetid://" .. HalloweenLobby.Id;

            if p42.failed[v44] then
                task.wait(p42.config.EmptyRetry);
            else
                local Sound = Instance.new("Sound");
                Sound.Name = "HalloweenLobby";
                Sound.SoundId = v44;
                Sound.Volume = HalloweenLobby.Volume or 0.32;
                p42:play(Sound, false, "Halloween");
                Sound:Destroy();
                task.wait(p42.config.TrackGap);
            end;
        elseif v43 == "Map" then
            p42.themeAttempted = true;
            local v45 = p42:mapTrack();

            if v45 then
                local Sound = Instance.new("Sound");
                Sound.Name = "MapTrack_" .. v45;
                Sound.SoundId = "rbxassetid://" .. v45;
                Sound.Volume = p42.config.MapTrackVolume or 0.32;
                p42:play(Sound, false, "Map");
                Sound:Destroy();
                task.wait(p42.config.TrackGap);
            else
                task.wait(p42.config.EmptyRetry);
            end;
        elseif v43 == "Lobby" or v43 == "Halloween" then
            local v46 = nil;
            local v47 = false;

            if p42.themeAttempted then
                v46 = p42:nextTrack();
            else
                p42.themeAttempted = true;
                v47 = true;

                if usable(p42.theme) then
                    v46 = p42.theme;
                end;
            end;

            if v46 then
                p42:play(v46, v47, v47 and v43 == "Halloween" and "Halloween" or "Lobby");
                task.wait(p42.config.TrackGap);
            else
                task.wait(p42.config.EmptyRetry);
            end;
        else
            task.wait(0.1);
        end;
    end;
end;

function u1.destroy(p48) -- Line: 181
    p48.alive = false;
    p48.generation = p48.generation + 1;

    for _, v in p48.connections do
        v:Disconnect();
    end;

    if p48.muteTween then
        p48.muteTween:Cancel();
    end;

    if p48.fadeIn then
        p48.fadeIn:Cancel();
    end;

    p48.folder:Destroy();
    p48.group:Destroy();
end;

return u1;