 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local MarketplaceService = game:GetService("MarketplaceService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Packages.Trove);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local NumberUtil = require(ReplicatedStorage.Shared.Utility.NumberUtil);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local GetUnixTime = require(ReplicatedStorage.Shared.Utility.GetUnixTime);
local Customization = require(ReplicatedStorage.Shared.Tables.Customization);
require(ReplicatedStorage.Shared.Utility.Essentials);
local ScriptableEmotes = require(ReplicatedStorage.Shared.Tables.ScriptableEmotes);
local ScriptableCosmetics = require(ReplicatedStorage.Shared.Tables.ScriptableCosmetics);
require(ReplicatedStorage.Shared.Tables.SeasonPass);
local WheelItems = require(ReplicatedStorage.Shared.Tables.WheelItems);
local u1 = Trove.new();
local v2 = Knit.CreateController({
    Name = "SpinWheelController"
});

local function deep_equals(p3, p4, p5) -- Line: 31
    -- upvalues: deep_equals (copy)
    if p3 == p4 then
        return true;
    end;

    local v6 = type(p3);

    if v6 ~= type(p4) then
        return false;
    end;

    if v6 ~= "table" then
        return false;
    end;

    if not p5 then
        local v7 = getmetatable(p3);

        if v7 and v7.__eq then
            return p3 == p4;
        end;
    end;

    for i, v in pairs(p3) do
        local v8 = p4[i];

        if v8 == nil or deep_equals(v, v8, p5) == false then
            return false;
        end;
    end;

    for i, _ in pairs(p4) do
        if p3[i] == nil then
            return false;
        end;
    end;

    return true;
end;

local u9 = {
    Spin = 3606541311,
    ["3Spins"] = 3606541348,
    ["10Spins"] = 3606541426
};
local u10 = { "1", "2", "3" };
local u11 = { "ConnectorOne", "ConnectorTwo" };
local u12 = #u11;
local Attribute = workspace:GetAttribute("SpinWheelTime");
local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(122, 122, 122);
local Color3_fromRGB_ret3 = Color3.fromRGB(24, 26, 45);
local Color3_fromRGB_ret4 = Color3.fromRGB(255, 214, 92);
local u13 = nil;
local u14 = 0;
local u15 = false;
local u16 = false;
local u17 = {};
local NumberValue = Instance.new("NumberValue");
NumberValue.Value = 1;
local NumberValue2 = Instance.new("NumberValue");

local function SliceCenter(p18) -- Line: 96
    return ({ 0, -180, -60, -240, -120, -300 })[p18];
end;

local function GetSliceNumFromRotation(p19) -- Line: 107
    return math.floor((p19 - 30) % 360 / 60) + 1;
end;

local function lerp(p20, p21, p22) -- Line: 115
    return p20 + (p21 - p20) * p22;
end;

local function quart(p23) -- Line: 119
    -- upvalues: TweenService (copy)
    return TweenService:GetValue(p23, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
end;

local function Info(p24, p25, p26) -- Line: 123
    return TweenInfo.new(p24, Enum.EasingStyle[p25], Enum.EasingDirection[p26 or "Out"]);
end;

local function Tween(p27, p28, p29) -- Line: 127
    -- upvalues: TweenService (copy)
    local v30 = TweenService:Create(p27, p28, p29);
    v30:Play();

    return v30;
end;

local function New(p31, p32, p33) -- Line: 133
    local Instance_new_ret = Instance.new(p31);

    for i, v in p32 do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p33;

    return Instance_new_ret;
end;

local function GetScale(p34) -- Line: 142
    local v35 = p34:FindFirstChildOfClass("UIScale");

    if not v35 then
        v35 = Instance.new("UIScale");

        for i, v in {} do
            v35[i] = v;
        end;

        v35.Parent = p34;
    end;

    return v35;
end;

local function Punch(p36, p37) -- Line: 146
    -- upvalues: TweenService (copy), Tween (copy)
    TweenService:Create(p36, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Scale = p37
    }):Play();
    task.delay(0.12, Tween, p36, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    });
end;

local function FormatProgress(p38) -- Line: 151
    -- upvalues: u12 (copy)
    return `PROGRESS: {p38}/{u12}`;
end;

local function GetOwned() -- Line: 155
    -- upvalues: Knit (copy), WheelItems (copy)
    local Inventory = Knit.GetController("Network").Player.Customization.Inventory;
    local v39 = {};

    for i = 1, 2 do
        local v40 = WheelItems.Rewards[i == 1 and 2 or 1];

        if v40 then
            v40 = v40[3];
        end;

        local v41;

        if typeof(v40) == "table" then
            v41 = table.find(Inventory[v40.Type], v40.Name) ~= nil;
        else
            v41 = false;
        end;

        v39[i] = v41;
        local _ = i;
    end;

    v39[3] = v39[1] and v39[2];

    return v39;
end;

