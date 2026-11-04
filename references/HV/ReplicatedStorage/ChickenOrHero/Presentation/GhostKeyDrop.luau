 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local v1 = {};
local Color3_fromRGB_ret = Color3.fromRGB(255, 205, 90);
local Font_fromEnum_ret = Font.fromEnum(Enum.Font.Creepster);
local u2 = {
    Rise = { "rbxassetid://9113080525", 0.3, 0.25, 0.8, 0 },
    Got = { "rbxassetid://9116169563", 0.55, 0.4, 0.55, 0.25 }
};

local function smooth(p3) -- Line: 35
    local math_clamp_ret = math.clamp(p3, 0, 1);

    return math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret);
end;

local function backOut(p4) -- Line: 39
    local v5 = math.clamp(p4, 0, 1) - 1;

    return 1 + v5 * v5 * (2.7 * v5 + 1.7);
end;

local u6 = nil;

local function keyIcon() -- Line: 46
    -- upvalues: u6 (ref), ChickenOrHero (copy)
    if u6 == nil then
        local v7 = ChickenOrHero:FindFirstChild("Game") and ChickenOrHero.Game:FindFirstChild("GhostTraderConfig");
        local success, result = pcall(require, v7);
        u6 = not (success and (type(result) == "table" and type(result.KeyIcon) == "string")) and "" or result.KeyIcon;

        if u6 == "" then
            warn("[GhostKeyDrop] Game.GhostTraderConfig.KeyIcon didn\'t load; the key shows as a glow only");
        end;
    end;

    return u6;
end;

local u8 = nil;

local function screen(p9) -- Line: 60
    -- upvalues: u8 (ref), Players (copy)
    if p9.screen then
        return p9.screen;
    end;

    if u8 and u8.Parent then
        return u8;
    end;

    local v10 = Players.LocalPlayer and Players.LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if not v10 then
        return nil;
    end;

    u8 = Instance.new("ScreenGui");
    u8.Name = "GhostKeyDrop";
    u8.ResetOnSpawn = false;
    u8.IgnoreGuiInset = true;
    u8.DisplayOrder = 70;
    u8.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    u8:SetAttribute("SelfManagedText", true);
    u8.Parent = v10;

    return u8;
end;

local function play(p11, p12, p13) -- Line: 84
    -- upvalues: u2 (copy)
    local u14 = u2[p11];

    if not (u14 and p12) then
        return;
    end;

    local Sound = Instance.new("Sound");
    Sound.Name = "GhostKey" .. p11;
    Sound.SoundId = u14[1];
    Sound.Volume = u14[2];
    Sound.RollOffMinDistance = 10;
    Sound.RollOffMaxDistance = 90;
    Sound.Parent = p12;
    local os_clock_ret = os.clock();

    local function go() -- Line: 97
        -- upvalues: Sound (copy), u14 (copy)
        if not Sound.Parent then
            return;
        end;

        Sound.TimePosition = u14[3];
        Sound:Play();
        task.delay(u14[4], function() -- Line: 103
            -- upvalues: Sound (ref)
            Sound:Destroy();
        end);
    end;

    task.delay(math.max(0, (p13 or 0) - u14[5]), function() -- Line: 107
        -- upvalues: Sound (copy), u14 (copy), os_clock_ret (copy)
        if not Sound.IsLoaded then
            Sound.Loaded:Once(function() -- Line: 111
                -- upvalues: os_clock_ret (ref), Sound (ref), u14 (ref)
                if os.clock() - os_clock_ret < 1.5 then
                    if not Sound.Parent then
                        return;
                    end;

                    Sound.TimePosition = u14[3];
                    Sound:Play();
                    task.delay(u14[4], function() -- Line: 103
                        -- upvalues: Sound (ref)
                        Sound:Destroy();
                    end);
                end;
            end);

            return;
        end;

        if not Sound.Parent then
            return;
        end;

        Sound.TimePosition = u14[3];
        Sound:Play();
        task.delay(u14[4], function() -- Line: 103
            -- upvalues: Sound (ref)
            Sound:Destroy();
        end);
    end);
    task.delay(4, function() -- Line: 118
        -- upvalues: Sound (copy)
        if Sound.Parent and not Sound.IsPlaying then
            Sound:Destroy();
        end;
    end);
end;

