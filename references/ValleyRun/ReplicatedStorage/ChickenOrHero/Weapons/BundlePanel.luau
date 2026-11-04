 

 

local Players = game:GetService("Players");
local MarketplaceService = game:GetService("MarketplaceService");
local RunService = game:GetService("RunService");
local SoundService = game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
local TextService = game:GetService("TextService");
local script_Parent = script.Parent;
local Parent = script_Parent.Parent;
local Bundles = require(script_Parent.Bundles);
local Current = Bundles.Current;
local GearCatalog = require(Parent.Gear.GearCatalog);
local EmoteCatalog = require(Parent.Emotes.EmoteCatalog);
local EmotePose = require(Parent.Interface.EmotePose);
local CharacterClone = require(Parent.Interface.CharacterClone);
local GiftClient = require(script_Parent.GiftClient);
local SkinCatalog = require(script_Parent.SkinCatalog);
local OfferRules = require(script_Parent.OfferRules);
local KnifeIconCopy = require(script_Parent.KnifeIconCopy);
local u1 = {};
local LocalPlayer = Players.LocalPlayer;
local ArmoryEvent = script_Parent:WaitForChild("ArmoryEvent");
local utf8_char_ret = utf8.char(57346);
local CFrame_Angles_ret = CFrame.Angles(-0.4363323129985824, -0.20943951023931956, -0.5585053606381855);
local u2 = nil;
local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_new_ret2 = Color3.new(0, 0, 0);
local Color3_fromRGB_ret = Color3.fromRGB(23, 23, 25);
local Color3_fromRGB_ret2 = Color3.fromRGB(34, 34, 39);
Color3.fromRGB(76, 76, 81);
local Color3_fromRGB_ret3 = Color3.fromRGB(87, 235, 159);
local Color3_fromRGB_ret4 = Color3.fromRGB(255, 224, 84);
local Color3_fromRGB_ret5 = Color3.fromRGB(253, 60, 85);
local Color3_fromRGB_ret6 = Color3.fromRGB(255, 160, 60);
local Color3_fromRGB_ret7 = Color3.fromRGB(190, 200, 212);
local Color3_fromRGB_ret8 = Color3.fromRGB(122, 243, 168);
local Color3_fromRGB_ret9 = Color3.fromRGB(114, 210, 251);
local Color3_fromRGB_ret10 = Color3.fromRGB(250, 211, 112);
local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(80, 255, 100), Color3.fromRGB(17, 213, 40));
local ColorSequence_new_ret2 = ColorSequence.new(Color3.fromRGB(125, 125, 125), Color3.fromRGB(80, 80, 80));
local ColorSequence_new_ret3 = ColorSequence.new(Color3.fromRGB(255, 202, 58), Color3.fromRGB(230, 161, 0));
local u3 = nil;
local u4 = nil;
local u5 = false;
local u6 = false;
local u7 = nil;
local u8 = nil;

local function productNow() -- Line: 59
    -- upvalues: Bundles (copy), Current (ref), u7 (ref)
    return Bundles.productId(Current, u7);
end;

local u9 = false;

local function comma(p10) -- Line: 64
    local math_floor_ret = math.floor(p10);

    return tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
end;

local function sound(p11) -- Line: 68
    -- upvalues: SoundService (copy)
    local GameAudio = SoundService:FindFirstChild("GameAudio");

    if GameAudio then
        GameAudio = GameAudio:FindFirstChild("04_UI");
    end;

    if GameAudio then
        GameAudio = GameAudio:FindFirstChild(p11);
    end;

    if GameAudio and GameAudio:IsA("Sound") then
        require(game:GetService("ReplicatedFirst"):WaitForChild("LazySound")).playLocal(GameAudio);
    end;
end;

local function make(p12, p13, p14) -- Line: 78
    local Instance_new_ret = Instance.new(p12);

    for i, v in p14 do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p13;

    return Instance_new_ret;
end;

