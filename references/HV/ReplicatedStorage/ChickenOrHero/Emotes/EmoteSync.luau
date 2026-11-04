 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local EmoteCatalog = require(script.Parent.EmoteCatalog);
local u1 = {};
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = false;
local u6 = nil;
local u7 = false;
local u8 = 1;
local u9 = 1;
local u10 = 1;
local u11 = 1;

local function settingsLevel() -- Line: 37
    -- upvalues: Players (copy)
    local LocalPlayer = Players.LocalPlayer;

    if LocalPlayer:GetAttribute("MusicMuted") == true then
        return 0, 0;
    end;

    local Attribute = LocalPlayer:GetAttribute("EmoteVolume");
    local v12 = (type(Attribute) ~= "number" or Attribute ~= Attribute) and 1 or math.clamp(Attribute, 0, 1);

    if LocalPlayer:GetAttribute("EmoteSoundsMuted") == true then
        return v12, 0;
    end;

    return v12, v12;
end;

local function mine(p13) -- Line: 47
    -- upvalues: Players (copy)
    local Character = Players.LocalPlayer.Character;
    local v14;

    if Character == nil then
        v14 = false;
    else
        v14 = p13:IsDescendantOf(Character);
    end;

    return v14;
end;

local function levelFor(p15) -- Line: 51
    -- upvalues: Players (copy), u8 (ref), u9 (ref)
    local Character = Players.LocalPlayer.Character;
    local v16;

    if Character == nil then
        v16 = false;
    else
        v16 = p15:IsDescendantOf(Character);
    end;

    if v16 then
        return u8;
    end;

    return u9;
end;

local function emoteTrack(p17, p18) -- Line: 55
    -- upvalues: EmoteCatalog (copy)
    local v19 = p17:FindFirstChildOfClass("Humanoid");

    if v19 then
        v19 = v19:FindFirstChildOfClass("Animator");
    end;

    if not v19 then
        return nil;
    end;

    local v20 = EmoteCatalog.assetId(p18);
    local v21 = "ValleyEmote_" .. p18;

    for _, v in v19:GetPlayingAnimationTracks() do
        local Animation = v.Animation;

        if v.Name == v21 or v20 and (Animation and Animation.AnimationId == v20) then
            return v;
        end;
    end;

    return nil;
end;

local function register(p22) -- Line: 73
    -- upvalues: u2 (copy)
    if not u2[p22] then
        local Attribute = p22:GetAttribute("EmoteBaseVolume");

        if type(Attribute) ~= "number" then
            Attribute = p22.Volume;
            p22:SetAttribute("EmoteBaseVolume", Attribute);
        end;

        u2[p22] = {
            gain = 0,
            target = 0,
            base = Attribute
        };
        p22.Volume = 0;
    end;
end;

local function registerExtra(p23, p24) -- Line: 86
    -- upvalues: u3 (copy)
    if not u3[p23] then
        local Attribute = p23:GetAttribute("EmoteBaseVolume");

        if type(Attribute) ~= "number" then
            Attribute = p23.Volume;
            p23:SetAttribute("EmoteBaseVolume", Attribute);
        end;

        u3[p23] = {
            base = Attribute,
            root = p24
        };
        p23.Volume = 0;
    end;
end;

function u1.group(p25) -- Line: 99
    for _, v in p25 do
        v.leader = nil;
    end;

    local v26 = {};

    for _, v in p25 do
        if not v.leader then
            table.clear(v26);
            v26[1] = v;
            v.leader = v;
            local v27 = v;
            local v28 = v27;
            local v29 = v27;
            v27 = v28;
            v29 = v28;
            local v30 = 1;

            while v26[v30] do
                local v31 = v26[v30];
                v30 = v30 + 1;

                if v31.at < v28.at or v31.at == v28.at and v31.user < v28.user then
                    v28 = v31;
                end;

                for _, v2 in p25 do
                    if not (v2.leader or (v2.id ~= v31.id or (v2.position - v31.position).Magnitude > 35)) then
                        v2.leader = v27;
                        table.insert(v26, v2);
                    end;
                end;
            end;

            for _, v2 in v26 do
                v2.leader = v28;
            end;
        end;
    end;
end;

