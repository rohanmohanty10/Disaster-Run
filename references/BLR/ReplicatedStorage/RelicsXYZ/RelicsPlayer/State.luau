  

local script_Parent = script.Parent;
local Parent = script_Parent.Parent;
local CollectionService = game:GetService("CollectionService");
game:GetService("RunService");
local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local Hooks = script_Parent.Hooks;
local Shared = Parent.Shared;
local Enums = require(script_Parent.Enums);
local Signal = require(Shared.Signal);
local React = require(Shared.React);
local ReactRoblox = require(Shared.ReactRoblox);
local useEffect = React.useEffect;
local useClock = require(Hooks.useClock);
local useTheme = require(Hooks.useTheme);
local useSignal = require(Hooks.useSignal);
local useStatus = require(Hooks.useStatus);
local useTagged = require(Hooks.useTagged);
local useChanged = require(Hooks.useChanged);
local useRestore = require(Hooks.useRestore);
local usePlaylist = require(Hooks.usePlaylist);
local useSettings = require(Hooks.useSettings);
local useFeatures = require(Hooks.useFeatures);
local useFormFactor = require(Hooks.useFormFactor);
local useBoomboxData = require(Hooks.useBoomboxData);
local u1 = require(Parent);
local Auras = require(Shared.Auras);
local RunContext = require(Shared.RunContext);

local function wrapRef(u2: table) -- Line: 116
    return function() -- Line: 117
        -- upvalues: u2 (copy)
        return u2.current;
    end;
end;

local function createPorts() -- Line: 122
    -- upvalues: Signal (copy)
    return {
        SetSong = Signal.new(),
        SetQueue = Signal.new(),
        SetVolume = Signal.new(),
        SetWidget = Signal.new(),
        SetLooped = Signal.new(),
        SetPlaying = Signal.new(),
        SetWindowTab = Signal.new(),
        SetVolumeMod = Signal.new(),
        SetJumpToTime = Signal.new(),
        SetWindowState = Signal.new(),
        SongChanged = Signal.new(),
        QueueChanged = Signal.new(),
        VolumeChanged = Signal.new(),
        LoopedChanged = Signal.new(),
        PlayingChanged = Signal.new(),
        WindowTabChanged = Signal.new(),
        HasBoomboxChanged = Signal.new(),
        WindowStateChanged = Signal.new()
    };
end;

local function getGlobalBoombox() -- Line: 146
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("RELICSxyz Boombox");
    end;

    return Character and {
        Audio = Character:FindFirstChildOfClass("AudioPlayer"),
        Fader = Character:FindFirstChildOfClass("AudioFader")
    } or nil;
end;

local u3 = React.createContext({});

