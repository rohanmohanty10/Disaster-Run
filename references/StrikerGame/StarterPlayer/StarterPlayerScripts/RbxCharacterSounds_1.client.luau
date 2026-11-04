 
 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local SoundService = game:GetService("SoundService");
local AtomicBinding = require(script:WaitForChild("AtomicBinding"));

local function loadFlag(u1: string) -- Line: 12
    local success, result = pcall(function() -- Line: 13
        -- upvalues: u1 (copy)
        return UserSettings():IsUserFeatureEnabled(u1);
    end);

    return success and result;
end;

local u2 = "UserSoundsUseRelativeVelocity2";
local success, result = pcall(function() -- Line: 13
    -- upvalues: u2 (copy)
    return UserSettings():IsUserFeatureEnabled(u2);
end);
local u3 = success and result;
local u4 = "UserNewCharacterSoundsApi3";
local success2, result2 = pcall(function() -- Line: 13
    -- upvalues: u4 (copy)
    return UserSettings():IsUserFeatureEnabled(u4);
end);
local u5 = success2 and result2;
local u6 = "UserFixCharSoundsEmitters";
local success3, result3 = pcall(function() -- Line: 13
    -- upvalues: u6 (copy)
    return UserSettings():IsUserFeatureEnabled(u6);
end);
local u7 = success3 and result3;
local u8 = "UserFixCharSoundsEmitterRootPart";
local success4, result4 = pcall(function() -- Line: 13
    -- upvalues: u8 (copy)
    return UserSettings():IsUserFeatureEnabled(u8);
end);
local u9 = success4 and result4;
local u10 = {
    Climbing = {
        SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3",
        Looped = true
    },
    Died = {
        SoundId = "rbxasset://sounds/uuhhh.mp3"
    },
    FreeFalling = {
        SoundId = "rbxasset://sounds/action_falling.ogg",
        Looped = true
    },
    GettingUp = {
        SoundId = "rbxasset://sounds/action_get_up.mp3"
    },
    Jumping = {
        SoundId = "rbxasset://sounds/action_jump.mp3"
    },
    Landing = {
        SoundId = "rbxasset://sounds/action_jump_land.mp3"
    },
    Running = {
        SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3",
        Looped = true,
        Pitch = 1.85
    },
    Splash = {
        SoundId = "rbxasset://sounds/impact_water.mp3"
    },
    Swimming = {
        SoundId = "rbxasset://sounds/action_swim.mp3",
        Looped = true,
        Pitch = 1.6
    }
};
local u11 = {
    Climbing = {
        AssetId = "rbxasset://sounds/action_footsteps_plastic.mp3",
        Looping = true
    },
    Died = {
        AssetId = "rbxasset://sounds/uuhhh.mp3"
    },
    FreeFalling = {
        AssetId = "rbxasset://sounds/action_falling.ogg",
        Looping = true
    },
    GettingUp = {
        AssetId = "rbxasset://sounds/action_get_up.mp3"
    },
    Jumping = {
        AssetId = "rbxasset://sounds/action_jump.mp3"
    },
    Landing = {
        AssetId = "rbxasset://sounds/action_jump_land.mp3"
    },
    Running = {
        AssetId = "rbxasset://sounds/action_footsteps_plastic.mp3",
        Looping = true,
        PlaybackSpeed = 1.85
    },
    Splash = {
        AssetId = "rbxasset://sounds/impact_water.mp3"
    },
    Swimming = {
        AssetId = "rbxasset://sounds/action_swim.mp3",
        Looping = true,
        PlaybackSpeed = 1.6
    }
};

local function map(p12: number, p13: number, p14: number, p15: number, p16: number) -- Line: 97
    return (p12 - p13) * (p16 - p15) / (p14 - p13) + p15;
end;

local function getRelativeVelocity(p17, p18) -- Line: 101
    if not p17 then
        return p18;
    end;

    local v19 = p17.ActiveController and (p17.ActiveController:IsA("GroundController") and p17.GroundSensor or p17.ActiveController:IsA("ClimbController") and p17.ClimbSensor);

    if v19 and v19.SensedPart then
        return p18 - v19.SensedPart:GetVelocityAtPosition(p17.RootPart.Position);
    end;

    return p18;
end;

local function playSound(p20: userdata, p21: boolean?) -- Line: 118
    -- upvalues: u5 (copy)
    if not p21 then
        p20.TimePosition = 0;
    end;

    if u5 and p20:IsA("AudioPlayer") then
        p20:Play();

        return;
    end;

    p20.Playing = true;
end;

local function stopSound(p22: userdata) -- Line: 129
    -- upvalues: u5 (copy)
    if u5 and p22:IsA("AudioPlayer") then
        p22:Stop();

        return;
    end;

    p22.Playing = false;
end;

