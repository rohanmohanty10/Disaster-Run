 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local UserInputService = game:GetService("UserInputService");
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local starterPlayer = ReplicatedStorage.client.starterPlayer;
local packets = require(ReplicatedStorage.packets);

return function(p1) -- Line: 11
    -- upvalues: starterPlayer (copy), Players (copy), UserInputService (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), packets (copy)
    p1:destroyContainer();
    local u2 = starterPlayer.SFX:Clone();
    u2.Parent = p1.playerGui;
    local Frame2 = u2.Frame.Frame2;
    local TextBox = Frame2.Search.TextBox;
    local TimestampRow = Frame2.TimestampRow;
    local PitchRow = Frame2.PitchRow;
    local setting = Players.LocalPlayer:FindFirstChild("setting");

    local function readNumber(p3, p4) -- Line: 23
        -- upvalues: setting (copy)
        local v5 = setting and setting:FindFirstChild(p3);

        if v5 then
            p4 = v5.Value or p4;
        end;

        return p4;
    end;

    local u6 = {};
    local v7;

    if setting then
        v7 = setting:FindFirstChild("flowMusicId");
    else
        v7 = setting;
    end;

    u6.id = v7 and v7.Value or 0;
    local v8;

    if setting then
        v8 = setting:FindFirstChild("flowMusicTimestamp");
    else
        v8 = setting;
    end;

    u6.timestamp = v8 and v8.Value or 0;

    if setting then
        setting = setting:FindFirstChild("flowMusicPitch");
    end;

    u6.pitch = setting and setting.Value or 1;
    local u9 = 0;
    local u10 = {};

    local function addConn(p11) -- Line: 37
        -- upvalues: u10 (copy)
        table.insert(u10, p11);
    end;

    u2.Destroying:Once(function() -- Line: 41
        -- upvalues: u10 (copy)
        for _, v in u10 do
            v:Disconnect();
        end;
    end);
    local Sound = Instance.new("Sound");
    Sound.Volume = 0;
    Sound.Parent = u2;

    local function round(p12, p13) -- Line: 51
        if p13 <= 0 then
            return p12;
        end;

        return math.floor(p12 / p13 + 0.5) * p13;
    end;

    local function wireSlider(p14, u15, u16, u17, u18, u19, u20) -- Line: 58
        -- upvalues: u10 (copy), UserInputService (ref)
        local Track = p14.Track;
        local Knob = Track.Knob;
        local Box = p14.Box;

        local function refresh() -- Line: 63
            -- upvalues: u15 (copy), u16 (copy), u18 (copy), Knob (copy), Box (copy), u20 (copy)
            local v21 = u15();
            local v22 = u16() - v21;
            local v23;

            if v22 > 0 then
                local v24 = (u18() - v21) / v22;
                v23 = math.clamp(v24, 0, 1);
            else
                v23 = 0;
            end;

            Knob.Position = UDim2.new(v23, 0, 0.5, 0);
            Box.Text = u20(u18());
        end;

        local function setFromFraction(p25) -- Line: 71
            -- upvalues: u15 (copy), u16 (copy), u17 (copy), u19 (copy), refresh (copy)
            local v26 = u15();
            local v27 = u16();
            local math_clamp_ret = math.clamp(v26 + p25 * (v27 - v26), v26, v27);
            local v28 = u17();

            if v28 > 0 then
                math_clamp_ret = math.floor(math_clamp_ret / v28 + 0.5) * v28;
            end;

            u19((math.clamp(math_clamp_ret, v26, v27)));
            refresh();
        end;

        local function fractionFromInput(p29) -- Line: 79
            -- upvalues: Track (copy)
            local X = Track.AbsoluteSize.X;

            return X <= 0 and 0 or math.clamp((p29.Position.X - Track.AbsolutePosition.X) / X, 0, 1);
        end;

        local u30 = false;

        local function beginDrag(p31) -- Line: 88
            -- upvalues: u30 (ref), Track (copy), u15 (copy), u16 (copy), u17 (copy), u19 (copy), refresh (copy)
            if p31.UserInputType == Enum.UserInputType.MouseButton1 or p31.UserInputType == Enum.UserInputType.Touch then
                u30 = true;
                local X = Track.AbsoluteSize.X;
                local v32 = X <= 0 and 0 or math.clamp((p31.Position.X - Track.AbsolutePosition.X) / X, 0, 1);
                local v33 = u15();
                local v34 = u16();
                local math_clamp_ret = math.clamp(v33 + v32 * (v34 - v33), v33, v34);
                local v35 = u17();

                if v35 > 0 then
                    math_clamp_ret = math.floor(math_clamp_ret / v35 + 0.5) * v35;
                end;

                u19((math.clamp(math_clamp_ret, v33, v34)));
                refresh();
            end;
        end;

        local v36 = Knob.InputBegan:Connect(beginDrag);
        table.insert(u10, v36);
        local v37 = Track.InputBegan:Connect(beginDrag);
        table.insert(u10, v37);
        local v43 = UserInputService.InputChanged:Connect(function(p38) -- Line: 97
            -- upvalues: u30 (ref), Track (copy), u15 (copy), u16 (copy), u17 (copy), u19 (copy), refresh (copy)
            if u30 and (p38.UserInputType == Enum.UserInputType.MouseMovement or p38.UserInputType == Enum.UserInputType.Touch) then
                local X = Track.AbsoluteSize.X;
                local v39 = X <= 0 and 0 or math.clamp((p38.Position.X - Track.AbsolutePosition.X) / X, 0, 1);
                local v40 = u15();
                local v41 = u16();
                local math_clamp_ret = math.clamp(v40 + v39 * (v41 - v40), v40, v41);
                local v42 = u17();

                if v42 > 0 then
                    math_clamp_ret = math.floor(math_clamp_ret / v42 + 0.5) * v42;
                end;

                u19((math.clamp(math_clamp_ret, v40, v41)));
                refresh();
            end;
        end);
        table.insert(u10, v43);
        local v45 = UserInputService.InputEnded:Connect(function(p44) -- Line: 102
            -- upvalues: u30 (ref)
            if p44.UserInputType == Enum.UserInputType.MouseButton1 or p44.UserInputType == Enum.UserInputType.Touch then
                u30 = false;
            end;
        end);
        table.insert(u10, v45);
        local v50 = Box.FocusLost:Connect(function() -- Line: 108
            -- upvalues: u15 (copy), u16 (copy), Box (copy), u19 (copy), u17 (copy), refresh (copy)
            local v46 = u15();
            local v47 = u16();
            local v48 = tonumber(Box.Text);

            if v48 then
                local v49 = u17();

                if v49 > 0 then
                    v48 = math.floor(v48 / v49 + 0.5) * v49;
                end;

                u19((math.clamp(v48, v46, v47)));
            end;

            refresh();
        end);
        table.insert(u10, v50);

        return refresh;
    end;

    local u53 = wireSlider(TimestampRow, function() -- Line: 122
        return 0;
    end, function() -- Line: 123
        -- upvalues: u9 (ref)
        return u9;
    end, function() -- Line: 124
        -- upvalues: u9 (ref)
        return math.max(0.1, u9 / 200);
    end, function() -- Line: 125
        -- upvalues: u6 (copy)
        return u6.timestamp;
    end, function(p51) -- Line: 126
        -- upvalues: u6 (copy)
        u6.timestamp = p51;
    end, function(p52) -- Line: 127
        return string.format("%.1f", p52);
    end);
    local v56 = wireSlider(PitchRow, function() -- Line: 132
        return 0.5;
    end, function() -- Line: 133
        return 2;
    end, function() -- Line: 134
        return 0.05;
    end, function() -- Line: 135
        -- upvalues: u6 (copy)
        return u6.pitch;
    end, function(p54) -- Line: 136
        -- upvalues: u6 (copy)
        u6.pitch = p54;
    end, function(p55) -- Line: 137
        return string.format("%.2f", p55);
    end);

    local function applyDuration() -- Line: 140
        -- upvalues: u9 (ref), Sound (copy), u6 (copy), u53 (copy)
        u9 = Sound.TimeLength;

        if u9 < u6.timestamp then
            u6.timestamp = u9;
        end;

        u53();
    end;

    local v57 = Sound:GetPropertyChangedSignal("TimeLength"):Connect(function() -- Line: 148
        -- upvalues: Sound (copy), u9 (ref), u6 (copy), u53 (copy)
        if Sound.TimeLength > 0 then
            u9 = Sound.TimeLength;

            if u9 < u6.timestamp then
                u6.timestamp = u9;
            end;

            u53();
        end;
    end);
    table.insert(u10, v57);

    local function loadId(p58) -- Line: 154
        -- upvalues: u6 (copy), Sound (copy), u9 (ref), u53 (copy)
        u6.id = p58;

        if p58 > 0 then
            Sound.SoundId = `rbxassetid://{p58}`;

            if Sound.TimeLength > 0 then
                u9 = Sound.TimeLength;

                if u9 < u6.timestamp then
                    u6.timestamp = u9;
                end;

                u53();
            end;
        else
            Sound.SoundId = "";
            u9 = 0;
            u53();
        end;
    end;

    if u6.id > 0 then
        TextBox.Text = tostring(u6.id);
    end;

    local v60 = TextBox.FocusLost:Connect(function() -- Line: 172
        -- upvalues: TextBox (copy), u6 (copy), Sound (copy), u9 (ref), u53 (copy)
        local v59 = tonumber(TextBox.Text) or 0;
        u6.id = v59;

        if v59 > 0 then
            Sound.SoundId = `rbxassetid://{v59}`;

            if Sound.TimeLength > 0 then
                u9 = Sound.TimeLength;

                if u9 < u6.timestamp then
                    u6.timestamp = u9;
                end;

                u53();
            end;
        else
            Sound.SoundId = "";
            u9 = 0;
            u53();
        end;
    end);
    table.insert(u10, v60);
    v56();
    local id = u6.id;
    u6.id = id;

    if id > 0 then
        Sound.SoundId = `rbxassetid://{id}`;

        if Sound.TimeLength > 0 then
            u9 = Sound.TimeLength;

            if u9 < u6.timestamp then
                u6.timestamp = u9;
            end;

            u53();
        end;
    else
        Sound.SoundId = "";
        u9 = 0;
        u53();
    end;

    Frame2.Close.Button.MouseButton1Up:Once(function() -- Line: 179
        -- upvalues: soundUtil (ref), ReplicatedStorage (ref), SoundService (ref), packets (ref), u6 (copy), u2 (copy)
        soundUtil:play(ReplicatedStorage.Resources.click, SoundService);
        packets.bytenet_settingChange.send({
            name = "flowMusicId",
            value = u6.id
        });
        packets.bytenet_settingChange.send({
            name = "flowMusicTimestamp",
            value = u6.timestamp
        });
        packets.bytenet_settingChange.send({
            name = "flowMusicPitch",
            value = u6.pitch
        });
        u2:Destroy();
    end);
end;