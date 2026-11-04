 

 

local Players = game:GetService("Players");
local MarketplaceService = game:GetService("MarketplaceService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local SoundService = game:GetService("SoundService");
local Debris = game:GetService("Debris");
local StarterGui = game:GetService("StarterGui");
local LocalPlayer = Players.LocalPlayer;
local script_Parent = script.Parent;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local SpinWheelEvent = game.ReplicatedStorage.ChickenOrHero:WaitForChild("SpinWheelEvent");
local Telemetry = require(game.ReplicatedStorage.ChickenOrHero:WaitForChild("Interface"):WaitForChild("Telemetry"));
local KnifeIconCopy = require(game.ReplicatedStorage.ChickenOrHero:WaitForChild("Weapons"):WaitForChild("KnifeIconCopy"));
local FFlags = require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags"));
local GearCatalog = require(game.ReplicatedStorage.ChickenOrHero:WaitForChild("Gear"):WaitForChild("GearCatalog"));
local v1 = require(game.ReplicatedStorage.ChickenOrHero:WaitForChild("Game"):WaitForChild("MapLocator")).interactables(10);
local ProximityPrompt = v1:WaitForChild("SpinTheWheel"):WaitForChild("SpinPad"):WaitForChild("PromptPad"):WaitForChild("ProximityPrompt");
local Main = script_Parent:WaitForChild("Main");
local Spinner = Main.Wheel.Spinner;
local Spin = Main.Spin;
local Buy1 = Main.Buy1;
local Buy10 = Main.Buy10;
local Buy100 = Main.Buy100;
local RobuxSpin = Main.RobuxSpin;
local CloseButton = Main.CloseButton;
local NextFreeSpin = Main.NextFreeSpin;
local Spin5 = Main:FindFirstChild("Spin5");
local Spin10 = Main:FindFirstChild("Spin10");
local Skip = Main:FindFirstChild("Skip");

local function multiButton(p2) -- Line: 39
    local v3;

    if p2 == nil or p2:FindFirstChild("Label") == nil then
        v3 = false;
    else
        v3 = p2:FindFirstChild("Locked") ~= nil;
    end;

    return v3;
end;

local u4;

if FFlags.SpinWheelMulti == true then
    if Spin5 == nil or Spin5:FindFirstChild("Label") == nil then
        u4 = false;
    else
        u4 = Spin5:FindFirstChild("Locked") ~= nil;
    end;

    if u4 then
        if Spin10 == nil or Spin10:FindFirstChild("Label") == nil then
            u4 = false;
        else
            u4 = Spin10:FindFirstChild("Locked") ~= nil;
        end;

        if u4 then
            u4 = Skip ~= nil;
        end;
    end;
else
    u4 = false;
end;

local u5 = u4 and {
    [Spin5] = 5,
    [Spin10] = 10
} or {};

for _, v in { "Spin5", "Spin10", "Skip" } do
    local v6 = Main:FindFirstChild(v);

    if v6 then
        v6.Visible = false;
    end;
end;

local Position = NextFreeSpin.Position;
local u7 = 0;

local function bounceNextFree() -- Line: 57
    -- upvalues: u7 (ref), NextFreeSpin (copy), Position (copy), TweenService (copy)
    u7 = os.clock();
    NextFreeSpin.Position = Position;
    local v8 = TweenService:Create(NextFreeSpin, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = Position - UDim2.fromScale(0, 0.012)
    });
    v8.Completed:Once(function(p9) -- Line: 63
        -- upvalues: TweenService (ref), NextFreeSpin (ref), Position (ref)
        if p9 == Enum.PlaybackState.Completed then
            TweenService:Create(NextFreeSpin, TweenInfo.new(0.4, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                Position = Position
            }):Play();
        end;
    end);
    v8:Play();
end;

local OddsButton = Main.OddsButton;
local Odds = Main.Odds;
local List = Odds.List;
local OddTemplate = List.OddTemplate;
OddTemplate.Parent = nil;
local u10 = {
    Kitsune = {
        model = "Kitsune",
        name = "KITSUNE",
        tilt = 20,
        icon = "rbxassetid://128029087883505"
    },
    Kusarigama = {
        model = "Kusarigama",
        name = "KUSARIGAMA",
        tilt = 0,
        icon = "rbxassetid://91694591265017"
    }
};
local u11 = {
    {
        upTo = 1,
        color = Color3.fromRGB(242, 191, 89)
    },
    {
        upTo = 5,
        color = Color3.fromRGB(183, 123, 244)
    },
    {
        upTo = 20,
        color = Color3.fromRGB(92, 173, 238)
    },
    {
        upTo = 30,
        color = Color3.fromRGB(104, 211, 122)
    },
    {
        upTo = 100,
        color = Color3.fromRGB(175, 185, 192)
    }
};
local ServerTimeNow = workspace:GetServerTimeNow();
local v12 = math.max(ServerTimeNow, os.time()) / 86400;
local math_floor_ret = math.floor(v12);
local Sound = Instance.new("Sound");
Sound.Name = "WheelTick";
Sound.SoundId = "rbxassetid://10066931761";
Sound.Volume = 0.35;
Sound.Parent = SoundService;

local function playTick() -- Line: 140
    -- upvalues: Sound (copy), SoundService (copy), Debris (copy)
    local v13 = Sound:Clone();
    v13.Parent = SoundService;
    v13:Play();
    Debris:AddItem(v13, 1);
end;

local TextLabel = Instance.new("TextLabel");
TextLabel.Name = "WheelResult";
TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
TextLabel.Position = UDim2.fromScale(0.5, 0.79);
TextLabel.Size = UDim2.fromScale(0.74, 0.08);
TextLabel.BackgroundTransparency = 1;
TextLabel.TextColor3 = Color3.fromRGB(255, 220, 126);
TextLabel.TextStrokeColor3 = Color3.fromRGB(35, 17, 52);
TextLabel.TextStrokeTransparency = 0.1;
TextLabel.Font = Enum.Font.GothamBlack;
TextLabel.TextScaled = true;
TextLabel.Text = "";
TextLabel.Visible = false;
TextLabel.ZIndex = 50;
TextLabel.Parent = Main;

local function rewardSound(p14, p15, p16) -- Line: 192
    -- upvalues: SoundService (copy), Debris (copy)
    local Sound2 = Instance.new("Sound");
    Sound2.SoundId = "rbxassetid://" .. p14;
    Sound2.Volume = p15;
    Sound2.PlaybackSpeed = p16 or 1;
    Sound2.Parent = SoundService;
    Sound2:Play();
    Debris:AddItem(Sound2, 5);
end;

local function tween(p17, p18, p19, p20) -- Line: 202
    -- upvalues: TweenService (copy)
    local v21 = TweenService:Create(p17, TweenInfo.new(p18, p20 or Enum.EasingStyle.Quart, Enum.EasingDirection.Out), p19);
    v21:Play();

    return v21;
end;

local function sliceArt(p22) -- Line: 294
    -- upvalues: u10 (copy)
    local v23 = p22.Parent and u10[p22.Parent.Name];
    local v24;

    if v23 then
        v24 = p22:FindFirstChild("PrizeImage");
    else
        v24 = v23;
    end;

    if v24 and v24:IsA("ImageLabel") then
        v24.Image = v23.icon;
        v24.ImageTransparency = 0;
    end;
end;

local u25 = false;
local u26 = {};
local u27 = false;
local u28 = nil;
local u29 = {};
local u30 = 0;
local u31 = (-1 / 0);
local u32 = nil;
local u33 = nil;

local function notifyReward(u34) -- Line: 212
    -- upvalues: StarterGui (copy)
    if not u34 or u34 == "" then
        return;
    end;

    task.spawn(function() -- Line: 216
        -- upvalues: StarterGui (ref), u34 (copy)
        for i = 1, 5 do
            if pcall(StarterGui.SetCore, StarterGui, "SendNotification", {
                Title = "SPIN WHEEL REWARD",
                Duration = 6,
                Text = u34
            }) then
                return;
            end;

            task.wait(i * 0.3);
            local _ = i;
        end;
    end);
end;

local u35 = nil;
local u36 = false;

local function showKnife(p37, p38, p39, p40, p41, p42, p43) -- Line: 235
    -- upvalues: KnifeIconCopy (copy)
    local v44 = game.ReplicatedStorage.ChickenOrHero.Weapons.Models:FindFirstChild(p41.model);
    local v45;

    if v44 then
        v45 = v44:FindFirstChild("Blade");
    else
        v45 = v44;
    end;

    if v45 and v45:IsA("BasePart") then
        local ViewportFrame = Instance.new("ViewportFrame");
        ViewportFrame.Name = p43 or p41.model .. "Preview";
        ViewportFrame.AnchorPoint = Vector2.new(0.5, 0.5);
        ViewportFrame.Position = p38;
        ViewportFrame.Size = p39;
        ViewportFrame.BackgroundTransparency = 1;
        ViewportFrame.Ambient = Color3.fromRGB(210, 190, 130);
        ViewportFrame.LightColor = Color3.fromRGB(255, 238, 188);
        ViewportFrame.LightDirection = Vector3.new(-0.4, -0.8, -1);
        ViewportFrame.ZIndex = p40;
        ViewportFrame.Parent = p37;
        local WorldModel = Instance.new("WorldModel");
        WorldModel.Parent = ViewportFrame;
        local v46, _, v47, v48 = KnifeIconCopy.new(v45);
        v46.Parent = WorldModel;
        local Attribute = v44:GetAttribute("ThumbAxis");
        local Attribute2 = v44:GetAttribute("ThumbNormal");
        local v49;

        if typeof(Attribute) == "Vector3" and (typeof(Attribute2) == "Vector3" and Attribute.Magnitude > 0.5) then
            local Unit = Attribute.Unit;
            local Unit2 = (Attribute2 - Unit * Attribute2:Dot(Unit)).Unit;
            local math_rad_ret = math.rad(p41.tilt or 0);
            local math_cos_ret = math.cos(math_rad_ret);
            local math_sin_ret = math.sin(math_rad_ret);
            local Vector3_new_ret = Vector3.new(math_cos_ret, math_sin_ret, 0);
            v49 = CFrame.fromMatrix(Vector3.new(0, 0, 0), Vector3_new_ret, Vector3.new(0, 0, 1), Vector3_new_ret:Cross(Vector3.new(0, 0, 1))) * CFrame.fromMatrix(Vector3.new(0, 0, 0), Unit, Unit2, Unit:Cross(Unit2)):Inverse();
        else
            local Attribute3 = v44:GetAttribute("PreviewRotation");

            if typeof(Attribute3) == "CFrame" then
                v49 = Attribute3.Rotation;
            else
                v49 = CFrame.Angles(0.2617993877991494, 1.1344640137963142, -0.4363323129985824);
            end;
        end;

        v46.CFrame = CFrame.new(-v49:VectorToWorldSpace(v48)) * v49;
        local v50 = 0;
        local v51 = 0;
        local v52 = 0;

        for _, v in { -0.5, 0.5 } do
            local v53 = v;

            for _, v2 in { -0.5, 0.5 } do
                local v54 = v2;

                for _, v3 in { -0.5, 0.5 } do
                    local v55 = v49:VectorToWorldSpace(v47 * Vector3.new(v53, v54, v3));
                    local math_abs_ret = math.abs(v55.X);
                    v51 = math.max(v51, math_abs_ret);
                    local math_abs_ret2 = math.abs(v55.Y);
                    v52 = math.max(v52, math_abs_ret2);
                    v50 = math.max(v50, v55.Z);
                end;
            end;
        end;

        local Camera = Instance.new("Camera");
        Camera.FieldOfView = 35;
        local v56 = math.max(v52, v51 / (p42 or 1)) * 1.08;
        local math_rad_ret = math.rad(Camera.FieldOfView / 2);
        local v57 = v50 + v56 / math.tan(math_rad_ret);
        Camera.CFrame = CFrame.lookAt(Vector3.new(0, 0, v57), Vector3.new(0, 0, 0));
        Camera.Parent = ViewportFrame;
        ViewportFrame.CurrentCamera = Camera;

        return ViewportFrame;
    end;