function u1.apply(p32) -- Line: 131
    for _, v in p32 do
        local leader = v.leader;
        local track = v.track;
        local track2 = leader.track;

        if leader ~= v and (track and (track2 and (track.Length > 0 and track2.Length > 0))) then
            local v33 = track2.TimePosition % track.Length;
            local math_abs_ret = math.abs(track.TimePosition - v33);

            if math.min(math_abs_ret, track.Length - math_abs_ret) > 0.08 then
                track.TimePosition = v33;
            end;
        end;

        local sound = v.sound;
        local sound2 = leader.sound;

        if sound and (leader ~= v and (sound2 and sound2.TimeLength > 0)) then
            local math_abs_ret = math.abs(sound.TimePosition - sound2.TimePosition);

            if math.min(math_abs_ret, sound2.TimeLength - math_abs_ret) > 0.08 then
                sound.TimePosition = sound2.TimePosition;
            end;
        end;
    end;
end;

function u1.pick(p34, p35, p36, p37) -- Line: 155
    if p35 then
        p35 = p35.leader and p35.leader.sound or p35.sound;
    end;

    if p35 then
        return p35;
    end;

    local v38 = nil;
    local v39 = nil;
    local v40 = nil;

    for _, v in p34 do
        if v.leader == v and v.sound then
            local Magnitude = (v.position - p36).Magnitude;

            if not v38 or Magnitude < v39 then
                v38 = v.sound;
                v39 = Magnitude;
            end;

            if v.sound == p37 then
                v40 = Magnitude;
            end;
        end;
    end;

    if v40 and (v38 ~= p37 and v40 - v39 < 4) then
        return p37;
    end;

    return v38;
end;

local function collect() -- Line: 178
    -- upvalues: u4 (copy), Players (copy), emoteTrack (copy)
    table.clear(u4);
    local LocalPlayer = Players.LocalPlayer;
    local v41 = nil;

    for _, v in Players:GetPlayers() do
        local Character = v.Character;
        local v42;

        if Character then
            v42 = Character:GetAttribute("EmoteId");
        else
            v42 = Character;
        end;

        local v43;

        if Character then
            v43 = Character:FindFirstChild("HumanoidRootPart");
        else
            v43 = Character;
        end;

        if type(v42) == "string" and v43 then
            local EmoteSound = v43:FindFirstChild("EmoteSound");
            local Attribute = Character:GetAttribute("EmoteStartedAt");
            local v44 = {
                id = v42,
                position = v43.Position,
                at = type(Attribute) == "number" and Attribute and Attribute or (1 / 0),
                user = v.UserId,
                track = emoteTrack(Character, v42)
            };

            if not (EmoteSound and EmoteSound:IsA("Sound")) then
                EmoteSound = nil;
            end;

            v44.sound = EmoteSound;
            table.insert(u4, v44);

            if v == LocalPlayer then
                v41 = v44;
            end;
        end;
    end;

    return u4, v41;
end;

local function listener() -- Line: 206
    -- upvalues: Players (copy)
    local Character = Players.LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if Character then
        return Character.Position;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    return workspace_CurrentCamera and workspace_CurrentCamera.CFrame.Position or Vector3.new(0, 0, 0);
end;

local function pass() -- Line: 216
    -- upvalues: collect (copy), u1 (copy), register (copy), u6 (ref), Players (copy), u9 (ref), u2 (copy), u4 (copy)
    local v45, v46 = collect();

    if #v45 > 0 then
        u1.group(v45);
        u1.apply(v45);

        for _, v in v45 do
            if v.sound then
                register(v.sound);
            end;
        end;

        local pick = u1.pick;
        local Character = Players.LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        local v47;

        if Character then
            v47 = Character.Position;
        else
            local workspace_CurrentCamera = workspace.CurrentCamera;
            v47 = workspace_CurrentCamera and workspace_CurrentCamera.CFrame.Position or Vector3.new(0, 0, 0);
        end;

        u6 = pick(v45, v46, v47, u6);

        if u9 == 0 and (v46 and (v46.sound and u6 ~= v46.sound)) then
            u6 = v46.sound;
        end;
    else
        u6 = nil;
    end;

    for i, v in u2 do
        v.target = i == u6 and 1 or 0;
    end;

    table.clear(u4);
end;