local function pop(p15, p16) -- Line: 126
    -- upvalues: keyIcon (copy), Font_fromEnum_ret (copy), Color3_fromRGB_ret (copy), TweenService (copy)
    local v17 = p15.AbsoluteSize.Y <= 0 and 720 or p15.AbsoluteSize.Y;
    local CanvasGroup = Instance.new("CanvasGroup");
    CanvasGroup.Name = "KeyPop";
    CanvasGroup.BackgroundTransparency = 1;
    CanvasGroup.AnchorPoint = Vector2.new(0.5, 0.5);
    CanvasGroup.Position = UDim2.fromScale(0.5, 0.39);
    CanvasGroup.Size = UDim2.fromScale(0.8, 0.12);
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
    UIListLayout.Padding = UDim.new(0, (math.floor(v17 * 0.008)));
    UIListLayout.Parent = CanvasGroup;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Key";
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = keyIcon();
    ImageLabel.ScaleType = Enum.ScaleType.Fit;
    ImageLabel.Size = UDim2.fromOffset(math.floor(v17 * 0.085), (math.floor(v17 * 0.085)));
    ImageLabel.Parent = CanvasGroup;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Text";
    TextLabel.BackgroundTransparency = 1;
    TextLabel.AutomaticSize = Enum.AutomaticSize.X;
    TextLabel.Size = UDim2.fromOffset(0, (math.floor(v17 * 0.085)));
    TextLabel.FontFace = Font_fromEnum_ret;
    TextLabel.TextSize = math.floor(v17 * 0.06);
    TextLabel.TextColor3 = Color3_fromRGB_ret;
    TextLabel.Text = ("+%d GHOST KEY%s"):format(p16, p16 == 1 and "" or "S");
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.new(0, 0, 0);
    UIStroke.Thickness = math.max(1.5, v17 * 0.004);
    UIStroke.LineJoinMode = Enum.LineJoinMode.Round;
    UIStroke.Parent = TextLabel;
    TextLabel.Parent = CanvasGroup;
    local UIScale = Instance.new("UIScale");
    UIScale.Scale = 1.5;
    UIScale.Parent = CanvasGroup;
    CanvasGroup.Parent = p15;
    TweenService:Create(UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
    task.delay(1.4, function() -- Line: 167
        -- upvalues: TweenService (ref), CanvasGroup (copy)
        TweenService:Create(CanvasGroup, TweenInfo.new(0.45), {
            GroupTransparency = 1,
            Position = UDim2.fromScale(0.5, 0.34)
        }):Play();
        task.delay(0.5, function() -- Line: 169
            -- upvalues: CanvasGroup (ref)
            CanvasGroup:Destroy();
        end);
    end);

    return CanvasGroup;
end;

local function noticeText(p18, p19) -- Line: 176
    local v20 = p18 == 1 and "You found a Ghost Key!" or ("You found %d Ghost Keys!"):format(p18);

    if type(p19) == "number" then
        return ("%s You have %d. Trade %s at the Ghost Key Trader in the lobby."):format(v20, p19, p19 == 1 and "it" or "them");
    end;

    return v20 .. " Trade " .. (p18 == 1 and "it" or "them") .. " at the Ghost Key Trader in the lobby.";
end;

function v1.show(u21, p22) -- Line: 188
    -- upvalues: Players (copy), screen (copy), pop (copy), noticeText (copy), Color3_fromRGB_ret (copy), keyIcon (copy), play (copy), TweenService (copy), RunService (copy)
    local u23 = p22 or {};

    if type(u21) ~= "table" or (type(u21.userId) ~= "number" or typeof(u21.from) ~= "Vector3") then
        return nil;
    end;

    local u24 = u21.userId == (u23.userId or Players.LocalPlayer and Players.LocalPlayer.UserId);
    local u25 = (type(u21.amount) ~= "number" or u21.amount < 1) and 1 or math.floor(u21.amount);
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local from = u21.from;
    local u26 = false;

    local function tell() -- Line: 200
        -- upvalues: u26 (ref), u24 (copy), screen (ref), u23 (ref), pop (ref), u25 (copy), noticeText (ref)
        if u26 or not u24 then
            return;
        end;

        u26 = true;
        local v27 = screen(u23);

        if v27 then
            pcall(pop, v27, u25);
        end;

        if u23.notice then
            pcall(u23.notice, noticeText(u25, u23.keys));
        end;
    end;

    if not (u24 or (not workspace_CurrentCamera or (workspace_CurrentCamera.CFrame.Position - from).Magnitude <= 140)) then
        return nil;
    end;

    local function target() -- Line: 216
        -- upvalues: u23 (ref), Players (ref), u21 (copy)
        if u23.target then
            if u23.target.Parent then
                return u23.target;
            end;

            return nil;
        end;

        local PlayerByUserId = Players:GetPlayerByUserId(u21.userId);

        if PlayerByUserId then
            PlayerByUserId = PlayerByUserId.Character;
        end;

        if PlayerByUserId then
            PlayerByUserId = PlayerByUserId:FindFirstChild("HumanoidRootPart");
        end;

        if PlayerByUserId and PlayerByUserId:IsA("BasePart") then
            return PlayerByUserId;
        end;

        return nil;
    end;

    local Attachment = Instance.new("Attachment");
    Attachment.Name = "GhostKeyDrop";
    Attachment.Parent = u23.world or workspace.Terrain;
    Attachment.WorldPosition = from + Vector3.new(0, 1.2, 0);
    local v28 = u24 and 3 or 2.4;
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "Key";
    BillboardGui.Adornee = Attachment;
    BillboardGui.AlwaysOnTop = u24;
    BillboardGui.LightInfluence = 0;
    BillboardGui.MaxDistance = 140;
    BillboardGui.Size = UDim2.fromScale(v28 * 1.6, v28 * 1.6);
    local UIScale = Instance.new("UIScale");
    UIScale.Scale = 0.3;
    UIScale.Parent = BillboardGui;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Glow";
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = "rbxassetid://129028976496842";
    ImageLabel.ImageColor3 = Color3_fromRGB_ret;
    ImageLabel.ImageTransparency = 0.35;
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
    ImageLabel.Size = UDim2.fromScale(1, 1);
    ImageLabel.Parent = BillboardGui;
    local ImageLabel2 = Instance.new("ImageLabel");
    ImageLabel2.Name = "Key";
    ImageLabel2.BackgroundTransparency = 1;
    ImageLabel2.Image = keyIcon();
    ImageLabel2.ScaleType = Enum.ScaleType.Fit;
    ImageLabel2.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageLabel2.Position = UDim2.fromScale(0.5, 0.5);
    ImageLabel2.Size = UDim2.fromScale(0.62, 0.62);
    ImageLabel2.ZIndex = 2;
    ImageLabel2.Parent = BillboardGui;
    BillboardGui.Parent = Attachment;
    local PointLight = Instance.new("PointLight");
    PointLight.Color = Color3_fromRGB_ret;
    PointLight.Range = 9;
    PointLight.Brightness = 1.6;
    PointLight.Shadows = false;
    PointLight.Parent = Attachment;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Name = "Sparks";
    ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds";
    ParticleEmitter.Color = ColorSequence.new(Color3_fromRGB_ret);
    ParticleEmitter.LightEmission = 1;
    ParticleEmitter.LightInfluence = 0;
    ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.35), NumberSequenceKeypoint.new(1, 0) });
    ParticleEmitter.Lifetime = NumberRange.new(0.4, 0.8);
    ParticleEmitter.Speed = NumberRange.new(1, 3);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.Rate = 18;
    ParticleEmitter.Parent = Attachment;
    local v29;

    if u24 then
        v29 = screen(u23);
    else
        v29 = Attachment;
    end;

    play("Rise", v29, 0);
    local os_clock_ret = os.clock();
    local u30 = nil;
    local u31 = false;
    local u32 = nil;

    local function finish(u33) -- Line: 287
        -- upvalues: u31 (ref), u32 (ref), ParticleEmitter (copy), BillboardGui (copy), PointLight (copy), TweenService (ref), ImageLabel2 (copy), ImageLabel (copy), Attachment (copy), tell (copy)
        if u31 then
            return;
        end;

        u31 = true;

        if u32 then
            u32:Disconnect();
        end;

        pcall(function() -- Line: 295
            -- upvalues: ParticleEmitter (ref), u33 (copy), BillboardGui (ref), PointLight (ref), TweenService (ref), ImageLabel2 (ref), ImageLabel (ref)
            ParticleEmitter.Rate = 0;

            if not u33 then
                TweenService:Create(ImageLabel2, TweenInfo.new(0.35), {
                    ImageTransparency = 1
                }):Play();
                TweenService:Create(ImageLabel, TweenInfo.new(0.35), {
                    ImageTransparency = 1
                }):Play();
                TweenService:Create(PointLight, TweenInfo.new(0.35), {
                    Brightness = 0
                }):Play();

                return;
            end;

            ParticleEmitter:Emit(24);
            BillboardGui.Enabled = false;
            PointLight.Brightness = 4;
            TweenService:Create(PointLight, TweenInfo.new(0.4), {
                Brightness = 0
            }):Play();
        end);
        task.delay(0.9, function() -- Line: 309
            -- upvalues: Attachment (ref)
            Attachment:Destroy();
        end);
        tell();
    end;

    u32 = RunService.RenderStepped:Connect(function() -- Line: 314
        -- upvalues: os_clock_ret (copy), Attachment (copy), finish (copy), ImageLabel2 (copy), from (copy), UIScale (copy), target (copy), u30 (ref), play (ref), u24 (copy), screen (ref), u23 (ref)
        local success, result = pcall(function() -- Line: 315
            -- upvalues: os_clock_ret (ref), Attachment (ref), finish (ref), ImageLabel2 (ref), from (ref), UIScale (ref), target (ref), u30 (ref), play (ref), u24 (ref), screen (ref), u23 (ref)
            local v34 = os.clock() - os_clock_ret;

            if v34 > 5 or not Attachment.Parent then
                return finish(false);
            end;

            local math_cos_ret = math.cos(v34 / 0.6 * 3.141592653589793);
            local math_abs_ret = math.abs(math_cos_ret);
            ImageLabel2.Size = UDim2.fromScale(math.max(0.1, math_abs_ret) * 0.62, 0.62);

            if v34 < 0.4 then
                local v35 = v34 / 0.4;
                local v36 = math.clamp(v35, 0, 1) - 1;
                Attachment.WorldPosition = from + Vector3.new(0, 1, 0) * (1.2 + 2.4000000000000004 * (1 + v36 * v36 * (2.7 * v36 + 1.7)));
                local math_clamp_ret = math.clamp(v35 * 1.4, 0, 1);
                UIScale.Scale = 0.3 + 0.7 * (math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret));

                return;
            end;

            if v34 < 0.75 then
                UIScale.Scale = 1;
                Attachment.WorldPosition = from + Vector3.new(0, 1, 0) * (math.sin((v34 - 0.4) / 0.35 * 3.141592653589793) * 0.15 + 3.6);

                return;
            end;

            local v37 = target();

            if not v37 then
                return finish(false);
            end;

            local v38 = v37.Position + Vector3.new(0, 0.6, 0);

            if not u30 then
                local WorldPosition = Attachment.WorldPosition;
                u30 = {
                    from = WorldPosition,
                    start = os.clock(),
                    seconds = math.clamp((v38 - WorldPosition).Magnitude / 42, 0.3, 0.85)
                };

                if u24 then
                    v37 = screen(u23);
                end;

                play("Got", v37, u30.seconds);
            end;

            local v39 = (os.clock() - u30.start) / u30.seconds;
            local math_clamp_ret = math.clamp(v39, 0, 1);
            local v40 = math_clamp_ret * math_clamp_ret;
            local v41 = (u30.from + v38) / 2 + Vector3.new(0, 1, 0) * (1 + (v38 - u30.from).Magnitude * 0.12);
            Attachment.WorldPosition = u30.from:Lerp(v41, v40):Lerp(v41:Lerp(v38, v40), v40);
            UIScale.Scale = 1 - v40 * 0.45;

            if math_clamp_ret >= 1 then
                finish(true);
            end;
        end);

        if not success then
            warn("[GhostKeyDrop] " .. tostring(result));
            finish(false);
        end;
    end);

    return Attachment;
