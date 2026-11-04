 

 

local SoundService = game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
local LazySound = require(game:GetService("ReplicatedFirst"):WaitForChild("LazySound"));
local u1 = {};
u1.__index = u1;

local function assetReady(p2) -- Line: 17
    -- upvalues: LazySound (copy)
    if not (p2 and (p2:IsA("Sound") and p2:GetAttribute("Enabled") ~= false)) then
        return false;
    end;

    local v3 = LazySound.id(p2);
    local v4;

    if v3:match("%S") == nil or v3 == "rbxassetid://0" then
        v4 = false;
    else
        v4 = v3 ~= "0";
    end;

    return v4;
end;

function u1.new(p5, p6, p7) -- Line: 24
    -- upvalues: SoundService (copy), u1 (copy)
    local Folder = Instance.new("Folder");
    Folder.Name = "GameAudioPlayback";
    Folder.Parent = SoundService;
    local v8 = {
        voiceCount = 0,
        music = nil,
        musicToken = "",
        alive = true,
        library = p5,
        catalog = p6,
        cfg = p7,
        folder = Folder,
        voices = {},
        loops = {},
        cooldowns = setmetatable({}, {
            __mode = "k"
        }),
        random = Random.new(),
        emitters = setmetatable({}, {
            __mode = "k"
        })
    };

    return setmetatable(v8, u1);
end;

function u1.template(p9, p10) -- Line: 48
    -- upvalues: assetReady (copy)
    if p9.library:GetAttribute("Enabled") == false then
        return nil;
    end;

    local v11 = p9.catalog[p10];

    if not v11 then
        return nil;
    end;

    local library = p9.library;

    for _, v in string.split(v11.Path, "/") do
        if library then
            library = library:FindFirstChild(v);
        end;
    end;

    return assetReady(library) and library and library or nil;
end;

function u1.trace(p12, p13, p14) -- Line: 62
    if p12.library:GetAttribute("DebugEvents") ~= true then
        return;
    end;

    p12.folder:SetAttribute("LastCue", p13);
    p12.folder:SetAttribute("LastCuePlayed", p14);
    local v15 = "Cue_" .. p13;
    p12.folder:SetAttribute(v15, (p12.folder:GetAttribute(v15) or 0) + 1);
end;

function u1.remove(p16, p17) -- Line: 71
    if not (p17 and p16.voices[p17]) then
        return;
    end;

    p16.voices[p17] = nil;
    p16.voiceCount = p16.voiceCount - 1;

    if p17.tween then
        p17.tween:Cancel();
    end;

    p17.sound:Destroy();
end;

function u1.create(u18, p19, p20, p21, p22, p23, p24) -- Line: 82
    -- upvalues: LazySound (copy)
    if not u18.alive or u18.voiceCount >= u18.cfg.MaxVoices then
        return nil;
    end;

    if p21 and not p21:IsDescendantOf(workspace) then
        return nil;
    end;

    local v25 = LazySound.arm(p20:Clone());
    v25.Name = "CoH_" .. p19;
    v25.PlayOnRemove = false;
    v25.Looped = p24;
    v25.Volume = p20.Volume * (p22 or 1);
    v25.PlaybackSpeed = p20.PlaybackSpeed * (p23 or 1);
    local v26;

    if p21 and p21:IsA("BasePart") then
        v26 = p21:FindFirstChild("CoHAudioEmitter");

        if not v26 then
            v26 = Instance.new("Attachment");
            v26.Name = "CoHAudioEmitter";
            v26.Parent = p21;
            u18.emitters[v26] = true;
        end;
    else
        v26 = nil;
    end;

    v25.Parent = v26 or (p21 or u18.folder);
    local Attribute = p20:GetAttribute("KnifeMaxSeconds");
    local v27 = type(Attribute) == "number" and Attribute and Attribute or nil;

    if v27 and (v27 ~= v27 or v27 <= 0) then
        v27 = nil;
    end;

    local v28 = u18.catalog[p19];
    local v29 = not p24;

    if v29 then
        if v28 then
            if type(v28.Path) == "string" then
                v28 = string.sub(v28.Path, 1, 10) == "08_Knives/";
            else
                v28 = false;
            end;
        end;
    else
        v28 = v29;
    end;

    local v30 = v27 and math.clamp(v27, 0.2, u18.cfg.MaxOneShotSeconds) or u18.cfg.MaxOneShotSeconds;
    local os_clock_ret = os.clock();
    local u31 = {
        sound = v25,
        template = p20,
        id = LazySound.id(p20),
        key = p19,
        deadline = p24 and (1 / 0) or os_clock_ret + v30
    };
    u31.knifeFade = not p24 and v27 ~= nil;

    if v28 then
        u31.knife = true;
        local math_min_ret = math.min(v27 or 0.5, 0.5);
        u31.hold = math.clamp(math_min_ret, 0.2, 0.5);
        u31.deadline = os_clock_ret + u18.cfg.MaxOneShotSeconds;
        u31.knifeFade = false;
    end;

    u18.voices[u31] = true;
    u18.voiceCount = u18.voiceCount + 1;

    if not p24 then
        v25.Ended:Once(function() -- Line: 136
            -- upvalues: u18 (copy), u31 (copy)
            u18:remove(u31);
        end);
    end;

    if v25.PlaybackRegionsEnabled then
        v25.TimePosition = v25.PlaybackRegion.Min;
    end;

    v25:Play();

    return u31;
