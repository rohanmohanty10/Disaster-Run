 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local SoundService = game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local script_Parent = script.Parent;
local EmotePose = require(script_Parent.EmotePose);
local Preview = require(script_Parent.Shop.Preview);
local Widgets = require(script_Parent.Widgets);
local u1 = {};
local Color3_fromRGB_ret = Color3.fromRGB(255, 202, 57);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 222, 135);
local Color3_fromRGB_ret3 = Color3.fromRGB(228, 228, 232);
local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_new_ret2 = Color3.new(0, 0, 0);
local Color3_fromRGB_ret4 = Color3.fromRGB(23, 23, 25);
local NumberSequence_new_ret = NumberSequence.new(0.15, 0.55);
local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(255, 244, 180), Color3.fromRGB(255, 176, 36));
local Vector2_new_ret = Vector2.new(0.5, 0.5);
local UDim_new_ret = UDim.new(0.12, 0);
local Back = Enum.EasingStyle.Back;
local Quad = Enum.EasingStyle.Quad;
local In = Enum.EasingDirection.In;
local Out = Enum.EasingDirection.Out;
local u2 = nil;

local function ease(p3, p4, p5) -- Line: 51
    -- upvalues: TweenService (copy), Out (copy)
    return TweenService:GetValue(math.clamp(p3, 0, 1), p4, p5 or Out);
end;

local function tween(p6, p7, p8, p9, p10) -- Line: 55
    -- upvalues: TweenService (copy), Back (copy), Out (copy)
    local v11 = TweenService:Create(p6, TweenInfo.new(p7, p9 or Back, p10 or Out), p8);
    v11:Play();

    return v11;
end;

local function sound(p12) -- Line: 61
    -- upvalues: SoundService (copy)
    local GameAudio = SoundService:FindFirstChild("GameAudio");

    for i in p12:gmatch("[^%.]+") do
        if GameAudio then
            GameAudio = GameAudio:FindFirstChild(i);
        end;
    end;

    if GameAudio and GameAudio:IsA("Sound") then
        require(game:GetService("ReplicatedFirst"):WaitForChild("LazySound")).playLocal(GameAudio);
    end;
end;

function u1.chime(p13) -- Line: 75
    -- upvalues: SoundService (copy)
    local Sound = Instance.new("Sound");
    Sound.Name = "ClaimSound";
    Sound.SoundId = "rbxassetid://80854650043151";
    Sound.Volume = 0.5;
    local v14 = tonumber(p13) or 1;
    local v15 = (math.max(1, v14) - 1) * 0.05 + 1;
    Sound.PlaybackSpeed = math.min(1.5, v15);
    local GameAudioMixer = SoundService:FindFirstChild("GameAudioMixer");

    if GameAudioMixer then
        GameAudioMixer = GameAudioMixer:FindFirstChild("UI");
    end;

    if GameAudioMixer and GameAudioMixer:IsA("SoundGroup") then
        Sound.SoundGroup = GameAudioMixer;
    end;

    Sound.Ended:Once(function() -- Line: 86
        -- upvalues: Sound (copy)
        Sound:Destroy();
    end);
    Sound.Parent = SoundService;
    Sound:Play();
    task.delay(5, function() -- Line: 92
        -- upvalues: Sound (copy)
        if Sound.Parent then
            Sound:Destroy();
        end;
    end);
end;

local function claimSound(p16) -- Line: 101
    -- upvalues: u1 (copy)
    if p16.chimedAt == p16.clock then
        return;
    end;

    p16.chimedAt = p16.clock;
    p16.chimes = (p16.chimes or 0) + 1;
    u1.chime(p16.chimes);
end;

local function scaleOf(p17) -- Line: 113
    -- upvalues: Vector2_new_ret (copy)
    local Parent = p17.Parent;

    if p17.AnchorPoint ~= Vector2_new_ret or Parent and Parent:FindFirstChildWhichIsA("UIGridStyleLayout") then
        return nil;
    end;

    local v18 = p17:FindFirstChildOfClass("UIScale");

    if not v18 then
        v18 = Instance.new("UIScale");
        v18.Name = "PopScale";
        v18.Parent = p17;
    end;

    if v18.Name == "PopScale" then
        return v18;
    end;

    return nil;
end;