return table.freeze({
    Driver = function(p4: table) -- Line: 211, Name: Driver
        -- upvalues: createPorts (copy), useFormFactor (copy), useBoomboxData (copy), useFeatures (copy), useStatus (copy), useTheme (copy), useSettings (copy), Enums (copy), useRestore (copy), RunContext (copy), useSignal (copy), React (copy), useChanged (copy), LocalPlayer (copy), getGlobalBoombox (copy), u1 (copy), useEffect (copy), useClock (copy), Auras (copy), CollectionService (copy), useTagged (copy), Players (copy), usePlaylist (copy), Signal (copy), u3 (copy), ReactRoblox (copy)
        local v5 = p4.Ports or createPorts();
        local u6 = useFormFactor();
        local v7 = useBoomboxData();
        local u8 = useFeatures();
        local u9 = useStatus();
        local v10 = useTheme();
        local u11 = useSettings();
        local ProximityAudio = u11.ProximityAudio;
        local GlobalMute = u11.GlobalMute;
        local LocalMute = u11.LocalMute;

        if ProximityAudio and (u9 ~= Enums.UserStatus.BoomboxPurchased and u9 ~= Enums.UserStatus.Freemium) then
            ProximityAudio = false;
        end;

        local u12, u13 = useRestore("Playing", not RunContext.IsEdit, v5.PlayingChanged);
        useSignal(v5.SetPlaying, u13);
        v5.Playing = u12;
        local u14, u15 = React.useState(nil);
        useSignal(v5.SetJumpToTime, u15);
        local u16, v17 = useRestore("Volume", 1, v5.VolumeChanged);
        useSignal(v5.SetVolume, v17);
        v5.Volume = u16;
        local u18, v19 = useRestore("Looped", false, v5.LoopedChanged);
        useSignal(v5.SetLooped, v19);
        v5.Looped = u18;
        local u20, v21 = React.useState(nil);
        useSignal(v5.SetWidget, v21);
        local v22, u23 = useRestore("WindowTab", Enums.WindowTab.Play, v5.WindowTabChanged);
        useSignal(v5.SetWindowTab, u23);
        v5.WindowTab = v22;
        local u24, u25 = useChanged({}, v5.QueueChanged);
        useSignal(v5.SetQueue, u25);
        v5.Queue = u24;
        local u26, u27 = useRestore("Song", nil, v5.SongChanged);
        useSignal(v5.SetSong, u27);
        v5.Song = u26;
        local u28, u29 = React.useState({});
        useSignal(v5.SetVolumeMod, function(u30, u31) -- Line: 266
            -- upvalues: u28 (copy), u29 (copy)
            if u28[u30] == u31 then
                return;
            end;

            u29(function(p32) -- Line: 271
                -- upvalues: u30 (copy), u31 (copy)
                local table_clone_ret = table.clone(p32);
                table_clone_ret[u30] = u31;

                return table_clone_ret;
            end);
        end);
        local u33 = React.useRef(nil);
        local u34 = React.useRef(nil);
        local u35 = React.useRef(nil);
        local v36 = React.useRef(nil);
        local v37 = React.useRef(nil);
        local v38 = React.useRef(nil);
        local v39 = React.useRef(nil);
        local v40 = React.useRef(nil);
        local v41 = React.useRef(nil);
        local v42 = React.useRef(nil);
        local v43 = React.useRef(nil);
        local v44 = React.useRef(nil);
        local u45 = React.useRef(LocalPlayer.Character);
        local u46 = React.useRef((getGlobalBoombox()));

        local function getIndex() -- Line: 301
            -- upvalues: u26 (copy), u24 (copy)
            local v47 = u26 and table.find(u24, u26);

            return v47;
        end;

        local function goBack() -- Line: 305
            -- upvalues: u34 (copy), u26 (copy), u1 (ref), u24 (copy), u27 (copy)
            local current = u34.current;

            if not u26 then
                return;
            end;

            if current and current.TimePosition > 5 then
                current.TimePosition = 0;
                u1.FireServer("SetTime", 0);

                return;
            end;

            local v48 = u26 and table.find(u24, u26);
            local v49 = v48 or 1;
            local v50;

            if v49 <= 1 then
                v50 = #u24;
            else
                v50 = #u24 < v49 and 1 or v49 - 1;
            end;

            u27(u24[v50]);
        end;

        local function goForward() -- Line: 332
            -- upvalues: u26 (copy), u24 (copy), u27 (copy)
            local v51 = u26 and table.find(u24, u26);
            local v52 = v51 or 0;
            local v53;

            if #u24 <= v52 then
                v53 = 1;
            elseif v52 < 1 then
                v53 = #u24;
            else
                v53 = v52 + 1;
            end;

            u27(u24[v53]);
        end;

        useEffect(function() -- Line: 347
            -- upvalues: u34 (copy), u33 (copy), u16 (copy), LocalMute (copy), ProximityAudio (ref), GlobalMute (copy), u28 (copy), u1 (ref)
            local current = u33.current;

            if u34.current and current then
                local v54 = 1;

                for _, v in pairs(u28) do
                    v54 = v54 * v;
                end;

                current.Volume = ((LocalMute or ProximityAudio and not GlobalMute) and 0 or u16) * v54;
                u1.FireServer("SetVolume", u16 * v54);
            end;
        end, {
            u16,
            ProximityAudio,
            LocalMute,
            u28,
            GlobalMute
        });
        useEffect(function() -- Line: 375
            -- upvalues: u14 (copy), u34 (copy), u1 (ref), u15 (copy)
            if u14 then
                local current = u34.current;

                if current then
                    current.TimePosition = u14;
                end;

                u1.FireServer("SetTime", u14);
                u15(nil);
            end;
        end, { ProximityAudio, u14 });
        useClock(30, function() -- Line: 392
            -- upvalues: LocalPlayer (ref), u45 (copy), u46 (copy), getGlobalBoombox (ref), u34 (copy), u33 (copy), ProximityAudio (ref), u1 (ref), GlobalMute (copy), LocalMute (copy), u16 (copy), u12 (copy)
            local Character = LocalPlayer.Character;

            if Character ~= u45.current then
                u45.current = Character;
                u46.current = getGlobalBoombox();
            end;

            if not u46.current then
                u46.current = getGlobalBoombox();
            end;

            local current = u46.current;
            local v55;

            if current then
                v55 = current.Audio;
            else
                v55 = current;
            end;

            if current then
                current = current.Fader;
            end;

            local current2 = u34.current;
            local current3 = u33.current;

            if ProximityAudio and (current2 and current3) then
                if v55 and current then
                    local TimePosition = current2.TimePosition;
                    local math_abs_ret = math.abs(v55.TimePosition - TimePosition);

                    if math_abs_ret > 0.2 then
                        u1.FireServer("SetTime", TimePosition + 0.1);
                    end;

                    if math_abs_ret > 0 then
                        v55.TimePosition = TimePosition;
                    end;

                    if GlobalMute or LocalMute then
                        current.Volume = 0;
                    elseif current.Volume ~= u16 then
                        current.Volume = u16;
                        u1.FireServer("SetVolume", u16);
                    end;

                    if v55.AssetId ~= current2.AssetId then
                        v55.AssetId = current2.AssetId;
                        u1.FireServer("SetSong", current2.AssetId);
                    end;

                    if v55.IsPlaying ~= u12 then
                        if u12 then
                            v55:Play();
                        else
                            v55:Stop();
                        end;

                        u1.FireServer("SetPlaying", u12);
                    end;
                else
                    u1.FireServer("SetSong", current2.AssetId);
                    u1.FireServer("SetVolume", current3.Volume);
                    u1.FireServer("SetTime", current2.TimePosition);
                    u1.FireServer("SetPlaying", current2.IsPlaying);
                end;
            end;
        end, {
            ProximityAudio,
            GlobalMute,
            LocalMute,
            u16,
            u12
        });
        useClock(20, function(p56) -- Line: 465
            -- upvalues: Auras (ref), u11 (copy)
            Auras.Update(u11.AuraToggle, p56);
        end, { u11 });
        useEffect(function() -- Line: 470
            -- upvalues: LocalPlayer (ref), CollectionService (ref)
            local u57 = {};
            local u58 = 0;
            task.spawn(function() -- Line: 486
                -- upvalues: u58 (ref), LocalPlayer (ref), u57 (copy)
                while task.wait(0.025) do
                    local os_clock_ret = os.clock();
                    local math_sin_ret = math.sin(os_clock_ret);
                    local v59 = os_clock_ret - u58 > 0.5;
                    local Character = LocalPlayer.Character;
                    local v60 = CFrame.Angles(0, os_clock_ret % 6.28, 0) * CFrame.new(0, math_sin_ret / 8, 0);
                    local v61 = false;

                    for i in u57 do
                        v61 = v59 and not (v61 or (not Character or (i.WorldPosition - Character:GetPivot().Position).Magnitude >= 16)) and true or v61;
                        i.Transform = v60;
                    end;

                    if v59 then
                        LocalPlayer:SetAttribute("RelicsTrial", v61 and true or nil);
                        u58 = os_clock_ret;
                    end;
                end;
            end);

            local function onBoneAdded(p62: userdata) -- Line: 474
                -- upvalues: u57 (copy)
                if p62:IsA("Bone") then
                    u57[p62] = true;
                end;
            end;

            local function onBoneRemoved(p63: userdata) -- Line: 480
                -- upvalues: u57 (copy)
                if p63:IsA("Bone") then
                    u57[p63] = nil;
                end;
            end;

            for _, v in CollectionService:GetTagged("RelicsTrialMount") do
                if v:IsA("Bone") then
                    u57[v] = true;
                end;
            end;

            CollectionService:GetInstanceAddedSignal("RelicsTrialMount"):Connect(onBoneAdded);
            CollectionService:GetInstanceRemovedSignal("RelicsTrialMount"):Connect(onBoneRemoved);
        end, {});
        local u64 = React.useRef(nil);
        local u65 = useTagged("RelicsPlaylist");
        local v66 = u64.current ~= nil;

        if not v66 then
            table.sort(u65, function(p67, p68) -- Line: 539
                -- upvalues: u9 (copy), Enums (ref)
                local v69 = p67:GetAttribute("IsFree") and true or false;
                local v70 = p68:GetAttribute("IsFree") and true or false;

                if v69 == v70 then
                    return p67.Name < p68.Name;
                end;

                if u9 == Enums.UserStatus.BoomboxPurchased then
                    return v70;
                end;

                return v69;
            end);

            for _, v in u65 do
                local v71 = v:FindFirstAncestorOfClass("Player");

                if v71 == nil or v71 == Players.LocalPlayer then
                    u64.current = v;
                    break;
                end;
            end;
        end;

        local u72 = usePlaylist(u64.current);
        React.useEffect(function() -- Line: 567
            -- upvalues: u64 (copy), u72 (copy), u27 (copy), u25 (copy)
            if u64.current and u72 then
                local Songs = u72.Songs;
                u27(Songs[1]);
                u25(Songs);
            end;
        end, { v66 });
        local u74, u75 = useRestore("WindowState", function() -- Line: 575
            -- upvalues: u8 (copy), RunContext (ref), Enums (ref), u6 (copy), u9 (copy), u65 (copy), Players (ref)
            if not u8.StartActive then
                if RunContext.IsEdit then
                    return Enums.WindowState.Full;
                end;

                return Enums.WindowState.Hidden;
            end;

            local Full = Enums.WindowState.Full;

            if u6 == "Phone" then
                Full = Enums.WindowState.Compact;
            end;

            if u9 == Enums.UserStatus.BoomboxPurchased then
                return Full;
            end;

            for _, v in u65 do
                local v73 = v:FindFirstAncestorOfClass("Player");

                if (v73 == nil or v73 == Players.LocalPlayer) and v:GetAttribute("IsFree") then
                    return Full;
                end;
            end;

            return Enums.WindowState.Hidden;
        end, v5.WindowStateChanged);

        if u74 == Enums.WindowState.Hidden and RunContext.IsEdit then
            warn("cannot hide window in edit mode!");
            u75(Enums.WindowState.Full);
        end;

        React.useEffect(function() -- Line: 619
            -- upvalues: u9 (copy), Enums (ref), u75 (copy), u23 (copy), u13 (copy)
            if u9 == Enums.UserStatus.TryBeforeBuy then
                u75(Enums.WindowState.Full);
                u23(Enums.WindowTab.Upsell);
                u13(true);
            end;
        end, { u9 });
        React.useEffect(function() -- Line: 628
            -- upvalues: u34 (copy), u74 (copy), Enums (ref), u9 (copy), u13 (copy), u26 (copy), u1 (ref), u12 (copy), u18 (copy), u15 (copy), u24 (copy), u27 (copy), ProximityAudio (ref)
            local current = u34.current;

            if current then
                if u74 == Enums.WindowState.Hidden and u9 == Enums.UserStatus.TrialExpired then
                    u13(false);
                end;

                if current.AssetId ~= u26 then
                    current.TimePosition = 0;
                    current.AssetId = u26 or "";
                    u1.FireServer("SetTime", 0);
                    u1.FireServer("SetSong", u26);
                end;

                if u12 and not current.IsPlaying then
                    current:Play();
                elseif not u12 and current.IsPlaying then
                    current:Stop();
                end;

                local u79 = current.Ended:Connect(function() -- Line: 656
                    -- upvalues: u18 (ref), u15 (ref), u13 (ref), u26 (ref), u24 (ref), u27 (ref)
                    if u18 then
                        u15(0);
                        u13(true);

                        return;
                    end;

                    local v76 = u26 and table.find(u24, u26);
                    local v77 = v76 or 0;
                    local v78;

                    if #u24 <= v77 then
                        v78 = 1;
                    elseif v77 < 1 then
                        v78 = #u24;
                    else
                        v78 = v77 + 1;
                    end;

                    u27(u24[v78]);
                end);
                local v80;

                if ProximityAudio then
                    v80 = u12;
                else
                    v80 = false;
                end;

                u1.FireServer("SetPlaying", v80);

                return function() -- Line: 668
                    -- upvalues: u79 (copy)
                    u79:Disconnect();
                end;
            end;
        end, {
            u26,
            u24,
            u18,
            u12,
            ProximityAudio,
            u14,
            u74
        });
        local v81, v82 = useRestore("Position", nil);
        local v83, v84 = useChanged(false, v5.HasBoomboxChanged);
        v5.HasBoombox = v83;
        v5.WindowState = u74;
        v84(u9 == Enums.UserStatus.BoomboxPurchased and true or u9 == Enums.UserStatus.Freemium);
        useSignal(v5.SetWindowState, u75);
        local v85 = {
            Ports = v5,
            Status = u9,
            Theme = v10,
            Features = u8,
            Boombox = v7,

            GetAudioPlayer = function() -- Line: 117
                -- upvalues: u34 (copy)
                return u34.current;
            end,

            GetSpectrogram = function() -- Line: 117
                -- upvalues: u35 (copy)
                return u35.current;
            end,

            GoBack = goBack,
            GoForward = goForward,
            Playing = u12,
            SetPlaying = u13,
            Volume = u16,
            SetVolume = v17,
            Looped = u18,
            SetLooped = v19,
            Widget = u20,
            SetWidget = v21,
            WindowTab = v22,
            SetWindowTab = u23,
            WindowState = u74,
            SetWindowState = u75,
            Queue = u24,
            SetQueue = u25,
            Song = u26,
            SetSong = u27,
            Position = v81,
            SetPosition = v82,
            JumpToTime = u14,
            SetJumpToTime = u15,

            WidgetReturn = function() -- Line: 736, Name: WidgetReturn
                -- upvalues: u20 (copy)
                if u20 and u20.ReturnFunc then
                    u20.ReturnFunc();
                end;
            end,

            ReturnEvent = React.useState(Signal.new)
        };
        local createElement = React.createElement;
        local Provider = u3.Provider;
        local v86 = {
            value = v85
        };
        local children = p4.children;
        local v87 = {
            Turntable = React.createElement("Folder", {}, {
                Music = React.createElement("AudioPlayer", {
                    [React.Tag] = "RelicsClientAudioPlayer",
                    ref = u34
                }),
                Volume = React.createElement("AudioFader", {
                    ref = u33
                }),
                Spectrogram = React.createElement("AudioAnalyzer", {
                    ref = u35
                }),
                Output = React.createElement("AudioDeviceOutput", {
                    ref = v36
                }),
                Bass = React.createElement("AudioAnalyzer", {
                    [React.Tag] = "RelicsAudioAnalyzer_Bass",
                    SpectrumEnabled = false,
                    ref = v40
                }, {
                    BassFilter = React.createElement("AudioEqualizer", {
                        HighGain = -80,
                        LowGain = 10,
                        MidGain = -80,
                        MidRange = NumberRange.new(320.78, 1287.02),
                        ref = v39
                    })
                }),
                Treble = React.createElement("AudioAnalyzer", {
                    [React.Tag] = "RelicsAudioAnalyzer_Treble",
                    SpectrumEnabled = false,
                    ref = v42
                }, {
                    TrebleFilter = React.createElement("AudioEqualizer", {
                        HighGain = -80,
                        LowGain = -80,
                        MidGain = 10,
                        MidRange = NumberRange.new(1000, 4000),
                        ref = v41
                    })
                }),
                Percussion = React.createElement("AudioAnalyzer", {
                    [React.Tag] = "RelicsAudioAnalyzer_Percussion",
                    SpectrumEnabled = false,
                    ref = v44
                }, {
                    PercussionFilter = React.createElement("AudioEqualizer", {
                        HighGain = -80,
                        LowGain = -80,
                        MidGain = 5,
                        MidRange = NumberRange.new(6000, 20000),
                        ref = v43
                    })
                }),
                Wiring = React.createElement("Folder", nil, {
                    MusicToVolume = React.createElement("Wire", {
                        SourceInstance = u34,
                        TargetInstance = u33
                    }),
                    VolumeToOutput = React.createElement("Wire", {
                        SourceInstance = u33,
                        TargetInstance = v36
                    }),
                    MusicToSpectrogram = React.createElement("Wire", {
                        SourceInstance = u34,
                        TargetInstance = u35
                    }),
                    MusicToBassFilter = React.createElement("Wire", {
                        SourceInstance = u34,
                        TargetInstance = v39
                    }),
                    BassFilterToBass = React.createElement("Wire", {
                        SourceInstance = v39,
                        TargetInstance = v40
                    }),
                    MusicToTrebleFilter = React.createElement("Wire", {
                        SourceInstance = u34,
                        TargetInstance = v41
                    }),
                    TrebleFilterToTreble = React.createElement("Wire", {
                        SourceInstance = v41,
                        TargetInstance = v42
                    }),
                    MusicToPercussionFilter = React.createElement("Wire", {
                        SourceInstance = u34,
                        TargetInstance = v43
                    }),
                    PercussionFilterToPercussion = React.createElement("Wire", {
                        SourceInstance = v43,
                        TargetInstance = v44
                    })
                })
            })
        };
        local v88 = not GlobalMute and ReactRoblox.createPortal({
            RELICSxyz_Listener = React.createElement("AudioListener", {
                AudioInteractionGroup = "RELICSxyz",
                ref = v37
            }, {
                ListenerToOutput = React.createElement("Wire", {
                    SourceInstance = v37,
                    TargetInstance = v38
                })
            }),
            RELICSxyz_Output = React.createElement("AudioDeviceOutput", {
                ref = v38
            })
        }, workspace.CurrentCamera);
        v87.Global = v88;

        return createElement(Provider, v86, children, v87);
    end,

    Context = u3,
    CreatePorts = createPorts
});