end;

function u1.one(p32, p33, p34, p35, p36) -- Line: 146
    local v37 = p32.catalog[p33];

    if not v37 then
        return false;
    end;

    local v38 = p34 or p32.folder;
    local v39 = p32.cooldowns[v38];

    if not v39 then
        v39 = {};
        p32.cooldowns[v38] = v39;
    end;

    local os_clock_ret = os.clock();

    if os_clock_ret - (v39[p33] or (-1 / 0)) < v37.MinInterval then
        return false;
    end;

    v39[p33] = os_clock_ret;
    local v40 = p32:template(p33);
    local v41;

    if v40 then
        v41 = v40:GetAttribute("PitchVariation");
    else
        v41 = v40;
    end;

    local v42 = type(v41) == "number" and v41 and v41 or 0;
    local math_clamp_ret = math.clamp(v42, 0, 0.04);
    local v43 = p36 or 1;

    if math_clamp_ret > 0 then
        v43 = v43 * p32.random:NextNumber(1 - math_clamp_ret, 1 + math_clamp_ret);
    end;

    if v40 then
        v40 = p32:create(p33, v40, p34, p35, v43, false);
    end;

    p32:trace(p33, v40 ~= nil);

    return v40 ~= nil;
end;

function u1.loop(p44, p45, p46, p47, p48, p49) -- Line: 174
    -- upvalues: LazySound (copy)
    local v50;

    if p46 then
        v50 = p44:template(p46);
    else
        v50 = p46;
    end;

    local v51 = p44.loops[p45];

    if v51 and not (p44.voices[v51] and (v50 and (v51.template == v50 and v51.id == LazySound.id(v50)))) then
        p44:remove(v51);
        p44.loops[p45] = nil;
        v51 = nil;
    end;

    if not v50 or (p48 or 1) <= 0.001 then
        if v51 then
            p44:remove(v51);
            p44.loops[p45] = nil;
        end;

        return;
    end;

    if not v51 then
        v51 = p44:create(p46, v50, p47, p48, p49, true);
        p44.loops[p45] = v51;
        p44:trace(p46, v51 ~= nil);
    end;

    if v51 then
        v51.sound.Volume = v50.Volume * (p48 or 1);
        v51.sound.PlaybackSpeed = v50.PlaybackSpeed * (p49 or 1);
    end;
end;

function u1.setMusic(p52, p53) -- Line: 199
    -- upvalues: LazySound (copy), TweenService (copy)
    local v54 = p52:template(p53);
    local v55 = p53 .. ":" .. (v54 and (LazySound.id(v54) or "") or "");

    if p52.musicToken == v55 and (not p52.music or p52.voices[p52.music]) then
        local music = p52.music;

        if music and os.clock() >= music.fadeEnd then
            music.sound.Volume = v54.Volume;
            music.sound.PlaybackSpeed = v54.PlaybackSpeed;
        end;

        return;
    end;

    p52.musicToken = v55;
    p52.folder:SetAttribute("MusicSlot", p53);

    if p52.music then
        local music = p52.music;

        if music.tween then
            music.tween:Cancel();
        end;

        music.deadline = os.clock() + p52.cfg.MusicFade + 0.1;
        music.tween = TweenService:Create(music.sound, TweenInfo.new(p52.cfg.MusicFade), {
            Volume = 0
        });
        music.tween:Play();
    end;

    p52.music = nil;

    if v54 then
        local v56 = p52:create(p53, v54, nil, 0, 1, true);

        if v56 then
            v56.fadeEnd = os.clock() + p52.cfg.MusicFade;
            v56.tween = TweenService:Create(v56.sound, TweenInfo.new(p52.cfg.MusicFade), {
                Volume = v54.Volume
            });
            v56.tween:Play();
            p52.music = v56;
            p52:trace(p53, true);

            return;
        end;

        p52.musicToken = "";
    end;
end;

function u1.update(p57) -- Line: 235
    -- upvalues: TweenService (copy), assetReady (copy), LazySound (copy)
    local os_clock_ret = os.clock();

    for i in p57.voices do
        if i.knife and i.sound.Parent then
            if not (i.heardAt or (not i.sound.IsPlaying or i.sound.TimePosition <= 0)) then
                i.heardAt = os_clock_ret;
                i.deadline = os_clock_ret + i.hold + 0.8 + 0.05;
            end;

            if i.heardAt and (not i.tween and i.heardAt + i.hold <= os_clock_ret) then
                i.tween = TweenService:Create(i.sound, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Volume = 0
                });
                i.tween:Play();
            end;
        elseif i.knifeFade and not (i.tween or (i.deadline - 0.12 > os_clock_ret or (os_clock_ret >= i.deadline or not i.sound.Parent))) then
            i.tween = TweenService:Create(i.sound, TweenInfo.new(0.12), {
                Volume = 0
            });
            i.tween:Play();
        end;

        if not (i.sound.Parent and (i.template.Parent and (assetReady(i.template) and (p57.library:GetAttribute("Enabled") ~= false and (i.id == LazySound.id(i.template) and i.deadline > os_clock_ret))))) then
            p57:remove(i);
        end;
    end;
end;

function u1.destroy(p58) -- Line: 264
    p58.alive = false;

    for i in p58.voices do
        p58:remove(i);
    end;

    for i in p58.emitters do
        i:Destroy();
    end;

    p58.folder:Destroy();
end;

return u1;