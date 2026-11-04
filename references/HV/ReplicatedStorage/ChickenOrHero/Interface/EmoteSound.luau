 

 

local SoundService = game:GetService("SoundService");
local EmoteCatalog = require(script.Parent.Parent.Emotes.EmoteCatalog);
local u1 = {};
u1.__index = u1;
local u2 = nil;
local u3 = nil;

local function show(p4, p5) -- Line: 16
    if p4.icon then
        p4.icon.Image = p5 and "rbxassetid://134448347476578" or "rbxassetid://130344237995259";
    end;
end;

function u1.silence() -- Line: 23
    -- upvalues: u2 (ref), u3 (ref)
    if u2 then
        u2:Destroy();
        u2 = nil;
    end;

    if u3 then
        local v6 = u3;

        if v6.icon then
            v6.icon.Image = "rbxassetid://130344237995259";
        end;

        u3 = nil;
    end;
end;

function u1.new(p7) -- Line: 35
    -- upvalues: u1 (copy)
    local v8 = {
        button = p7,
        icon = p7:FindFirstChild("Icon")
    };
    local u9 = setmetatable(v8, u1);
    p7.Visible = false;

    if u9.icon then
        u9.icon.Image = "rbxassetid://130344237995259";
    end;

    u9.connection = p7.Activated:Connect(function() -- Line: 39
        -- upvalues: u9 (copy)
        u9:toggle();
    end);

    return u9;
end;

function u1.set(p10, p11) -- Line: 47
    -- upvalues: EmoteCatalog (copy)
    if p11 ~= p10.id then
        p10:stop();
        p10.id = p11;
        local v12;

        if p11 then
            v12 = EmoteCatalog.soundId(p11);
        else
            v12 = nil;
        end;

        p10.soundId = v12;
    end;

    p10.button.Visible = p10.soundId ~= nil;
end;

function u1.toggle(p13) -- Line: 56
    -- upvalues: u3 (ref), u1 (copy), EmoteCatalog (copy), SoundService (copy), u2 (ref)
    u1.silence();

    if u3 == p13 or not p13.soundId then
        return;
    end;

    local v14 = EmoteCatalog.get(p13.id);
    local Sound = Instance.new("Sound");
    Sound.Name = "EmotePreviewSound";
    Sound.SoundId = p13.soundId;
    Sound.Looped = true;
    Sound.Volume = v14 and v14.Volume or 0.25;
    local v15, v16 = EmoteCatalog.soundIds(p13.id);

    for i, v in v15 do
        if i > 1 then
            local Sound2 = Instance.new("Sound");
            Sound2.SoundId = v;
            Sound2.Looped = true;
            Sound2.Volume = v16[i];
            Sound2.Parent = Sound;
            Sound2:Play();
        end;
    end;

    Sound.Parent = SoundService;
    Sound:Play();
    u2 = Sound;
    u3 = p13;

    if p13.icon then
        p13.icon.Image = "rbxassetid://134448347476578";
    end;
end;

function u1.stop(p17) -- Line: 87
    -- upvalues: u3 (ref), u1 (copy)
    if u3 == p17 then
        u1.silence();
    end;
end;

function u1.destroy(p18) -- Line: 93
    p18:stop();

    if p18.connection then
        p18.connection:Disconnect();
        p18.connection = nil;
    end;
end;

return u1;