local function SampleSequence(p42, p43) -- Line: 170
    local Keypoints = p42.Keypoints;

    for i = 1, #Keypoints - 1 do
        local v44 = Keypoints[i];
        local v45 = Keypoints[i + 1];

        if p43 <= v45.Time then
            return v44.Value:Lerp(v45.Value, (math.clamp((p43 - v44.Time) / (v45.Time - v44.Time), 0, 1)));
        end;

        local _ = i;
    end;

    return Keypoints[#Keypoints].Value;
end;

local function Shake(p46, p47, p48, p49) -- Line: 182
    -- upvalues: RunService (copy)
    local os_clock_ret = os.clock();

    while os.clock() - os_clock_ret < p49 do
        local v50 = p48 * (1 - (os.clock() - os_clock_ret) / p49) ^ 2;
        p46.Position = p47 + UDim2.fromScale((math.random() * 2 - 1) * v50, (math.random() * 2 - 1) * v50);
        RunService.PreRender:Wait();
    end;

    p46.Position = p47;
end;

local function Burst(p51) -- Line: 192
    -- upvalues: Color3_fromRGB_ret (copy), TweenService (copy), Debris (copy), Color3_fromRGB_ret4 (copy)
    local TweenInfo_new_ret = TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
    local Vector2_new_ret = Vector2.new(0.5, 0.5);
    local UDim2_fromScale_ret = UDim2.fromScale(0.5, 0.5);
    local v52 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2_new_ret,
        Position = UDim2_fromScale_ret,
        Size = UDim2.fromScale(0.8, 0.8),
        ZIndex = p51.ZIndex + 2
    };
    local Frame = Instance.new("Frame");

    for i, v in v52 do
        Frame[i] = v;
    end;

    Frame.Parent = p51;
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");

    for i, v in {} do
        UIAspectRatioConstraint[i] = v;
    end;

    UIAspectRatioConstraint.Parent = Frame;
    local v53 = {
        CornerRadius = UDim.new(0.5, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v53 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v54 = {
        Thickness = 8,
        Color = Color3_fromRGB_ret
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v54 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    TweenService:Create(Frame, TweenInfo_new_ret, {
        Size = UDim2.fromScale(2.8, 2.8)
    }):Play();
    TweenService:Create(UIStroke, TweenInfo_new_ret, {
        Thickness = 0,
        Transparency = 1
    }):Play();
    local v55 = {
        BackgroundTransparency = 1,
        ImageTransparency = 0.2,
        Image = p51.Image,
        ScaleType = p51.ScaleType,
        AnchorPoint = Vector2_new_ret,
        Position = UDim2_fromScale_ret,
        Size = UDim2.fromScale(1, 1),
        ZIndex = p51.ZIndex + 1
    };
    local ImageLabel = Instance.new("ImageLabel");

    for i, v in v55 do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = p51;
    TweenService:Create(ImageLabel, TweenInfo_new_ret, {
        ImageTransparency = 1,
        Size = UDim2.fromScale(1.9, 1.9)
    }):Play();
    Debris:AddItem(Frame, TweenInfo_new_ret.Time);
    Debris:AddItem(ImageLabel, TweenInfo_new_ret.Time);

    for i = 1, 12 do
        local v56 = math.random(10, 18) / 100;
        local v57 = {
            BorderSizePixel = 0,
            Rotation = 45,
            AnchorPoint = Vector2_new_ret,
            Position = UDim2_fromScale_ret,
            Size = UDim2.fromScale(v56, v56),
            SizeConstraint = Enum.SizeConstraint.RelativeXX,
            BackgroundColor3 = i % 3 == 0 and Color3_fromRGB_ret4 or Color3_fromRGB_ret,
            ZIndex = p51.ZIndex + 3
        };
        local Frame2 = Instance.new("Frame");

        for i2, v in v57 do
            Frame2[i2] = v;
        end;

        Frame2.Parent = p51;
        local UIStroke2 = Instance.new("UIStroke");

        for i2, v in {
            Thickness = 2
        } do
            UIStroke2[i2] = v;
        end;

        UIStroke2.Parent = Frame2;
        local v58 = i / 12 * 3.141592653589793 * 2 + math.random() * 0.5;
        local v59 = 0.9 + math.random() * 0.7;
        local v60 = 0.55 + math.random() * 0.25;
        local TweenInfo_new_ret2 = TweenInfo.new(v60, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
        TweenService:Create(Frame2, TweenInfo_new_ret2, {
            Position = UDim2.fromScale(0.5 + math.cos(v58) * v59, 0.5 + math.sin(v58) * v59),
            Size = UDim2.fromScale(0, 0),
            Rotation = 45 + math.random(-180, 180)
        }):Play();
        TweenService:Create(UIStroke2, TweenInfo_new_ret2, {
            Thickness = 0
        }):Play();
        Debris:AddItem(Frame2, TweenInfo_new_ret2.Time);
    end;
end;

local function Charge(p61) -- Line: 237
    -- upvalues: TweenService (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), RunService (copy)
    local TweenInfo_new_ret = TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
    local v62 = p61:FindFirstChildOfClass("UIScale");

    if not v62 then
        v62 = Instance.new("UIScale");

        for i, v in {} do
            v62[i] = v;
        end;

        v62.Parent = p61;
    end;

    TweenService:Create(v62, TweenInfo_new_ret, {
        Scale = 1.15
    }):Play();
    TweenService:Create(p61, TweenInfo_new_ret, {
        ImageColor3 = Color3_fromRGB_ret2:Lerp(Color3_fromRGB_ret, 0.4)
    }):Play();
    local os_clock_ret = os.clock();

    while os.clock() - os_clock_ret < TweenInfo_new_ret.Time do
        local v63 = os.clock() * 60;
        p61.Rotation = math.sin(v63) * 6 * (os.clock() - os_clock_ret) / TweenInfo_new_ret.Time;
        RunService.PreRender:Wait();
    end;

    p61.Rotation = 0;
end;

local function SetConnector(p64, p65) -- Line: 250
    -- upvalues: u17 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret3 (copy)
    p64.UIGradient.Color = u17[p64];
    p64.UIGradient.Enabled = p65;
    p64.BackgroundColor3 = p65 and Color3_fromRGB_ret or Color3_fromRGB_ret3;
end;

local function BuildSwoop(p66, p67) -- Line: 256
    -- upvalues: Color3_fromRGB_ret3 (copy), SampleSequence (copy), Color3_fromRGB_ret (copy)
    if p67 <= 0 then
        return ColorSequence.new(Color3_fromRGB_ret3);
    end;

    if p67 >= 1 then
        return p66;
    end;

    local math_clamp_ret = math.clamp(p67, 0.002, 0.997);
    local v68 = math_clamp_ret - 0.15;
    local v69 = { ColorSequenceKeypoint.new(0, SampleSequence(p66, 0)) };

    if v68 > 0.001 then
        table.insert(v69, ColorSequenceKeypoint.new(v68, SampleSequence(p66, v68)));
    end;

    local ColorSequenceKeypoint_new = ColorSequenceKeypoint.new;
    local v70 = SampleSequence(p66, math_clamp_ret);
    table.insert(v69, ColorSequenceKeypoint_new(math_clamp_ret, v70:Lerp(Color3_fromRGB_ret, 0.75)));
    table.insert(v69, ColorSequenceKeypoint.new(math_clamp_ret + 0.001, Color3_fromRGB_ret3));
    table.insert(v69, ColorSequenceKeypoint.new(1, Color3_fromRGB_ret3));

    return ColorSequence.new(v69);
end;

local function SwoopConnector(p71) -- Line: 274
    -- upvalues: u17 (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret (copy), BuildSwoop (copy), TweenService (copy), RunService (copy)
    local UIGradient = p71.UIGradient;
    local v72 = u17[p71];
    UIGradient.Color = ColorSequence.new(Color3_fromRGB_ret3);
    UIGradient.Enabled = true;
    p71.BackgroundColor3 = Color3_fromRGB_ret;
    local os_clock_ret = os.clock();
    local v73;

    repeat
        local v74 = (os.clock() - os_clock_ret) / 0.9;
        v73 = math.min(v74, 1);
        UIGradient.Color = BuildSwoop(v72, TweenService:GetValue(v73, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut));
        RunService.PreRender:Wait();
    until v73 >= 1;

    UIGradient.Color = v72;
end;

local function SetupBar(p75) -- Line: 292
    -- upvalues: u10 (copy), u11 (copy), u17 (copy)
    for _, v in u10 do
        p75:WaitForChild(v).AnchorPoint = Vector2.new(0.5, 0.5);
    end;

    for _, v in u11 do
        local v76 = p75:WaitForChild(v);
        u17[v76] = v76:WaitForChild("UIGradient").Color;
    end;
end;

local function SetBar(p77, p78, p79) -- Line: 303
    -- upvalues: u10 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), u11 (copy), u17 (copy), Color3_fromRGB_ret3 (copy)
    for i, v in u10 do
        local v80 = p77[v];
        v80.ImageColor3 = i <= p78 + 1 and Color3_fromRGB_ret or Color3_fromRGB_ret2;
        v80.Rotation = 0;
        local v81 = v80:FindFirstChildOfClass("UIScale");
        local v82;

        if v81 then
            v82 = i;
        else
            v81 = Instance.new("UIScale");
            v82 = i;

            for i2, v3 in {} do
                v81[i2] = v3;
            end;

            v81.Parent = v80;
        end;

        v81.Scale = 1;
        local Tick = v80:FindFirstChild("Tick");

        if Tick then
            Tick.Visible = p79[v82] == true;
            local v83 = Tick:FindFirstChildOfClass("UIScale");

            if not v83 then
                v83 = Instance.new("UIScale");

                for i2, v3 in {} do
                    v83[i2] = v3;
                end;

                v83.Parent = Tick;
            end;

            v83.Scale = 1;
        end;
    end;

    for i, v in u11 do
        local v84 = p77[v];
        local v85 = i <= p78;
        v84.UIGradient.Color = u17[v84];
        v84.UIGradient.Enabled = v85;
        v84.BackgroundColor3 = v85 and Color3_fromRGB_ret or Color3_fromRGB_ret3;
    end;
end;

local function PopTick(p86, p87) -- Line: 322
    -- upvalues: Tween (copy)
    local Tick = p86:FindFirstChild("Tick");

    if not Tick then
        return;
    end;

    local v88 = Tick:FindFirstChildOfClass("UIScale");

    if not v88 then
        v88 = Instance.new("UIScale");

        for i, v in {} do
            v88[i] = v;
        end;

        v88.Parent = Tick;
    end;

    v88.Scale = 0;
    Tick.Visible = true;
    task.delay(0.12 + (p87 or 0), Tween, v88, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    });
end;

local function RevealTicks(p89, p90) -- Line: 332
    -- upvalues: u10 (copy), PopTick (copy)
    for i, v in u10 do
        if p90[i] then
            PopTick(p89[v], 0.4 + (i - 1) * 0.15);
        end;
    end;
end;

local function NewScene(p91, p92, p93) -- Line: 340
    local ZoneCharacter = p91:WaitForChild("ZoneCharacter");
    local Sunburst = p91:WaitForChild("Sunburst");
    local SunburstCounter = p91:WaitForChild("SunburstCounter");
    local Template = p91:WaitForChild("ParticleMask"):WaitForChild("Holder"):WaitForChild("Template");
    Template.Visible = false;
    local v94 = {
        Next = 0,
        Sun = Sunburst,
        Counter = SunburstCounter
    };
    local v95 = Sunburst:FindFirstChildOfClass("UIScale");

    if not v95 then
        v95 = Instance.new("UIScale");

        for i, v in {} do
            v95[i] = v;
        end;

        v95.Parent = Sunburst;
    end;

    v94.SunScale = v95;
    local v96 = SunburstCounter:FindFirstChildOfClass("UIScale");

    if not v96 then
        v96 = Instance.new("UIScale");

        for i, v in {} do
            v96[i] = v;
        end;

        v96.Parent = SunburstCounter;
    end;

    v94.CounterScale = v96;
    v94.Char = ZoneCharacter;
    v94.Home = ZoneCharacter.Position;
    v94.Alert = ZoneCharacter:WaitForChild("Alert");
    v94.Template = Template;
    v94.Particles = {};
    v94.Min = p92;
    v94.Max = p93;

    return v94;
end;

local function ClearScene(p97) -- Line: 363
    for _, v in p97.Particles do
        v.Instance:Destroy();
    end;

    table.clear(p97.Particles);
    p97.Next = 0;
end;

local function UpdateScene(p98, p99, p100, p101, p102) -- Line: 371
    -- upvalues: u14 (ref), TweenService (copy)
    p98.Char.Position = p98.Home + UDim2.fromScale(0, math.sin(u14 * 1.8 + p100) * 0.012 - p101);
    p98.Char.Rotation = math.sin(u14 * 0.9 + p100) * 4;
    p98.Alert.Rotation = math.sin(u14 * 6 + p100) * 10;
    p98.Sun.Rotation = (p98.Sun.Rotation + 20 * p102 * p99) % 360;
    p98.Counter.Rotation = (p98.Counter.Rotation - 14 * p102 * p99) % 360;
    local v103 = math.sin(u14 * 2) * 0.04;
    local v104 = (p102 - 1) * 0.03;
    p98.SunScale.Scale = v103 + 1 + v104;
    p98.CounterScale.Scale = 1 - v103 + v104;

    if u14 >= p98.Next then
        local v105 = p98.Template:Clone();
        v105.Visible = true;
        v105.Rotation = 0;
        local v106 = v105:FindFirstChildOfClass("UIScale");

        if not v106 then
            v106 = Instance.new("UIScale");

            for i, v in {} do
                v106[i] = v;
            end;

            v106.Parent = v105;
        end;

        v106.Scale = 0;
        local v107 = {
            Instance = v105,
            Scale = v106,
            X = 0.05 + math.random() * 0.9,
            Size = 0.6 + math.random() * 0.5,
            Start = u14,
            Life = 4 + math.random() * 2,
            Phase = math.random() * 3.141592653589793 * 2,
            Speed = 1 + math.random() * 1.5
        };
        v105.Position = UDim2.fromScale(v107.X, 1.15);
        v105.Parent = p98.Template.Parent;
        table.insert(p98.Particles, v107);
        p98.Next = u14 + p98.Min + math.random() * (p98.Max - p98.Min);
    end;

    for i = #p98.Particles, 1, -1 do
        local v108 = p98.Particles[i];
        local v109 = (u14 - v108.Start) / v108.Life;
        local v110;

        if v109 >= 1 then
            v108.Instance:Destroy();
            table.remove(p98.Particles, i);
            v110 = i;
        else
            local v111 = u14 * v108.Speed + v108.Phase;
            v108.Instance.Position = UDim2.fromScale(v108.X + math.sin(v111 * 0.7) * 0.015, 1.15 - 1.3 * v109);
            v108.Instance.Rotation = math.sin(v111) * 4;
            v108.Scale.Scale = v108.Size * TweenService:GetValue(math.min(v109 / 0.15, 1), Enum.EasingStyle.Back, Enum.EasingDirection.Out);
            v110 = i;
        end;
    end;
end;

local function UpdateTease(p112, p113) -- Line: 425
    -- upvalues: u11 (copy), u10 (copy), u14 (ref), TweenService (copy), Color3_fromRGB_ret3 (copy), SampleSequence (copy), u17 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy)
    local v114 = u11[p113 + 1];

    if not v114 then
        return;
    end;

    local v115 = p112[v114];
    local v116 = p112[u10[p113 + 2]];
    local v117 = u14 % 2.4 / 1.1;
    local v118 = -0.25 + 1.5 * TweenService:GetValue(math.min(v117, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
    local v119 = {};

    for i = 0, 16 do
        local v120 = i / 16;
        local v121 = 1 - math.abs(v120 - v118) / 0.25;
        local math_max_ret = math.max(0, v121);
        local ColorSequenceKeypoint_new = ColorSequenceKeypoint.new;
        local v122 = SampleSequence(u17[v115], v120);
        table.insert(v119, ColorSequenceKeypoint_new(v120, Color3_fromRGB_ret3:Lerp(v122, math_max_ret * 0.85)));
        local _ = i;
    end;

    v115.BackgroundColor3 = Color3_fromRGB_ret;
    v115.UIGradient.Enabled = true;
    v115.UIGradient.Color = ColorSequence.new(v119);
    local v123 = (math.sin(u14 * 3) + 1) / 2;
    local v124 = 1 - math.abs(v117 - 1) / 0.25;
    local math_max_ret = math.max(0, v124);
    local v125 = v116:FindFirstChildOfClass("UIScale");

    if not v125 then
        v125 = Instance.new("UIScale");

        for i, v in {} do
            v125[i] = v;
        end;

        v125.Parent = v116;
    end;

    v125.Scale = v123 * 0.04 + 1 + math_max_ret * 0.1;
    v116.ImageColor3 = Color3_fromRGB_ret2:Lerp(Color3_fromRGB_ret, v123 * 0.15 + math_max_ret * 0.35);
end;

local function UpdatePityFx() -- Line: 452
    -- upvalues: u13 (ref), u16 (ref), u14 (ref), SampleSequence (copy), Color3_fromRGB_ret (copy)
    local Pity = u13.Pity;

    if not Pity.Bar.Visible then
        return;
    end;

    local v126 = u16 and 9 or 2;
    local v127 = (math.sin(u14 * v126 * 0.5) + 1) / 2;
    Pity.Entry.Rotation = math.sin(u14 * v126) * (u16 and 8 or 3);
    Pity.EntryScale.Scale = 1 + v127 * (u16 and 0.08 or 0.03);
    local v128 = math.min(u14 % (u16 and 1.2 or 2.6) / 0.8, 1) * 1.36 + -0.18;
    local v129 = {};

    for i = 0, 16 do
        local v130 = i / 16;
        local v131 = 1 - math.abs(v130 - v128) / 0.18;
        local math_max_ret = math.max(0, v131);
        local ColorSequenceKeypoint_new = ColorSequenceKeypoint.new;
        local v132 = SampleSequence(Pity.Colors, v130);
        table.insert(v129, ColorSequenceKeypoint_new(v130, v132:Lerp(Color3_fromRGB_ret, math_max_ret * 0.7)));
        local _ = i;
    end;

    Pity.Gradient.Color = ColorSequence.new(v129);
end;

local function ResetPopup() -- Line: 473
    -- upvalues: u13 (ref), NumberValue (copy), NumberValue2 (copy)
    u13.Popup.GroupTransparency = 1;
    u13.Popup.Visible = false;
    u13.PopupFrame.Position = u13.Home.Frame;
    u13.PopupTitle.Position = u13.Home.Title - UDim2.fromScale(0, 0.04);
    u13.PopupText.Position = u13.Home.Text - UDim2.fromScale(0, 0.04);
    u13.PopupText.TextColor3 = u13.Home.Color;
    local PopupFrame = u13.PopupFrame;
    local v133 = PopupFrame:FindFirstChildOfClass("UIScale");

    if not v133 then
        v133 = Instance.new("UIScale");

        for i, v in {} do
            v133[i] = v;
        end;

        v133.Parent = PopupFrame;
    end;

    v133.Scale = 1.6;
    local Char = u13.Pop.Char;
    local v134 = Char:FindFirstChildOfClass("UIScale");

    if not v134 then
        v134 = Instance.new("UIScale");

        for i, v in {} do
            v134[i] = v;
        end;

        v134.Parent = Char;
    end;

    v134.Scale = 0.5;
    local Alert = u13.Pop.Alert;
    local v135 = Alert:FindFirstChildOfClass("UIScale");

    if not v135 then
        v135 = Instance.new("UIScale");

        for i, v in {} do
            v135[i] = v;
        end;

        v135.Parent = Alert;
    end;

    v135.Scale = 0;
    local PopupText = u13.PopupText;
    local v136 = PopupText:FindFirstChildOfClass("UIScale");

    if not v136 then
        v136 = Instance.new("UIScale");

        for i, v in {} do
            v136[i] = v;
        end;

        v136.Parent = PopupText;
    end;

    v136.Scale = 1;
    local PopupTitle = u13.PopupTitle;
    local v137 = PopupTitle:FindFirstChildOfClass("UIScale");

    if not v137 then
        v137 = Instance.new("UIScale");

        for i, v in {} do
            v137[i] = v;
        end;

        v137.Parent = PopupTitle;
    end;

    v137.Scale = 1;
    NumberValue.Value = 1;
    NumberValue2.Value = 0;
end;

local function ClosePopup() -- Line: 489
    -- upvalues: u15 (ref), u13 (ref), TweenService (copy), ResetPopup (copy)
    if not u15 then
        return;
    end;

    u15 = false;
    local TweenInfo_new_ret = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
    local PopupFrame = u13.PopupFrame;
    local v138 = PopupFrame:FindFirstChildOfClass("UIScale");

    if not v138 then
        v138 = Instance.new("UIScale");

        for i, v in {} do
            v138[i] = v;
        end;

        v138.Parent = PopupFrame;
    end;

    TweenService:Create(v138, TweenInfo_new_ret, {
        Scale = 0.85
    }):Play();
    local Char = u13.Pop.Char;
    local v139 = Char:FindFirstChildOfClass("UIScale");

    if not v139 then
        v139 = Instance.new("UIScale");

        for i, v in {} do
            v139[i] = v;
        end;

        v139.Parent = Char;
    end;

    TweenService:Create(v139, TweenInfo_new_ret, {
        Scale = 0.8
    }):Play();
    local v140 = TweenService:Create(u13.Popup, TweenInfo_new_ret, {
        GroupTransparency = 1
    });
    v140:Play();
    v140.Completed:Once(function() -- Line: 496
        -- upvalues: u15 (ref), ResetPopup (ref)
        if not u15 then
            ResetPopup();
        end;
    end);
end;

local function AnimateStep(p141, p142, p143, p144) -- Line: 503
    -- upvalues: u10 (copy), u11 (copy), Charge (copy), SwoopConnector (copy), Color3_fromRGB_ret (copy), TweenService (copy), PopTick (copy), Punch (copy), Burst (copy), Shake (copy), u13 (ref), NumberValue (copy), NumberValue2 (copy), Tween (copy)
    local v145 = p141[u10[p142 + 1]];
    local v146 = u11[p142];

    if v146 then
        task.spawn(Charge, v145);
        SwoopConnector(p141[v146]);
    end;

    TweenService:Create(v145, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageColor3 = Color3_fromRGB_ret
    }):Play();

    for i, v in u10 do
        if p144[i] and not p143[i] then
            PopTick(p141[v], (i - 1) * 0.15);
        end;
    end;

    local v147 = v145:FindFirstChildOfClass("UIScale");

    if not v147 then
        v147 = Instance.new("UIScale");

        for i, v in {} do
            v147[i] = v;
        end;

        v147.Parent = v145;
    end;

    Punch(v147, 1.5);
    Burst(v145);
    task.spawn(Shake, u13.PopupFrame, u13.Home.Frame, 0.012, 0.4);
    NumberValue.Value = 8;
    TweenService:Create(NumberValue, TweenInfo.new(1.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Value = 1
    }):Play();
    TweenService:Create(NumberValue2, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Value = 0.04
    }):Play();
    task.delay(0.15, Tween, NumberValue2, TweenInfo.new(0.6, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
        Value = 0
    });
end;

local function OpenPopup(p148, p149, p150) -- Line: 530
    -- upvalues: u15 (ref), ResetPopup (copy), SetBar (copy), u13 (ref), u12 (copy), TweenService (copy), Tween (copy), Punch (copy), Shake (copy), AnimateStep (copy), Color3_fromRGB_ret4 (copy), ClosePopup (copy)
    if u15 then
        return;
    end;

    u15 = true;
    ResetPopup();
    SetBar(u13.PopupFrame, p148 - 1, p149);
    u13.PopupText.Text = `PROGRESS: {p148 - 1}/{u12}`;
    u13.Popup.Subtitle.Text = "";
    u13.Popup.Visible = true;
    TweenService:Create(u13.Popup, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    }):Play();
    local Char = u13.Pop.Char;
    local v151 = Char:FindFirstChildOfClass("UIScale");

    if not v151 then
        v151 = Instance.new("UIScale");

        for i, v in {} do
            v151[i] = v;
        end;

        v151.Parent = Char;
    end;

    TweenService:Create(v151, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
    TweenService:Create(u13.PopupTitle, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Position = u13.Home.Title
    }):Play();
    task.delay(0.08, Tween, u13.PopupText, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Position = u13.Home.Text
    });
    local PopupFrame = u13.PopupFrame;
    local v152 = PopupFrame:FindFirstChildOfClass("UIScale");

    if not v152 then
        v152 = Instance.new("UIScale");

        for i, v in {} do
            v152[i] = v;
        end;

        v152.Parent = PopupFrame;
    end;

    local v153 = TweenService:Create(v152, TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Scale = 1
    });
    v153:Play();
    v153.Completed:Wait();
    local PopupFrame2 = u13.PopupFrame;
    local v154 = PopupFrame2:FindFirstChildOfClass("UIScale");

    if not v154 then
        v154 = Instance.new("UIScale");

        for i, v in {} do
            v154[i] = v;
        end;

        v154.Parent = PopupFrame2;
    end;

    Punch(v154, 0.94);
    task.spawn(Shake, u13.PopupFrame, u13.Home.Frame, 0.005, 0.25);
    task.wait(0.45);
    AnimateStep(u13.PopupFrame, p148, p149, p150);
    u13.PopupText.Text = `PROGRESS: {p148}/{u12}`;
    u13.PopupText.TextColor3 = Color3_fromRGB_ret4;

    if p148 >= 2 then
        u13.Popup.Subtitle.Text = "ZONE UNLOCKED";
    else
        u13.Popup.Subtitle.Text = "SPIN ONE MORE EMOTE TO UNLOCK THE ZONE";
    end;

    TweenService:Create(u13.PopupText, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextColor3 = u13.Home.Color
    }):Play();
    local PopupText = u13.PopupText;
    local v155 = PopupText:FindFirstChildOfClass("UIScale");

    if not v155 then
        v155 = Instance.new("UIScale");

        for i, v in {} do
            v155[i] = v;
        end;

        v155.Parent = PopupText;
    end;

    Punch(v155, 1.4);
    local PopupTitle = u13.PopupTitle;
    local v156 = PopupTitle:FindFirstChildOfClass("UIScale");

    if not v156 then
        v156 = Instance.new("UIScale");

        for i, v in {} do
            v156[i] = v;
        end;

        v156.Parent = PopupTitle;
    end;

    Punch(v156, 1.15);
    local Alert = u13.Pop.Alert;
    local v157 = Alert:FindFirstChildOfClass("UIScale");

    if not v157 then
        v157 = Instance.new("UIScale");

        for i, v in {} do
            v157[i] = v;
        end;

        v157.Parent = Alert;
    end;

    TweenService:Create(v157, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
    task.wait(2.8);
    ClosePopup();
end;

local function StartCountdown() -- Line: 570
    -- upvalues: u13 (ref), GetUnixTime (copy), Attribute (copy), NumberUtil (copy), Punch (copy), Color3_fromRGB_ret4 (copy), TweenService (copy)
    local Timer = u13.Timer;
    local TextColor3 = Timer.TextColor3;
    local v158 = nil;

    while u13.Countdown.Parent do
        local v159 = Attribute - GetUnixTime();

        if v159 ~= v158 then
            Timer.Text = `TIME LEFT: {v159 > 0 and (NumberUtil.AdaptiveClockString(v159) or "GONE SOON!") or "GONE SOON!"}`;
            local v160 = v159 <= 3600;
            local Countdown = u13.Countdown;
            local v161 = Countdown:FindFirstChildOfClass("UIScale");

            if v161 then
                v158 = v159;
            else
                v161 = Instance.new("UIScale");
                v158 = v159;

                for i, v in {} do
                    v161[i] = v;
                end;

                v161.Parent = Countdown;
            end;

            Punch(v161, v160 and 1.1 or 1.04);

            if v160 then
                Timer.TextColor3 = Color3_fromRGB_ret4;
                TweenService:Create(Timer, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    TextColor3 = TextColor3
                }):Play();
            end;

            if v159 <= 0 then
                break;
            end;
        end;

        task.wait(0.1);
    end;