local function round(p15, p16) -- Line: 87
    local v17 = {
        CornerRadius = p16 or UDim.new(0.08, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v17 do
        UICorner[i] = v;
    end;

    UICorner.Parent = p15;
end;

local function border(p18, p19, p20) -- Line: 91
    local v21 = {
        Color = p19,
        Thickness = p20,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v21 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = p18;

    return UIStroke;
end;

local function text(p22, p23, p24, p25, p26, p27) -- Line: 96
    -- upvalues: Color3_new_ret (copy), Color3_new_ret2 (copy)
    local v28 = {
        BackgroundTransparency = 1,
        TextScaled = true,
        TextWrapped = true,
        Name = p23,
        Text = p24,
        TextColor3 = p25 or Color3_new_ret,
        FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", p26 or Enum.FontWeight.ExtraBold)
    };
    local TextLabel = Instance.new("TextLabel");

    for i, v in v28 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p22;
    local v29 = {
        Thickness = 0.12,
        Color = Color3_new_ret2,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v29 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextLabel;

    for i, v in p27 or {} do
        TextLabel[i] = v;
    end;

    return TextLabel;
end;

local function box(p30, p31, p32, p33, p34, p35) -- Line: 113
    p30.Position = UDim2.fromScale(p31, p32);
    p30.Size = UDim2.fromScale(p33, p34);
    p30.AnchorPoint = p35 or Vector2.zero;

    return p30;
end;

local function turntable(p36, p37, u38, p39) -- Line: 121
    -- upvalues: KnifeIconCopy (copy)
    local v40 = p37:Clone();

    for _, descendant in v40:GetDescendants() do
        if descendant:IsA("LuaSourceContainer") or (descendant:IsA("Sound") or (descendant:IsA("ParticleEmitter") or (descendant:IsA("Light") or descendant:IsA("Trail")))) then
            descendant:Destroy();
        end;
    end;

    v40.Anchored = true;
    v40.CFrame = u38;
    local WorldModel = Instance.new("WorldModel");

    for i, v in {} do
        WorldModel[i] = v;
    end;

    WorldModel.Parent = p36;
    v40.Parent = WorldModel;
    local Camera = Instance.new("Camera");

    for i, v in {
        FieldOfView = 33
    } do
        Camera[i] = v;
    end;

    Camera.Parent = p36;
    p36.CurrentCamera = Camera;
    local Size = v40.Size;
    local v41 = p37:FindFirstAncestorOfClass("Model");

    if v41 and KnifeIconCopy.cross(WorldModel, v41, function(p42, p43) -- Line: 139
        -- upvalues: u38 (copy)
        return p43:GetAttribute("PreviewRotation") or u38;
    end, Vector3.new(0, 1, 0), v40) then
        local v44;
        v44, Size = WorldModel:GetBoundingBox();
        WorldModel:PivotTo(WorldModel:GetPivot() - v44.Position);
    end;

    if v41 then
        v41 = v41:GetAttribute("PreviewZoom");
    end;

    local v45 = tonumber(v41) or 1;
    local math_clamp_ret = math.clamp(v45, 0.5, 3);

    return {
        angle = 0,
        camera = Camera,
        extent = math.max(Size.X, Size.Y, Size.Z, 0.5) / math_clamp_ret,
        height = p39
    };
end;

local function step(p46, p47) -- Line: 152
    p46.angle = p46.angle + p47 * 0.6;
    local extent = p46.extent;
    local camera = p46.camera;
    local CFrame_lookAt = CFrame.lookAt;
    local v48 = math.sin(p46.angle) * extent * 2;
    local v49 = p46.height * extent;
    local v50 = math.cos(p46.angle) * extent * 2;
    camera.CFrame = CFrame_lookAt(Vector3.new(v48, v49, v50), Vector3.new(0, 0, 0));
end;

local function offer(p51) -- Line: 162
    -- upvalues: u6 (ref), u9 (ref), OfferRules (copy), Current (ref), u4 (ref), utf8_char_ret (copy)
    if u6 then
        return "OWNED  ✓", false;
    end;

    if u9 then
        return "ADDING YOUR BUNDLE…", false;
    end;

    if not OfferRules.active(Current, p51) then
        return "OFFER ENDED", false;
    end;

    if u4 == nil then
        return "CHECKING PRICE…", false;
    end;

    if not (u4 and (u4.IsForSale and type(u4.PriceInRobux) == "number")) then
        return "NOT ON SALE", false;
    end;

    local math_floor_ret = math.floor(u4.PriceInRobux);

    return utf8_char_ret .. " " .. tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""), true;
end;

local function paint(p52) -- Line: 177
    -- upvalues: offer (copy), ColorSequence_new_ret (copy), ColorSequence_new_ret2 (copy), Color3_new_ret (copy), u6 (ref), OfferRules (copy), Current (ref), GiftClient (copy), u4 (ref), LocalPlayer (copy), ColorSequence_new_ret3 (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local v53, v54 = offer(ServerTimeNow);

    if p52.buyText.Text ~= v53 then
        p52.buyText.Text = v53;
    end;

    if p52.live ~= v54 then
        p52.live = v54;
        p52.buy.Interactable = v54;
        p52.buy.AutoButtonColor = v54;
        local v55;

        if v54 then
            v55 = ColorSequence_new_ret;
        else
            v55 = ColorSequence_new_ret2;
        end;

        p52.buyFill.Color = v55;
        local buyText = p52.buyText;
        local v56;

        if v54 then
            v56 = Color3_new_ret;
        else
            v56 = Color3.fromRGB(165, 165, 165);
        end;

        buyText.TextColor3 = v56;
    end;

    local v57 = u6 and "YOURS TO KEEP" or OfferRules.countdown(Current, ServerTimeNow);

    if p52.timer.Text ~= v57 then
        p52.timer.Text = v57;
    end;

    local v58 = GiftClient.giftable(Current.Key) and OfferRules.active(Current, ServerTimeNow);

    if v58 then
        local v59;

        if type(u4) == "table" then
            v59 = u4.IsForSale ~= true;
        else
            v59 = false;
        end;

        v58 = not v59;
    end;

    if p52.giftShown ~= v58 then
        p52.giftShown = v58;
        p52.gift.Visible = v58;
        local buy = p52.buy;
        local Vector2_new_ret = Vector2.new(0, 0.5);
        buy.Position = UDim2.fromScale(0.575, 0.895);
        buy.Size = UDim2.fromScale(0.39 - (v58 and 0.08387499999999999 or 0), 0.115);
        buy.AnchorPoint = Vector2_new_ret or Vector2.zero;
    end;

    local v60 = v58 and not GiftClient.busy() and LocalPlayer:GetAttribute("InMatch") ~= true;

    if p52.giftLive ~= v60 then
        p52.giftLive = v60;
        p52.gift.Interactable = v60;
        p52.gift.AutoButtonColor = v60;
        local v61;

        if v60 then
            v61 = ColorSequence_new_ret3;
        else
            v61 = ColorSequence_new_ret2;
        end;

        p52.giftFill.Color = v61;
    end;
end;

local function fetchPrice() -- Line: 215
    -- upvalues: u4 (ref), u5 (ref), Bundles (copy), Current (ref), u7 (ref), u8 (ref), MarketplaceService (copy), u3 (ref), paint (copy)
    if u4 ~= nil or u5 then
        return;
    end;

    u5 = true;
    local u62 = Bundles.productId(Current, u7);
    u8 = u62;
    task.spawn(function() -- Line: 222
        -- upvalues: MarketplaceService (ref), u62 (copy), u5 (ref), u4 (ref), Current (ref), u3 (ref), paint (ref)
        local success, result = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, u62, Enum.InfoType.Product);
        u5 = false;
        u4 = success and result and result or false;

        if not success then
            warn("[" .. Current.Key .. "] price unavailable: " .. tostring(result));
        end;

        if u3 then
            paint(u3);
        end;
    end);
end;

local function evenSizes(u63) -- Line: 238
    -- upvalues: TextService (copy)
    local u64 = false;
    local u65 = false;

    local function fits(p66, p67, p68) -- Line: 240
        -- upvalues: TextService (ref)
        local GetTextBoundsParams = Instance.new("GetTextBoundsParams");
        GetTextBoundsParams.Text = p66.Text;
        GetTextBoundsParams.Font = p66.FontFace;
        GetTextBoundsParams.Size = p67;
        GetTextBoundsParams.Width = p68.X;
        local success, result = pcall(TextService.GetTextBoundsAsync, TextService, GetTextBoundsParams);

        if not success then
            return nil;
        end;

        local v69;

        if result.X <= p68.X then
            v69 = result.Y <= p68.Y;
        else
            v69 = false;
        end;

        return v69;
    end;

    local function fit() -- Line: 252
        -- upvalues: u64 (ref), u65 (ref), u63 (copy), fits (copy)
        if u64 then
            u65 = true;

            return;
        end;

        u64 = true;

        while true do
            u65 = false;
            local v70 = nil;

            for _, v in u63 do
                local AbsoluteSize = v.AbsoluteSize;

                if not (v.Parent and (AbsoluteSize.X >= 4 and AbsoluteSize.Y >= 4)) then
                    v70 = nil;
                end;

                local math_floor_ret = math.floor(AbsoluteSize.Y);
                local math_max_ret = math.max(6, math_floor_ret);
                local v71 = v;
                local v72 = 6;

                while v72 < math_max_ret do
                    local math_ceil_ret = math.ceil((v72 + math_max_ret) / 2);
                    local v73 = fits(v71, math_ceil_ret, AbsoluteSize);

                    if v73 == nil then
                        v72 = 0;
                    end;

                    if v73 then
                        v72 = math_ceil_ret;
                    else
                        math_max_ret = math_ceil_ret - 1;
                    end;
                end;

                if v72 == 0 then
                    v70 = nil;
                end;

                if v70 then
                    v70 = math.min(v70, v72);
                else
                    v70 = v72;
                end;
            end;

            if v70 then
                for _, v in u63 do
                    v.TextScaled = false;
                    v.TextSize = v70;
                end;
            end;

            if not u65 then
                u64 = false;

                return;
            end;
        end;
    end;

    for _, v in u63 do
        v:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 296
            -- upvalues: fit (copy)
            task.spawn(fit);
        end);
    end;

    task.spawn(fit);
end;

local function abilityCard(p74, p75, p76) -- Line: 305
    -- upvalues: Color3_new_ret (copy), Color3_new_ret2 (copy), Color3_fromRGB_ret (copy), text (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret8 (copy), Color3_fromRGB_ret9 (copy), Color3_fromRGB_ret10 (copy), Color3_fromRGB_ret2 (copy), evenSizes (copy), Color3_fromRGB_ret7 (copy), sound (copy)
    local v77 = p75.Accent or Color3_new_ret;
    local v78 = {
        Name = "AbilityInfo",
        Text = "",
        AutoButtonColor = false,
        BackgroundTransparency = 0.4,
        ZIndex = 10,
        BackgroundColor3 = Color3_new_ret2,
        Size = UDim2.fromScale(1, 1)
    };
    local TextButton = Instance.new("TextButton");

    for i, v in v78 do
        TextButton[i] = v;
    end;

    TextButton.Parent = p74;
    local v79 = {
        CornerRadius = UDim.new(0.045, 0) or UDim.new(0.08, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v79 do
        UICorner[i] = v;
    end;

    UICorner.Parent = TextButton;
    local v80 = {
        Name = "Card",
        Text = "",
        AutoButtonColor = false,
        ZIndex = 11,
        BackgroundColor3 = Color3_fromRGB_ret
    };
    local TextButton2 = Instance.new("TextButton");

    for i, v in v80 do
        TextButton2[i] = v;
    end;

    TextButton2.Parent = TextButton;
    local Vector2_new_ret = Vector2.new(0.5, 0.5);
    TextButton2.Position = UDim2.fromScale(0.5, 0.5);
    TextButton2.Size = UDim2.fromScale(0.66, 0.8);
    TextButton2.AnchorPoint = Vector2_new_ret or Vector2.zero;
    local v81 = {
        CornerRadius = UDim.new(0.05, 0) or UDim.new(0.08, 0)
    };
    local UICorner2 = Instance.new("UICorner");

    for i, v in v81 do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = TextButton2;
    local v82 = {
        Thickness = 2.5,
        Color = v77,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v82 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextButton2;

    local function z(p83) -- Line: 321
        p83.ZIndex = 12;

        for _, descendant in p83:GetDescendants() do
            if descendant:IsA("GuiObject") then
                descendant.ZIndex = 13;
            end;
        end;

        return p83;
    end;

    local v84 = {
        Name = "Icon",
        BackgroundTransparency = 1,
        Image = p76 or "rbxassetid://129028976496842",
        ScaleType = Enum.ScaleType.Fit
    };
    local ImageLabel = Instance.new("ImageLabel");
    local v85 = z;

    for i, v in v84 do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = TextButton2;
    local v86 = z(ImageLabel);
    v86.Position = UDim2.fromScale(0.05, 0.06);
    v86.Size = UDim2.fromScale(0.15, 0.2);
    v86.AnchorPoint = Vector2.zero;
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");

    for i, v in {
        AspectRatio = 1
    } do
        UIAspectRatioConstraint[i] = v;
    end;

    UIAspectRatioConstraint.Parent = v86;
    local v87 = {
        TextXAlignment = Enum.TextXAlignment.Left
    };
    local v88 = text(TextButton2, "Name", p75.Name, v77, Enum.FontWeight.Heavy, v87);
    v88.Position = UDim2.fromScale(0.23, 0.065);
    v88.Size = UDim2.fromScale(0.62, 0.13);
    v88.AnchorPoint = Vector2.zero;
    v85(v88);
    local v89 = text(TextButton2, "Role", (p75.Role or "") .. " ABILITY  ·  BUNDLE ONLY", Color3_new_ret, Enum.FontWeight.Bold, v87);
    v89.Position = UDim2.fromScale(0.23, 0.2);
    v89.Size = UDim2.fromScale(0.62, 0.065);
    v89.AnchorPoint = Vector2.zero;
    v85(v89);
    local v90 = {
        Name = "Close",
        Text = "X",
        TextScaled = true,
        BackgroundTransparency = 1,
        TextColor3 = Color3_fromRGB_ret5,
        FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
    };
    local TextButton3 = Instance.new("TextButton");
    local v91 = v85;

    for i, v in v90 do
        TextButton3[i] = v;
    end;

    TextButton3.Parent = TextButton2;
    local v92 = v85(TextButton3);
    local Vector2_new_ret2 = Vector2.new(1, 0);
    v92.Position = UDim2.fromScale(0.955, 0.075);
    v92.Size = UDim2.fromScale(0.08, 0.11);
    v92.AnchorPoint = Vector2_new_ret2 or Vector2.zero;
    local v93 = {
        Thickness = 0.12,
        Color = Color3_new_ret2,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v93 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = v92;
    local v94 = {};

    if p75.Duration then
        table.insert(v94, { "ACTIVE", p75.Duration, Color3_fromRGB_ret8 });
    end;

    table.insert(v94, { "COOLDOWN", p75.Cooldown or 0, Color3_fromRGB_ret9 });

    if p75.SealSeconds then
        table.insert(v94, { "HOLD", p75.SealSeconds, Color3_fromRGB_ret10 });
    end;

    local v95 = 0;

    for _, v in v94 do
        v95 = v95 + (#("%s %ds"):format(v[1], v[2]) + 1);
    end;

    local v96 = 0.9 - (#v94 - 1) * 0.03;
    local v97 = 0.05;

    for _, v in v94 do
        local v98 = v[1];
        local v99 = v[2];
        local v100 = v[3];
        local v101 = v96 * (#("%s %ds"):format(v98, v99) + 1) / v95;
        local v102 = {
            Name = "Chip",
            BackgroundColor3 = Color3_fromRGB_ret2
        };
        local Frame = Instance.new("Frame");

        for i, v2 in v102 do
            Frame[i] = v2;
        end;

        Frame.Parent = TextButton2;
        Frame.Position = UDim2.fromScale(v97, 0.31);
        Frame.Size = UDim2.fromScale(v101, 0.1);
        Frame.AnchorPoint = Vector2.zero;
        v97 = v97 + (v101 + 0.03);
        local v103 = {
            CornerRadius = UDim.new(1, 0) or UDim.new(0.08, 0)
        };
        local UICorner3 = Instance.new("UICorner");

        for i, v2 in v103 do
            UICorner3[i] = v2;
        end;

        UICorner3.Parent = Frame;
        local v104 = {
            Thickness = 1.5,
            Color = v77,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        };
        local UIStroke3 = Instance.new("UIStroke");

        for i, v2 in v104 do
            UIStroke3[i] = v2;
        end;

        UIStroke3.Parent = Frame;
        local v105 = text(Frame, "Text", ("<font color=\"#%s\">%s</font> %ds"):format(v100:ToHex(), v98, v99), Color3_new_ret, Enum.FontWeight.ExtraBold, {
            RichText = true
        });
        local Vector2_new_ret3 = Vector2.new(0.5, 0.5);
        v105.Position = UDim2.fromScale(0.5, 0.5);
        v105.Size = UDim2.fromScale(0.84, 0.62);
        v105.AnchorPoint = Vector2_new_ret3 or Vector2.zero;
        v91(Frame);
    end;

    local v106 = p75.HowTo or { p75.Description };
    local v107;

    if type(p75.InfoNote) == "string" and p75.InfoNote ~= "" then
        v107 = p75.InfoNote;
    else
        v107 = nil;
    end;

    local v108 = 0.47 / math.max(#v106, 1);
    local v109 = v107 and 0.44 or 0.47;
    local v110 = {};

    for i, v in v106 do
        local v111 = v109 + (i - 1) * v108;
        local v112, v113;

        if #v106 > 1 then
            local v114 = {
                Name = "Step" .. i,
                BackgroundColor3 = v77
            };
            local Frame = Instance.new("Frame");
            v112 = v;
            v113 = i;

            for i2, v2 in v114 do
                Frame[i2] = v2;
            end;

            Frame.Parent = TextButton2;
            local Vector2_new_ret3 = Vector2.new(0, 0.5);
            Frame.Position = UDim2.fromScale(0.05, v111 + v108 * 0.45);
            Frame.Size = UDim2.fromScale(0.06, v108 * 0.55);
            Frame.AnchorPoint = Vector2_new_ret3 or Vector2.zero;
            local v115 = {
                AspectRatio = 1,
                DominantAxis = Enum.DominantAxis.Height
            };
            local UIAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint");

            for i2, v2 in v115 do
                UIAspectRatioConstraint2[i2] = v2;
            end;

            UIAspectRatioConstraint2.Parent = Frame;
            local v116 = {
                CornerRadius = UDim.new(1, 0) or UDim.new(0.08, 0)
            };
            local UICorner3 = Instance.new("UICorner");

            for i2, v2 in v116 do
                UICorner3[i2] = v2;
            end;

            UICorner3.Parent = Frame;
            local v117 = text(Frame, "Text", tostring(v113), Color3_new_ret, Enum.FontWeight.Heavy);
            local Vector2_new_ret4 = Vector2.new(0.5, 0.5);
            v117.Position = UDim2.fromScale(0.5, 0.5);
            v117.Size = UDim2.fromScale(0.6, 0.6);
            v117.AnchorPoint = Vector2_new_ret4 or Vector2.zero;
            v91(Frame);
        else
            v112 = v;
            v113 = i;
        end;

        local v118 = text(TextButton2, "Line" .. v113, v112, Color3_new_ret, Enum.FontWeight.Bold, v87);
        v118:FindFirstChildOfClass("UIStroke").Thickness = 0.07;
        local Vector2_new_ret3 = Vector2.new(0, 0.5);
        v118.Position = UDim2.fromScale(#v106 > 1 and 0.15 or 0.05, v111 + v108 * 0.45);
        v118.Size = UDim2.fromScale(#v106 > 1 and 0.8 or 0.9, v108 * 0.82);
        v118.AnchorPoint = Vector2_new_ret3 or Vector2.zero;
        v91(v118);
        table.insert(v110, v118);
    end;

    evenSizes(v110);

    if v107 then
        local v119 = text(TextButton2, "Note", v107, Color3_fromRGB_ret7, Enum.FontWeight.SemiBold);
        v119.TextXAlignment = Enum.TextXAlignment.Center;
        v119:FindFirstChildOfClass("UIStroke").Thickness = 0.07;
        local Vector2_new_ret3 = Vector2.new(0.5, 0.5);
        v119.Position = UDim2.fromScale(0.5, 0.932);
        v119.Size = UDim2.fromScale(0.86, 0.038);
        v119.AnchorPoint = Vector2_new_ret3 or Vector2.zero;
        v91(v119);
    end;

    local function hide() -- Line: 404
        -- upvalues: TextButton (copy), sound (ref)
        if TextButton.Visible then
            TextButton.Visible = false;
            sound("PanelClose");
        end;
    end;

    TextButton.Activated:Connect(hide);
    v92.Activated:Connect(hide);

    return TextButton;
end;

local function teardown(p120) -- Line: 416
    for _, v in p120.connections do
        v:Disconnect();
    end;

    table.clear(p120.connections);
    table.clear(p120.views);

    for _, v in p120.poses do
        v:destroy();
    end;

    table.clear(p120.poses);
    table.clear(p120.floaters);
    p120.gui:Destroy();
end;

local function build(p121) -- Line: 430
    -- upvalues: SkinCatalog (copy), Current (ref), Color3_fromRGB_ret (copy), TweenService (copy), text (copy), Color3_new_ret (copy), Color3_fromRGB_ret5 (copy), Color3_new_ret2 (copy), Color3_fromRGB_ret2 (copy), GearCatalog (copy), EmoteCatalog (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret6 (copy), Parent (copy), Color3_fromRGB_ret4 (copy), ColorSequence_new_ret (copy), ColorSequence_new_ret2 (copy), GiftClient (copy), script_Parent (copy), turntable (copy), CFrame_Angles_ret (copy), EmotePose (copy), CharacterClone (copy), u1 (copy), abilityCard (copy), sound (copy), paint (copy), offer (copy), LocalPlayer (copy), u2 (ref), ArmoryEvent (copy), MarketplaceService (copy), productNow (copy), RunService (copy), u3 (ref), teardown (copy)
    local v122 = SkinCatalog.get(Current.SkinId);
    local v123 = Current.Accent or (v122 and typeof(v122.Accent) == "Color3" and v122.Accent or Color3.fromRGB(255, 86, 108));
    local v124 = {
        DisplayOrder = 80,
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        Name = Current.Key,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    };
    local ScreenGui = Instance.new("ScreenGui");

    for i, v in v124 do
        ScreenGui[i] = v;
    end;

    ScreenGui.Parent = p121;
    ScreenGui:SetAttribute("SelfManagedText", true);
    local v125 = {
        Name = "Panel",
        BackgroundTransparency = 0.04,
        BackgroundColor3 = Color3_fromRGB_ret
    };
    local Frame = Instance.new("Frame");

    for i, v in v125 do
        Frame[i] = v;
    end;

    Frame.Parent = ScreenGui;
    local Vector2_new_ret = Vector2.new(0.5, 0.5);
    Frame.Position = UDim2.fromScale(0.5, 0.5);
    Frame.Size = UDim2.fromScale(0.62, 0.62);
    Frame.AnchorPoint = Vector2_new_ret or Vector2.zero;
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");

    for i, v in {
        AspectRatio = 1.6
    } do
        UIAspectRatioConstraint[i] = v;
    end;

    UIAspectRatioConstraint.Parent = Frame;
    local v126 = {
        MaxSize = Vector2.new(840, 525),
        MinSize = Vector2.new(352, 220)
    };
    local UISizeConstraint = Instance.new("UISizeConstraint");

    for i, v in v126 do
        UISizeConstraint[i] = v;
    end;

    UISizeConstraint.Parent = Frame;
    local v127 = {
        CornerRadius = UDim.new(0.045, 0) or UDim.new(0.08, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v127 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v128 = {
        Thickness = 2.5,
        Color = v123,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v128 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    local UIScale = Instance.new("UIScale");

    for i, v in {
        Scale = 0.9
    } do
        UIScale[i] = v;
    end;

    UIScale.Parent = Frame;
    TweenService:Create(UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
    local v129 = text(Frame, "Title", Current.Title, Color3_new_ret, Enum.FontWeight.Heavy, {
        TextXAlignment = Enum.TextXAlignment.Left
    });
    v129.Position = UDim2.fromScale(0.035, 0.04);
    v129.Size = UDim2.fromScale(0.5, 0.1);
    v129.AnchorPoint = Vector2.zero;
    local v130 = {
        Name = "TimerPill",
        BackgroundColor3 = Color3.fromRGB(12, 12, 14)
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v130 do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    Frame2.Position = UDim2.fromScale(0.56, 0.045);
    Frame2.Size = UDim2.fromScale(0.3, 0.085);
    Frame2.AnchorPoint = Vector2.zero;
    local v131 = {
        CornerRadius = UDim.new(1, 0) or UDim.new(0.08, 0)
    };
    local UICorner2 = Instance.new("UICorner");

    for i, v in v131 do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = Frame2;
    local v132 = {
        Thickness = 1.5,
        Color = v123,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v132 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = Frame2;
    local v133 = text(Frame2, "Timer", "", v123, Enum.FontWeight.ExtraBold);
    local Vector2_new_ret2 = Vector2.new(0.5, 0.5);
    v133.Position = UDim2.fromScale(0.5, 0.5);
    v133.Size = UDim2.fromScale(0.86, 0.66);
    v133.AnchorPoint = Vector2_new_ret2 or Vector2.zero;
    local v134 = {
        Name = "Close",
        Text = "X",
        TextScaled = true,
        BackgroundTransparency = 1,
        Modal = true,
        TextColor3 = Color3_fromRGB_ret5,
        FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
    };
    local TextButton = Instance.new("TextButton");

    for i, v in v134 do
        TextButton[i] = v;
    end;

    TextButton.Parent = Frame;
    local Vector2_new_ret3 = Vector2.new(0.5, 0.5);
    TextButton.Position = UDim2.fromScale(0.965, 0.088);
    TextButton.Size = UDim2.fromScale(0.07, 0.11);
    TextButton.AnchorPoint = Vector2_new_ret3 or Vector2.zero;
    local v135 = {
        Thickness = 0.12,
        Color = Color3_new_ret2,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke3 = Instance.new("UIStroke");

    for i, v in v135 do
        UIStroke3[i] = v;
    end;

    UIStroke3.Parent = TextButton;
    local v136 = {
        Name = "Knife",
        BackgroundColor3 = Color3_new_ret
    };
    local Frame3 = Instance.new("Frame");

    for i, v in v136 do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame;
    Frame3.Position = UDim2.fromScale(0.035, 0.17);
    Frame3.Size = UDim2.fromScale(0.52, 0.63);
    Frame3.AnchorPoint = Vector2.zero;
    local v137 = {
        Rotation = 90,
        Color = ColorSequence.new(Color3_fromRGB_ret2, v123:Lerp(Color3_fromRGB_ret, 0.45))
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v137 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Frame3;
    local v138 = {
        CornerRadius = UDim.new(0.06, 0) or UDim.new(0.08, 0)
    };
    local UICorner3 = Instance.new("UICorner");

    for i, v in v138 do
        UICorner3[i] = v;
    end;

    UICorner3.Parent = Frame3;
    local v139 = {
        Thickness = 2,
        Color = v123,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke4 = Instance.new("UIStroke");

    for i, v in v139 do
        UIStroke4[i] = v;
    end;

    UIStroke4.Parent = Frame3;
    local ImageLabel = Instance.new("ImageLabel");

    for i, v in {
        Name = "Glow",
        BackgroundTransparency = 1,
        Image = "rbxassetid://129028976496842",
        ImageTransparency = 0.55,
        ImageColor3 = v123
    } do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = Frame3;
    local Vector2_new_ret4 = Vector2.new(0.5, 0.5);
    ImageLabel.Position = UDim2.fromScale(0.5, 0.44);
    ImageLabel.Size = UDim2.fromScale(0.75, 1.15);
    ImageLabel.AnchorPoint = Vector2_new_ret4 or Vector2.zero;
    local UIAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint");

    for i, v in {
        AspectRatio = 1
    } do
        UIAspectRatioConstraint2[i] = v;
    end;

    UIAspectRatioConstraint2.Parent = ImageLabel;
    Frame3.ClipsDescendants = true;
    local Random_new_ret = Random.new();
    local v140 = {};

    for i = 1, Current.Floaters and 12 or 0 do
        local v141 = {
            Name = "Floater",
            BackgroundTransparency = 1,
            Image = Current.Floaters[(i - 1) % #Current.Floaters + 1],
            ImageColor3 = v123:Lerp(Color3_new_ret, Random_new_ret:NextNumber(0, 0.45)),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Size = UDim2.fromScale(Random_new_ret:NextNumber(0.06, 0.11), Random_new_ret:NextNumber(0.06, 0.11))
        };
        local ImageLabel2 = Instance.new("ImageLabel");

        for i2, v in v141 do
            ImageLabel2[i2] = v;
        end;

        ImageLabel2.Parent = Frame3;
        local UIAspectRatioConstraint3 = Instance.new("UIAspectRatioConstraint");

        for i2, v in {
            AspectRatio = 1
        } do
            UIAspectRatioConstraint3[i2] = v;
        end;

        UIAspectRatioConstraint3.Parent = ImageLabel2;
        v140[i] = {
            image = ImageLabel2,
            x = Random_new_ret:NextNumber(0.08, 0.92),
            t = Random_new_ret:NextNumber(),
            speed = Random_new_ret:NextNumber(0.1, 0.2),
            sway = Random_new_ret:NextNumber(0.02, 0.05),
            phase = Random_new_ret:NextNumber(0, 6.283185307179586)
        };
    end;

    local v142 = {
        Name = "View",
        BackgroundTransparency = 1,
        LightDirection = Vector3.new(-1, -1, -1),
        Ambient = Color3.fromRGB(205, 205, 210),
        LightColor = Color3_new_ret
    };
    local ViewportFrame = Instance.new("ViewportFrame");

    for i, v in v142 do
        ViewportFrame[i] = v;
    end;

    ViewportFrame.Parent = Frame3;
    local Vector2_new_ret5 = Vector2.new(0.5, 0.5);
    ViewportFrame.Position = UDim2.fromScale(0.5, 0.44);
    ViewportFrame.Size = UDim2.fromScale(0.92, 0.66);
    ViewportFrame.AnchorPoint = Vector2_new_ret5 or Vector2.zero;
    local Frame4 = Instance.new("Frame");

    for i, v in {
        Name = "Tag",
        BackgroundColor3 = v123
    } do
        Frame4[i] = v;
    end;

    Frame4.Parent = Frame3;
    Frame4.Position = UDim2.fromScale(0.04, 0.05);
    Frame4.Size = UDim2.fromScale(0.36, 0.1);
    Frame4.AnchorPoint = Vector2.zero;
    Frame4.ZIndex = 2;
    local v143 = {
        CornerRadius = UDim.new(1, 0) or UDim.new(0.08, 0)
    };
    local UICorner4 = Instance.new("UICorner");

    for i, v in v143 do
        UICorner4[i] = v;
    end;

    UICorner4.Parent = Frame4;
    local v144 = text(Frame4, "Text", "EXCLUSIVE KNIFE", Color3_new_ret, Enum.FontWeight.Heavy);
    local Vector2_new_ret6 = Vector2.new(0.5, 0.5);
    v144.Position = UDim2.fromScale(0.5, 0.5);
    v144.Size = UDim2.fromScale(0.86, 0.7);
    v144.AnchorPoint = Vector2_new_ret6 or Vector2.zero;
    local v145 = text(Frame3, "KnifeName", v122 and (v122.Name or "BONKER") or "BONKER", Color3_new_ret, Enum.FontWeight.Heavy);
    local Vector2_new_ret7 = Vector2.new(0.5, 0.5);
    v145.Position = UDim2.fromScale(0.5, 0.82);
    v145.Size = UDim2.fromScale(0.8, 0.13);
    v145.AnchorPoint = Vector2_new_ret7 or Vector2.zero;
    local v146 = text(Frame3, "Subtitle", v122 and (v122.Subtitle or "") or "", Color3.fromRGB(225, 225, 230), Enum.FontWeight.Bold);
    local Vector2_new_ret8 = Vector2.new(0.5, 0.5);
    v146.Position = UDim2.fromScale(0.5, 0.925);
    v146.Size = UDim2.fromScale(0.86, 0.07);
    v146.AnchorPoint = Vector2_new_ret8 or Vector2.zero;
    local u147 = Current.Ability and GearCatalog.Items[Current.Ability];
    local u148 = Current.Emote and EmoteCatalog.get(Current.Emote);
    local v149 = (Current.Gems or 0) > 0;
    local v150 = (Current.Candy or 0) > 0;
    local v151 = (Current.Keys or 0) > 0;
    local math_max_ret = math.max((v149 and 1 or 0) + (v150 and 1 or 0) + (v151 and 1 or 0) + (u147 and 1 or 0) + (u148 and 1 or 0) + (Current.Item and 1 or 0), 1);
    local u152 = (0.63 - 0.022 * (math_max_ret - 1)) / math_max_ret;
    local u153 = 0;

    local function extra(p154, p155, p156, p157, p158) -- Line: 548
        -- upvalues: Frame (copy), Color3_fromRGB_ret2 (ref), u153 (ref), u152 (copy), text (ref), Color3_new_ret (ref)
        local v159 = p158 ~= nil;
        local v160 = {
            Name = p154,
            BackgroundColor3 = Color3_fromRGB_ret2
        };
        local Instance_new_ret = Instance.new(v159 and "TextButton" or "Frame");

        for i, v in v160 do
            Instance_new_ret[i] = v;
        end;

        Instance_new_ret.Parent = Frame;

        if v159 then
            Instance_new_ret.Text = "";
            Instance_new_ret.AutoButtonColor = true;
        end;

        Instance_new_ret.Position = UDim2.fromScale(0.575, 0.17 + u153 * (u152 + 0.022));
        Instance_new_ret.Size = UDim2.fromScale(0.39, u152);
        Instance_new_ret.AnchorPoint = Vector2.zero;
        u153 = u153 + 1;
        local v161 = {
            CornerRadius = UDim.new(0.12, 0) or UDim.new(0.08, 0)
        };
        local UICorner5 = Instance.new("UICorner");

        for i, v in v161 do
            UICorner5[i] = v;
        end;

        UICorner5.Parent = Instance_new_ret;
        local v162 = {
            Thickness = 2,
            Color = p155,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        };
        local UIStroke5 = Instance.new("UIStroke");

        for i, v in v162 do
            UIStroke5[i] = v;
        end;

        UIStroke5.Parent = Instance_new_ret;
        local v163 = u152 > 0.3;

        if v163 then
            Instance_new_ret:SetAttribute("Big", true);
            local v164 = {
                TextXAlignment = Enum.TextXAlignment.Center
            };
            local v165 = text(Instance_new_ret, "Amount", p156, p155, Enum.FontWeight.Heavy, v164);
            local Vector2_new_ret9 = Vector2.new(0.5, 0.5);
            v165.Position = UDim2.fromScale(0.5, 0.71);
            v165.Size = UDim2.fromScale(0.84, 0.1);
            v165.AnchorPoint = Vector2_new_ret9 or Vector2.zero;
            local v166 = text(Instance_new_ret, "Caption", p157, Color3_new_ret, Enum.FontWeight.Bold, v164);
            local Vector2_new_ret10 = Vector2.new(0.5, 0.5);
            v166.Position = UDim2.fromScale(0.5, 0.82);
            v166.Size = UDim2.fromScale(0.7, 0.06);
            v166.AnchorPoint = Vector2_new_ret10 or Vector2.zero;
            v166:FindFirstChildOfClass("UIStroke").Thickness = 0.07;
        end;

        local v167 = {
            TextXAlignment = Enum.TextXAlignment.Left
        };
        local v168;

        if v163 then
            v168 = nil;
        else
            local v169 = text(Instance_new_ret, "Amount", p156, p155, Enum.FontWeight.Heavy, v167);
            v169.Position = UDim2.fromScale(0.3, 0.1);
            v169.Size = UDim2.fromScale(0.66, 0.46);
            v169.AnchorPoint = Vector2.zero;
            v168 = text(Instance_new_ret, "Caption", p157, Color3_new_ret, Enum.FontWeight.Bold, v167);
            v168.Position = UDim2.fromScale(0.3, 0.6);
            v168.Size = UDim2.fromScale(0.66, 0.28);
            v168.AnchorPoint = Vector2.zero;
            v168:FindFirstChildOfClass("UIStroke").Thickness = 0.07;
        end;

        if p158 then
            if v168 then
                v168.Size = UDim2.fromScale(0.52, 0.28);
            end;

            local Frame5 = Instance.new("Frame");

            for i, v in {
                Name = "Badge",
                BackgroundColor3 = p155
            } do
                Frame5[i] = v;
            end;

            Frame5.Parent = Instance_new_ret;

            if v163 then
                local Vector2_new_ret9 = Vector2.new(1, 1);
                Frame5.Position = UDim2.fromScale(0.93, 0.93);
                Frame5.Size = UDim2.fromScale(0.13, 0.1);
                Frame5.AnchorPoint = Vector2_new_ret9 or Vector2.zero;
            else
                local Vector2_new_ret9 = Vector2.new(1, 0.5);
                Frame5.Position = UDim2.fromScale(0.955, 0.74);
                Frame5.Size = UDim2.fromScale(0.3, 0.32);
                Frame5.AnchorPoint = Vector2_new_ret9 or Vector2.zero;
            end;

            local v170 = {
                AspectRatio = 1,
                DominantAxis = Enum.DominantAxis.Height
            };
            local UIAspectRatioConstraint3 = Instance.new("UIAspectRatioConstraint");

            for i, v in v170 do
                UIAspectRatioConstraint3[i] = v;
            end;

            UIAspectRatioConstraint3.Parent = Frame5;
            local v171 = {
                CornerRadius = UDim.new(1, 0) or UDim.new(0.08, 0)
            };
            local UICorner6 = Instance.new("UICorner");

            for i, v in v171 do
                UICorner6[i] = v;
            end;

            UICorner6.Parent = Frame5;
            local v172 = text(Frame5, "Text", p158, Color3_new_ret, Enum.FontWeight.Heavy);
            local Vector2_new_ret9 = Vector2.new(0.5, 0.5);
            v172.Position = UDim2.fromScale(0.5, 0.5);
            v172.Size = UDim2.fromScale(0.62, 0.62);
            v172.AnchorPoint = Vector2_new_ret9 or Vector2.zero;
        end;

        return Instance_new_ret;
    end;

    local function icon(p173, p174, p175) -- Line: 592
        p175.Name = "Icon";
        p175.BackgroundTransparency = 1;

        if p173:GetAttribute("Big") then
            local Instance_new_ret = Instance.new(p174);

            for i, v in p175 do
                Instance_new_ret[i] = v;
            end;

            Instance_new_ret.Parent = p173;
            local Vector2_new_ret9 = Vector2.new(0.5, 0.5);
            Instance_new_ret.Position = UDim2.fromScale(0.5, 0.36);
            Instance_new_ret.Size = UDim2.fromScale(0.8, 0.5);
            Instance_new_ret.AnchorPoint = Vector2_new_ret9 or Vector2.zero;

            return Instance_new_ret;
        end;

        local Instance_new_ret = Instance.new(p174);

        for i, v in p175 do
            Instance_new_ret[i] = v;
        end;

        Instance_new_ret.Parent = p173;
        local Vector2_new_ret9 = Vector2.new(0, 0.5);
        Instance_new_ret.Position = UDim2.fromScale(0.04, 0.5);
        Instance_new_ret.Size = UDim2.fromScale(0.23, 0.84);
        Instance_new_ret.AnchorPoint = Vector2_new_ret9 or Vector2.zero;

        return Instance_new_ret;
    end;

    local v176 = nil;
    local u177 = nil;
    local v178;

    if u147 then
        local v179 = u147.Accent or v123;
        v178 = extra("Ability", v179, u147.Name, u147.Pair and "RUNNER + CHASER" or u147.Role .. " ABILITY", "i");
        local v180 = Current.AbilityIcon or u147.IconImage;
        local v181 = {
            Image = v180 or "rbxassetid://129028976496842"
        };

        if v180 then
            v179 = Color3_new_ret;
        end;

        v181.ImageColor3 = v179;
        v181.ScaleType = Enum.ScaleType.Fit;
        local v182 = icon(v178, "ImageLabel", v181);
        local UIAspectRatioConstraint3 = Instance.new("UIAspectRatioConstraint");

        for i, v in {
            AspectRatio = 1
        } do
            UIAspectRatioConstraint3[i] = v;
        end;

        UIAspectRatioConstraint3.Parent = v182;
    else
        v178 = nil;
    end;

    if u148 then
        v176 = extra("Emote", v123, string.upper(u148.Name), "EMOTE", "▶");
        u177 = icon(v176, "ViewportFrame", {
            LightDirection = Vector3.new(-1, -1, -1),
            Ambient = Color3.fromRGB(200, 200, 205),
            LightColor = Color3_new_ret
        });
    end;

    if v149 then
        local math_floor_ret = math.floor(Current.Gems);
        icon(extra("Gems", Color3_fromRGB_ret3, "+" .. tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""), "GEMS"), "ImageLabel", {
            Image = "rbxassetid://137046122108742",
            ScaleType = Enum.ScaleType.Fit
        });
    end;

    if v150 then
        local math_floor_ret = math.floor(Current.Candy);
        icon(extra("Candy", Color3_fromRGB_ret6, "+" .. tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""), "CANDY CORN"), "ImageLabel", {
            Image = require(Parent.Game.CandyCorn).Icon,
            ScaleType = Enum.ScaleType.Fit
        });
    end;

    if v151 then
        local Color3_fromRGB_ret11 = Color3.fromRGB(255, 210, 90);
        local math_floor_ret = math.floor(Current.Keys);
        icon(extra("Keys", Color3_fromRGB_ret11, "+" .. tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""), "GHOST KEYS"), "ImageLabel", {
            Image = require(Parent.Game.GhostTraderConfig).KeyIcon,
            ScaleType = Enum.ScaleType.Fit
        });
    end;

    local v183;

    if Current.Item then
        local math_floor_ret = math.floor(Current.ItemCount);
        v183 = icon(extra("Peels", Color3_fromRGB_ret4, "+" .. tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""), "BANANA PEELS"), "ViewportFrame", {
            LightDirection = Vector3.new(-1, -1, -1),
            Ambient = Color3.fromRGB(210, 210, 210),
            LightColor = Color3_new_ret
        });
    else
        v183 = nil;
    end;

    local v184 = {};

    for i, v in { "Equip", "Swing", "Hit" } do
        local v185 = {
            Text = "",
            AutoButtonColor = true,
            Name = v .. "Sound",
            BackgroundColor3 = Color3_fromRGB_ret2
        };
        local TextButton2 = Instance.new("TextButton");
        local v186 = v;

        for i2, v2 in v185 do
            TextButton2[i2] = v2;
        end;

        TextButton2.Parent = Frame;
        local Vector2_new_ret9 = Vector2.new(0, 0.5);
        TextButton2.Position = UDim2.fromScale(0.035 + (i - 1) * 0.175, 0.895);
        TextButton2.Size = UDim2.fromScale(0.16, 0.09);
        TextButton2.AnchorPoint = Vector2_new_ret9 or Vector2.zero;
        local v187 = {
            CornerRadius = UDim.new(0.3, 0) or UDim.new(0.08, 0)
        };
        local UICorner5 = Instance.new("UICorner");

        for i2, v2 in v187 do
            UICorner5[i2] = v2;
        end;

        UICorner5.Parent = TextButton2;
        local v188 = {
            Thickness = 1.5,
            Color = v123,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        };
        local UIStroke5 = Instance.new("UIStroke");

        for i2, v2 in v188 do
            UIStroke5[i2] = v2;
        end;

        UIStroke5.Parent = TextButton2;
        local v189 = {
            Name = "Icon",
            BackgroundTransparency = 1,
            Image = "rbxassetid://131542353379801",
            ScaleType = Enum.ScaleType.Fit
        };
        local ImageLabel2 = Instance.new("ImageLabel");

        for i2, v2 in v189 do
            ImageLabel2[i2] = v2;
        end;

        ImageLabel2.Parent = TextButton2;
        local Vector2_new_ret10 = Vector2.new(0, 0.5);
        ImageLabel2.Position = UDim2.fromScale(0.1, 0.5);
        ImageLabel2.Size = UDim2.fromScale(0.2, 0.6);
        ImageLabel2.AnchorPoint = Vector2_new_ret10 or Vector2.zero;
        local v190 = text(TextButton2, "Label", v186 == "Equip" and "DRAW" or string.upper(v186), Color3_new_ret, Enum.FontWeight.ExtraBold, {
            TextXAlignment = Enum.TextXAlignment.Left
        });
        local Vector2_new_ret11 = Vector2.new(0, 0.5);
        v190.Position = UDim2.fromScale(0.36, 0.5);
        v190.Size = UDim2.fromScale(0.56, 0.52);
        v190.AnchorPoint = Vector2_new_ret11 or Vector2.zero;
        v184[TextButton2] = v186;
    end;

    local v191 = {
        Name = "Buy",
        Text = "",
        AutoButtonColor = true,
        BackgroundColor3 = Color3_new_ret
    };
    local TextButton2 = Instance.new("TextButton");

    for i, v in v191 do
        TextButton2[i] = v;
    end;

    TextButton2.Parent = Frame;
    local Vector2_new_ret9 = Vector2.new(0, 0.5);
    TextButton2.Position = UDim2.fromScale(0.575, 0.895);
    TextButton2.Size = UDim2.fromScale(0.39, 0.115);
    TextButton2.AnchorPoint = Vector2_new_ret9 or Vector2.zero;
    local v192 = {
        CornerRadius = UDim.new(0.3, 0) or UDim.new(0.08, 0)
    };
    local UICorner5 = Instance.new("UICorner");

    for i, v in v192 do
        UICorner5[i] = v;
    end;

    UICorner5.Parent = TextButton2;
    local v193 = {
        Thickness = 2.5,
        Color = Color3_new_ret2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke5 = Instance.new("UIStroke");

    for i, v in v193 do
        UIStroke5[i] = v;
    end;

    UIStroke5.Parent = TextButton2;
    local v194 = {
        Rotation = 90,
        Color = ColorSequence_new_ret
    };
    local UIGradient2 = Instance.new("UIGradient");

    for i, v in v194 do
        UIGradient2[i] = v;
    end;

    UIGradient2.Parent = TextButton2;
    local v195 = text(TextButton2, "Label", "", Color3_new_ret, Enum.FontWeight.Heavy);
    local Vector2_new_ret10 = Vector2.new(0.5, 0.5);
    v195.Position = UDim2.fromScale(0.5, 0.5);
    v195.Size = UDim2.fromScale(0.86, 0.62);
    v195.AnchorPoint = Vector2_new_ret10 or Vector2.zero;
    local v196 = {
        Name = "Gift",
        Text = "",
        Visible = false,
        BackgroundColor3 = Color3_new_ret
    };
    local TextButton3 = Instance.new("TextButton");

    for i, v in v196 do
        TextButton3[i] = v;
    end;

    TextButton3.Parent = Frame;
    local Vector2_new_ret11 = Vector2.new(0, 0.5);
    TextButton3.Position = UDim2.fromScale(0.893125, 0.895);
    TextButton3.Size = UDim2.fromScale(0.071875, 0.115);
    TextButton3.AnchorPoint = Vector2_new_ret11 or Vector2.zero;
    local v197 = {
        CornerRadius = UDim.new(0.3, 0) or UDim.new(0.08, 0)
    };
    local UICorner6 = Instance.new("UICorner");

    for i, v in v197 do
        UICorner6[i] = v;
    end;

    UICorner6.Parent = TextButton3;
    local v198 = {
        Thickness = 2.5,
        Color = Color3_new_ret2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke6 = Instance.new("UIStroke");

    for i, v in v198 do
        UIStroke6[i] = v;
    end;

    UIStroke6.Parent = TextButton3;
    local v199 = {
        Rotation = 90,
        Color = ColorSequence_new_ret2
    };
    local UIGradient3 = Instance.new("UIGradient");

    for i, v in v199 do
        UIGradient3[i] = v;
    end;

    UIGradient3.Parent = TextButton3;
    local v200 = {
        Name = "Icon",
        BackgroundTransparency = 1,
        Image = GiftClient.ICON,
        ScaleType = Enum.ScaleType.Fit
    };
    local ImageLabel2 = Instance.new("ImageLabel");

    for i, v in v200 do
        ImageLabel2[i] = v;
    end;

    ImageLabel2.Parent = TextButton3;
    local Vector2_new_ret12 = Vector2.new(0.5, 0.5);
    ImageLabel2.Position = UDim2.fromScale(0.5, 0.5);
    ImageLabel2.Size = UDim2.fromScale(0.66, 0.66);
    ImageLabel2.AnchorPoint = Vector2_new_ret12 or Vector2.zero;
    local u201 = {
        gui = ScreenGui,
        timer = v133,
        buy = TextButton2,
        buyFill = UIGradient2,
        buyText = v195,
        gift = TextButton3,
        giftFill = UIGradient3,
        glow = ImageLabel,
        connections = {},
        views = {},
        poses = {},
        floaters = v140
    };

    if v122 then
        v122 = script_Parent.Models:FindFirstChild(v122.Model);
    end;

    local v202;

    if v122 then
        v202 = v122:FindFirstChild("Blade") or v122:FindFirstChildWhichIsA("MeshPart", true);
    else
        v202 = v122;
    end;

    if v202 then
        local views = u201.views;
        local v203 = turntable(ViewportFrame, v202, v122:GetAttribute("PreviewRotation") or CFrame_Angles_ret, 0.1);
        table.insert(views, v203);
    end;

    local v204;

    if v183 then
        v204 = Parent.Gear.Assets:FindFirstChild(Current.Item);
    else
        v204 = v183;
    end;

    if v204 and v204:IsA("BasePart") then
        local views = u201.views;
        local v205 = turntable(v183, v204, CFrame.identity, 0.6);
        table.insert(views, v205);
    end;

    if u177 then
        u177 = EmotePose.new(u177, u148.Id);
    end;

    if u177 then
        table.insert(u201.poses, u177);
        task.spawn(function() -- Line: 703
            -- upvalues: u177 (copy), CharacterClone (ref)
            for i = 1, 75 do
                if u177.destroyed then
                    return;
                end;

                if u177.clone and (CharacterClone.dressed(u177.clone) and u177:play()) then
                    return;
                end;

                task.wait(0.2);
                local _ = i;
            end;
        end);
    end;

    table.insert(u201.connections, TextButton.Activated:Connect(function() -- Line: 715
        -- upvalues: u1 (ref)
        u1.close();
    end));
    local PresentationCues = Parent.Audio:WaitForChild("PresentationCues");

    for i, v in v184 do
        table.insert(u201.connections, i.Activated:Connect(function() -- Line: 720
            -- upvalues: PresentationCues (copy), Current (ref), v (copy)
            PresentationCues:Fire("KnifePreview", Current.SkinId, v);
        end));
    end;

    if v178 then
        local u206 = nil;
        table.insert(u201.connections, v178.Activated:Connect(function() -- Line: 727
            -- upvalues: u206 (ref), abilityCard (ref), Frame (copy), u147 (copy), Current (ref), sound (ref)
            if u206 then
                u206.Visible = true;
            else
                u206 = abilityCard(Frame, u147, Current.AbilityIcon or u147.IconImage);
            end;

            sound("PanelOpen");
        end));
    end;

    table.insert(u201.connections, TextButton3.Activated:Connect(function() -- Line: 736
        -- upvalues: u201 (copy), sound (ref), GiftClient (ref), Current (ref)
        if u201.giftLive then
            sound("Click");
            GiftClient.open(Current.Key);
        end;
    end));
    table.insert(u201.connections, GiftClient.changed:Connect(function() -- Line: 743
        -- upvalues: paint (ref), u201 (copy)
        paint(u201);
    end));

    if v176 then
        table.insert(u201.connections, v176.Activated:Connect(function() -- Line: 748
            -- upvalues: PresentationCues (copy), Current (ref), u148 (copy)
            PresentationCues:Fire("KnifePreview", Current.SkinId, "Emote:" .. u148.Id);
        end));
    end;

    table.insert(u201.connections, TextButton2.Activated:Connect(function() -- Line: 752
        -- upvalues: offer (ref), LocalPlayer (ref), u201 (copy), sound (ref), u2 (ref), ArmoryEvent (ref), Current (ref), MarketplaceService (ref), productNow (ref)
        local _, v207 = offer(workspace:GetServerTimeNow());

        if not v207 or LocalPlayer:GetAttribute("GiftOpen") ~= nil then
            return;
        end;

        u201.buying = true;
        sound("Click");

        if u2 then
            ArmoryEvent:FireServer("BundleSource", Current.Key, u2);
        end;

        local success, result = pcall(MarketplaceService.PromptProductPurchase, MarketplaceService, LocalPlayer, productNow());

        if not success then
            warn("[" .. Current.Key .. "] purchase prompt failed: " .. tostring(result));
        end;
    end));
    local u208 = 0;
    table.insert(u201.connections, RunService.RenderStepped:Connect(function(p209) -- Line: 770
        -- upvalues: u201 (copy), u3 (ref), u1 (ref), teardown (ref), u208 (ref), paint (ref)
        if not u201.gui.Parent then
            if u3 == u201 then
                u1.close();

                return;
            end;

            teardown(u201);

            return;
        end;

        for _, v in u201.views do
            v.angle = v.angle + p209 * 0.6;
            local extent = v.extent;
            local camera = v.camera;
            local CFrame_lookAt = CFrame.lookAt;
            local v210 = math.sin(v.angle) * extent * 2;
            local v211 = v.height * extent;
            local v212 = math.cos(v.angle) * extent * 2;
            camera.CFrame = CFrame_lookAt(Vector3.new(v210, v211, v212), Vector3.new(0, 0, 0));
        end;

        u201.glow.Rotation = (u201.glow.Rotation + p209 * 12) % 360;
        local os_clock_ret = os.clock();

        for _, v in u201.floaters do
            v.t = (v.t + p209 * v.speed) % 1;
            v.image.Position = UDim2.fromScale(v.x + math.sin(os_clock_ret * 1.3 + v.phase) * v.sway, 1.08 - v.t * 1.16);
            local image = v.image;
            local v213 = 1 - math.min(v.t, 1 - v.t) * 6;
            image.ImageTransparency = math.max(0, v213) * 0.85 + 0.15;
        end;

        u208 = u208 + p209;

        if u208 >= 0.25 then
            u208 = 0;
            paint(u201);
        end;
    end));

    return u201;
end;

function u1.open(p214, p215, p216) -- Line: 803
    -- upvalues: u3 (ref), Bundles (copy), LocalPlayer (copy), u2 (ref), Current (ref), u4 (ref), u5 (ref), u6 (ref), u9 (ref), build (copy), sound (copy), ArmoryEvent (copy), u7 (ref), u8 (ref), MarketplaceService (copy), paint (copy), u1 (copy)
    if u3 then
        return;
    end;

    local v217 = type(p215) == "string" and p215 and p215 or Bundles.Current.Key;
    local v218 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if v218 then
        v218 = v218:FindFirstChild("BundleShowcase");
    end;

    local v219 = v218 and (v218:IsA("ScreenGui") and v218.Enabled) and v218:FindFirstChild("Open");

    if v219 and (v219:IsA("BindableEvent") and v218:GetAttribute("Ready") == true) then
        local table_find = table.find;
        local string_split = string.split;
        local v220 = v218:GetAttribute("Bundles") or "";

        if table_find(string_split(tostring(v220), ","), v217) then
            v219:Fire(v217, p216);

            return;
        end;
    end;

    if p216 ~= "3d_display" and p216 ~= "shop_ui" then
        p216 = nil;
    end;

    u2 = p216;
    local v221 = type(p215) == "string" and Bundles.get(p215) or Bundles.Current;

    if v221 ~= Current then
        Current = v221;
        u4 = nil;
        u5 = false;
        u6 = false;
        u9 = false;
    end;

    local v222 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if not v222 then
        return;
    end;

    if p214 == true then
        u6 = true;
    end;

    u3 = build(v222);
    LocalPlayer:SetAttribute("BundleOfferOpen", true);
    sound("PanelOpen");
    local u223 = u3;
    table.insert(u223.connections, ArmoryEvent.OnClientEvent:Connect(function(p224, p225) -- Line: 841
        -- upvalues: u6 (ref), Bundles (ref), Current (ref), u7 (ref), u5 (ref), u8 (ref), u4 (ref), MarketplaceService (ref), u3 (ref), paint (ref), u9 (ref), u223 (copy)
        if p224 == "State" and (type(p225) == "table" and p225.loaded) then
            u6 = Bundles.purchased(Current, p225);
            u7 = p225;

            if not (u5 or (u8 == nil or Bundles.productId(Current, u7) == u8)) then
                u4 = nil;

                if u4 == nil and not u5 then
                    u5 = true;
                    local u226 = Bundles.productId(Current, u7);
                    u8 = u226;
                    task.spawn(function() -- Line: 222
                        -- upvalues: MarketplaceService (ref), u226 (copy), u5 (ref), u4 (ref), Current (ref), u3 (ref), paint (ref)
                        local success, result = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, u226, Enum.InfoType.Product);
                        u5 = false;
                        u4 = success and result and result or false;

                        if not success then
                            warn("[" .. Current.Key .. "] price unavailable: " .. tostring(result));
                        end;

                        if u3 then
                            paint(u3);
                        end;
                    end);
                end;
            end;

            if u6 then
                u9 = false;
            end;

            paint(u223);
        end;
    end));
    table.insert(u223.connections, MarketplaceService.PromptProductPurchaseFinished:Connect(function(p227, p228, p229) -- Line: 857
        -- upvalues: LocalPlayer (ref), Bundles (ref), Current (ref), u6 (ref), u223 (copy), u9 (ref), paint (ref)
        if p227 == LocalPlayer.UserId and (Bundles.byProduct(p228) == Current and (p229 and (not u6 and u223.buying))) then
            u9 = true;
            paint(u223);
        end;
    end));
    local connections = u223.connections;
    local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("InMatch");
    table.insert(connections, AttributeChangedSignal:Connect(function() -- Line: 864
        -- upvalues: LocalPlayer (ref), u1 (ref)
        if LocalPlayer:GetAttribute("InMatch") == true then
            u1.close();
        end;
    end));

    if u4 == nil and not u5 then
        u5 = true;
        local u230 = Bundles.productId(Current, u7);
        u8 = u230;
        task.spawn(function() -- Line: 222
            -- upvalues: MarketplaceService (ref), u230 (copy), u5 (ref), u4 (ref), Current (ref), u3 (ref), paint (ref)
            local success, result = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, u230, Enum.InfoType.Product);
            u5 = false;
            u4 = success and result and result or false;

            if not success then
                warn("[" .. Current.Key .. "] price unavailable: " .. tostring(result));
            end;

            if u3 then
                paint(u3);
            end;
        end);
    end;

    paint(u223);
    ArmoryEvent:FireServer("Get");
end;

function u1.close() -- Line: 874
    -- upvalues: u3 (ref), teardown (copy), LocalPlayer (copy), sound (copy)
    local v231 = u3;

    if not v231 then
        return;
    end;

    u3 = nil;
    teardown(v231);
    LocalPlayer:SetAttribute("BundleOfferOpen", nil);
    sound("PanelClose");
end;

function u1.isOpen() -- Line: 885
    -- upvalues: u3 (ref)
    return u3 ~= nil;
end;

return u1;