local function flash(p19, p20) -- Line: 128
    -- upvalues: Color3_new_ret (copy), Quad (copy), TweenService (copy), Back (copy), Out (copy)
    if p19:FindFirstChildWhichIsA("UIGridStyleLayout") then
        return;
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = "PopFlash";
    Frame.BackgroundColor3 = Color3_new_ret;
    Frame.BackgroundTransparency = p20;
    Frame.BorderSizePixel = 0;
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.ZIndex = 50;
    local v21 = p19:FindFirstChildOfClass("UICorner");

    if v21 then
        v21:Clone().Parent = Frame;
    end;

    Frame.Parent = p19;
    local v22 = TweenService:Create(Frame, TweenInfo.new(0.35, Quad or Back, Out), {
        BackgroundTransparency = 1
    });
    v22:Play();
    v22.Completed:Once(function() -- Line: 144
        -- upvalues: Frame (copy)
        Frame:Destroy();
    end);
end;

function u1.press(p23) -- Line: 150
    -- upvalues: scaleOf (copy), TweenService (copy), Back (copy), Out (copy), flash (copy)
    local v24 = scaleOf(p23);

    if not v24 then
        flash(p23, 0.6);

        return;
    end;

    v24.Scale = 0.9;
    TweenService:Create(v24, TweenInfo.new(0.3, Back, Out), {
        Scale = 1
    }):Play();
end;

function u1.bounce(p25) -- Line: 161
    -- upvalues: scaleOf (copy), TweenService (copy), Back (copy), Out (copy)
    local v26 = scaleOf(p25);

    if v26 then
        v26.Scale = 1.3;
        TweenService:Create(v26, TweenInfo.new(0.45, Back, Out), {
            Scale = 1
        }):Play();
    end;
end;

function u1.collect(p27, p28) -- Line: 171
    -- upvalues: flash (copy), scaleOf (copy), TweenService (copy), Back (copy), Out (copy)
    flash(p27, 0.35);

    if p28 then
        p28 = scaleOf(p28);
    end;

    if p28 then
        p28.Scale = 1.25;
        TweenService:Create(p28, TweenInfo.new(0.5, Back, Out), {
            Scale = 1
        }):Play();
    end;
end;

local function finish(p29) -- Line: 180
    -- upvalues: u2 (ref)
    if u2 == p29 then
        u2 = nil;
    end;

    if p29.done then
        return;
    end;

    p29.done = true;

    if p29.step then
        p29.step:Disconnect();
        p29.step = nil;
    end;

    if p29.input then
        p29.input:Disconnect();
        p29.input = nil;
    end;

    if p29.match then
        p29.match:Disconnect();
        p29.match = nil;
    end;

    for _, v in p29.items do
        if v.preview then
            v.preview:destroy();
            v.preview = nil;
        end;
    end;

    table.clear(p29.items);
    p29.gui:Destroy();
end;

local function corner(p30) -- Line: 210
    -- upvalues: UDim_new_ret (copy)
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim_new_ret;
    UICorner.Parent = p30;
end;

local function outline(p31, p32, p33) -- Line: 216
    local UIStroke = Instance.new("UIStroke");
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
    UIStroke.Color = p32;
    UIStroke.Thickness = p33;
    UIStroke.Parent = p31;

    return UIStroke;
end;