end;

function v2.Spin(p162, p163, p164) -- Line: 601
    -- upvalues: Knit (copy), TweenService (copy), SfxManager (copy), WheelItems (copy), Effects (copy)
    Knit.GetController("Network");
    local Slices = p162.UI.Wheel.Slices;
    p162.spinning = true;
    p162:UpdateSpins();
    local Rotation = Slices.Rotation;
    local v165 = math.random(5, 10) * 360 - Rotation;
    local v166 = Rotation + ({ 0, -180, -60, -240, -120, -300 })[p163] + v165 + math.random(-12, 12);
    local v167 = math.floor((Rotation - 30) % 360 / 60) + 1;
    local v168 = 0;

    while true do
        v168 = v168 + task.wait();
        local v169 = v168 / 5;
        local Value = TweenService:GetValue(v169, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);

        if v169 >= 1 or p162.skipRequested then
            break;
        end;

        local v170 = Rotation + (v166 - Rotation) * Value;
        local v171 = math.floor((v170 - 30) % 360 / 60) + 1;

        if v171 == v167 then
            v171 = v167;
        else
            SfxManager:playSound({
                Sound = "Spin",
                Parent = workspace
            });
        end;

        Slices.Rotation = v170 % 360;
        v167 = v171;
    end;

    Slices.Rotation = v166;
    p162.skipRequested = false;
    local v172 = WheelItems.Rewards[p163];
    local v173;

    if p164 and WheelItems.Rewards[p163][3].LuckySpins then
        v173 = `Duplicate! Received {WheelItems.Rewards[p163][3].LuckySpins} Lucky Style Spins!`;
    elseif p164 and WheelItems.Rewards[p163][3].Money then
        v173 = `Duplicate! Received {WheelItems.Rewards[p163][3].Money} Money!`;
    elseif typeof(v172[3]) == "number" and v172[3] > 0 then
        v173 = `You got {v172[3]} {v172[2]}!`;
    else
        v173 = `You got {v172[2]}!`;
    end;

    Effects:Popup(v173, 2, Color3.new(1, 0.74902, 0));
    task.wait(0.25);
    p162.spinning = false;
    p162:UpdateSpins();
    p162:UpdateProgress(true);
    p162:UpdatePity(true);