end;

local u58 = {};
local u59 = nil;
local u60 = {
    credits = 0,
    nextFreeAt = 0,
    discountAvailable = true,
    purchasesAvailable = false
};
local u61 = false;
local u62 = {};
local u63 = false;
local u64 = 0;
local u65 = nil;
local u66 = {
    GhostKey = "Ghost Key",
    ["250Coins"] = "250 Coins",
    ["500Coins"] = "500 Coins",
    Adrenaline = "Adrenaline x3",
    ["2xCoins"] = "2x Coins (15 min)",
    ["2xGems"] = "2x Gems (25 min)",
    Kitsune = "Kitsune",
    Kusarigama = "Kusarigama"
};

local function showMessage(u67, p68) -- Line: 163
    -- upvalues: TextLabel (copy), TweenService (copy)
    if not u67 or u67 == "" then
        return;
    end;

    TextLabel.Text = u67;
    TextLabel.Visible = true;
    TextLabel.TextTransparency = 0;
    TextLabel.TextStrokeTransparency = 0.1;
    TextLabel.Rotation = -3;
    TweenService:Create(TextLabel, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Rotation = 0
    }):Play();
    task.delay(p68 or 3, function() -- Line: 176
        -- upvalues: TextLabel (ref), u67 (copy), TweenService (ref)
        if TextLabel.Text ~= u67 then
            return;
        end;

        TweenService:Create(TextLabel, TweenInfo.new(0.3), {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }):Play();
        task.wait(0.32);

        if TextLabel.Text == u67 then
            TextLabel.Visible = false;
        end;
    end);
end;

local u69 = nil;
local u70 = nil;
local u71 = nil;
local u72 = false;

for i in u10 do
    local v73 = Spinner:FindFirstChild(i);

    if v73 and v73:FindFirstChild("Prize") then
        local Prize = v73.Prize;
        local v74 = Prize.Parent and u10[Prize.Parent.Name];
        local v75;

        if v74 then
            v75 = Prize:FindFirstChild("PrizeImage");
        end;

        if v75 and v75:IsA("ImageLabel") then
            v75.Image = v74.icon;
            v75.ImageTransparency = 0;
        end;
    end;
end;

local SpinTheWheel = v1:WaitForChild("SpinTheWheel");

local function lobbyArt(p76) -- Line: 311
    -- upvalues: u10 (copy)
    local Parent = p76.Parent;

    if p76:IsA("GuiObject") and (Parent and (Parent.Parent and Parent.Parent.Name == "Spinner")) then
        local v77 = p76.Parent and u10[p76.Parent.Name];
        local v78;

        if v77 then
            v78 = p76:FindFirstChild("PrizeImage");
        else
            v78 = v77;
        end;

        if v78 and v78:IsA("ImageLabel") then
            v78.Image = v77.icon;
            v78.ImageTransparency = 0;
        end;
    end;
end;

SpinTheWheel.DescendantAdded:Connect(function(p79) -- Line: 317
    -- upvalues: lobbyArt (copy)
    if p79.Name == "Prize" then
        task.defer(lobbyArt, p79);
    end;
end);

for _, descendant in SpinTheWheel:GetDescendants() do
    if descendant.Name == "Prize" then
        local Parent = descendant.Parent;

        if descendant:IsA("GuiObject") and (Parent and (Parent.Parent and Parent.Parent.Name == "Spinner")) then
            local v80 = descendant.Parent and u10[descendant.Parent.Name];
            local v81;

            if v80 then
                v81 = descendant:FindFirstChild("PrizeImage");
            end;

            if v81 and v81:IsA("ImageLabel") then
                v81.Image = v80.icon;
                v81.ImageTransparency = 0;
            end;
        end;
    end;
end;