local function text(p34, p35, p36, p37, p38, p39) -- Line: 229
    -- upvalues: Vector2_new_ret (copy), Color3_new_ret2 (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p35;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.AnchorPoint = Vector2_new_ret;
    TextLabel.Text = p36;
    TextLabel.TextColor3 = p37;
    TextLabel.TextSize = p39;
    TextLabel.TextWrapped = true;
    TextLabel.FontFace = p38;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
    UIStroke.Thickness = 0.12;
    UIStroke.Color = Color3_new_ret2;
    UIStroke.Parent = TextLabel;
    TextLabel.Parent = p34;

    return TextLabel, UIStroke;
end;

local function tile(p40, p41, p42, p43, p44) -- Line: 249
    -- upvalues: Vector2_new_ret (copy), Color3_new_ret (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret4 (copy), NumberSequence_new_ret (copy), UDim_new_ret (copy), Color3_new_ret2 (copy), text (copy), Color3_fromRGB_ret3 (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "Item";
    Frame.AnchorPoint = Vector2_new_ret;
    Frame.Size = UDim2.fromOffset(p42, p42);
    Frame.BackgroundColor3 = Color3_new_ret;
    Frame.BorderSizePixel = 0;
    Frame.Visible = false;
    Frame.ZIndex = 4;
    local v45 = p41.color or Color3_fromRGB_ret;
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Rotation = 90;
    UIGradient.Color = ColorSequence.new(Color3_fromRGB_ret4, v45);
    UIGradient.Transparency = NumberSequence_new_ret;
    UIGradient.Parent = Frame;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim_new_ret;
    UICorner.Parent = Frame;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
    UIStroke.Color = Color3_new_ret2;
    UIStroke.Thickness = 0.07;
    UIStroke.Parent = Frame;
    UIStroke.ZIndex = 1;
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke2.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
    UIStroke2.Color = v45;
    UIStroke2.Thickness = 0.035;
    UIStroke2.Parent = Frame;
    UIStroke2.ZIndex = 2;
    local UIScale = Instance.new("UIScale");
    UIScale.Parent = Frame;
    local v46 = {
        spec = p41,
        holder = Frame,
        scale = UIScale
    };
    local v47 = p41.count and "+0" or p41.amount;

    if p41.title then
        local title = p41.title;
        local v48 = p41.color or Color3_new_ret;
        local math_floor_ret = math.floor(p42 * 0.17);
        local v49 = text(Frame, "Title", title, v48, p44, (math.max(14, math_floor_ret)));
        v49.Position = UDim2.fromScale(0.5, 0.5);
        v49.Size = UDim2.fromScale(0.88, 0.6);
    elseif p43 then
        local v50 = p43:Clone();
        v50.Name = "Picture";
        v50.AnchorPoint = Vector2_new_ret;
        v50.Position = UDim2.fromScale(0.5, v47 and 0.42 or 0.5);
        local v51 = v47 and 0.66 or 0.8;
        v50.Size = UDim2.fromScale(v51, v51);
        local Amount = v50:FindFirstChild("Amount");

        if Amount then
            Amount:Destroy();
        end;

        local Image = v50:FindFirstChild("Image");
        local View = v50:FindFirstChild("View");

        if Image then
            Image.Image = p41.image or "";
            Image.Visible = p41.image ~= nil;
        end;

        if View then
            View.Visible = false;
        end;

        if p41.icon and Image then
            local v52 = p41.icon:Clone();
            v52.AnchorPoint = Image.AnchorPoint;
            v52.Position = Image.Position;
            v52.Size = Image.Size;
            v52.Parent = v50;
            Image.Visible = false;
        end;

        v50.Parent = Frame;
        v46.image = Image;
        v46.view = View;
    end;

    if v47 then
        local v53 = p41.amountColor or Color3_new_ret;
        local math_floor_ret = math.floor(p42 * 0.22);
        local v54 = text(Frame, "Amount", v47, v53, p44, (math.max(14, math_floor_ret)));
        v54.Position = UDim2.fromScale(0.5, 0.81);
        v54.Size = UDim2.fromScale(0.96, 0.3);
        v54.TextWrapped = false;
        v54.ZIndex = 2;
        v46.amount = v54;
    end;

    if p41.name then
        local name = p41.name;
        local math_floor_ret = math.floor(p42 * 0.15);
        local v55 = text(Frame, "Caption", name, Color3_fromRGB_ret3, p44, (math.max(13, math_floor_ret)));
        v55.AnchorPoint = Vector2.new(0.5, 0);
        v55.Position = UDim2.fromScale(0.5, 1.08);
        v55.Size = UDim2.fromScale(1.3, 0.36);
        v55.TextYAlignment = Enum.TextYAlignment.Top;
    end;

    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Glare";
    Frame2.BackgroundColor3 = Color3_new_ret;
    Frame2.BackgroundTransparency = 1;
    Frame2.BorderSizePixel = 0;
    Frame2.Size = UDim2.fromScale(1, 1);
    Frame2.ZIndex = 5;
    local UICorner2 = Instance.new("UICorner");
    UICorner2.CornerRadius = UDim_new_ret;
    UICorner2.Parent = Frame2;
    Frame2.Parent = Frame;
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "Ring";
    Frame3.AnchorPoint = Vector2_new_ret;
    Frame3.Position = UDim2.fromScale(0.5, 0.5);
    Frame3.Size = UDim2.fromScale(1, 1);
    Frame3.BackgroundTransparency = 1;
    Frame3.Visible = false;
    local UICorner3 = Instance.new("UICorner");
    UICorner3.CornerRadius = UDim_new_ret;
    UICorner3.Parent = Frame3;
    local UIStroke3 = Instance.new("UIStroke");
    UIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke3.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
    UIStroke3.Color = v45;
    UIStroke3.Thickness = 0.03;
    UIStroke3.Parent = Frame3;
    v46.ringLine = UIStroke3;
    Frame3.Parent = Frame;
    v46.glare = Frame2;
    v46.ring = Frame3;
    Frame.Parent = p40;

    return v46;
end;

local function picture(u56, u57) -- Line: 347
    -- upvalues: Preview (copy), EmotePose (copy)
    local spec = u57.spec;
    local view = u57.view;

    if not (view and (spec.knife or spec.emote)) then
        return;
    end;

    task.spawn(function() -- Line: 352
        -- upvalues: spec (copy), Preview (ref), view (copy), EmotePose (ref), u56 (copy), u57 (copy)
        local success, result = pcall(function() -- Line: 353
            -- upvalues: spec (ref), Preview (ref), view (ref), EmotePose (ref)
            if spec.knife then
                return Preview.knife(view, spec.knife, nil);
            end;

            return EmotePose.new(view, spec.emote);
        end);

        if not (success and result) then
            return;
        end;

        if u56.done then
            result:destroy();

            return;
        end;

        u57.preview = result;
        view.Visible = true;

        if u57.image then
            u57.image.Visible = false;
        end;
    end);
end;

local function bezier(p58, p59, p60, p61) -- Line: 374
    local v62 = 1 - p61;

    return p58 * (v62 * v62) + p59 * (2 * v62 * p61) + p60 * (p61 * p61);
end;

local function place(p63, p64) -- Line: 379
    p63.holder.Position = UDim2.fromOffset(p64.X, p64.Y);
end;

local function spot(p65, p66) -- Line: 384
    if typeof(p66) ~= "Instance" or not p66:IsA("GuiObject") then
        return nil;
    end;

    local v67 = p66;

    while p66 and not p66:IsA("LayerCollector") do
        if p66:IsA("GuiObject") and not p66.Visible then
            return nil;
        end;

        p66 = p66.Parent;
    end;

    if not (p66 and p66.Enabled) then
        return nil;
    end;

    local AbsoluteSize = v67.AbsoluteSize;
    local v68 = v67.AbsolutePosition + AbsoluteSize * 0.5 - p65.base;
    local AbsoluteSize2 = p65.gui.AbsoluteSize;

    if AbsoluteSize.X < 1 or (v68.X < 0 or (v68.Y < 0 or (v68.X > AbsoluteSize2.X or v68.Y > AbsoluteSize2.Y))) then
        return nil;
    end;

    return v68;
end;

local function land(p69, p70) -- Line: 407
    p69.state = "landed";
    p69.landedAt = p70;
    local to = p69.to;
    p69.holder.Position = UDim2.fromOffset(to.X, to.Y);
    p69.scale.Scale = 1;
    p69.holder.Rotation = 0;
    p69.glare.BackgroundTransparency = 0.35;
    p69.ring.Visible = true;

    if p69.spec.emote and not p69.spec.still then
        p69.playAt = p70 + 0.3;
    end;
end;

local function leave(p71, p72) -- Line: 422
    -- upvalues: Widgets (copy), spot (copy)
    p71.leaving = p72;
    local v73 = 0;
    local v74 = 0.3;

    for i, v in p71.items do
        v.state = "leave";
        v.glare.BackgroundTransparency = 1;
        v.ring.Visible = false;

        if v.amount and v.spec.count then
            v.amount.Text = "+" .. Widgets.number(v.spec.count);
        end;

        local v75 = spot(p71, v.spec.target);

        if v75 then
            v.exitTo = v75;
            v.exitVia = Vector2.new((v.to.X + v75.X) * 0.5, math.min(v.to.Y, v75.Y) - p71.size * 0.6);
            v.exitDelay = v73 * 0.1;
            v.exitTime = 0.55;
            v73 = v73 + 1;
        else
            v.exitDelay = (i - 1) * 0.04;
            v.exitTime = 0.28;
        end;

        v74 = math.max(v74, v.exitDelay + v.exitTime);
    end;

    p71.endAt = p72 + v74 + 0.05;
end;

local function step(p76, p77) -- Line: 448
    -- upvalues: Quad (copy), TweenService (copy), Out (copy), Back (copy), u1 (copy), Widgets (copy), sound (copy), leave (copy), In (copy), finish (copy)
    local v78 = p76.clock + p77;
    p76.clock = v78;
    local leaving = p76.leaving;
    local v79 = not leaving and 1 or 1 - math.clamp((v78 - leaving) / 0.3, 0, 1);
    p76.dim.BackgroundTransparency = 1 - 0.45 * TweenService:GetValue(math.clamp(v78 / 0.25, 0, 1), Quad, Out) * v79;
    local v80 = TweenService:GetValue(math.clamp(v78 / 0.45, 0, 1), Quad, Out) * v79;

    for _, v in p76.rays do
        v.image.ImageTransparency = 1 - v.alpha * v80;
        v.image.Rotation = (v.image.Rotation + p77 * v.spin) % 360;
    end;

    local v81 = math.clamp((v78 - 0.05) / 0.2, 0, 1) * v79;
    p76.heading.TextTransparency = 1 - v81;
    p76.headingLine.Transparency = 1 - v81;
    p76.headingScale.Scale = 0.5 + 0.5 * TweenService:GetValue(math.clamp((v78 - 0.05) / 0.4, 0, 1), Back, Out);
    local v82 = 0;

    for _, v in p76.items do
        local state = v.state;

        if state == "wait" and (v.start <= v78 or p76.skip) then
            state = "fly";
            v.state = state;
            v.holder.Visible = true;
        end;

        if state == "fly" then
            local v83 = (v78 - v.start) / 0.45;

            if v83 >= 1 or p76.skip then
                v.state = "landed";
                v.landedAt = v78;
                local to = v.to;
                v.holder.Position = UDim2.fromOffset(to.X, to.Y);
                v.scale.Scale = 1;
                v.holder.Rotation = 0;
                v.glare.BackgroundTransparency = 0.35;
                v.ring.Visible = true;

                if v.spec.emote and not v.spec.still then
                    v.playAt = v78 + 0.3;
                end;

                state = "landed";

                if p76.chimedAt ~= p76.clock then
                    p76.chimedAt = p76.clock;
                    p76.chimes = (p76.chimes or 0) + 1;
                    u1.chime(p76.chimes);
                end;
            else
                local from = v.from;
                local via = v.via;
                local to = v.to;
                local Value = TweenService:GetValue(math.clamp(v83, 0, 1), Quad, Out);
                local v84 = 1 - Value;
                local v85 = from * (v84 * v84) + via * (2 * v84 * Value) + to * (Value * Value);
                v.holder.Position = UDim2.fromOffset(v85.X, v85.Y);
                v.scale.Scale = 0.3 + 0.7 * TweenService:GetValue(math.clamp(v83, 0, 1), Back, Out);
            end;
        end;

        if state == "landed" then
            v82 = v82 + 1;
            local v86 = v78 - v.landedAt;

            if v.ring.Visible then
                local v87 = v86 / 0.45;

                if v87 >= 1 then
                    v.ring.Visible = false;
                    v.glare.BackgroundTransparency = 1;
                else
                    local Value = TweenService:GetValue(math.clamp(v87, 0, 1), Quad, Out);
                    v.ring.Size = UDim2.fromScale(1 + 0.6 * Value, 1 + 0.6 * Value);
                    v.ringLine.Transparency = Value;
                    v.glare.BackgroundTransparency = math.min(1, 0.35 + v87 * 1.6);
                end;
            end;

            if v.amount and (v.spec.count and not v.counted) then
                local v88 = v86 / 0.55;
                v.counted = v88 >= 1;
                local amount = v.amount;
                local number = Widgets.number;
                local v89 = v.spec.count * TweenService:GetValue(math.clamp(v88, 0, 1), Quad, Out);
                amount.Text = "+" .. number((math.round(v89)));
            end;

            if v.playAt and (v.preview and v.playAt <= v78) then
                v.playAt = nil;
                v.preview:play();
            end;
        end;

        if v.preview then
            v.preview:step(p77);
        end;
    end;

    if not p76.landedAll and v82 == #p76.items then
        p76.landedAll = v78;
        local _ = p76.skip;
        p76.leaveAt = v78 + 15;
        sound("04_UI.MatchSummary.CountComplete");
    end;

    if p76.landedAll then
        local v90 = math.clamp((v78 - p76.landedAll - 0.3) / 0.3, 0, 1) * v79 * (math.cos((v78 - p76.landedAll) * 4) * 0.2 + 0.8);
        p76.hint.TextTransparency = 1 - v90;
        p76.hintLine.Transparency = 1 - v90;

        if not leaving and p76.leaveAt <= v78 then
            leave(p76, v78);
            leaving = v78;
        end;
    end;

    if leaving then
        for _, v in p76.items do
            if v.state == "leave" then
                local v91 = (v78 - leaving - v.exitDelay) / v.exitTime;

                if v91 >= 1 then
                    v.state = "gone";
                    v.holder.Visible = false;

                    if v.exitTo then
                        u1.bounce(v.spec.target);
                        sound("04_UI.MatchSummary.CountTick");
                    end;
                elseif v91 > 0 then
                    if v.exitTo then
                        local Value = TweenService:GetValue(math.clamp(v91, 0, 1), Quad, In or Out);
                        local v92 = 1 - Value;
                        local v93 = v.to * (v92 * v92) + v.exitVia * (2 * v92 * Value) + v.exitTo * (Value * Value);
                        v.holder.Position = UDim2.fromOffset(v93.X, v93.Y);
                        v.scale.Scale = 1 - 0.7 * Value;
                    else
                        v.scale.Scale = 1 - TweenService:GetValue(math.clamp(v91, 0, 1), Back, In or Out);
                    end;
                end;
            end;
        end;

        if p76.endAt <= v78 then
            finish(p76);
        end;
    end;
end;

local function hintText() -- Line: 555
    -- upvalues: UserInputService (copy)
    local PreferredInput = UserInputService.PreferredInput;

    return PreferredInput == Enum.PreferredInput.Touch and "Tap to continue" or (PreferredInput == Enum.PreferredInput.Gamepad and "Press a button to continue" or "Click to continue");
end;

local u94 = {
    [Enum.KeyCode.ButtonA] = true,
    [Enum.KeyCode.ButtonB] = true,
    [Enum.KeyCode.ButtonX] = true,
    [Enum.KeyCode.ButtonY] = true
};

function u1.show(p95, p96) -- Line: 576
    -- upvalues: u2 (ref), finish (copy), Players (copy), Color3_new_ret2 (copy), Color3_fromRGB_ret2 (copy), Vector2_new_ret (copy), text (copy), Color3_new_ret (copy), ColorSequence_new_ret (copy), UserInputService (copy), Color3_fromRGB_ret3 (copy), tile (copy), Preview (copy), EmotePose (copy), RunService (copy), u94 (copy), step (copy), sound (copy)
    if u2 then
        finish(u2);
    end;

    local v97 = #p95;
    local LocalPlayer = Players.LocalPlayer;
    local v98;

    if LocalPlayer then
        v98 = LocalPlayer:FindFirstChildOfClass("PlayerGui");
    else
        v98 = LocalPlayer;
    end;

    if v97 == 0 or not v98 then
        return;
    end;

    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "RewardPop";
    ScreenGui.DisplayOrder = p96.displayOrder or 50;
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.ScreenInsets = Enum.ScreenInsets.None;
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    ScreenGui.Parent = v98;
    local AbsolutePosition = ScreenGui.AbsolutePosition;
    local AbsoluteSize = ScreenGui.AbsoluteSize;

    if AbsoluteSize.X < 1 or AbsoluteSize.Y < 1 then
        AbsoluteSize = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1280, 720);
    end;

    local v99 = p96.font and p96.font.Family;
    local v100;

    if v99 then
        v100 = Font.new(v99, Enum.FontWeight.ExtraBold);
    else
        v100 = Font.fromEnum(Enum.Font.GothamBold);
    end;

    local v101;

    if v99 then
        v101 = Font.new(v99, Enum.FontWeight.Heavy);
    else
        v101 = Font.fromEnum(Enum.Font.GothamBlack);
    end;

    local v102;

    if v97 > 5 then
        v102 = math.ceil(v97 / 2);
    else
        v102 = v97;
    end;

    local math_ceil_ret = math.ceil(v97 / v102);
    local math_min_ret = math.min(AbsoluteSize.Y * 0.2, AbsoluteSize.X * 0.86 / ((v102 - 1) * 1.32 + 1.3), AbsoluteSize.Y * 0.84 / ((math_ceil_ret - 1) * 1.55 + 2.35));
    local math_floor_ret = math.floor(math_min_ret);
    local v103 = math_floor_ret * 1.32;
    local v104 = math_floor_ret * 1.55;
    local v105 = AbsoluteSize.Y * 0.5 - math_floor_ret * ((math_ceil_ret - 1) * 1.55 + 2.35) * 0.5;
    local v106 = v105 + math_floor_ret * 1.1;
    local v107 = v106 + (math_ceil_ret - 1) * v104;
    local Vector2_new_ret2 = Vector2.new(AbsoluteSize.X * 0.5, (v106 + v107) * 0.5);
    local v108;

    if p96.origin then
        v108 = p96.origin - AbsolutePosition;
    else
        v108 = Vector2.new(AbsoluteSize.X * 0.5, AbsoluteSize.Y * 0.85);
    end;

    local u109 = {
        clock = 0,
        gui = ScreenGui,
        items = {},
        rays = {},
        base = AbsolutePosition,
        size = math_floor_ret
    };
    u2 = u109;
    local Frame = Instance.new("Frame");
    Frame.Name = "Backdrop";
    Frame.BackgroundColor3 = Color3_new_ret2;
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.Parent = ScreenGui;
    u109.dim = Frame;
    local math_max_ret = math.max(v102 * v103 * 1.1, math_floor_ret * 3.3);
    local math_min_ret2 = math.min(math_max_ret, AbsoluteSize.X * 1.1, AbsoluteSize.Y * 1.25);
    local math_floor_ret2 = math.floor(math_min_ret2);

    for i, v in { 14, -9 } do
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "Rays";
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.Image = "rbxassetid://129028976496842";
        ImageLabel.ImageColor3 = Color3_fromRGB_ret2;
        ImageLabel.ImageTransparency = 1;
        ImageLabel.AnchorPoint = Vector2_new_ret;
        ImageLabel.Position = UDim2.fromOffset(Vector2_new_ret2.X, Vector2_new_ret2.Y);
        local v110;

        if i == 1 then
            v110 = math_floor_ret2;
        else
            v110 = math.floor(math_floor_ret2 * 0.8);
        end;

        ImageLabel.Size = UDim2.fromOffset(v110, v110);
        ImageLabel.Rotation = i * 20;
        ImageLabel.ZIndex = 2;
        ImageLabel.Parent = ScreenGui;
        table.insert(u109.rays, {
            image = ImageLabel,
            spin = v,
            alpha = i == 1 and 0.3 or 0.2
        });
    end;

    local v111 = p96.heading or (v97 == 1 and "REWARD CLAIMED!" or "REWARDS CLAIMED!");
    local math_floor_ret3 = math.floor(math_floor_ret * 0.3);
    local v112, v113 = text(ScreenGui, "Heading", v111, Color3_new_ret, v101, (math.max(20, math_floor_ret3)));
    v112.Position = UDim2.fromOffset(AbsoluteSize.X * 0.5, v105 + math_floor_ret * 0.19);
    local UDim2_fromOffset = UDim2.fromOffset;
    local math_min_ret3 = math.min(AbsoluteSize.X * 0.8, math_floor_ret * 5);
    v112.Size = UDim2_fromOffset(math.floor(math_min_ret3), (math.floor(math_floor_ret * 0.38)));
    v112.ZIndex = 6;
    v112.TextTransparency = 1;
    v113.Transparency = 1;
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Rotation = 90;
    UIGradient.Color = ColorSequence_new_ret;
    UIGradient.Parent = v112;
    local UIScale = Instance.new("UIScale");
    UIScale.Scale = 0.5;
    UIScale.Parent = v112;
    u109.heading = v112;
    u109.headingLine = v113;
    u109.headingScale = UIScale;
    local PreferredInput = UserInputService.PreferredInput;
    local v114 = PreferredInput == Enum.PreferredInput.Touch and "Tap to continue" or (PreferredInput == Enum.PreferredInput.Gamepad and "Press a button to continue" or "Click to continue");
    local math_floor_ret4 = math.floor(math_floor_ret * 0.12);
    local v115, v116 = text(ScreenGui, "Hint", v114, Color3_fromRGB_ret3, v100, (math.max(12, math_floor_ret4)));
    v115.Position = UDim2.fromOffset(AbsoluteSize.X * 0.5, v107 + math_floor_ret * 1.14);
    local UDim2_fromOffset2 = UDim2.fromOffset;
    local math_min_ret4 = math.min(AbsoluteSize.X * 0.8, math_floor_ret * 4);
    local math_floor_ret5 = math.floor(math_min_ret4);
    local math_floor_ret6 = math.floor(math_floor_ret * 0.16);
    v115.Size = UDim2_fromOffset2(math_floor_ret5, (math.max(14, math_floor_ret6)));
    v115.ZIndex = 6;
    v115.TextTransparency = 1;
    v116.Transparency = 1;
    u109.hint = v115;
    u109.hintLine = v116;

    for i, v in p95 do
        local v117 = tile(ScreenGui, v, math_floor_ret, p96.template, v100);
        local math_ceil_ret2 = math.ceil(i / v102);
        local v118;

        if math_ceil_ret2 < math_ceil_ret then
            v118 = v102;
        else
            v118 = v97 - (math_ceil_ret - 1) * v102;
        end;

        local Vector2_new_ret3 = Vector2.new(AbsoluteSize.X * 0.5 + ((i - 1) % v102 - (v118 - 1) * 0.5) * v103, v106 + (math_ceil_ret2 - 1) * v104);
        local math_max_ret2 = math.max(math_floor_ret * 0.8, (Vector2_new_ret3 - v108).Magnitude * 0.35);
        v117.from = v108;
        v117.to = Vector2_new_ret3;
        v117.via = Vector2.new((v108.X + Vector2_new_ret3.X) * 0.5, math.min(v108.Y, Vector2_new_ret3.Y) - math_max_ret2);
        v117.start = 0.2 + (i - 1) * 0.14;
        v117.state = "wait";
        v117.holder.Position = UDim2.fromOffset(v108.X, v108.Y);
        v117.scale.Scale = 0.3;
        table.insert(u109.items, v117);
    end;

    task.spawn(function() -- Line: 697
        -- upvalues: u109 (copy), Preview (ref), EmotePose (ref), RunService (ref)
        for _, v in u109.items do
            if u109.done then
                return;
            end;

            local u119 = u109;
            local spec = v.spec;
            local view = v.view;

            if view and (spec.knife or spec.emote) then
                task.spawn(function() -- Line: 352
                    -- upvalues: spec (copy), Preview (ref), view (copy), EmotePose (ref), u119 (copy), v (copy)
                    local success, result = pcall(function() -- Line: 353
                        -- upvalues: spec (ref), Preview (ref), view (ref), EmotePose (ref)
                        if spec.knife then
                            return Preview.knife(view, spec.knife, nil);
                        end;

                        return EmotePose.new(view, spec.emote);
                    end);

                    if not (success and result) then
                        return;
                    end;

                    if u119.done then
                        result:destroy();

                        return;
                    end;

                    v.preview = result;
                    view.Visible = true;

                    if v.image then
                        v.image.Visible = false;
                    end;
                end);
            end;

            RunService.Heartbeat:Wait();
        end;
    end);
    u109.input = UserInputService.InputBegan:Connect(function(p120) -- Line: 708
        -- upvalues: u109 (copy), u94 (ref)
        local UserInputType = p120.UserInputType;

        if not (u109.leaving or UserInputType ~= Enum.UserInputType.MouseButton1 and (UserInputType ~= Enum.UserInputType.Touch and not u94[p120.KeyCode])) then
            if u109.landedAll then
                u109.leaveAt = u109.clock;

                return;
            end;

            u109.skip = true;
        end;
    end);
    u109.match = LocalPlayer:GetAttributeChangedSignal("InMatch"):Connect(function() -- Line: 722
        -- upvalues: LocalPlayer (copy), finish (ref), u109 (copy)
        if LocalPlayer:GetAttribute("InMatch") == true then
            finish(u109);
        end;
    end);
    u109.step = RunService.RenderStepped:Connect(function(p121) -- Line: 727
        -- upvalues: step (ref), u109 (copy)
        step(u109, p121);
    end);
    sound("04_UI.MatchSummary.Reveal");
end;

function u1.cancel() -- Line: 734
    -- upvalues: u2 (ref), finish (copy)
    if u2 then
        finish(u2);
    end;
end;

return u1;