end;

function v2.UpdateSpins(p174) -- Line: 669
    -- upvalues: Knit (copy)
    local Controller = Knit.GetController("Network");
    local WheelSpins = Controller.Player.WheelSpins;

    if Controller.Player.CanSkipWheel and p174.spinning then
        p174.UI.Buttons.Spin.RobuxFrame.Visible = false;
        p174.UI.Buttons.Spin.LeftFrame.Visible = false;
        p174.UI.Buttons.Spin.SkipFrame.Visible = true;

        return;
    end;

    if WheelSpins <= 0 then
        p174.UI.Buttons.Spin.RobuxFrame.Visible = true;
        p174.UI.Buttons.Spin.LeftFrame.Visible = false;
        p174.UI.Buttons.Spin.SkipFrame.Visible = false;

        return;
    end;

    p174.UI.Buttons.Spin.RobuxFrame.Visible = false;
    p174.UI.Buttons.Spin.LeftFrame.Visible = true;
    p174.UI.Buttons.Spin.SkipFrame.Visible = false;
    p174.UI.Buttons.Spin.LeftFrame.Text.Text = `{WheelSpins} LEFT`;
end;

function v2.UpdateProgress(p175, p176) -- Line: 690
    -- upvalues: Knit (copy), WheelItems (copy), u12 (copy), GetOwned (copy), SetBar (copy), RevealTicks (copy), u15 (ref), OpenPopup (copy)
    local Controller = Knit.GetController("Network");
    local v177 = 0;
    local v178 = {};

    if not v178[WheelItems.Rewards[1][3].Type] then
        v178[WheelItems.Rewards[1][3].Type] = {};
    end;

    if not v178[WheelItems.Rewards[2][3].Type] then
        v178[WheelItems.Rewards[2][3].Type] = {};
    end;

    table.insert(v178[WheelItems.Rewards[1][3].Type], WheelItems.Rewards[1][3].Name);
    table.insert(v178[WheelItems.Rewards[2][3].Type], WheelItems.Rewards[2][3].Name);

    for i, v in v178 do
        local v179 = v;

        for _, v3 in Controller.Player.Customization.Inventory[i] do
            if table.find(v179, v3) then
                v177 = v177 + 1;
            end;
        end;
    end;

    local math_min_ret = math.min(v177, u12);

    if p175.spinning and (p175.Progress and p175.Progress < math_min_ret) then
        return;
    end;

    local Progress = p175.Progress;
    local Owned = p175.Owned;
    local v180 = GetOwned();
    p175.Progress = math_min_ret;
    p175.Owned = v180;
    p175.UI.Progress.Text = `PROGRESS: {math_min_ret}/{u12}`;
    SetBar(p175.UI.ProgressFrame, math_min_ret, v180);

    if not p176 then
        RevealTicks(p175.UI.ProgressFrame, v180);
    end;

    if p176 and (Progress and (Owned and (Progress < math_min_ret and (not u15 and p175.UI.Parent.Enabled)))) then
        p175.PopupThread = task.spawn(OpenPopup, math_min_ret, Owned, v180);
    end;