local function celebrate(p82) -- Line: 329
    -- upvalues: u70 (ref), u10 (copy), SoundService (copy), Debris (copy), Main (copy), TweenService (copy), showKnife (copy)
    if u70 then
        u70:Destroy();
    end;

    local v83 = u10[p82.id];
    local v84 = v83 ~= nil;
    local v85 = v83 and Color3.fromRGB(255, 211, 78) or p82.id == "2xGems" and Color3.fromRGB(97, 224, 255) or (p82.id == "GhostKey" and Color3.fromRGB(255, 205, 90) or Color3.fromRGB(255, 199, 105));
    local Sound2 = Instance.new("Sound");
    Sound2.SoundId = "rbxassetid://82803453482376";
    Sound2.Volume = 0.35;
    Sound2.PlaybackSpeed = v84 and 0.85 or 1.15 or 1;
    Sound2.Parent = SoundService;
    Sound2:Play();
    Debris:AddItem(Sound2, 5);

    if v84 then
        local Sound3 = Instance.new("Sound");
        Sound3.SoundId = "rbxassetid://10128766965";
        Sound3.Volume = 0.35;
        Sound3.PlaybackSpeed = 0.85;
        Sound3.Parent = SoundService;
        Sound3:Play();
        Debris:AddItem(Sound3, 5);
        task.delay(0.18, function() -- Line: 342
            -- upvalues: SoundService (ref), Debris (ref)
            local Sound4 = Instance.new("Sound");
            Sound4.SoundId = "rbxassetid://9117278724";
            Sound4.Volume = 0.35;
            Sound4.PlaybackSpeed = 1;
            Sound4.Parent = SoundService;
            Sound4:Play();
            Debris:AddItem(Sound4, 5);
        end);
    end;

    local CanvasGroup = Instance.new("CanvasGroup");
    CanvasGroup.Name = "WheelCelebration";
    CanvasGroup.BackgroundTransparency = 1;
    CanvasGroup.Size = UDim2.fromScale(1, 1);
    CanvasGroup.ZIndex = 60;
    CanvasGroup.Parent = Main;
    u70 = CanvasGroup;
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundColor3 = v85;
    Frame.BackgroundTransparency = v84 and 0.55 or 0.72;
    Frame.BorderSizePixel = 0;
    Frame.ZIndex = 60;
    Frame.Parent = CanvasGroup;
    TweenService:Create(Frame, TweenInfo.new(v84 and 0.8 or 0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play();
    local UDim2_fromScale_ret = UDim2.fromScale(0.5, 0.416);

    for i = 1, v84 and 3 or 2 do
        local Frame2 = Instance.new("Frame");
        Frame2.Name = "RewardRing";
        Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
        Frame2.Position = UDim2_fromScale_ret;
        Frame2.Size = UDim2.fromScale(0.02, 0.02);
        Frame2.BackgroundTransparency = 1;
        Frame2.ZIndex = 61;
        Frame2.Parent = CanvasGroup;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(1, 0);
        UICorner.Parent = Frame2;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = v85;
        UIStroke.Thickness = v84 and 4 or 2;
        UIStroke.Transparency = 0.06;
        UIStroke.Parent = Frame2;
        task.delay((i - 1) * 0.16, function() -- Line: 379
            -- upvalues: Frame2 (copy), i (copy), TweenService (ref), UIStroke (copy)
            if not Frame2.Parent then
                return;
            end;

            local v86 = {
                Size = UDim2.fromScale(i * 0.12 + 0.36, i * 0.17 + 0.6)
            };
            TweenService:Create(Frame2, TweenInfo.new(0.72, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), v86):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.72, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
        end);
        local _ = i;
    end;

    local v87 = v84 and 24 or 12;

    for i = 1, v87 do
        local Frame2 = Instance.new("Frame");
        Frame2.Name = "RewardRay";
        Frame2.AnchorPoint = Vector2.new(0.5, 1);
        Frame2.Position = UDim2_fromScale_ret;
        Frame2.Size = UDim2.fromScale(i % 2 == 0 and 0.006 or 0.003, 0.02);
        Frame2.Rotation = i * 360 / v87;
        Frame2.BackgroundColor3 = v85;
        Frame2.BackgroundTransparency = 0.35;
        Frame2.BorderSizePixel = 0;
        Frame2.ZIndex = 61;
        Frame2.Parent = CanvasGroup;
        local UIGradient = Instance.new("UIGradient");
        UIGradient.Transparency = NumberSequence.new(0, 1);
        UIGradient.Parent = Frame2;
        local v88 = {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(i % 2 == 0 and 0.006 or 0.003, v84 and 0.32 or 0.2)
        };
        TweenService:Create(Frame2, TweenInfo.new(v84 and 1.1 or 0.75, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), v88):Play();
        local _ = i;
    end;

    for i = 1, v84 and 42 or 22 do
        local Frame2 = Instance.new("Frame");
        Frame2.Name = "RewardConfetti";
        Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
        Frame2.Position = UDim2_fromScale_ret;
        Frame2.Size = UDim2.fromScale(v84 and 0.009 or 0.006, v84 and 0.018 or 0.012);
        Frame2.Rotation = math.random(0, 360);
        local v89;

        if i % 3 == 0 then
            v89 = Color3.new(1, 1, 1) or v85;
        else
            v89 = v85;
        end;

        Frame2.BackgroundColor3 = v89;
        Frame2.BorderSizePixel = 0;
        Frame2.ZIndex = 63;
        Frame2.Parent = CanvasGroup;
        local v90 = math.random() * 3.141592653589793 * 2;
        local v91 = (0.12 + math.random() * 0.35) * (v84 and 1 or 0.75);
        local v92 = 0.8 + math.random() * 0.6;
        local v93 = {
            BackgroundTransparency = 1,
            Position = UDim2.fromScale(0.5 + math.cos(v90) * v91, 0.416 + math.sin(v90) * v91),
            Rotation = Frame2.Rotation + math.random(-270, 270)
        };
        TweenService:Create(Frame2, TweenInfo.new(v92, Enum.EasingStyle.Cubic or Enum.EasingStyle.Quart, Enum.EasingDirection.Out), v93):Play();
        local _ = i;
    end;

    if v84 then
        local CanvasGroup2 = Instance.new("CanvasGroup");
        CanvasGroup2.Name = "JackpotCard";
        CanvasGroup2.AnchorPoint = Vector2.new(0.5, 0.5);
        CanvasGroup2.Position = UDim2_fromScale_ret;
        CanvasGroup2.Size = UDim2.fromOffset(math.min(420, Main.AbsoluteSize.X * 0.48), (math.min(300, Main.AbsoluteSize.Y * 0.48)));
        CanvasGroup2.BackgroundColor3 = Color3.fromRGB(18, 22, 37);
        CanvasGroup2.BackgroundTransparency = 0.06;
        CanvasGroup2.GroupTransparency = 1;
        CanvasGroup2.ZIndex = 70;
        CanvasGroup2.Parent = CanvasGroup;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(0, 20);
        UICorner.Parent = CanvasGroup2;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = v85;
        UIStroke.Thickness = 3;
        UIStroke.Parent = CanvasGroup2;
        local UIScale = Instance.new("UIScale");
        UIScale.Scale = 0.55;
        UIScale.Parent = CanvasGroup2;
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "PrizeArt";
        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
        ImageLabel.Position = UDim2.fromScale(0.5, 0.46);
        ImageLabel.Size = UDim2.fromScale(0.48, 0.56);
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.ScaleType = Enum.ScaleType.Fit;
        ImageLabel.Image = "";
        ImageLabel.ZIndex = 71;
        ImageLabel.Parent = CanvasGroup2;
        local Size = CanvasGroup2.Size;
        showKnife(CanvasGroup2, ImageLabel.Position, ImageLabel.Size, ImageLabel.ZIndex + 1, v83, ImageLabel.Size.X.Scale * Size.X.Offset / math.max(1, ImageLabel.Size.Y.Scale * Size.Y.Offset));
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.Name = "PrizeTitle";
        TextLabel2.Position = UDim2.fromScale(0.06, 0.74);
        TextLabel2.Size = UDim2.fromScale(0.88, 0.17);
        TextLabel2.BackgroundTransparency = 1;
        local v94;

        if p82.gems then
            v94 = "+" .. p82.gems .. " GEMS";
        else
            v94 = v83.name .. ((type(p82.copies) ~= "number" or p82.copies <= 1) and "" or " x" .. p82.copies);
        end;

        TextLabel2.Text = v94;
        TextLabel2.TextColor3 = v85;
        TextLabel2.TextStrokeTransparency = 0.35;
        TextLabel2.Font = Enum.Font.GothamBlack;
        TextLabel2.TextScaled = true;
        TextLabel2.ZIndex = 71;
        TextLabel2.Parent = CanvasGroup2;
        local TextLabel3 = Instance.new("TextLabel");
        TextLabel3.Name = "JackpotTitle";
        TextLabel3.Position = UDim2.fromScale(0.06, 0.05);
        TextLabel3.Size = UDim2.fromScale(0.88, 0.14);
        TextLabel3.BackgroundTransparency = 1;
        TextLabel3.Text = not p82.gems and "✦ VOID BLADES EVENT ✦" or "✦ " .. v83.name .. " OWNED ✦";
        TextLabel3.TextColor3 = Color3.new(1, 1, 1);
        TextLabel3.Font = Enum.Font.GothamBold;
        TextLabel3.TextScaled = true;
        TextLabel3.ZIndex = 71;
        TextLabel3.Parent = CanvasGroup2;
        TweenService:Create(CanvasGroup2, TweenInfo.new(0.45, Enum.EasingStyle.Back or Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            GroupTransparency = 0
        }):Play();
        TweenService:Create(UIScale, TweenInfo.new(0.6, Enum.EasingStyle.Back or Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Scale = 1
        }):Play();
    end;

    task.delay(v84 and 3 or 1.7, function() -- Line: 491
        -- upvalues: CanvasGroup (copy), TweenService (ref), Debris (ref)
        if CanvasGroup.Parent then
            TweenService:Create(CanvasGroup, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                GroupTransparency = 1
            }):Play();
            Debris:AddItem(CanvasGroup, 0.5);
        end;
    end);
end;

local function rarityColor(p95) -- Line: 499
    -- upvalues: u11 (copy)
    for _, v in u11 do
        if p95 <= v.upTo then
            return v.color;
        end;
    end;

    return u11[#u11].color;
end;

local function prizeArt(p96) -- Line: 509
    -- upvalues: Spinner (copy)
    local v97 = Spinner:FindFirstChild(p96);

    for _, v in v97 and v97:GetDescendants() or {} do
        if v.Name == "PrizeImage" and (v:IsA("ImageLabel") and v.Image ~= "") then
            return v.Image;
        end;
    end;

    return "";
end;

local function buildOdds(p98) -- Line: 520
    -- upvalues: u25 (ref), OddTemplate (copy), prizeArt (copy), u10 (copy), showKnife (copy), u66 (copy), u11 (copy), List (copy)
    if u25 or type(p98) ~= "table" then
        return;
    end;

    u25 = true;

    for i, v in p98 do
        if type(v) == "table" and (type(v.id) == "string" and type(v.percent) == "number") then
            local v99 = OddTemplate:Clone();
            v99.Name = v.id;
            v99.LayoutOrder = i;
            local v100 = prizeArt(v.id);
            v99.Item.Image = v100;
            local v101;

            if v100 == "" then
                v101 = not u10[v.id];
            else
                v101 = false;
            end;

            v99.Item.Fallback.Visible = v101;

            if u10[v.id] then
                local UDim2_fromScale_ret = UDim2.fromScale(1, 1);
                showKnife(v99.Item, UDim2.fromScale(0.5, 0.5), UDim2_fromScale_ret, v99.Item.ZIndex + 1, u10[v.id], 1);
            end;

            v99.ItemName.Text = u66[v.id] or v.id;
            v99.Percent.Text = string.format("%.2f", v.percent):gsub("%.?0+$", "") .. "%";
            local percent = v.percent;
            local v102;

            for _, v2 in u11 do
                if percent <= v2.upTo then
                    v102 = v2.color;
                    break;
                end;
            end;

            v102 = u11[#u11].color;
            v99.Percent.TextColor3 = v102;
            v99.Visible = true;
            v99.Parent = List;
        end;
    end;
end;

local function serverNow() -- Line: 548
    local ServerTimeNow2 = workspace:GetServerTimeNow();

    if ServerTimeNow2 > 1000000000 then
        return ServerTimeNow2;
    end;

    return os.time();
end;

local function durationText(p103) -- Line: 552
    local math_ceil_ret = math.ceil(p103);
    local math_max_ret = math.max(0, math_ceil_ret);

    return string.format("%dm %02ds", math.floor(math_max_ret / 60), math_max_ret % 60);
end;

local function updateLabels() -- Line: 557
    -- upvalues: Spin (copy), u60 (copy), NextFreeSpin (copy), u32 (ref), Buy1 (copy), u26 (copy), Buy10 (copy), Buy100 (copy), RobuxSpin (copy), u27 (ref), u61 (ref), u36 (ref), u5 (copy), Odds (copy)
    Spin.SpinAmount.Text = string.format("Spin! (%d)", u60.credits or 0);
    local v104 = u60.nextFreeAt or 0;
    local ServerTimeNow2 = workspace:GetServerTimeNow();

    if ServerTimeNow2 <= 1000000000 then
        ServerTimeNow2 = os.time();
    end;

    local v105 = v104 - ServerTimeNow2;
    local v106;

    if u32 then
        v106 = "SPIN x" .. u32.count;
    elseif v105 > 0 then
        local math_ceil_ret = math.ceil(v105);
        local math_max_ret = math.max(0, math_ceil_ret);
        v106 = "Free Spin: " .. string.format("%dm %02ds", math.floor(math_max_ret / 60), math_max_ret % 60);
    else
        v106 = "Free spin ready!";
    end;

    NextFreeSpin.Text = v106;
    Buy1.Price.Text = "Buy 1 Spin " .. "" .. " " .. (u26[3716057178] or "...");
    Buy10.Price.Text = "Buy 10 Spins " .. "" .. " " .. (u26[3716072886] or "...");
    Buy100.Price.Text = "Buy 100 Spins " .. "" .. " " .. (u26[3718405322] or "...");
    RobuxSpin.Price.Text = "" .. " " .. (u26[u60.discountAvailable and 3716057142 or 3716057178] or "...");
    RobuxSpin.FlavorText.Visible = u60.discountAvailable;
    RobuxSpin.Discount.Visible = u60.discountAvailable;
    RobuxSpin.Price.Position = u60.discountAvailable and UDim2.fromScale(0.311, 0.5) or UDim2.fromScale(0.5, 0.5);

    if u60.discountAvailable then
        RobuxSpin.Discount.Text = "" .. " " .. (u26[3716057178] or "...");
    end;

    local v107;

    if (u60.credits or 0) > 0 then
        v107 = not u27 and not u61;
    else
        v107 = false;
    end;

    Spin.AutoButtonColor = v107;
    Buy1.AutoButtonColor = not (u27 or u36) and u60.purchasesAvailable;
    Buy10.AutoButtonColor = not (u27 or u36) and u60.purchasesAvailable;
    Buy100.AutoButtonColor = not (u27 or u36) and u60.purchasesAvailable;
    RobuxSpin.AutoButtonColor = not (u27 or u36) and u60.purchasesAvailable;

    for i, v in u5 do
        local v108 = v <= (u60.credits or 0);
        i.Visible = not u32 and not Odds.Visible;
        i.Label.Text = "Spin x" .. v;
        i.Locked.Visible = not v108;
        local v109 = not u27;

        if v109 then
            local v110 = not u61;

            if not v110 then
                v108 = v110;
            end;
        else
            v108 = v109;
        end;

        i.AutoButtonColor = v108;
    end;
end;

local function hideGui(u111) -- Line: 591
    -- upvalues: script_Parent (copy), u58 (copy), u62 (copy), u63 (ref)
    if u111:IsA("ScreenGui") and (u111 ~= script_Parent and (u111.Name ~= "TouchGui" and u111.Name ~= "RewardPop")) then
        if u58[u111] == nil then
            u58[u111] = u111.Enabled;
        end;

        if not u62[u111] then
            u62[u111] = u111:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 597
                -- upvalues: u63 (ref), u111 (copy), u58 (ref)
                if u63 and u111.Enabled then
                    u58[u111] = true;
                    u111.Enabled = false;
                end;
            end);
        end;

        u111.Enabled = false;
    end;
end;

local u112 = 0;

local function openWheel() -- Line: 609
    -- upvalues: u63 (ref), LocalPlayer (copy), u112 (ref), Telemetry (copy), PlayerGui (copy), hideGui (copy), script_Parent (copy), u64 (ref), SpinWheelEvent (copy), Spinner (copy), updateLabels (copy), bounceNextFree (copy)
    if u63 or LocalPlayer:GetAttribute("InMatch") == true then
        return;
    end;

    u63 = true;
    LocalPlayer:SetAttribute("SpinWheelOpen", true);
    u112 = os.clock();
    Telemetry.track("panel_open", "SpinWheel");

    for _, child in PlayerGui:GetChildren() do
        hideGui(child);
    end;

    script_Parent.Enabled = true;

    if os.clock() - u64 > 0.4 then
        u64 = os.clock();
        SpinWheelEvent:FireServer("State");
    end;

    Spinner.Rotation = -30;
    updateLabels();
    bounceNextFree();
end;

local function closeWheel() -- Line: 632
    -- upvalues: u63 (ref), u71 (ref), u59 (ref), u27 (ref), u33 (ref), StarterGui (copy), LocalPlayer (copy), Telemetry (copy), u112 (ref), script_Parent (copy), u70 (ref), u62 (copy), u58 (copy), PlayerGui (copy), TextLabel (copy), Odds (copy), NextFreeSpin (copy), Position (copy)
    if not u63 then
        return;
    end;

    u71();

    if u59 then
        u59:Cancel();
        u59 = nil;
        u27 = false;
    end;

    if u33 then
        local u113 = u33;

        if u113 and u113 ~= "" then
            task.spawn(function() -- Line: 216
                -- upvalues: StarterGui (ref), u113 (copy)
                for i = 1, 5 do
                    if pcall(StarterGui.SetCore, StarterGui, "SendNotification", {
                        Title = "SPIN WHEEL REWARD",
                        Duration = 6,
                        Text = u113
                    }) then
                        return;
                    end;

                    task.wait(i * 0.3);
                    local _ = i;
                end;
            end);
        end;

        u33 = nil;
    end;

    u63 = false;
    LocalPlayer:SetAttribute("SpinWheelOpen", nil);
    local track = Telemetry.track;
    local v114 = os.clock() - u112;
    track("panel_close", "SpinWheel:Closed", (math.floor(v114)));
    script_Parent.Enabled = false;

    if u70 then
        u70:Destroy();
        u70 = nil;
    end;

    for i, v in u62 do
        v:Disconnect();
        u62[i] = nil;
    end;

    for i, v in u58 do
        if i.Parent == PlayerGui then
            i.Enabled = v;
        end;

        u58[i] = nil;
    end;

    TextLabel.Visible = false;
    Odds.Visible = false;
    NextFreeSpin.Position = Position;
end;

local function animate(p115) -- Line: 669
    -- upvalues: LocalPlayer (copy), u33 (ref), closeWheel (copy), StarterGui (copy), u59 (ref), u63 (ref), openWheel (copy), u27 (ref), TextLabel (copy), updateLabels (copy), Spinner (copy), RunService (copy), Sound (copy), SoundService (copy), Debris (copy), TweenService (copy), celebrate (copy), showMessage (copy), u28 (ref), u69 (ref)
    if type(p115) ~= "table" or type(p115.angle) ~= "number" then
        return;
    end;

    if LocalPlayer:GetAttribute("InMatch") == true then
        local u116 = u33 or p115.message;
        u33 = nil;
        closeWheel();

        if u116 then
            if u116 == "" then
                return;
            end;

            task.spawn(function() -- Line: 216
                -- upvalues: StarterGui (ref), u116 (copy)
                for i = 1, 5 do
                    if pcall(StarterGui.SetCore, StarterGui, "SendNotification", {
                        Title = "SPIN WHEEL REWARD",
                        Duration = 6,
                        Text = u116
                    }) then
                        return;
                    end;

                    task.wait(i * 0.3);
                    local _ = i;
                end;
            end);
        end;

        return;
    end;

    if u59 then
        u59:Cancel();
    end;

    if not u63 then
        openWheel();
    end;

    u27 = true;
    TextLabel.Visible = false;
    updateLabels();
    local Rotation = Spinner.Rotation;
    local v117 = p115.angle + math.ceil((Rotation + 2160 - p115.angle) / 360) * 360;
    local math_floor_ret2 = math.floor((Rotation + 30) / 60);
    local v119 = RunService.RenderStepped:Connect(function() -- Line: 693
        -- upvalues: Spinner (ref), math_floor_ret2 (ref), Sound (ref), SoundService (ref), Debris (ref)
        local math_floor_ret3 = math.floor((Spinner.Rotation + 30) / 60);

        if math_floor_ret2 < math_floor_ret3 then
            for i = math_floor_ret2 + 1, math_floor_ret3 do
                local v118 = Sound:Clone();
                v118.Parent = SoundService;
                v118:Play();
                Debris:AddItem(v118, 1);
                local _ = i;
            end;

            math_floor_ret2 = math_floor_ret3;
        end;
    end);
    local v120 = TweenService:Create(Spinner, TweenInfo.new(5.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Rotation = v117
    });
    u59 = v120;
    v120:Play();
    v120.Completed:Wait();
    v119:Disconnect();

    if u59 ~= v120 then
        return;
    end;

    u59 = nil;
    Spinner.Rotation = p115.angle;
    u27 = false;
    updateLabels();
    celebrate(p115);
    showMessage(p115.message or "YOU WON!", 4);
    local u121 = u33 or p115.message;

    if u121 and u121 ~= "" then
        task.spawn(function() -- Line: 216
            -- upvalues: StarterGui (ref), u121 (copy)
            for i = 1, 5 do
                if pcall(StarterGui.SetCore, StarterGui, "SendNotification", {
                    Title = "SPIN WHEEL REWARD",
                    Duration = 6,
                    Text = u121
                }) then
                    return;
                end;

                task.wait(i * 0.3);
                local _ = i;
            end;
        end);
    end;

    u33 = nil;
    local Size = Spinner.Size;
    TweenService:Create(Spinner, TweenInfo.new(0.16, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(Size.X.Scale * 1.04, Size.X.Offset, Size.Y.Scale * 1.04, Size.Y.Offset)
    }):Play();
    task.delay(0.17, function() -- Line: 725
        -- upvalues: TweenService (ref), Spinner (ref), Size (copy)
        TweenService:Create(Spinner, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = Size
        }):Play();
    end);

    if u28 then
        local v122 = u28;
        u28 = nil;
        task.delay(0.8, u69, v122);
    end;
end;

local function slot(p123, p124, p125) -- Line: 743
    return {
        position = UDim2.fromScale(p123, p124),
        scale = p125 / 0.753
    };
end;

local u126 = {
    [5] = {
        {
            scale = 0.5843293492695883,
            position = UDim2.fromScale(0.5, 0.5185)
        },
        {
            scale = 0.5312084993359893,
            position = UDim2.fromScale(0.27, 0.284)
        },
        {
            scale = 0.5312084993359893,
            position = UDim2.fromScale(0.73, 0.284)
        },
        {
            scale = 0.5312084993359893,
            position = UDim2.fromScale(0.27, 0.753)
        },
        {
            scale = 0.5312084993359893,
            position = UDim2.fromScale(0.73, 0.753)
        }
    },
    [10] = {
        {
            scale = 0.4780876494023904,
            position = UDim2.fromScale(0.5, 0.262)
        },
        {
            scale = 0.4780876494023904,
            position = UDim2.fromScale(0.12, 0.262)
        },
        {
            scale = 0.4780876494023904,
            position = UDim2.fromScale(0.31, 0.262)
        },
        {
            scale = 0.4780876494023904,
            position = UDim2.fromScale(0.69, 0.262)
        },
        {
            scale = 0.4780876494023904,
            position = UDim2.fromScale(0.88, 0.262)
        },
        {
            scale = 0.4780876494023904,
            position = UDim2.fromScale(0.12, 0.688)
        },
        {
            scale = 0.4780876494023904,
            position = UDim2.fromScale(0.31, 0.688)
        },
        {
            scale = 0.4780876494023904,
            position = UDim2.fromScale(0.5, 0.688)
        },
        {
            scale = 0.4780876494023904,
            position = UDim2.fromScale(0.69, 0.688)
        },
        {
            scale = 0.4780876494023904,
            position = UDim2.fromScale(0.88, 0.688)
        }
    }
};
local u127 = {
    ["2xCoins"] = 15,
    ["2xGems"] = 25
};
local Color3_fromRGB_ret = Color3.fromRGB(255, 211, 78);
local Position2 = Main.Wheel.Position;
local u128 = {
    Spin,
    RobuxSpin,
    CloseButton,
    Buy1,
    Buy10,
    Buy100,
    OddsButton,
    Odds
};
local u129 = {};
local Frame = Instance.new("Frame");
Frame.Name = "MultiBackdrop";
Frame.Size = UDim2.fromScale(1, 1);
Frame.BackgroundColor3 = Color3.new(0, 0, 0);
Frame.BackgroundTransparency = 1;
Frame.BorderSizePixel = 0;
Frame.ZIndex = 0;
Frame.Visible = false;
Frame.Parent = script_Parent;
local Wheel = Main.Wheel;
local UIScale = Instance.new("UIScale");
UIScale.Name = "MultiScale";
UIScale.Parent = Wheel;
local Frame2 = Instance.new("Frame");
Frame2.Name = "MultiRing";
Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
Frame2.Position = UDim2.fromScale(0.5, 0.5);
Frame2.Size = UDim2.fromScale(1.04, 1.04);
Frame2.BackgroundTransparency = 1;
Frame2.ZIndex = 5;
Frame2.Visible = false;
Frame2.Parent = Wheel;
local UICorner = Instance.new("UICorner");
UICorner.CornerRadius = UDim.new(1, 0);
UICorner.Parent = Frame2;
local UIStroke = Instance.new("UIStroke");
UIStroke.Thickness = 8;
UIStroke.Parent = Frame2;
local TextLabel2 = Instance.new("TextLabel");
TextLabel2.Name = "MultiChip";
TextLabel2.AnchorPoint = Vector2.new(0.5, 0.5);
TextLabel2.Position = UDim2.fromScale(0.5, 0.8);
TextLabel2.Size = UDim2.fromScale(0.66, 0.16);
TextLabel2.BackgroundColor3 = Color3.fromRGB(18, 22, 37);
TextLabel2.BackgroundTransparency = 0.08;
TextLabel2.TextColor3 = Color3.new(1, 1, 1);
TextLabel2.Font = Enum.Font.GothamBlack;
TextLabel2.TextScaled = true;
TextLabel2.Text = "";
TextLabel2.ZIndex = 8;
TextLabel2.Visible = false;
TextLabel2.Parent = Wheel;
local UICorner2 = Instance.new("UICorner");
UICorner2.CornerRadius = UDim.new(0.5, 0);
UICorner2.Parent = TextLabel2;
local UIStroke2 = Instance.new("UIStroke");
UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
UIStroke2.Thickness = 6;
UIStroke2.Parent = TextLabel2;
local UIPadding = Instance.new("UIPadding");
UIPadding.PaddingTop = UDim.new(0.14, 0);
UIPadding.PaddingBottom = UDim.new(0.14, 0);
UIPadding.PaddingLeft = UDim.new(0.06, 0);
UIPadding.PaddingRight = UDim.new(0.06, 0);
UIPadding.Parent = TextLabel2;
local UIScale2 = Instance.new("UIScale");
UIScale2.Name = "Pop";
UIScale2.Parent = TextLabel2;

local function wheelParts(p130) -- Line: 840
    return {
        frame = p130,
        scale = p130.MultiScale,
        spinner = p130.Spinner,
        ring = p130.MultiRing,
        ringStroke = p130.MultiRing:FindFirstChildOfClass("UIStroke"),
        chip = p130.MultiChip,
        chipStroke = p130.MultiChip:FindFirstChildOfClass("UIStroke"),
        chipPop = p130.MultiChip.Pop
    };
end;

local u131 = wheelParts(Main.Wheel);
local u132 = {};

local function stageWheels(p133) -- Line: 856
    -- upvalues: u132 (copy), Main (copy), Position2 (copy), wheelParts (copy), u131 (copy)
    for i = #u132 + 2, p133 do
        local v134 = Main.Wheel:Clone();
        v134.Name = "MultiWheel" .. i;
        v134.Visible = false;
        v134.Position = Position2;
        v134.MultiScale.Scale = 1;
        v134.MultiRing.Visible = false;
        v134.MultiChip.Visible = false;
        local _ = i;

        for _, descendant in v134:GetDescendants() do
            if descendant:IsA("ViewportFrame") then
                descendant.CurrentCamera = descendant:FindFirstChildOfClass("Camera");
            end;
        end;

        v134.Parent = Main;
        local v135 = wheelParts(v134);
        table.insert(u132, v135);
    end;

    local v136 = { u131 };

    for i = 1, p133 - 1 do
        v136[i + 1] = u132[i];
        local _ = i;
    end;

    return v136;
end;

local function setStageControls(p137) -- Line: 881
    -- upvalues: u128 (copy), u129 (copy), Odds (copy), TextLabel (copy)
    if p137 then
        for _, v in u128 do
            if u129[v] == nil then
                u129[v] = v.Visible;
            end;

            v.Visible = false;
        end;
    else
        for i, v in u129 do
            i.Visible = v;
        end;

        table.clear(u129);
        Odds.Visible = false;
    end;

    TextLabel.Visible = false;
end;

local function stageTween(p138, p139, p140, p141, p142, p143) -- Line: 899
    -- upvalues: TweenService (copy)
    local v144 = TweenService:Create(p139, TweenInfo.new(p140, p142 or Enum.EasingStyle.Quart, p143 or Enum.EasingDirection.Out), p141);
    table.insert(p138.tweens, v144);
    v144:Play();

    return v144;
end;

local function resetStage(p145) -- Line: 911
    -- upvalues: u132 (copy), u131 (copy), Position2 (copy), Frame (copy), Skip (copy), u129 (copy), Odds (copy), TextLabel (copy)
    for _, v in p145.tweens do
        v:Cancel();
    end;

    table.clear(p145.tweens);

    if p145.ticker then
        p145.ticker:Disconnect();
        p145.ticker = nil;
    end;

    if p145.aura then
        p145.aura.holder:Destroy();
        p145.aura = nil;
    end;

    for _, v in u132 do
        v.frame.Visible = false;
        v.ring.Visible = false;
        v.chip.Visible = false;
    end;

    u131.scale.Scale = 1;
    u131.frame.Position = Position2;
    u131.ring.Visible = false;
    u131.chip.Visible = false;
    Frame.Visible = false;
    Frame.BackgroundTransparency = 1;
    Skip.Visible = false;

    for i, v in u129 do
        i.Visible = v;
    end;

    table.clear(u129);
    Odds.Visible = false;
    TextLabel.Visible = false;
end;

local function withCommas(p146) -- Line: 939
    local math_floor_ret2 = math.floor(p146);
    local v147 = tostring(math_floor_ret2);
    local v148;

    repeat
        v147, v148 = string.gsub(v147, "^(-?%d+)(%d%d%d)", "%1,%2");
    until v148 == 0;

    return v147;
end;

local function gearPrize(p149) -- Line: 949
    -- upvalues: GearCatalog (copy)
    return type(p149.count) == "number" and GearCatalog.get(p149.id) or nil;
end;

local function keyIcon() -- Line: 954
    local success, result = pcall(function() -- Line: 955
        return require(game.ReplicatedStorage.ChickenOrHero.Game.GhostTraderConfig);
    end);

    if success and type(result) == "table" then
        return result.KeyIcon;
    end;

    return nil;
end;

local function keysOf(p150) -- Line: 961
    return p150.id == "GhostKey" and (tonumber(p150.keys) or 1) or 0;
end;

local function chipText(p151) -- Line: 966
    -- upvalues: u10 (copy), GearCatalog (copy), u66 (copy)
    local v152 = u10[p151.id];
    local v153 = tonumber(string.match(p151.id, "^(%d+)Coins$"));
    local v154;

    if type(p151.count) == "number" then
        v154 = GearCatalog.get(p151.id) or nil;
    else
        v154 = nil;
    end;

    if p151.gems then
        return "+" .. p151.gems .. " GEMS";
    end;

    if v152 then
        return v152.name;
    end;

    if v153 then
        return "+" .. v153 .. " COINS";
    end;

    if p151.id == "GhostKey" then
        return "+" .. (p151.id == "GhostKey" and (tonumber(p151.keys) or 1) or 0) .. " GHOST KEY" .. ((p151.id == "GhostKey" and (tonumber(p151.keys) or 1) or 0) == 1 and "" or "S");
    end;

    if v154 then
        return "+" .. p151.count .. " " .. string.upper(v154.Name);
    end;

    return p151.id == "2xCoins" and "2x COINS" or (p151.id == "2xGems" and "2x GEMS" or (u66[p151.id] or p151.id));
end;

local function notifyBatch(p155) -- Line: 983
    -- upvalues: u127 (copy), GearCatalog (copy), u10 (copy), withCommas (copy), notifyReward (copy)
    local v156 = {};
    local v157 = {};
    local v158 = {};
    local v159 = 0;
    local v160 = {};
    local v161 = {};
    local v162 = {};
    local v163 = {};
    local v164 = 0;

    for _, v in p155 do
        if type(v) == "table" and type(v.id) == "string" then
            local v165 = tonumber(string.match(v.id, "^(%d+)Coins$"));

            if v165 then
                v159 = v159 + v165;
            elseif v.id == "GhostKey" then
                v164 = v164 + (v.id == "GhostKey" and (tonumber(v.keys) or 1) or 0);
            elseif u127[v.id] then
                v160[v.id] = (v160[v.id] or 0) + u127[v.id];
            else
                local v166;

                if type(v.count) == "number" then
                    v166 = GearCatalog.get(v.id) or nil;
                else
                    v166 = nil;
                end;

                if v166 then
                    if not v161[v.id] then
                        table.insert(v162, v.id);
                    end;

                    v161[v.id] = (v161[v.id] or 0) + v.count;
                elseif u10[v.id] then
                    local v167 = v163[v.id];

                    if not v167 then
                        v167 = {
                            copies = 0,
                            gems = 0
                        };
                        v163[v.id] = v167;
                        table.insert(v156, v.id);
                    end;

                    if v.gems then
                        v167.gems = v167.gems + v.gems;
                    else
                        v167.copies = v167.copies + 1;
                        v167.last = v;
                    end;
                elseif type(v.message) == "string" then
                    if not v157[v.message] then
                        table.insert(v158, v.message);
                    end;

                    v157[v.message] = (v157[v.message] or 0) + 1;
                end;
            end;
        end;
    end;

    local v168 = {};

    for _, v in v156 do
        local v169 = v163[v];
        local name = u10[v].name;

        if v169.copies == 1 then
            table.insert(v168, v169.last.message);
        elseif v169.copies > 1 then
            local v170;

            if type(v169.last.copies) == "number" then
                v170 = v169.last.copies;
            else
                v170 = v169.copies;
            end;

            table.insert(v168, ("+%d %s! (x%d)"):format(v169.copies, name, v170));
        end;

        if v169.gems > 0 then
            table.insert(v168, ("%s OWNED! +%d GEMS"):format(name, v169.gems));
        end;
    end;

    for _, v in v158 do
        local v171;

        if v157[v] > 1 then
            v171 = v .. " (x" .. v157[v] .. ")";
        else
            v171 = v;
        end;

        table.insert(v168, v171);
    end;

    for _, v in v162 do
        local v172 = v161[v];
        local string_upper = string.upper;
        local Name = GearCatalog.get(v).Name;
        table.insert(v168, ("+%d %s!"):format(v172, string_upper(Name)));
    end;

    if v160["2xGems"] then
        table.insert(v168, ("+%d MIN OF 2× GEMS!"):format(v160["2xGems"]));
    end;

    if v160["2xCoins"] then
        table.insert(v168, ("+%d MIN OF 2× COINS!"):format(v160["2xCoins"]));
    end;

    if v164 > 0 then
        table.insert(v168, ("+%d GHOST KEY%s!"):format(v164, v164 == 1 and "" or "S"));
    end;

    if v159 > 0 then
        local v173 = "+" .. withCommas(v159) .. " COINS!";
        table.insert(v168, v173);
    end;

    for i, v in v168 do
        task.delay((i - 1) * 0.15, notifyReward, v);
    end;
end;

local u174 = nil;
local u175 = (-1 / 0);
local u176 = nil;
LocalPlayer:SetAttribute("SpinSummaryOpen", nil);

local function summaryClosed(p177) -- Line: 1068
    -- upvalues: u176 (ref), LocalPlayer (copy)
    if u176 == p177 then
        u176 = nil;
        LocalPlayer:SetAttribute("SpinSummaryOpen", nil);
    end;
end;

local function watchSummary() -- Line: 1074
    -- upvalues: PlayerGui (copy), script_Parent (copy), u176 (ref), LocalPlayer (copy)
    local u178 = nil;

    for _, child in PlayerGui:GetChildren() do
        if child.Name == "RewardPop" and (child:IsA("ScreenGui") and child.DisplayOrder == script_Parent.DisplayOrder + 1) then
            u178 = child;
        end;
    end;

    if not u178 then
        return;
    end;

    u176 = u178;
    LocalPlayer:SetAttribute("SpinSummaryOpen", true);
    u178.AncestryChanged:Connect(function() -- Line: 1086
        -- upvalues: u178 (ref), PlayerGui (ref), u176 (ref), LocalPlayer (ref)
        if not u178:IsDescendantOf(PlayerGui) and u176 == u178 then
            u176 = nil;
            LocalPlayer:SetAttribute("SpinSummaryOpen", nil);
        end;
    end);
end;

local function loadClaimPop() -- Line: 1092
    -- upvalues: u174 (ref)
    if u174 == nil then
        local success, result = pcall(require, game.ReplicatedStorage.ChickenOrHero.Interface:FindFirstChild("ClaimPop"));

        if not success or type(result) ~= "table" then
            result = false;
        end;

        u174 = result;
    end;

    return u174 or nil;
end;

local function cancelSummary() -- Line: 1100
    -- upvalues: u175 (ref)
    if os.clock() - u175 > 10 then
        return;
    end;

    u175 = (-1 / 0);
    local RewardPop = game.ReplicatedStorage.ChickenOrHero.Interface:FindFirstChild("RewardPop");

    if RewardPop then
        pcall(function() -- Line: 1107
            -- upvalues: RewardPop (copy)
            require(RewardPop).cancel();
        end);
    end;
end;

local function summarizeBatch(p179, p180) -- Line: 1113
    -- upvalues: u174 (ref), u127 (copy), GearCatalog (copy), u10 (copy), u66 (copy), Main (copy), script_Parent (copy), u175 (ref), watchSummary (copy)
    if u174 == nil then
        local success, result = pcall(require, game.ReplicatedStorage.ChickenOrHero.Interface:FindFirstChild("ClaimPop"));

        if not success or type(result) ~= "table" then
            result = false;
        end;

        u174 = result;
    end;

    local v181 = u174 or nil;

    if not v181 then
        return false;
    end;

    local v182 = {};
    local v183 = {};
    local v184 = {};
    local v185 = {};
    local v186 = 0;
    local v187 = 0;
    local v188 = {};
    local v189 = {};
    local v190 = {};
    local v191 = 0;

    for _, v in p179 do
        local v192 = tonumber(string.match(v.id, "^(%d+)Coins$"));
        v186 = v186 + (tonumber(v.gems) or 0);

        if v192 then
            v187 = v187 + v192;
        elseif v.id == "GhostKey" then
            v191 = v191 + (v.id == "GhostKey" and (tonumber(v.keys) or 1) or 0);
        elseif u127[v.id] then
            v188[v.id] = (v188[v.id] or 0) + u127[v.id];
        else
            local v193;

            if type(v.count) == "number" then
                v193 = GearCatalog.get(v.id) or nil;
            else
                v193 = nil;
            end;

            if v193 then
                if not v189[v.id] then
                    table.insert(v190, v.id);
                end;

                v189[v.id] = (v189[v.id] or 0) + v.count;
            elseif not v.gems then
                if u10[v.id] then
                    if not v182[v.id] then
                        table.insert(v183, v.id);
                    end;

                    v182[v.id] = (v182[v.id] or 0) + 1;
                else
                    if not v184[v.id] then
                        table.insert(v185, v.id);
                    end;

                    v184[v.id] = (v184[v.id] or 0) + 1;
                end;
            end;
        end;
    end;

    local v194 = {};
    local v195 = {};
    local v196 = {};

    for _, v in v183 do
        local v197 = v181.knife(u10[v].model);

        if v197 then
            if v182[v] > 1 then
                v197.name = (v197.name or u10[v].name) .. " ×" .. v182[v];
            end;

            table.insert(v194, v197);
        end;
    end;

    for _, v in v185 do
        local v198 = {
            title = string.upper(u66[v] or v),
            color = v181.GOLD
        };
        local v199;

        if v184[v] > 1 then
            v199 = "×" .. v184[v];
        else
            v199 = nil;
        end;

        v198.name = v199;
        table.insert(v195, v198);
    end;

    if v191 > 0 then
        local v200 = {};
        local success, result = pcall(function() -- Line: 955
            return require(game.ReplicatedStorage.ChickenOrHero.Game.GhostTraderConfig);
        end);
        local v201;

        if success and type(result) == "table" then
            v201 = result.KeyIcon;
        else
            v201 = nil;
        end;

        v200.image = v201;
        v200.amount = "+" .. v191;
        v200.name = v191 == 1 and "Ghost Key" or "Ghost Keys";
        v200.color = Color3.fromRGB(255, 205, 90);
        table.insert(v195, v200);
    end;

    for _, v in v190 do
        local v202 = GearCatalog.get(v);
        local v203 = {
            image = v202.IconImage,
            amount = "+" .. v189[v],
            name = v181.titleCase(v202.Name)
        };
        local v204;

        if typeof(v202.Accent) == "Color3" then
            v204 = v202.Accent;
        else
            v204 = nil;
        end;

        v203.color = v204;
        table.insert(v195, v203);
    end;

    if v188["2xGems"] then
        table.insert(v196, {
            name = "Gem Boost",
            image = v181.GEM_IMAGE,
            amount = "2× " .. v188["2xGems"] .. "m",
            amountColor = v181.GEM_TEXT
        });
    end;

    if v188["2xCoins"] then
        table.insert(v196, {
            name = "Coin Boost",
            image = v181.COIN_IMAGE,
            amount = "2× " .. v188["2xCoins"] .. "m"
        });
    end;

    local Wheel2 = Main.Wheel;
    local success, result = pcall(v181.show, { v194, v195, v196 }, v187, v186, Wheel2.AbsolutePosition + Wheel2.AbsoluteSize / 2, {
        heading = "SPIN x" .. p180 .. " REWARDS!",
        displayOrder = script_Parent.DisplayOrder + 1
    });

    if not success or result ~= true then
        return false;
    end;

    u175 = os.clock();
    watchSummary();

    return true;
end;

local function spark(p205, p206, p207, p208, p209, p210) -- Line: 1219
    -- upvalues: Color3_fromRGB_ret (copy), TweenService (copy), Debris (copy)
    local v211 = math.random() * 3.141592653589793 * 2;
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "Spark";
    Frame3.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame3.Position = UDim2.fromScale(0.5 + math.cos(v211) * p207, 0.5 + math.sin(v211) * p207);
    Frame3.SizeConstraint = Enum.SizeConstraint.RelativeYY;
    Frame3.Size = UDim2.fromScale(p210, p210);
    Frame3.Rotation = 45;
    local v212;

    if math.random() < 0.3 then
        v212 = Color3.new(1, 1, 1);
    else
        v212 = Color3_fromRGB_ret;
    end;

    Frame3.BackgroundColor3 = v212;
    Frame3.BackgroundTransparency = 0.1;
    Frame3.BorderSizePixel = 0;
    Frame3.ZIndex = 0;
    Frame3.Parent = p206;
    local v213 = {
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0.5 + math.cos(v211) * p208, 0.5 + math.sin(v211) * p208),
        Rotation = 45 + math.random(-90, 90)
    };
    local v214 = TweenService:Create(Frame3, TweenInfo.new(p209, Enum.EasingStyle.Quad or Enum.EasingStyle.Quart, Enum.EasingDirection.Out), v213);
    table.insert(p205.tweens, v214);
    v214:Play();
    Debris:AddItem(Frame3, p209 + 0.1);