local function fade(p48) -- Line: 241
    -- upvalues: u10 (ref), u8 (ref), u11 (ref), u9 (ref), u2 (copy), Players (copy), u3 (copy)
    local v49 = p48 / 0.6;
    local v50 = u10 ~= u8 and true or u11 ~= u9;
    u10 = u8;
    u11 = u9;

    for i, v in u2 do
        if i.Parent then
            if v.gain ~= v.target or v50 then
                local v51;

                if v.target > v.gain then
                    v51 = math.min(v.target, v.gain + v49);
                else
                    v51 = math.max(v.target, v.gain - v49);
                end;

                v.gain = v51;
                local v52 = v.base * v.gain;
                local Character = Players.LocalPlayer.Character;
                local v53;

                if Character == nil then
                    v53 = false;
                else
                    v53 = i:IsDescendantOf(Character);
                end;

                local v54;

                if v53 then
                    v54 = u8;
                else
                    v54 = u9;
                end;

                i.Volume = v52 * v54;
            end;
        else
            u2[i] = nil;
        end;
    end;

    for i, v in u3 do
        if i.Parent then
            local EmoteSound = v.root:FindFirstChild("EmoteSound");

            if EmoteSound then
                EmoteSound = u2[EmoteSound];
            end;

            local v55 = v.base * (not EmoteSound and 0 or EmoteSound.gain);
            local Character = Players.LocalPlayer.Character;
            local v56;

            if Character == nil then
                v56 = false;
            else
                v56 = i:IsDescendantOf(Character);
            end;

            local v57;

            if v56 then
                v57 = u8;
            else
                v57 = u9;
            end;

            local v58 = v55 * v57;

            if i.Volume ~= v58 then
                i.Volume = v58;
            end;
        else
            u3[i] = nil;
        end;
    end;
end;

local function watch(p59) -- Line: 269
    -- upvalues: register (copy), u7 (ref), registerExtra (copy)
    local HumanoidRootPart = p59:WaitForChild("HumanoidRootPart", 10);

    if not HumanoidRootPart then
        return;
    end;

    HumanoidRootPart.ChildAdded:Connect(function(p60) -- Line: 274
        -- upvalues: register (ref), u7 (ref), registerExtra (ref), HumanoidRootPart (copy)
        if p60.Name ~= "EmoteSound" or not p60:IsA("Sound") then
            if p60.Name == "EmoteSoundExtra" and p60:IsA("Sound") then
                registerExtra(p60, HumanoidRootPart);
            end;

            return;
        end;

        register(p60);
        u7 = true;
    end);

    for _, child in HumanoidRootPart:GetChildren() do
        if child.Name == "EmoteSoundExtra" and child:IsA("Sound") then
            registerExtra(child, HumanoidRootPart);
        end;
    end;

    local EmoteSound = HumanoidRootPart:FindFirstChild("EmoteSound");

    if EmoteSound and EmoteSound:IsA("Sound") then
        register(EmoteSound);
        u7 = true;
    end;
end;

function u1.start() -- Line: 294
    -- upvalues: u5 (ref), RunService (copy), watch (copy), Players (copy), u8 (ref), u9 (ref), settingsLevel (copy), u7 (ref), pass (copy), u2 (copy), fade (copy)
    if u5 or not RunService:IsClient() then
        return;
    end;

    u5 = true;

    local function joined(p61) -- Line: 299
        -- upvalues: watch (ref)
        if p61.Character then
            task.spawn(watch, p61.Character);
        end;

        p61.CharacterAdded:Connect(function(p62) -- Line: 303
            -- upvalues: watch (ref)
            task.spawn(watch, p62);
        end);
    end;

    for _, v in Players:GetPlayers() do
        if v.Character then
            task.spawn(watch, v.Character);
        end;

        v.CharacterAdded:Connect(function(p63) -- Line: 303
            -- upvalues: watch (ref)
            task.spawn(watch, p63);
        end);
    end;

    Players.PlayerAdded:Connect(joined);
    local v64, v65 = settingsLevel();
    u8 = v64;
    u9 = v65;

    for _, v in { "EmoteSoundsMuted", "MusicMuted", "EmoteVolume" } do
        Players.LocalPlayer:GetAttributeChangedSignal(v):Connect(function() -- Line: 313
            -- upvalues: u8 (ref), u9 (ref), settingsLevel (ref)
            local v66, v67 = settingsLevel();
            u8 = v66;
            u9 = v67;
        end);
    end;

    local u68 = 0;
    RunService.Heartbeat:Connect(function(p69) -- Line: 318
        -- upvalues: u68 (ref), u7 (ref), pass (ref), u2 (ref), fade (ref)
        u68 = u68 + p69;

        if u7 or u68 >= 0.25 then
            u7 = false;
            u68 = 0;
            pass();
        end;

        if next(u2) then
            fade(p69);
        end;
    end);
end;

return u1;