end;

function v2.UpdatePity(p181, p182) -- Line: 739
    -- upvalues: Knit (copy), u13 (ref), u16 (ref), WheelItems (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret (copy), TweenService (copy), Punch (copy)
    if p182 and p181.spinning then
        return;
    end;

    local Controller = Knit.GetController("Network");
    local Pity = u13.Pity;
    local WheelSpinsDone = Controller.Player.WheelSpinsDone;
    local math_clamp_ret = math.clamp(WheelSpinsDone / 250, 0, 1);
    local v183 = u16;
    u16 = math_clamp_ret >= 0.8;
    Pity.Fill.Visible = WheelSpinsDone > 0;
    Pity.Count.Text = `{WheelSpinsDone}/{250}`;
    Pity.Title.Text = `{WheelItems.Rewards[1][3].Name} Pity`;
    Pity.Title.TextColor3 = u16 and Color3_fromRGB_ret4 or Color3_fromRGB_ret;

    if p182 then
        TweenService:Create(Pity.Fill, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(math_clamp_ret, 1)
        }):Play();
        local Count = Pity.Count;
        local v184 = Count:FindFirstChildOfClass("UIScale");

        if not v184 then
            v184 = Instance.new("UIScale");

            for i, v in {} do
                v184[i] = v;
            end;

            v184.Parent = Count;
        end;

        Punch(v184, 1.3);

        if u16 ~= v183 then
            local Title = Pity.Title;
            local v185 = Title:FindFirstChildOfClass("UIScale");

            if not v185 then
                v185 = Instance.new("UIScale");

                for i, v in {} do
                    v185[i] = v;
                end;

                v185.Parent = Title;
            end;

            Punch(v185, 1.2);
        end;
    else
        Pity.Fill.Size = UDim2.fromScale(math_clamp_ret, 1);
    end;
end;