end;

local function startAura(u215, u216) -- Line: 1241
    -- upvalues: u32 (ref), Main (copy), Color3_fromRGB_ret (copy), TweenService (copy), spark (copy)
    if u32 ~= u215 or (u216.landed or (u215.skipped or u215.aura)) then
        return;
    end;

    local v217 = u216.slot.scale * 0.753 * 1.8;
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "KnifeAura";
    Frame3.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame3.Position = u216.slot.position;
    Frame3.SizeConstraint = Enum.SizeConstraint.RelativeYY;
    Frame3.Size = UDim2.fromScale(v217, v217);
    Frame3.BackgroundTransparency = 1;
    Frame3.ZIndex = 0;
    Frame3.Parent = Main;
    local u218 = {
        holder = Frame3,
        rays = {}
    };
    u215.aura = u218;

    for i, v in { 360, -360 } do
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "Rays";
        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
        ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
        local v219;

        if i == 1 then
            v219 = UDim2.fromScale(1, 1);
        else
            v219 = UDim2.fromScale(0.8, 0.8);
        end;

        ImageLabel.Size = v219;
        ImageLabel.Rotation = i * 20;
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.Image = "rbxassetid://129028976496842";
        ImageLabel.ImageColor3 = Color3_fromRGB_ret;
        ImageLabel.ImageTransparency = 1;
        ImageLabel.ZIndex = 0;
        ImageLabel.Parent = Frame3;
        table.insert(u218.rays, ImageLabel);
        local v220 = {
            ImageTransparency = i == 1 and 0.6 or 0.72
        };
        local v221 = TweenService:Create(ImageLabel, TweenInfo.new(1.4, Enum.EasingStyle.Sine or Enum.EasingStyle.Quart, Enum.EasingDirection.Out), v220);
        table.insert(u215.tweens, v221);
        v221:Play();
        local v222 = TweenService:Create(ImageLabel, TweenInfo.new(i == 1 and 26 or 40, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
            Rotation = ImageLabel.Rotation + v
        });
        table.insert(u215.tweens, v222);
        v222:Play();
    end;

    u216.ringStroke.Color = Color3_fromRGB_ret;
    u216.ringStroke.Transparency = 0.75;
    u216.ring.Visible = true;
    local v223 = TweenService:Create(u216.ringStroke, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        Transparency = 0.25
    });
    table.insert(u215.tweens, v223);
    v223:Play();
    task.spawn(function() -- Line: 1291
        -- upvalues: u215 (copy), u218 (copy), u216 (copy), spark (ref), Frame3 (copy)
        while u215.aura == u218 and not u216.landed do
            spark(u215, Frame3, 0.2833333333333333, 0.4444444444444445, 0.8, 0.016);
            task.wait(0.1);
        end;
    end);