local function playSoundIf(p23: userdata, p24: boolean) -- Line: 137
    -- upvalues: u5 (copy)
    if u5 and p23:IsA("AudioPlayer") then
        if p23.IsPlaying and not p24 then
            p23:Stop();

            return;
        end;

        if not p23.IsPlaying and p24 then
            p23:Play();
        end;
    else
        p23.Playing = p24;
    end;
end;

local function setSoundLooped(p25: userdata, p26: boolean) -- Line: 149
    -- upvalues: u5 (copy)
    if u5 and p25:IsA("AudioPlayer") then
        p25.Looping = p26;

        return;
    end;

    p25.Looped = p26;
end;

local function shallowCopy(p27) -- Line: 157
    local v28 = {};

    for i, v in pairs(p27) do
        v28[i] = v;
    end;

    return v28;
end;

local u69 = AtomicBinding.new({
    humanoid = "Humanoid",
    rootPart = "HumanoidRootPart"
}, function(p29: table) -- Line: 165, Name: initializeSoundSystem
    -- upvalues: u3 (copy), u5 (copy), SoundService (copy), u7 (copy), u9 (copy), Players (copy), u11 (copy), u10 (copy), getRelativeVelocity (copy), RunService (copy)
    local humanoid = p29.humanoid;
    local rootPart = p29.rootPart;
    local u30 = nil;
    local u31;

    if u3 then
        u31 = humanoid.Parent:FindFirstChild("ControllerManager");
    else
        u31 = nil;
    end;

    local u32 = {};

    if u5 and SoundService.CharacterSoundsUseNewApi == Enum.RolloutState.Enabled then
        local v33 = nil;
        local v34 = nil;

        if u7 then
            if u9 then
                v34 = humanoid.RootPart or humanoid.Parent;
            else
                v34 = humanoid.RootPart;
            end;
        else
            v33 = Players.LocalPlayer.Character;
        end;

        local v35 = 5;
        local v36 = {};

        while v35 < 150 do
            v36[v35] = 5 / v35;
            v35 = v35 * 1.25;
        end;

        v36[150] = 0;

        if u7 then
            u30 = Instance.new("AudioEmitter", v34);
        else
            u30 = Instance.new("AudioEmitter", v33);
        end;

        u30.Name = "RbxCharacterSoundsEmitter";
        u30:SetDistanceAttenuation(v36);

        for i, v in pairs(u11) do
            local AudioPlayer = Instance.new("AudioPlayer");
            local Wire = Instance.new("Wire");
            AudioPlayer.Name = i;
            Wire.Name = i .. "Wire";
            AudioPlayer.Archivable = false;
            AudioPlayer.Volume = 0.65;

            for i2, v2 in pairs(v) do
                AudioPlayer[i2] = v2;
            end;

            AudioPlayer.Parent = rootPart;
            Wire.Parent = AudioPlayer;
            Wire.SourceInstance = AudioPlayer;
            Wire.TargetInstance = u30;
            u32[i] = AudioPlayer;
        end;
    else
        for i, v in pairs(u10) do
            local Sound = Instance.new("Sound");
            Sound.Name = i;
            Sound.Archivable = false;
            Sound.RollOffMinDistance = 5;
            Sound.RollOffMaxDistance = 150;
            Sound.Volume = 0.65;

            for i2, v2 in pairs(v) do
                Sound[i2] = v2;
            end;

            Sound.Parent = rootPart;
            u32[i] = Sound;
        end;
    end;

    local u37 = {};

    local function stopPlayingLoopedSounds(p38: userdata?) -- Line: 241
        -- upvalues: u37 (copy), u5 (ref)
        local l_pairs = pairs;
        local v39 = {};
        local v40 = p38 or nil;

        for i, v in pairs(u37) do
            v39[i] = v;
        end;

        for i in l_pairs(v39) do
            if i ~= v40 then
                if u5 and i:IsA("AudioPlayer") then
                    i:Stop();
                else
                    i.Playing = false;
                end;

                u37[i] = nil;
            end;
        end;
    end;

    local u41 = {
        [Enum.HumanoidStateType.FallingDown] = function() -- Line: 253
            -- upvalues: stopPlayingLoopedSounds (copy)
            stopPlayingLoopedSounds();
        end,

        [Enum.HumanoidStateType.GettingUp] = function() -- Line: 257
            -- upvalues: stopPlayingLoopedSounds (copy), u32 (copy), u5 (ref)
            stopPlayingLoopedSounds();
            local GettingUp = u32.GettingUp;
            GettingUp.TimePosition = 0;

            if u5 and GettingUp:IsA("AudioPlayer") then
                GettingUp:Play();

                return;
            end;

            GettingUp.Playing = true;
        end,

        [Enum.HumanoidStateType.Jumping] = function() -- Line: 262
            -- upvalues: stopPlayingLoopedSounds (copy), u32 (copy), u5 (ref)
            stopPlayingLoopedSounds();
            local Jumping = u32.Jumping;
            Jumping.TimePosition = 0;

            if u5 and Jumping:IsA("AudioPlayer") then
                Jumping:Play();

                return;
            end;

            Jumping.Playing = true;
        end,

        [Enum.HumanoidStateType.Swimming] = function() -- Line: 267
            -- upvalues: rootPart (copy), u32 (copy), u5 (ref), stopPlayingLoopedSounds (copy), u37 (copy)
            local math_abs_ret = math.abs(rootPart.AssemblyLinearVelocity.Y);

            if math_abs_ret > 0.1 then
                u32.Splash.Volume = math.clamp((math_abs_ret - 100) * 0.72 / 250 + 0.28, 0, 1);
                local Splash = u32.Splash;
                Splash.TimePosition = 0;

                if u5 and Splash:IsA("AudioPlayer") then
                    Splash:Play();
                else
                    Splash.Playing = true;
                end;
            end;

            stopPlayingLoopedSounds(u32.Swimming);
            local Swimming = u32.Swimming;

            if u5 and Swimming:IsA("AudioPlayer") then
                Swimming:Play();
            else
                Swimming.Playing = true;
            end;

            u37[u32.Swimming] = true;
        end,

        [Enum.HumanoidStateType.Freefall] = function() -- Line: 278
            -- upvalues: u32 (copy), stopPlayingLoopedSounds (copy), u5 (ref), u37 (copy)
            u32.FreeFalling.Volume = 0;
            stopPlayingLoopedSounds(u32.FreeFalling);
            local FreeFalling = u32.FreeFalling;

            if u5 and FreeFalling:IsA("AudioPlayer") then
                FreeFalling.Looping = true;
            else
                FreeFalling.Looped = true;
            end;

            if u32.FreeFalling:IsA("Sound") then
                u32.FreeFalling.PlaybackRegionsEnabled = true;
            end;

            u32.FreeFalling.LoopRegion = NumberRange.new(2, 9);
            local FreeFalling2 = u32.FreeFalling;
            FreeFalling2.TimePosition = 0;

            if u5 and FreeFalling2:IsA("AudioPlayer") then
                FreeFalling2:Play();
            else
                FreeFalling2.Playing = true;
            end;

            u37[u32.FreeFalling] = true;
        end,

        [Enum.HumanoidStateType.Landed] = function() -- Line: 292
            -- upvalues: stopPlayingLoopedSounds (copy), rootPart (copy), u32 (copy), u5 (ref)
            stopPlayingLoopedSounds();
            local math_abs_ret = math.abs(rootPart.AssemblyLinearVelocity.Y);

            if math_abs_ret > 75 then
                u32.Landing.Volume = math.clamp((math_abs_ret - 50) * 1 / 50 + 0, 0, 1);
                local Landing = u32.Landing;
                Landing.TimePosition = 0;

                if u5 and Landing:IsA("AudioPlayer") then
                    Landing:Play();

                    return;
                end;

                Landing.Playing = true;
            end;
        end,

        [Enum.HumanoidStateType.Running] = function() -- Line: 301
            -- upvalues: stopPlayingLoopedSounds (copy), u32 (copy), u5 (ref), u37 (copy)
            stopPlayingLoopedSounds(u32.Running);
            local Running = u32.Running;

            if u5 and Running:IsA("AudioPlayer") then
                Running:Play();
            else
                Running.Playing = true;
            end;

            u37[u32.Running] = true;
        end,

        [Enum.HumanoidStateType.Climbing] = function() -- Line: 307
            -- upvalues: u32 (copy), rootPart (copy), u3 (ref), getRelativeVelocity (ref), u31 (ref), u5 (ref), stopPlayingLoopedSounds (copy), u37 (copy)
            local Climbing = u32.Climbing;
            local AssemblyLinearVelocity = rootPart.AssemblyLinearVelocity;

            if u3 then
                AssemblyLinearVelocity = getRelativeVelocity(u31, AssemblyLinearVelocity);
            end;

            if math.abs(AssemblyLinearVelocity.Y) > 0.1 then
                if u5 and Climbing:IsA("AudioPlayer") then
                    Climbing:Play();
                else
                    Climbing.Playing = true;
                end;

                stopPlayingLoopedSounds(Climbing);
            else
                stopPlayingLoopedSounds();
            end;

            u37[Climbing] = true;
        end,

        [Enum.HumanoidStateType.Seated] = function() -- Line: 320
            -- upvalues: stopPlayingLoopedSounds (copy)
            stopPlayingLoopedSounds();
        end,

        [Enum.HumanoidStateType.Dead] = function() -- Line: 324
            -- upvalues: stopPlayingLoopedSounds (copy), u32 (copy), u5 (ref)
            stopPlayingLoopedSounds();
            local Died = u32.Died;
            Died.TimePosition = 0;

            if u5 and Died:IsA("AudioPlayer") then
                Died:Play();

                return;
            end;

            Died.Playing = true;
        end
    };
    local u53 = {
        [u32.Climbing] = function(p42: number, p43: userdata, p44: vector) -- Line: 332
            -- upvalues: u3 (ref), getRelativeVelocity (ref), u31 (ref), u5 (ref)
            if u3 then
                p44 = getRelativeVelocity(u31, p44);
            end;

            local v45 = p44.Magnitude > 0.1;

            if u5 and p43:IsA("AudioPlayer") then
                if p43.IsPlaying and not v45 then
                    p43:Stop();

                    return;
                end;

                if not p43.IsPlaying and v45 then
                    p43:Play();
                end;
            else
                p43.Playing = v45;
            end;
        end,

        [u32.FreeFalling] = function(p46: number, p47: userdata, p48: vector) -- Line: 337
            if p48.Magnitude > 75 then
                p47.Volume = math.clamp(p47.Volume + p46 * 0.9, 0, 1);

                return;
            end;

            p47.Volume = 0;
        end,

        [u32.Running] = function(p49: number, p50: userdata, p51: vector) -- Line: 345
            -- upvalues: humanoid (copy), u5 (ref)
            local v52;

            if p51.Magnitude > 0.5 then
                v52 = humanoid.MoveDirection.Magnitude > 0.5;
            else
                v52 = false;
            end;

            if u5 and p50:IsA("AudioPlayer") then
                if p50.IsPlaying and not v52 then
                    p50:Stop();

                    return;
                end;

                if not p50.IsPlaying and v52 then
                    p50:Play();
                end;
            else
                p50.Playing = v52;
            end;
        end
    };
    local u54 = {
        [Enum.HumanoidStateType.RunningNoPhysics] = Enum.HumanoidStateType.Running
    };
    local u55 = u54[humanoid:GetState()] or humanoid:GetState();

    local function transitionTo(p56) -- Line: 357
        -- upvalues: u41 (copy), u55 (ref)
        local v57 = u41[p56];

        if v57 then
            v57();
        end;

        u55 = p56;
    end;

    local v58 = u55;
    local v59 = u41[v58];

    if v59 then
        v59();
    end;

    u55 = v58;
    local u64 = humanoid.StateChanged:Connect(function(p60, p61) -- Line: 369
        -- upvalues: u54 (copy), u55 (ref), u41 (copy)
        local v62 = u54[p61] or p61;

        if v62 ~= u55 then
            local v63 = u41[v62];

            if v63 then
                v63();
            end;

            u55 = v62;
        end;
    end);
    local u68 = RunService.Stepped:Connect(function(p65: any, p66: number) -- Line: 377
        -- upvalues: u37 (copy), u53 (copy), rootPart (copy)
        for i in pairs(u37) do
            local v67 = u53[i];

            if v67 then
                v67(p66, i, rootPart.AssemblyLinearVelocity);
            end;
        end;
    end);

    return function() -- Line: 388, Name: terminate
        -- upvalues: u64 (copy), u68 (copy), u9 (ref), u30 (ref), u32 (copy)
        u64:Disconnect();
        u68:Disconnect();

        if u9 and u30 then
            u30:Destroy();
        end;

        for _, v in pairs(u32) do
            v:Destroy();
        end;

        table.clear(u32);
    end;
end);
local u70 = {};