function v2.SetupSkip(p186) -- Line: 766
    -- upvalues: Knit (copy), TweenService (copy), Effects (copy), Tween (copy), MarketplaceService (copy), LocalPlayer (copy)
    local Controller = Knit.GetController("Network");
    local SkipSpin = p186.UI:WaitForChild("SkipSpin");
    local u187 = SkipSpin:FindFirstChildOfClass("UIScale");

    if not u187 then
        u187 = Instance.new("UIScale");

        for i, v in {} do
            u187[i] = v;
        end;

        u187.Parent = SkipSpin;
    end;

    local Shine = SkipSpin:WaitForChild("Container"):WaitForChild("Shine");
    local Y = Shine.Position.Y;
    p186.SkipSpin = SkipSpin;
    local u188 = false;
    local u189 = 0;

    local function RestScale() -- Line: 779
        -- upvalues: u188 (ref)
        return u188 and 1.06 or 1;
    end;

    local function PlayShine() -- Line: 783
        -- upvalues: Shine (copy), Y (copy), TweenService (ref)
        Shine.Position = UDim2.new(-0.3, 0, Y.Scale, Y.Offset);
        TweenService:Create(Shine, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Position = UDim2.new(1.3, 0, Y.Scale, Y.Offset)
        }):Play();
    end;

    SkipSpin.MouseEnter:Connect(function() -- Line: 788
        -- upvalues: u188 (ref), u187 (copy), TweenService (ref)
        u188 = true;
        TweenService:Create(u187, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = 1.06
        }):Play();
    end);
    SkipSpin.MouseLeave:Connect(function() -- Line: 793
        -- upvalues: u188 (ref), u187 (copy), TweenService (ref)
        u188 = false;
        TweenService:Create(u187, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = 1
        }):Play();
    end);
    SkipSpin.MouseButton1Down:Connect(function() -- Line: 798
        -- upvalues: u187 (copy), TweenService (ref)
        TweenService:Create(u187, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = 0.92
        }):Play();
    end);
    SkipSpin.MouseButton1Up:Connect(function() -- Line: 802
        -- upvalues: u187 (copy), u188 (ref), TweenService (ref)
        TweenService:Create(u187, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Scale = u188 and 1.06 or 1
        }):Play();
    end);
    SkipSpin.Activated:Connect(function() -- Line: 806
        -- upvalues: u189 (ref), Controller (copy), Effects (ref), u187 (copy), TweenService (ref), Tween (ref), u188 (ref), PlayShine (copy), MarketplaceService (ref), LocalPlayer (ref)
        if os.clock() - u189 < 0.3 then
            return;
        end;

        u189 = os.clock();

        if Controller.Player.CanSkipWheel then
            return;
        end;

        if Controller.Policy then
            Effects:Popup("This purchase is not available for your region.");

            return;
        end;

        TweenService:Create(u187, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = 1.15
        }):Play();
        task.delay(0.12, Tween, u187, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Scale = u188 and 1.06 or 1
        });
        PlayShine();
        MarketplaceService:PromptGamePassPurchase(LocalPlayer, 2039878693);
    end);
    task.spawn(function() -- Line: 823
        -- upvalues: SkipSpin (copy), PlayShine (copy)
        while SkipSpin.Parent do
            PlayShine();
            task.wait(2.5);
        end;
    end);
end;

function v2.UpdateSkip(p190) -- Line: 831
    -- upvalues: Knit (copy)
    local Controller = Knit.GetController("Network");
    p190.SkipSpin.Visible = not Controller.Player.CanSkipWheel;
end;

function v2.SetupEffects(p191) -- Line: 836
    -- upvalues: u13 (ref), NewScene (copy), SetupBar (copy), ResetPopup (copy)
    local UI = p191.UI;
    local ProgressPopup = UI:WaitForChild("ProgressPopup");
    local Countdown = UI:WaitForChild("Countdown");
    local ProgressFrame = ProgressPopup:WaitForChild("ProgressFrame");
    local Progress = ProgressPopup:WaitForChild("Progress");
    local Title = ProgressPopup:WaitForChild("Title");
    local Subtitle = ProgressPopup:WaitForChild("Subtitle");
    local PityBar = UI:WaitForChild("PityBar");
    local Track = PityBar:WaitForChild("Track");
    local Fill = Track:WaitForChild("Fill");
    local Entry = PityBar:WaitForChild("Entry");
    local UIGradient = Fill:WaitForChild("UIGradient");
    local v192 = {
        Main = NewScene(UI, 0.55, 0.9),
        Pop = NewScene(ProgressPopup, 0.35, 0.65),
        Popup = ProgressPopup,
        PopupFrame = ProgressFrame,
        PopupText = Progress,
        PopupTitle = Title,
        PopupSubtitle = Subtitle,
        Countdown = Countdown,
        Timer = Countdown:WaitForChild("Timer"),
        Home = {
            Frame = ProgressFrame.Position,
            Title = Title.Position,
            Text = Progress.Position,
            Color = Progress.TextColor3
        }
    };
    local v193 = {
        Bar = PityBar,
        Odds = UI:WaitForChild("OddsFrame"),
        Entry = Entry
    };
    local v194 = Entry:FindFirstChildOfClass("UIScale");

    if not v194 then
        v194 = Instance.new("UIScale");

        for i, v in {} do
            v194[i] = v;
        end;

        v194.Parent = Entry;
    end;

    v193.EntryScale = v194;
    v193.Title = PityBar:WaitForChild("NameText");
    v193.Fill = Fill;
    v193.Gradient = UIGradient;
    v193.Colors = UIGradient.Color;
    v193.Count = Track:WaitForChild("Count");
    v192.Pity = v193;
    u13 = v192;
    SetupBar(UI.ProgressFrame);
    SetupBar(ProgressFrame);
    ResetPopup();
end;

function v2.Idle(p195, p196) -- Line: 884
    -- upvalues: u14 (ref), UpdateScene (copy), u13 (ref), UpdateTease (copy), NumberValue2 (copy), NumberValue (copy), UpdatePityFx (copy)
    u14 = u14 + p196;
    UpdateScene(u13.Main, p196, 0, 0, 1);
    local Alert = u13.Main.Alert;
    local v197 = Alert:FindFirstChildOfClass("UIScale");

    if not v197 then
        v197 = Instance.new("UIScale");

        for i, v in {} do
            v197[i] = v;
        end;

        v197.Parent = Alert;
    end;

    local math_sin_ret = math.sin(u14 * 3);
    v197.Scale = math.abs(math_sin_ret) * 0.08 + 1;
    UpdateTease(p195.UI.ProgressFrame, p195.Progress or 0);

    if u13.Popup.Visible then
        UpdateScene(u13.Pop, p196, 3.141592653589793, NumberValue2.Value, NumberValue.Value);
    end;

    UpdatePityFx();
end;

function v2.StopEffects(p198) -- Line: 898
    -- upvalues: u15 (ref), ResetPopup (copy), u13 (ref)
    if p198.PopupThread and coroutine.status(p198.PopupThread) ~= "dead" then
        task.cancel(p198.PopupThread);
    end;

    p198.PopupThread = nil;
    u15 = false;
    ResetPopup();
    local Main = u13.Main;

    for _, v in Main.Particles do
        v.Instance:Destroy();
    end;

    table.clear(Main.Particles);
    Main.Next = 0;
    local Pop = u13.Pop;

    for _, v in Pop.Particles do
        v.Instance:Destroy();
    end;

    table.clear(Pop.Particles);
    Pop.Next = 0;
end;