end;

local function flareAura(u224) -- Line: 1300
    -- upvalues: TweenService (copy), spark (copy)
    local aura = u224.aura;

    if not aura then
        return;
    end;

    for _, v in aura.rays do
        local v225 = TweenService:Create(v, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            ImageTransparency = 0.35
        });
        table.insert(u224.tweens, v225);
        v225:Play();
        task.delay(0.25, function() -- Line: 1307
            -- upvalues: u224 (copy), aura (copy), v (copy), TweenService (ref)
            if u224.aura == aura then
                local v226 = TweenService:Create(v, TweenInfo.new(1.2, Enum.EasingStyle.Sine or Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    ImageTransparency = 1
                });
                table.insert(u224.tweens, v226);
                v226:Play();
            end;
        end);
    end;

    for i = 1, 16 do
        spark(u224, aura.holder, 0.25, 0.2777777777777778 * (1.7 + math.random() * 0.3), 0.7, 0.022);
        local _ = i;
    end;
end;

local u227 = nil;

local function landWheel(p228, p229) -- Line: 1319
    -- upvalues: u32 (ref), u10 (copy), u29 (copy), u11 (copy), TweenService (copy), chipText (copy), Color3_fromRGB_ret (copy), SoundService (copy), Debris (copy), flareAura (copy), u227 (ref)
    if u32 ~= p228 or p229.landed then
        return;
    end;

    p229.landed = true;
    p228.landed = p228.landed + 1;
    local result = p229.result;
    local v230 = u10[result.id];
    local v231 = u29[result.id] or 100;
    local v232;

    for _, v in u11 do
        if v231 <= v.upTo then
            v232 = v.color;
            break;
        end;
    end;

    v232 = u11[#u11].color;
    p229.spinner.Rotation = result.angle;
    p229.ringStroke.Color = v232;
    p229.ringStroke.Transparency = 1;
    p229.ring.Visible = true;
    local v233 = TweenService:Create(p229.ringStroke, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Transparency = 0.1
    });
    table.insert(p228.tweens, v233);
    v233:Play();
    p229.chip.Text = chipText(result);
    local chip = p229.chip;
    local v234;

    if v230 then
        v234 = Color3_fromRGB_ret;
    else
        v234 = Color3.new(1, 1, 1);
    end;

    chip.TextColor3 = v234;
    p229.chipStroke.Color = v232;
    p229.chipPop.Scale = 0.4;
    p229.chip.Visible = true;
    local v235 = TweenService:Create(p229.chipPop, TweenInfo.new(0.3, Enum.EasingStyle.Back or Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Scale = 1
    });
    table.insert(p228.tweens, v235);
    v235:Play();
    p229.scale.Scale = p229.slot.scale * 1.08;
    local v236 = {
        Scale = p229.slot.scale
    };
    local v237 = TweenService:Create(p229.scale, TweenInfo.new(0.3, Enum.EasingStyle.Back or Enum.EasingStyle.Quart, Enum.EasingDirection.Out), v236);
    table.insert(p228.tweens, v237);
    v237:Play();
    local v238 = 0.95 + p228.landed * 0.04;
    local Sound2 = Instance.new("Sound");
    Sound2.SoundId = "rbxassetid://82803453482376";
    Sound2.Volume = 0.18;
    Sound2.PlaybackSpeed = v238 or 1;
    Sound2.Parent = SoundService;
    Sound2:Play();
    Debris:AddItem(Sound2, 5);

    if v230 then
        local Sound3 = Instance.new("Sound");
        Sound3.SoundId = "rbxassetid://10128766965";
        Sound3.Volume = 0.3;
        Sound3.PlaybackSpeed = 0.85;
        Sound3.Parent = SoundService;
        Sound3:Play();
        Debris:AddItem(Sound3, 5);
        flareAura(p228);
    end;

    if p228.landed == p228.count then
        task.spawn(u227, p228);
    end;