local function characterAdded(p71) -- Line: 415
    -- upvalues: u69 (copy)
    u69:bindRoot(p71);
end;

local function characterRemoving(p72) -- Line: 419
    -- upvalues: u69 (copy)
    u69:unbindRoot(p72);
end;

local function playerAdded(p73: userdata) -- Line: 423
    -- upvalues: u70 (copy), u69 (copy), characterAdded (copy), characterRemoving (copy)
    local v74 = u70[p73];

    if not v74 then
        v74 = {};
        u70[p73] = v74;
    end;

    if p73.Character then
        u69:bindRoot(p73.Character);
    end;

    table.insert(v74, p73.CharacterAdded:Connect(characterAdded));
    table.insert(v74, p73.CharacterRemoving:Connect(characterRemoving));
end;

local function playerRemoving(p75: userdata) -- Line: 437
    -- upvalues: u70 (copy), u69 (copy)
    local v76 = u70[p75];

    if v76 then
        for _, v in ipairs(v76) do
            v:Disconnect();
        end;

        u70[p75] = nil;
    end;

    if p75.Character then
        u69:unbindRoot(p75.Character);
    end;
end;

for _, v in ipairs(Players:GetPlayers()) do
    task.spawn(playerAdded, v);
end;

Players.PlayerAdded:Connect(playerAdded);
Players.PlayerRemoving:Connect(playerRemoving);