function v2.InitGui(u199) -- Line: 910
    -- upvalues: Knit (copy), LocalPlayer (copy), WheelItems (copy), Customization (copy), u9 (copy), Effects (copy), MarketplaceService (copy), u1 (copy), RunService (copy), ReplicatedStorage (copy), deep_equals (copy), StartCountdown (copy), Players (copy)
    local Controller = Knit.GetController("Shop");
    local Controller2 = Knit.GetController("Network");
    local Controller3 = Knit.GetController("UIController");
    local Controller4 = Knit.GetController("PromptController");
    local Controller5 = Knit.GetController("EmotesController");
    local Service = Knit.GetService("SpinWheelService");
    u199.UI = LocalPlayer.PlayerGui:WaitForChild("SpinWheel"):WaitForChild("BG");
    u199:SetupEffects();
    u199:SetupSkip();
    u199.UI.ProgressFrame["3"].NameText.Text = WheelItems.ZoneReward:upper();
    u199.UI.ProgressPopup.ProgressFrame["3"].NameText.Text = WheelItems.ZoneReward:upper();
    u199.UI.PityBar.NameText.Text = `{WheelItems.Rewards[1][2]:upper()} PITY`;

    local function CreatePreview(p200, p201) -- Line: 919
        -- upvalues: Controller5 (copy)
        local ViewportFrame = Instance.new("ViewportFrame", p200.Icon);
        ViewportFrame.Size = UDim2.fromScale(1, 1);
        ViewportFrame.Ambient = Color3.fromRGB(255, 255, 255);
        ViewportFrame.BackgroundTransparency = 1;
        ViewportFrame.ZIndex = p200.Icon.ZIndex;

        while not Controller5.CharacterRig do
            task.wait();
        end;

        Controller5:CreatePreview(p201.Name, ViewportFrame, Controller5.CharacterRig, p201.Name == "Ascended Vampire" and "AscendedVampirePlayer" or false);
    end;

    for _, v in {
        u199.UI.ProgressFrame["1"],
        u199.UI.ProgressFrame["2"],
        u199.UI.ProgressPopup.ProgressFrame["1"],
        u199.UI.ProgressPopup.ProgressFrame["2"]
    } do
        local v202 = WheelItems.Rewards[tonumber(v.Name) == 1 and 2 or 1];

        if v202 then
            local v203 = v202[2]:upper();
            local v204 = v202[3];

            if typeof(v204) == "table" then
                v.NameText.Text = v203;

                if v204.Type == "Emotes" then
                    task.spawn(CreatePreview, v, v204);
                elseif v204.Type == "GoalEffects" then
                    v.Icon.Image = Controller.GoalIcons[v204.Name] or "";
                else
                    local v205 = Customization[v204.Type][v204.Name];

                    if v205.IconId then
                        v.Icon.Image = `rbxassetid://{v205.IconId}`;
                    end;
                end;
            end;
        end;
    end;

    task.spawn(CreatePreview, u199.UI.PityBar.Entry, WheelItems.Rewards[1][3]);

    for i, v in WheelItems.Rewards do
        local v206 = v[1];
        local v207 = v[2]:upper();
        local v208 = v[3];
        local v209 = v[4];
        local v210 = u199.UI.Wheel.Slices:FindFirstChild((`{i}`));

        if v210 then
            local v211 = u199.UI.OddsFrame:FindFirstChild((`{i}`));

            if v211 then
                if typeof(v208) == "number" and v208 > 0 then
                    v210.ItemName.Text = `{v208} {v207}`;
                else
                    v210.ItemName.Text = v207;
                end;

                for i2 = 1, 2 do
                    local v212 = i2 == 1 and v210 and v210 or v211;
                    local v213;

                    if typeof(v208) == "table" then
                        if v208.Type == "Emotes" then
                            task.spawn(CreatePreview, v212, v208);
                            v213 = i2;
                        elseif v208.Type == "GoalEffects" then
                            v212.Icon.Image = Controller.GoalIcons[v208.Name] or "";
                            v213 = i2;
                        else
                            local v214 = Customization[v208.Type][v208.Name];

                            if v214.IconId then
                                v212.Icon.Image = `rbxassetid://{v214.IconId}`;
                                v213 = i2;
                            else
                                v213 = i2;
                            end;
                        end;
                    else
                        local v215 = WheelItems.Icons[v206];

                        if v215 then
                            v212.Icon.Image = v215;

                            if v206:match("^Lucky") then
                                script.Rainbow:Clone().Parent = v212.Icon;
                                v213 = i2;
                            else
                                v213 = i2;
                            end;
                        else
                            v212.Icon.Visible = false;
                            v213 = i2;
                        end;
                    end;
                end;

                v211.Chance.Text = `{v209}%`;
            end;
        end;
    end;

    task.spawn(function() -- Line: 1024
        -- upvalues: Controller4 (copy), u199 (copy)
        local v216 = Controller4.RepeatGetProductInfo(2039878693, Enum.InfoType.GamePass);
        u199.UI:WaitForChild("SkipSpin").RobuxFrame.Price.Text = `{utf8.char(57346)}{v216.PriceInRobux}`;
    end);

    for _, child in u199.UI.Buttons:GetChildren() do
        if child:IsA("ImageButton") then
            task.spawn(function() -- Line: 1031
                -- upvalues: Controller4 (copy), u9 (ref), child (copy)
                local v217 = Controller4.RepeatGetProductInfo(u9[child.Name], Enum.InfoType.Product);
                child.RobuxFrame.Price.Text = `{utf8.char(57346)}{v217.PriceInRobux}`;
            end);
            child.Activated:Connect(function() -- Line: 1036
                -- upvalues: child (copy), Controller2 (copy), Effects (ref), MarketplaceService (ref), LocalPlayer (ref), u9 (ref)
                if child.RobuxFrame.Visible then
                    if Controller2.Policy then
                        Effects:Popup("This purchase is not available for your region.");

                        return;
                    end;

                    MarketplaceService:PromptProductPurchase(LocalPlayer, u9[child.Name]);
                end;
            end);
        end;
    end;

    for _, child in u199.UI.GiftButtons:GetChildren() do
        if child:IsA("ImageButton") then
            child.Activated:Connect(function() -- Line: 1047
                -- upvalues: Controller2 (copy), Effects (ref), Knit (ref), u9 (ref), child (copy)
                if Controller2.Policy then
                    Effects:Popup("This purchase is not available for your region.");

                    return;
                end;

                Knit.GetController("GiftingController").PromptGiftPlayer(u9[child.Name]);
            end);
        end;
    end;

    u199.UI.Parent:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 1055
        -- upvalues: u1 (ref), u199 (copy), LocalPlayer (ref), RunService (ref), Controller3 (copy), Controller2 (copy), Service (copy), ReplicatedStorage (ref), deep_equals (ref), StartCountdown (ref)
        u1:Clean();

        if u199.UI.Parent.Enabled then
            local OverlapParams_new_ret = OverlapParams.new();
            OverlapParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
            OverlapParams_new_ret.FilterDescendantsInstances = { LocalPlayer.Character };
            local u218 = nil;
            u218 = u1:Add(RunService.Heartbeat:Connect(function() -- Line: 1064
                -- upvalues: OverlapParams_new_ret (copy), u218 (ref), u199 (ref), LocalPlayer (ref), Controller3 (ref)
                if #workspace:GetPartsInPart(workspace.Lobby.Spinwheel.Hitbox, OverlapParams_new_ret) == 0 then
                    u218:Disconnect();
                    u199.UI.Parent.Enabled = false;
                    LocalPlayer.PlayerGui.HUD.Enabled = not LocalPlayer.PlayerGui.InGame.Enabled;
                    Controller3:Focus(false);
                end;
            end));
            u1:Connect(u199.UI.Buttons.Spin.Activated, function() -- Line: 1076
                -- upvalues: u199 (ref), Controller2 (ref), Service (ref)
                if u199.spinning then
                    if Controller2.Player.CanSkipWheel then
                        u199.skipRequested = true;
                    end;

                    return;
                end;

                u199.spinning = true;
                u199.skipRequested = false;
                local v219, v220 = Service:SpinWheel();

                if v219 then
                    u199:Spin(v219, v220);

                    return;
                end;

                u199.spinning = false;
            end);
            local WheelSpins = Controller2.Player.WheelSpins;
            local WheelSpinsDone = Controller2.Player.WheelSpinsDone;
            local Emotes = Controller2.Player.Customization.Inventory.Emotes;
            local Cosmetics = Controller2.Player.Customization.Inventory.Cosmetics;
            u1:Connect(ReplicatedStorage.Controllers.NewData.Changed, function() -- Line: 1101
                -- upvalues: u199 (ref), WheelSpins (ref), Controller2 (ref), WheelSpinsDone (ref), deep_equals (ref), Emotes (ref), Cosmetics (ref)
                u199:UpdateSkip();

                if WheelSpins ~= Controller2.Player.WheelSpins then
                    WheelSpins = Controller2.Player.WheelSpins;
                    u199:UpdateSpins();
                end;

                if WheelSpinsDone ~= Controller2.Player.WheelSpinsDone then
                    WheelSpinsDone = Controller2.Player.WheelSpinsDone;
                    u199:UpdatePity(true);
                end;

                if not deep_equals(Emotes, Controller2.Player.Customization.Inventory.Emotes) then
                    Emotes = Controller2.Player.Customization.Inventory.Emotes;
                    u199:UpdateProgress(true);
                end;

                if not deep_equals(Emotes, Controller2.Player.Customization.Inventory.Cosmetics) then
                    Cosmetics = Controller2.Player.Customization.Inventory.Cosmetics;
                    u199:UpdateProgress(true);
                end;
            end);
            u1:Connect(RunService.PreRender, function(p221) -- Line: 1125
                -- upvalues: u199 (ref)
                u199:Idle(p221);
            end);
            u1:Add(task.spawn(StartCountdown));
            u1:Add(function() -- Line: 1129
                -- upvalues: u199 (ref)
                u199:StopEffects();
            end);
            u199:UpdateSpins();
            u199:UpdateSkip();
            u199:UpdateProgress();
            u199:UpdatePity();
        end;

        u199.UI.OddsFrame.Visible = true;
    end);
    workspace.Lobby.Spinwheel.Hitbox.Touched:Connect(function(p222) -- Line: 1141
        -- upvalues: Players (ref), LocalPlayer (ref), u199 (copy), Controller3 (copy)
        if Players:GetPlayerFromCharacter(p222.Parent) ~= LocalPlayer then
            return;
        end;

        if u199.UI.Parent.Enabled then
            return;
        end;

        u199.UI.Parent.Enabled = true;
        LocalPlayer.PlayerGui.HUD.Enabled = false;
        Controller3:Focus(true, u199.UI.Parent);
    end);
    RunService.PreRender:Connect(function(p223) -- Line: 1159
        -- upvalues: u199 (copy)
        if not u199.UI.Parent.Enabled then
            return;
        end;

        local Slices = u199.UI.Wheel.Slices;

        if not u199.spinning then
            Slices.Rotation = (Slices.Rotation + p223 * 20) % 360;
        end;
    end);