end;

local function spinWheelTo(u239, u240, p241, p242) -- Line: 1352
    -- upvalues: TweenService (copy), landWheel (copy)
    local v243 = {
        Rotation = u240.target
    };
    local v244 = TweenService:Create(u240.spinner, TweenInfo.new(p241, p242 or Enum.EasingStyle.Quart, Enum.EasingDirection.Out), v243);
    table.insert(u239.tweens, v244);
    v244:Play();
    u240.tween = v244;
    v244.Completed:Connect(function(p245) -- Line: 1355
        -- upvalues: landWheel (ref), u239 (copy), u240 (copy)
        if p245 == Enum.PlaybackState.Completed then
            landWheel(u239, u240);
        end;
    end);
end;

local function skipMulti() -- Line: 1363
    -- upvalues: u32 (ref), Skip (copy), spinWheelTo (copy)
    local u246 = u32;

    if not (u246 and (u246.spinning and not u246.skipped)) then
        return;
    end;

    u246.skipped = true;
    Skip.Visible = false;
    local v247 = 0;

    for i = 2, u246.count + 1 do
        local u248 = u246.wheels[u246.count < i and 1 or i];
        local v249;

        if u248.landed then
            v249 = i;
        else
            u248.tween:Cancel();
            u248.spinner.Rotation = math.max(u248.spinner.Rotation, u248.target - 540);
            task.delay(v247, function() -- Line: 1376
                -- upvalues: u32 (ref), u246 (copy), u248 (copy), spinWheelTo (ref)
                if u32 == u246 and not u248.landed then
                    spinWheelTo(u246, u248, 0.3);
                end;
            end);
            v247 = v247 + 0.04;
            v249 = i;
        end;
    end;