end;

local u42 = {
    Win = { "You won a Ghost Key!", "You won %d Ghost Keys!" },
    LastManStanding = { "Last Man Standing! You got a Ghost Key!", "Last Man Standing! You got %d Ghost Keys!" }
};

function v1.earned(p43, p44) -- Line: 370
    -- upvalues: screen (copy), pop (copy), play (copy), u42 (copy)
    local v45 = p44 or {};

    if type(p43) ~= "table" then
        return;
    end;

    local v46 = (type(p43.amount) ~= "number" or p43.amount < 1) and 1 or math.floor(p43.amount);
    local v47 = screen(v45);

    if v47 then
        pcall(pop, v47, v46);
        pcall(play, "Got", v47, 0.25);
    end;

    if v45.notice then
        local v48 = u42[p43.reason] or u42.Win;
        local v49;

        if v46 == 1 then
            v49 = v48[1];
        else
            v49 = v48[2]:format(v46);
        end;

        local keys = p43.keys;
        local v50;

        if type(keys) == "number" then
            v50 = ("%s You have %d. Trade %s at the Ghost Key Trader in the lobby."):format(v49, keys, keys == 1 and "it" or "them");
        else
            v50 = v49 .. " Trade " .. (v46 == 1 and "it" or "them") .. " at the Ghost Key Trader in the lobby.";
        end;

        pcall(v45.notice, v50);
    end;
end;

return table.freeze(v1);