end;

function v2.Display(p224) -- Line: 1172
    -- upvalues: Knit (copy), ReplicatedStorage (copy), Customization (copy), Trove (copy), ScriptableEmotes (copy), ScriptableCosmetics (copy), WheelItems (copy)
    Knit.GetController("Shop");
    Knit.GetController("Network");
    local Controller = Knit.GetController("LobbyController");
    local Controller2 = Knit.GetController("PromptController");
    local LimitedShopTemplates = ReplicatedStorage.Assets.LimitedShopTemplates;
    local u244 = {
        Emotes = function(u225: userdata, u226: any) -- Line: 1180, Name: Emotes
            -- upvalues: Customization (ref), Controller2 (copy), Controller (copy), Trove (ref), ScriptableEmotes (ref), ReplicatedStorage (ref)
            u226.Billboard.BillboardGui.ItemName.Text = `{string.upper(u225.ItemName)}`;
            u226.Billboard.BillboardGui.Category.Text = "WHEEL GRAND PRIZE";
            local v227 = Customization.Emotes[u225.ItemName];

            if not (v227 and v227.IsCutscene) then
                local v228 = ReplicatedStorage.Assets.EmoteAnimations:WaitForChild(u225.Anim or u225.ItemName);
                local v229 = u226.Character.Humanoid:LoadAnimation(v228);
                local u230 = Trove.new();
                u230:AttachToInstance(u226.Character);

                if ScriptableEmotes[u225.ItemName] then
                    if u225.ItemName == "Jackpot!" or (u225.ItemName == "Perfect Mind" or (u225.ItemName == "Skateboard" or (u225.ItemName == "Killer" or u225.ItemName == "Card Flip"))) then
                        v229.DidLoop:Connect(function() -- Line: 1209
                            -- upvalues: u230 (copy), ScriptableEmotes (ref), u225 (copy), u226 (copy)
                            u230:Clean();
                            ScriptableEmotes[u225.ItemName]({
                                Character = u226.Character
                            }, u230);
                        end);
                    else
                        task.spawn(ScriptableEmotes[u225.ItemName], {
                            Character = u226.Character
                        }, u230);
                    end;
                end;

                v229.Priority = Enum.AnimationPriority.Action2;
                v229.Looped = true;
                v229:Play();

                return;
            end;

            local v231 = Controller2.SpawnPurchasePrompt(u226.Parent, "PREVIEW", false, nil, true);
            v231.Triggered:Connect(function() -- Line: 1187
                -- upvalues: Controller (ref), u225 (copy)
                Controller:PreviewCutsceneEmote(u225.ItemName);
            end);
            v231.ObjectText = "Preview Cutscene";
            v231.UIOffset = Vector2.new(0, 80);
            v231.KeyboardKeyCode = Enum.KeyCode.T;
            v231.GamepadKeyCode = Enum.KeyCode.ButtonB;
            local v232 = Trove.new();
            v232:AttachToInstance(u226.Character);
            task.spawn(ScriptableEmotes[u225.ItemName .. "_LimitedShop"], {
                Character = u226.Character
            }, v232);
        end,

        GoalEffects = function(p233: userdata, p234: any) -- Line: 1224, Name: GoalEffects
            p234.Billboard.BillboardGui.ItemName.Text = `{string.upper(p233.ItemName)}`;
            p234.Billboard.BillboardGui.Category.Text = "WHEEL GRAND PRIZE";
        end,

        Cosmetics = function(p235: userdata, p236: any) -- Line: 1228, Name: Cosmetics
            -- upvalues: ReplicatedStorage (ref), ScriptableCosmetics (ref), Trove (ref)
            local u237 = ReplicatedStorage.Assets.Cosmetics:FindFirstChild(p235.ItemName):Clone();
            u237.Parent = p236.Character;
            p236.Billboard.BillboardGui.ItemName.Text = `{string.upper(p235.ItemName)}`;
            p236.Billboard.BillboardGui.Category.Text = "WHEEL GRAND PRIZE";

            if p235.Emote then
                local v238 = ReplicatedStorage.Assets.EmoteAnimations:WaitForChild(p235.Emote);
                local v239 = p236.Character.Humanoid:LoadAnimation(v238);
                v239.Priority = Enum.AnimationPriority.Action2;
                v239.Looped = true;
                v239:Play();
            end;

            if p235.IsTurnedAround then
                p236.Character:PivotTo(p236.Character:GetPivot() * CFrame.Angles(0, 3.141592653589793, 0));
            end;

            if p235.IsOnRight then
                p236.Character:PivotTo(p236.Character:GetPivot() * CFrame.fromEulerAngles(0, 1.5707963267948966, 0));
            end;

            if ScriptableCosmetics[p235.ItemName] then
                local u240 = Trove.new();
                u240:AttachToInstance(u237);
                u240:Add(u237.AncestryChanged:Connect(function() -- Line: 1254
                    -- upvalues: u237 (copy), u240 (copy)
                    if not u237:IsDescendantOf(workspace) then
                        u240:Destroy();
                    end;
                end));
                task.spawn(ScriptableCosmetics[p235.ItemName], p236.Character, u237, u240);
            end;
        end,

        Cards = function(p241: userdata, p242: any) -- Line: 1263, Name: Cards
            -- upvalues: ReplicatedStorage (ref)
            p242.Billboard.BillboardGui.ItemName.Text = string.upper(p241.ItemName);
            p242.Billboard.BillboardGui.Category.Text = "WHEEL GRAND PRIZE";
            local v243 = ReplicatedStorage.Assets.Cards:FindFirstChild(p241.ItemName):Clone();
            v243.Visible = true;
            v243.Size = UDim2.fromScale(1, 10);
            v243.AnchorPoint = Vector2.new(0.5, 0.75);
            v243:FindFirstChildOfClass("ViewportFrame"):Destroy();
            local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
            UIAspectRatioConstraint.AspectRatio = 1.778;
            UIAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize;
            UIAspectRatioConstraint.Parent = v243;

            for _, child in v243:GetChildren() do
                if child:IsA("TextLabel") and child.Name ~= "Txt" then
                    child.Text = "--";
                end;
            end;

            v243.Parent = p242.Root.BillboardGui;
        end
    };

    local function UpdateItemPreview(p245: userdata, p246: table) -- Line: 1289
        -- upvalues: LimitedShopTemplates (copy), u244 (copy)
        local v247 = {
            ItemName = p246[3].Name,
            ItemType = p246[3].Type
        };
        local v248 = p245.CFrame + Vector3.new(0, 1, 0) * p245.Size.Y * 0.5;
        local v249 = LimitedShopTemplates:FindFirstChild(v247.ItemType):Clone();
        local BoundingBox, v250 = v249:GetBoundingBox();
        v249:PivotTo((v248 + Vector3.new(0, 1, 0) * v250.Y * 0.5 + (v249:GetPivot().Position - BoundingBox.Position)) * CFrame.fromEulerAngles(0, -1.5707963267948966, 0));
        v249.Parent = p245;
        task.defer(u244[v247.ItemType], v247, v249);
    end;

    task.spawn(UpdateItemPreview, workspace:WaitForChild("Lobby"):WaitForChild("Spinwheel"):WaitForChild("1"):WaitForChild("Main"), WheelItems.Rewards[1]);
    task.spawn(UpdateItemPreview, workspace:WaitForChild("Lobby"):WaitForChild("Spinwheel"):WaitForChild("2"):WaitForChild("Main"), WheelItems.Rewards[2]);
end;

function v2.KnitStart(p251) -- Line: 1310
    p251:InitGui();
    p251:Display();
end;

return v2;