end;

u227 = function(p250) -- Line: 1386
    -- upvalues: u32 (ref), Skip (copy), Frame (copy), TweenService (copy), u131 (copy), Position2 (copy), resetStage (copy), u27 (ref), updateLabels (copy), summarizeBatch (copy), notifyBatch (copy), u35 (ref), showMessage (copy), u65 (ref), u33 (ref), animate (copy), u28 (ref), u69 (ref)
    if u32 ~= p250 then
        return;
    end;

    p250.spinning = false;
    Skip.Visible = false;

    if p250.ticker then
        p250.ticker:Disconnect();
        p250.ticker = nil;
    end;

    task.wait(p250.skipped and 0.5 or (p250.count == 10 and 1.2 or 1));

    if u32 ~= p250 then
        return;
    end;

    local v251 = TweenService:Create(Frame, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    });
    table.insert(p250.tweens, v251);
    v251:Play();
    u131.chip.Visible = false;
    u131.ring.Visible = false;
    local v252 = TweenService:Create(u131.scale, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Scale = 1
    });
    table.insert(p250.tweens, v252);
    v252:Play();
    local v253 = {
        Position = Position2
    };
    local v254 = TweenService:Create(u131.frame, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), v253);
    table.insert(p250.tweens, v254);
    v254:Play();

    for i = 2, p250.count do
        local v255 = TweenService:Create(p250.wheels[i].scale, TweenInfo.new(0.2, Enum.EasingStyle.Quad or Enum.EasingStyle.Quart, Enum.EasingDirection.In or Enum.EasingDirection.Out), {
            Scale = 0
        });
        table.insert(p250.tweens, v255);
        v255:Play();
        local _ = i;
    end;

    task.wait(0.36);

    if u32 ~= p250 then
        return;
    end;

    u32 = nil;
    resetStage(p250);
    u27 = false;
    updateLabels();
    p250.notified = true;

    if not summarizeBatch(p250.results, p250.count) then
        notifyBatch(p250.results);
    end;

    if u35 then
        showMessage(u35, 3);
        u35 = nil;
    end;

    local v256 = u65;
    u65 = nil;

    if not v256 then
        if u28 then
            local v257 = u28;
            u28 = nil;
            task.delay(0.4, u69, v257);
        end;

        return;
    end;

    u33 = v256.message;
    task.spawn(animate, v256);
end;

u69 = function(u258) -- Line: 1441
    -- upvalues: LocalPlayer (copy), notifyBatch (copy), u32 (ref), u27 (ref), u28 (ref), u126 (copy), u4 (copy), u63 (ref), openWheel (copy), cancelSummary (copy), u70 (ref), u128 (copy), u129 (copy), TextLabel (copy), updateLabels (copy), u29 (copy), stageWheels (copy), Frame (copy), TweenService (copy), Skip (copy), u10 (copy), startAura (copy), spinWheelTo (copy), RunService (copy), Sound (copy), SoundService (copy), Debris (copy)
    if LocalPlayer:GetAttribute("InMatch") == true then
        notifyBatch(u258);

        return;
    end;

    if u32 or u27 then
        if u28 then
            notifyBatch(u28);
        end;

        u28 = u258;

        return;
    end;

    local v259 = u126[#u258];

    if not (v259 and u4) then
        notifyBatch(u258);

        return;
    end;

    if not u63 then
        openWheel();

        if not u63 then
            notifyBatch(u258);

            return;
        end;
    end;

    local u260 = {
        landed = 0,
        count = #u258,
        results = u258,
        wheels = {},
        tweens = {}
    };
    u32 = u260;
    u27 = true;
    cancelSummary();

    if u70 then
        u70:Destroy();
        u70 = nil;
    end;

    for _, v in u128 do
        if u129[v] == nil then
            u129[v] = v.Visible;
        end;

        v.Visible = false;
    end;

    TextLabel.Visible = false;
    updateLabels();
    local v261 = {};

    for i in u258 do
        table.insert(v261, i);
    end;

    table.sort(v261, function(p262, p263) -- Line: 1481
        -- upvalues: u29 (ref), u258 (copy)
        local v264 = u29[u258[p262].id] or 100;
        local v265 = u29[u258[p263].id] or 100;

        if v264 == v265 then
            return p262 < p263;
        end;

        return v264 < v265;
    end);

    for i, v in stageWheels(u260.count) do
        local table_clone_ret = table.clone(v);
        table_clone_ret.slot = v259[i];
        local v266;

        if i == 1 then
            v266 = v261[1];
        else
            v266 = v261[u260.count + 2 - i];
        end;

        table_clone_ret.result = u258[v266];
        local v267;

        if i == 1 then
            v267 = u260.count;
        else
            v267 = i - 1;
        end;

        table_clone_ret.rank = v267;
        table_clone_ret.landed = false;
        table_clone_ret.spinner.Size = UDim2.fromScale(0.95, 0.95);
        u260.wheels[i] = table_clone_ret;
    end;

    Frame.Visible = true;
    local v268 = TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.45
    });
    table.insert(u260.tweens, v268);
    v268:Play();
    local u269 = u260.wheels[1];
    local v270 = {
        Scale = u269.slot.scale
    };
    local v271 = TweenService:Create(u269.scale, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), v270);
    table.insert(u260.tweens, v271);
    v271:Play();
    local v272 = {
        Position = u269.slot.position
    };
    local v273 = TweenService:Create(u269.frame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), v272);
    table.insert(u260.tweens, v273);
    v273:Play();

    for i = 2, u260.count do
        local u274 = u260.wheels[i];
        u274.frame.Position = u274.slot.position;
        u274.scale.Scale = 0;
        u274.spinner.Rotation = math.random(0, 359);
        u274.frame.Visible = true;
        local u275 = u260.count == 5;
        local v276;

        if u275 then
            v276 = (i - 2) * 0.06 + 0.12;
        else
            v276 = (i - 2) * 0.025 + 0.08;
        end;

        task.delay(v276, function() -- Line: 1510
            -- upvalues: u32 (ref), u260 (copy), u274 (copy), u275 (copy), TweenService (ref)
            if u32 == u260 then
                local v277 = {
                    Scale = u274.slot.scale
                };
                local v278;

                if u275 then
                    v278 = Enum.EasingStyle.Back;
                else
                    v278 = Enum.EasingStyle.Quad;
                end;

                local v279 = TweenService:Create(u274.scale, TweenInfo.new(u275 and 0.32 or 0.2, v278 or Enum.EasingStyle.Quart, Enum.EasingDirection.Out), v277);
                table.insert(u260.tweens, v279);
                v279:Play();
            end;
        end);
        local _ = i;
    end;

    task.wait(0.45);

    if u32 ~= u260 then
        return;
    end;

    u260.spinning = true;
    Skip.Visible = true;

    for _, v in u260.wheels do
        local v280;

        if u260.count == 5 then
            v280 = 3.6 + 0.35 * (v.rank - 1);
        else
            v280 = 3.2 + 0.2 * (v.rank - 1);
        end;

        if v.rank == u260.count and u10[v.result.id] then
            v280 = v280 + 0.6;
            task.delay(math.max(0, v280 - 2.2), startAura, u260, v);
        end;

        v.target = v.result.angle + math.ceil((v.spinner.Rotation + (4 + v.rank * 0.5) * 360 - v.result.angle) / 360) * 360;
        spinWheelTo(u260, v, v280, Enum.EasingStyle.Quint);
    end;

    local math_floor_ret2 = math.floor((u269.spinner.Rotation + 30) / 60);
    local u281 = 0;
    u260.ticker = RunService.RenderStepped:Connect(function() -- Line: 1543
        -- upvalues: u269 (copy), math_floor_ret2 (ref), u281 (ref), Sound (ref), SoundService (ref), Debris (ref)
        local math_floor_ret3 = math.floor((u269.spinner.Rotation + 30) / 60);

        if math_floor_ret3 ~= math_floor_ret2 then
            math_floor_ret2 = math_floor_ret3;

            if os.clock() - u281 >= 0.05 then
                u281 = os.clock();
                local v282 = Sound:Clone();
                v282.Parent = SoundService;
                v282:Play();
                Debris:AddItem(v282, 1);
            end;
        end;
    end);
end;

u71 = function() -- Line: 1557
    -- upvalues: u32 (ref), resetStage (copy), notifyBatch (copy), u27 (ref), u65 (ref), StarterGui (copy), u28 (ref), u35 (ref)
    local v283 = u32;
    u32 = nil;

    if v283 then
        resetStage(v283);

        if not v283.notified then
            v283.notified = true;
            notifyBatch(v283.results);
        end;

        u27 = false;
    end;

    if u65 then
        local message = u65.message;

        if message and message ~= "" then
            task.spawn(function() -- Line: 216
                -- upvalues: StarterGui (ref), message (copy)
                for i = 1, 5 do
                    if pcall(StarterGui.SetCore, StarterGui, "SendNotification", {
                        Title = "SPIN WHEEL REWARD",
                        Duration = 6,
                        Text = message
                    }) then
                        return;
                    end;

                    task.wait(i * 0.3);
                    local _ = i;
                end;
            end);
        end;

        u65 = nil;
    end;

    if u28 then
        notifyBatch(u28);
        u28 = nil;
    end;

    u35 = nil;
end;

LocalPlayer:GetAttributeChangedSignal("InMatch"):Connect(function() -- Line: 1593
    -- upvalues: LocalPlayer (copy), closeWheel (copy), cancelSummary (copy)
    if LocalPlayer:GetAttribute("InMatch") == true then
        closeWheel();
        cancelSummary();
    end;
end);
script.Destroying:Connect(closeWheel);
script.Destroying:Connect(function() -- Line: 1600
    -- upvalues: u176 (ref), LocalPlayer (copy)
    u176 = nil;
    LocalPlayer:SetAttribute("SpinSummaryOpen", nil);
end);
ProximityPrompt.Triggered:Connect(openWheel);
local BindableEvent = Instance.new("BindableEvent");
BindableEvent.Name = "OpenRequest";
BindableEvent.Event:Connect(openWheel);
BindableEvent.Parent = script_Parent;
PlayerGui.ChildAdded:Connect(function(p284) -- Line: 1610
    -- upvalues: u63 (ref), hideGui (copy)
    if u63 then
        hideGui(p284);
    end;
end);
CloseButton.Activated:Connect(closeWheel);
OddsButton.Activated:Connect(function() -- Line: 1616
    -- upvalues: Odds (copy), updateLabels (copy)
    Odds.Visible = not Odds.Visible;
    updateLabels();
end);
Spin.Activated:Connect(function() -- Line: 1620
    -- upvalues: u27 (ref), u61 (ref), u60 (copy), updateLabels (copy), SpinWheelEvent (copy)
    if u27 or (u61 or (u60.credits or 0) < 1) then
        return;
    end;

    u61 = true;
    updateLabels();
    SpinWheelEvent:FireServer("Spin");
    task.delay(10, function() -- Line: 1627
        -- upvalues: u61 (ref), updateLabels (ref)
        if u61 then
            u61 = false;
            updateLabels();
        end;
    end);
end);
Buy1.Activated:Connect(function() -- Line: 1634
    -- upvalues: u27 (ref), u36 (ref), u60 (copy), u30 (ref), SpinWheelEvent (copy), updateLabels (copy)
    if u27 or (u36 or not u60.purchasesAvailable) then
        return;
    end;

    u36 = true;
    u30 = u30 + 1;
    local u285 = u30;
    SpinWheelEvent:FireServer("PurchaseIntent", 3716057178, "Add");
    task.delay(30, function() -- Line: 1642
        -- upvalues: u30 (ref), u285 (copy), u36 (ref), updateLabels (ref)
        if u30 == u285 then
            u36 = false;
            updateLabels();
        end;
    end);
end);

