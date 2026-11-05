  

 

local u1 = game.ReplicatedStorage["Client Assets"];
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Trove = require(PathShortcuts.KnitPath.Trove);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
local Quotes = require(PathShortcuts.ReplicatedModules.Quotes);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local SoundGroups = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("SoundGroups"));
local DefaultStyle = require(script.DefaultStyle);
local u2 = {};
local u3 = {};
local u4 = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "-", "_", "=", "+", "[", "]", "{", "}", "|", "\\", ";", ":", "\'", "\"", ",", ".", "<", ">", "/", "?" };

local function GetRandomEncryptCharacter() -- Line: 26
    -- upvalues: u4 (copy)
    return u4[math.random(1, #u4)];
end;

local function ScrambleFullText(p5, p6) -- Line: 30
    -- upvalues: u4 (copy)
    local v7 = "";

    for i = 1, #p5 do
        if p6 and p5:sub(i, i) == " " then
            v7 = v7 .. " ";
        else
            v7 = v7 .. u4[math.random(1, #u4)];
        end;
    end;

    return v7;
end;

local function UpdateEncryptedDisplay(p8, p9, p10) -- Line: 43
    -- upvalues: u4 (copy)
    local v11 = "";

    for i = 1, #p8 do
        if i <= p9 then
            v11 = v11 .. p8:sub(i, i);
        elseif p10 and p8:sub(i, i) == " " then
            v11 = v11 .. " ";
        else
            v11 = v11 .. u4[math.random(1, #u4)];
        end;
    end;

    return v11;
end;

return function(p12, p13, p14) -- Line: 62
    -- upvalues: u1 (copy), u2 (ref), DefaultStyle (copy), u3 (ref), TweenService (copy), SoundGroups (copy), Trove (copy), Quotes (copy), TableUtil (copy), EffectsHandler (copy), ScrambleFullText (copy), RunService (copy), UpdateEncryptedDisplay (copy), ParticleHandler (copy)
    local wait = task.wait;
    local _ = p14.StandName;
    local _ = p14.MoveName;
    local _ = p14.QuoteIndex;
    local _ = p14.SkinName;
    local Stand = p12:FindFirstChild("Stand");
    local v15 = p14.StandHead and (Stand and Stand:FindFirstChild("Stand Head") or p12:FindFirstChild("Head")) or (p12:FindFirstChild("Head") or p12:FindFirstChild("Stand Head"));

    if not (v15 and v15:IsDescendantOf(workspace)) then
        return;
    end;

    if not p13.FullQuote then
        return;
    end;

    if not p13.SoundId then
        return;
    end;

    if p12:GetAttribute("Quoting") and not p12:GetAttribute("TrueURF") then
        return;
    end;

    local u16 = v15:FindFirstChild("Quote Gui");

    if not u16 then
        u16 = u1.Taunt["Quote Gui"]:Clone();
        u16.Parent = v15;
        u16.Quote.Text = "";

        if not next(u2) then
            u2 = DefaultStyle(u16.Quote);
        end;

        if not next(u3) then
            u3 = {
                Size = u16.Size,
                StudsOffset = u16.StudsOffset
            };

            if u16:FindFirstChild("Quote") then
                u3.QuoteSize = u16.Quote.Size;
                u3.QuotePosition = u16.Quote.Position;
            end;
        end;
    end;

    for i, v in u3 do
        if i == "QuoteSize" and u16.Quote then
            u16.Quote.Size = v;
        elseif i == "QuotePosition" and u16.Quote then
            u16.Quote.Position = v;
        elseif i ~= "QuoteSize" and i ~= "QuotePosition" then
            u16[i] = v;
        end;
    end;

    if p13.GuiStyle then
        local GuiStyle = p13.GuiStyle;

        if GuiStyle.SizeMultiplier then
            local Size = u16.Size;
            u16.Size = UDim2.new(Size.X.Scale * GuiStyle.SizeMultiplier, Size.X.Offset * GuiStyle.SizeMultiplier, Size.Y.Scale * GuiStyle.SizeMultiplier, Size.Y.Offset * GuiStyle.SizeMultiplier);
        end;

        if GuiStyle.Size then
            u16.Size = GuiStyle.Size;
        end;

        if GuiStyle.StudsOffset then
            u16.StudsOffset = GuiStyle.StudsOffset;
        end;

        if GuiStyle.QuoteSizeMultiplier and u16.Quote then
            local Size = u16.Quote.Size;
            u16.Quote.Size = UDim2.new(Size.X.Scale * GuiStyle.QuoteSizeMultiplier, Size.X.Offset * GuiStyle.QuoteSizeMultiplier, Size.Y.Scale * GuiStyle.QuoteSizeMultiplier, Size.Y.Offset * GuiStyle.QuoteSizeMultiplier);
        end;

        if GuiStyle.QuoteSize and u16.Quote then
            u16.Quote.Size = GuiStyle.QuoteSize;
        end;

        if GuiStyle.QuotePosition and u16.Quote then
            u16.Quote.Position = GuiStyle.QuotePosition;
        end;
    end;

    if p13.AutoScale then
        local v17 = 0;

        for _, v in p13.FullQuote do
            v17 = v17 + #(v.Quote or "");
        end;

        local v18 = math.clamp(v17 / (p13.AutoScale.BaseLength or 50), p13.AutoScale.MinMultiplier or 1, p13.AutoScale.MaxMultiplier or 2);
        local Size = u16.Size;
        u16.Size = UDim2.new(Size.X.Scale * v18, Size.X.Offset * v18, Size.Y.Scale * v18, Size.Y.Offset * v18);

        if p13.AutoScale.ScaleQuoteFrame and u16.Quote then
            local Size2 = u16.Quote.Size;
            u16.Quote.Size = UDim2.new(Size2.X.Scale * v18, Size2.X.Offset * v18, Size2.Y.Scale * v18, Size2.Y.Offset * v18);
        end;
    end;

    u16.Quote.TextTransparency = 1;
    TweenService:Create(u16.Quote, TweenInfo.new(0.5), {
        TextTransparency = 0
    }):Play();
    u16.Quote.Visible = not p13.HideQuote;
    local v19 = p12:GetAttribute("PSScale") or 1;
    local Sound = Instance.new("Sound");
    Sound.Name = "QuoteSound";
    Sound.SoundId = type(p13.SoundId) == "number" and `rbxassetid://{p13.SoundId}` or p13.SoundId;
    Sound.Volume = p13.SoundVolume or 0;
    Sound.PlaybackSpeed = (p13.PlaybackSpeed or 1) * v19;
    Sound.RollOffMode = Enum.RollOffMode.InverseTapered;
    Sound.RollOffMaxDistance = 200;
    Sound.RollOffMinDistance = 20;
    Sound.PlaybackRegionsEnabled = p13.PlaybackRegionsEnabled and true or false;
    Sound.PlaybackRegion = p13.PlaybackRegion or Sound.PlaybackRegion;
    Sound.Looped = p13.LoopSound or false;
    SoundGroups:AssignSoundTag(Sound);
    local v20 = Trove.new();
    local u21 = false;

    local function FinishQuote() -- Line: 202
        -- upvalues: u21 (ref)
        u21 = true;
    end;

    v20:Connect(Sound.Ended, FinishQuote);
    v20:Connect(Sound.Stopped, FinishQuote);
    v20:Connect(Sound.AncestryChanged, function(p22, p23) -- Line: 208
        -- upvalues: u21 (ref)
        if not p23 then
            u21 = true;
        end;
    end);
    Sound.Parent = p12.PrimaryPart or p12.Head;
    Sound:Play();

    if not p13.OmitReconcile then
        local v24 = Quotes.GetQuoteInfo(p14.AbilityName, p14.SkinName);
        p13 = TableUtil.Reconcile(p13, v24.Quotes[p14.Group][p14.QuoteIndex]);
    end;

    if p13.AdditionalEffect then
        local v25 = unpack(p13.AdditionalEffect.Arguments);
        v25.SelectedQuote = p13;
        EffectsHandler.CallEffect(p13.AdditionalEffect.Name, v25);
    end;

    if p13.ClientCallback then
        p13.ClientCallback(p12, p13);
    end;

    p12:SetAttribute("Quoting", (p13.SoundId == "" or p13.HideQuote) and "FakeQuote" or true);
    local Encrypt = p13.Encrypt;
    local u26 = p13.EncryptPreserveSpaces ~= false;
    local _ = (p13.EncryptUpdateRate or 0.05) / v19;
    local u27 = (p13.EncryptDecryptDelay or 0.5) / v19;
    local v28 = {};
    local u29 = 0;
    local u30 = false;
    local u31, u32;

    if Encrypt then
        local v33 = "";

        for _, v in p13.FullQuote do
            v33 = v33 .. (v.Quote or "");
        end;

        u31 = v33;
        u16.Quote.Text = ScrambleFullText(u31, u26);
        u32 = true;
        local u34 = tick();
        v28.Scramble = RunService.Heartbeat:Connect(function() -- Line: 253
            -- upvalues: u32 (ref), u34 (ref), u30 (ref), u27 (copy), u16 (ref), ScrambleFullText (ref), u31 (ref), u26 (copy), u29 (ref), UpdateEncryptedDisplay (ref)
            if not u32 then
                return;
            end;

            if not u30 and u27 <= tick() - u34 then
                u30 = true;
            end;

            if u30 then
                if u29 < #u31 then
                    u16.Quote.Text = UpdateEncryptedDisplay(u31, u29, u26);
                end;

                return;
            end;

            u16.Quote.Text = ScrambleFullText(u31, u26);
        end);
    else
        u31 = "";
    end;

    local v35 = 0;
    local v36 = 0;

    for i, v in ipairs(p13.FullQuote) do
        local _, v37 = next(p13.FullQuote, i);

        for i2, v2 in u2 do
            u16.Quote[i2] = v2;
        end;

        local v38 = p13.TextStyle or {};

        for i2, v2 in v38 do
            if i2 ~= "UnusualRecolor" then
                if i2 == "Font" then
                    u16.Quote.FontFace = Font.fromEnum(v2);
                else
                    u16.Quote[i2] = v2;
                end;
            end;
        end;

        local v39 = v38.UnusualRecolor and (p12 and p12.Parent) and ParticleHandler.GetUnusualHSVData({
            Character = p12
        });

        if v39 then
            u16.Quote.TextColor3 = ParticleHandler.TryHSVShift(u16.Quote.TextColor3, v39);
        end;

        local Quote = v.Quote;
        local v40 = (v.Timing or 0.03) / v19;
        local v41 = v.EndLag or 1;

        if v.TextStyle then
            for i2, v2 in v.TextStyle do
                if i2 ~= "UnusualRecolor" then
                    if i2 == "Font" then
                        u16.Quote.FontFace = Font.fromEnum(v2);
                    else
                        u16.Quote[i2] = v2;
                    end;
                end;
            end;
        end;

        if type(v.Transformer) == "function" then
            Quote = v.Transformer(v, p14);
        end;

        if v.ScaleTime then
            v40 = v.ScaleTime / #Quote / v19;
        end;

        local v42 = v36 + v40;

        for i2, v2 in utf8.graphemes(Quote) do
            v42 = v42 - v40;
            v35 = v35 + 1;

            if Encrypt then
                if u30 then
                    u29 = v35;
                end;
            else
                local Quote2 = u16.Quote;
                Quote2.Text = Quote2.Text .. Quote:sub(i2, v2);
            end;

            if v42 < v40 then
                v42 = v42 + wait(v40 - v42);
            end;
        end;

        v36 = v42 - v40;
        local v43 = v41 - v36;

        if v37 ~= nil then
            if v43 > 0 then
                v36 = task.wait(v43) - v43;
            else
                v36 = v36 - v41;
            end;
        end;

        if v.EraseQuote then
            if Encrypt then
                u29 = 0;
                v35 = 0;
            else
                u16.Quote.Text = "";
            end;
        end;
    end;

    if Encrypt then
        u32 = false;

        for _, v in v28 do
            v:Disconnect();
        end;

        u16.Quote.Text = u31;
    end;

    if p13.LoopSound then
        Sound:Stop();
        u21 = true;
    end;

    local v44 = p13.FullQuote[#p13.FullQuote].EndLag or 1;

    if v44 > 0 then
        task.wait(v44);
    end;

    if p13.YieldSound and not u21 then
        local v45 = os.time();

        repeat
            wait(0.1);
        until u21 or (p13.MaxYield or 10) < os.time() - v45;
    end;

    Sound:Stop();
    p12:SetAttribute("Quoting", nil);
    u16.Quote.TextTransparency = 1;
    u16.Quote.Text = "";
    u16.Quote.Visible = true;
    v20:Destroy();
    Sound:Destroy();
end;