local function buyPack(p286) -- Line: 1650
    -- upvalues: u27 (ref), u36 (ref), u60 (copy), u30 (ref), SpinWheelEvent (copy), updateLabels (copy)
    if u27 or (u36 or not u60.purchasesAvailable) then
        return;
    end;

    u36 = true;
    u30 = u30 + 1;
    local u287 = u30;
    SpinWheelEvent:FireServer("PurchaseIntent", p286, "Add");
    task.delay(30, function() -- Line: 1658
        -- upvalues: u30 (ref), u287 (copy), u36 (ref), updateLabels (ref)
        if u30 == u287 then
            u36 = false;
            updateLabels();
        end;
    end);
end;

Buy10.Activated:Connect(function() -- Line: 1665
    -- upvalues: buyPack (copy)
    buyPack(3716072886);
end);
Buy100.Activated:Connect(function() -- Line: 1668
    -- upvalues: buyPack (copy)
    buyPack(3718405322);
end);

local function requestMulti(u288) -- Line: 1673
    -- upvalues: u4 (copy), u32 (ref), u27 (ref), u61 (ref), LocalPlayer (copy), u60 (copy), updateLabels (copy), u31 (ref), SpinWheelEvent (copy)
    if not u4 or (u32 or (u27 or (u61 or LocalPlayer:GetAttribute("InMatch") == true))) then
        return;
    end;

    if (u60.credits or 0) < u288 then
        return;
    end;

    u61 = true;
    updateLabels();
    local v289 = u31 + 2.5 - os.clock();
    local math_max_ret = math.max(0, v289);
    u31 = os.clock() + math_max_ret;
    task.delay(math_max_ret, function() -- Line: 1685
        -- upvalues: SpinWheelEvent (ref), u288 (copy)
        SpinWheelEvent:FireServer("Spin", u288);
    end);
    task.delay(math_max_ret + 10, function() -- Line: 1688
        -- upvalues: u61 (ref), updateLabels (ref)
        if u61 then
            u61 = false;
            updateLabels();
        end;
    end);
end;

local function validResults(p290) -- Line: 1580
    -- upvalues: u126 (copy)
    if type(p290) ~= "table" or not u126[#p290] then
        return nil;
    end;

    for _, v in p290 do
        if type(v) ~= "table" or (type(v.id) ~= "string" or type(v.angle) ~= "number") then
            return nil;
        end;
    end;

    return p290;
end;

for i, v in u5 do
    i.Activated:Connect(function() -- Line: 1696
        -- upvalues: requestMulti (copy), v (copy)
        requestMulti(v);
    end);
end;

if u4 then
    Skip.Activated:Connect(skipMulti);
end;

RobuxSpin.Activated:Connect(function() -- Line: 1703
    -- upvalues: u27 (ref), u36 (ref), u60 (copy), u30 (ref), SpinWheelEvent (copy), updateLabels (copy)
    if u27 or (u36 or not u60.purchasesAvailable) then
        return;
    end;

    u36 = true;
    u30 = u30 + 1;
    local u291 = u30;
    SpinWheelEvent:FireServer("PurchaseIntent", u60.discountAvailable and 3716057142 or 3716057178, "Auto");
    task.delay(30, function() -- Line: 1711
        -- upvalues: u30 (ref), u291 (copy), u36 (ref), updateLabels (ref)
        if u30 == u291 then
            u36 = false;
            updateLabels();
        end;
    end);
end);
SpinWheelEvent.OnClientEvent:Connect(function(p292, p293) -- Line: 1718
    -- upvalues: MarketplaceService (copy), LocalPlayer (copy), u36 (ref), showMessage (copy), u61 (ref), u60 (copy), u72 (ref), u29 (copy), buildOdds (copy), updateLabels (copy), validResults (copy), u69 (ref), u32 (ref), u65 (ref), StarterGui (copy), u33 (ref), animate (copy), u35 (ref)
    if p292 == "PromptProduct" then
        if not pcall(MarketplaceService.PromptProductPurchase, MarketplaceService, LocalPlayer, p293) then
            u36 = false;
            showMessage("Purchase window unavailable.", 3);
        end;
    elseif p292 == "State" and type(p293) == "table" then
        if p293.result or (p293.results or p293.message) then
            u61 = false;
        end;

        if p293.message then
            u36 = false;
        end;

        u60.credits = p293.credits or 0;
        u60.nextFreeAt = p293.nextFreeAt or 0;
        u72 = u72 or type(p293.nextFreeAt) == "number";
        u60.discountAvailable = p293.discountAvailable == true;
        u60.purchasesAvailable = p293.purchasesAvailable == true;

        if type(p293.odds) == "table" then
            for _, v in p293.odds do
                if type(v) == "table" and (type(v.id) == "string" and type(v.percent) == "number") then
                    u29[v.id] = v.percent;
                end;
            end;
        end;

        buildOdds(p293.odds);
        updateLabels();
        local v294 = validResults(p293.results);

        if v294 then
            task.spawn(u69, v294);

            return;
        end;

        if p293.result and u32 then
            if u65 then
                local message = u65.message;

                if message and message ~= "" then
                    task.spawn(function() -- Line: 216
                        -- upvalues: StarterGui (ref), message (copy)
                        for i = 1, 5 do
                            if pcall(StarterGui.SetCore, StarterGui, "SendNotification", {
                                Title = "SPIN WHEEL REWARD",
                                Duration = 6,
                                Text = message
                            }) then
                                return;
                            end;

                            task.wait(i * 0.3);
                            local _ = i;
                        end;
                    end);
                end;
            end;

            u65 = p293.result;

            return;
        end;

        if p293.result then
            u33 = p293.result.message;
            task.spawn(animate, p293.result);

            return;
        end;

        if p293.message and u32 then
            u35 = p293.message;

            return;
        end;

        if p293.message then
            showMessage(p293.message, 3);
        end;
    end;
end);
MarketplaceService.PromptProductPurchaseFinished:Connect(function(p295, p296) -- Line: 1766
    -- upvalues: LocalPlayer (copy), u36 (ref), updateLabels (copy)
    if p295 == LocalPlayer.UserId and (p296 == 3716057178 or (p296 == 3716057142 or (p296 == 3716072886 or p296 == 3718405322))) then
        u36 = false;
        updateLabels();
    end;
end);

for _, v in { 3716057178, 3716057142, 3716072886, 3718405322 } do
    task.spawn(function() -- Line: 1774
        -- upvalues: MarketplaceService (copy), v (copy), u26 (copy), updateLabels (copy)
        for i = 1, 5 do
            local success, result = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, v, Enum.InfoType.Product);

            if success and (type(result) == "table" and type(result.PriceInRobux) == "number") then
                u26[v] = tostring(result.PriceInRobux);
                break;
            end;

            local v297;

            if i < 5 then
                task.wait(i * 2);
                v297 = i;
            else
                v297 = i;
            end;
        end;

        u26[v] = u26[v] or "?";
        updateLabels();
    end);
end;

local Sign = v1:WaitForChild("SpinTheWheel"):WaitForChild("Sign", 10);

if Sign then
    Sign = Sign:FindFirstChild("Title");
end;

local function updateSign() -- Line: 1793
    -- upvalues: Sign (copy), u60 (copy), u72 (ref)
    if not Sign then
        return;
    end;

    local v298 = u60.nextFreeAt or 0;
    local ServerTimeNow2 = workspace:GetServerTimeNow();

    if ServerTimeNow2 <= 1000000000 then
        ServerTimeNow2 = os.time();
    end;

    local v299 = v298 - ServerTimeNow2;
    local v300;

    if u72 then
        if v299 > 0 then
            local math_ceil_ret = math.ceil(v299);
            local math_max_ret = math.max(0, math_ceil_ret);
            v300 = "Free Spin in " .. string.format("%dm %02ds", math.floor(math_max_ret / 60), math_max_ret % 60);
        else
            v300 = "Free Spin ready!";
        end;
    else
        v300 = "Free Spin";
    end;

    if Sign.Text ~= v300 then
        Sign.Text = v300;
    end;
end;

task.spawn(function() -- Line: 1806
    -- upvalues: script_Parent (copy), Sign (copy), u60 (copy), u72 (ref), u63 (ref), u64 (ref), SpinWheelEvent (copy), updateLabels (copy), u7 (ref), bounceNextFree (copy), math_floor_ret (ref)
    while true do
        if not script_Parent.Parent then
            return;
        end;

        task.wait(0.25);

        if Sign then
            local v301 = u60.nextFreeAt or 0;
            local ServerTimeNow2 = workspace:GetServerTimeNow();

            if ServerTimeNow2 <= 1000000000 then
                ServerTimeNow2 = os.time();
            end;

            local v302 = v301 - ServerTimeNow2;
            local v303;

            if u72 then
                if v302 > 0 then
                    local math_ceil_ret = math.ceil(v302);
                    local math_max_ret = math.max(0, math_ceil_ret);
                    v303 = "Free Spin in " .. string.format("%dm %02ds", math.floor(math_max_ret / 60), math_max_ret % 60);
                else
                    v303 = "Free Spin ready!";
                end;
            else
                v303 = "Free Spin";
            end;

            if Sign.Text ~= v303 then
                Sign.Text = v303;
            end;
        end;

        if not u63 then
            if u72 then
                local ServerTimeNow2 = workspace:GetServerTimeNow();

                if ServerTimeNow2 <= 1000000000 then
                    ServerTimeNow2 = os.time();
                end;

                if (u60.nextFreeAt or 0) <= ServerTimeNow2 then
                    if os.clock() - u64 >= 15 then
                        u64 = os.clock();
                        SpinWheelEvent:FireServer("State");
                    end;
                end;
            elseif os.clock() - u64 >= 15 then
                u64 = os.clock();
                SpinWheelEvent:FireServer("State");
            end;
        end;

        if u63 then
            updateLabels();

            if os.clock() - u7 >= 2 then
                bounceNextFree();
            end;

            local ServerTimeNow2 = workspace:GetServerTimeNow();

            if ServerTimeNow2 <= 1000000000 then
                ServerTimeNow2 = os.time();
            end;

            local math_floor_ret2 = math.floor(ServerTimeNow2 / 86400);

            if math_floor_ret2 ~= math_floor_ret or (u60.nextFreeAt or (1 / 0)) <= ServerTimeNow2 then
                math_floor_ret = math_floor_ret2;

                if os.clock() - u64 >= 1 then
                    u64 = os.clock();
                    SpinWheelEvent:FireServer("State");
                end;
            end;
        end;
    end;
end);
script_Parent.Enabled = false;
Spinner.Rotation = -30;