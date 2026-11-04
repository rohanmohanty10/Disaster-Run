 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Styles = require(ReplicatedStorage.Shared.Tables.Styles);
local Rarities = require(ReplicatedStorage.Shared.Tables.Rarities);
local u1 = { Font.fromName("Oswald", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Font.fromId(12187373592, Enum.FontWeight.Bold, Enum.FontStyle.Normal) };

local function getOrCreateScale(p2: userdata) -- Line: 66
    local v3 = p2:FindFirstChildOfClass("UIScale");

    if not v3 then
        v3 = Instance.new("UIScale");
        v3.Scale = 1;
        v3.Parent = p2;
    end;

    return v3;
end;

local function getOrCreateGradient(p4: userdata) -- Line: 78
    local v5 = p4:FindFirstChildOfClass("UIGradient");

    if not v5 then
        v5 = Instance.new("UIGradient");
        v5.Parent = p4;
    end;

    return v5;
end;

local function resetEntryGradient(p6: userdata) -- Line: 89
    local v7 = p6:FindFirstChildOfClass("UIGradient");

    if not v7 then
        v7 = Instance.new("UIGradient");
        v7.Parent = p6;
    end;

    v7.Offset = Vector2.new(0, 0);
    v7.Rotation = 0;
    v7.Transparency = NumberSequence.new(0);
end;

return function(p8, p9) -- Line: 97, Name: PlayCutsceneCircle
    -- upvalues: TweenService (copy), Styles (copy), RunService (copy), u1 (copy), Rarities (copy)
    local Main = p8:WaitForChild("Main");
    local Template = Main:WaitForChild("Template");
    local Reveal = Main:WaitForChild("Reveal");
    local UIStroke = Reveal:WaitForChild("UIStroke");
    local TextFrame = Main:WaitForChild("TextFrame");
    local LettersFrame = TextFrame:WaitForChild("LettersFrame");
    local u10 = {};
    local u11 = nil;
    local u12 = {};
    local u13 = nil;
    local u14 = 0;
    local u15 = false;
    local u16 = 0;
    local u17 = false;
    p8.Destroying:Connect(function() -- Line: 119, Name: cleanup
        -- upvalues: u17 (ref), u11 (ref), u13 (ref)
        if u17 then
            return;
        end;

        u17 = true;

        if u11 then
            u11:Disconnect();
            u11 = nil;
        end;

        if u13 then
            u13:Disconnect();
            u13 = nil;
        end;
    end);
    Reveal.Visible = false;
    Reveal.TextTransparency = 1;
    Reveal.TextStrokeTransparency = 1;
    UIStroke.Transparency = 1;
    Template.Visible = false;

    for _, child in ipairs(LettersFrame:GetChildren()) do
        if child:IsA("Frame") then
            local Letter = child:FindFirstChild("Letter");

            if Letter and Letter:IsA("TextLabel") then
                local v18 = Letter:FindFirstChildOfClass("UIStroke");
                local Random_new_ret = Random.new(child.LayoutOrder * 7919 + #u12 * 3571);
                local v19 = {
                    Frame = child,
                    TextLabel = Letter,
                    Stroke = v18,
                    LayoutOrder = child.LayoutOrder,
                    BasePosition = Letter.Position,
                    BaseRotation = Letter.Rotation,
                    FloatSpeed = Random_new_ret:NextNumber(0.9, 1.5),
                    FloatPhase = Random_new_ret:NextNumber(0, 6.283185307179586),
                    RotationPhase = Random_new_ret:NextNumber(0, 6.283185307179586),
                    FloatMultiplier = Random_new_ret:NextNumber(0.7, 1),
                    RotationMultiplier = Random_new_ret:NextNumber(0.6, 1),
                    CurrentFontIndex = Random_new_ret:NextInteger(1, 2),
                    NextFontChange = Random_new_ret:NextNumber(0.6, 1.8)
                };
                table.insert(u12, v19);
                Letter.TextTransparency = 1;

                if v18 then
                    v18.Transparency = 1;
                end;
            end;
        end;
    end;

    table.sort(u12, function(p20, p21) -- Line: 189
        return p20.LayoutOrder < p21.LayoutOrder;
    end);

    local function animateGradientErase(u22: any, p23: number) -- Line: 193
        -- upvalues: TweenService (ref)
        task.delay(p23, function() -- Line: 194
            -- upvalues: u22 (copy), TweenService (ref)
            local Gui = u22.Gui;

            if not (Gui and Gui.Parent) then
                return;
            end;

            u22.IsHovered = false;
            u22.IsErasing = true;

            if u22.ScaleTween then
                u22.ScaleTween:Cancel();
                u22.ScaleTween = nil;
            end;

            local v24 = {
                UDim2.fromScale(0.12, 0),
                UDim2.fromScale(-0.12, 0),
                UDim2.fromScale(0, 0.12),
                UDim2.fromScale(0, -0.12)
            };
            local v25 = v24[math.random(1, #v24)];
            local UDim2_new_ret = UDim2.new(Gui.Position.X.Scale + v25.X.Scale, Gui.Position.X.Offset, Gui.Position.Y.Scale + v25.Y.Scale, Gui.Position.Y.Offset);
            local v26 = TweenService:Create(Gui, TweenInfo.new(0.55, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                GroupTransparency = 1,
                Position = UDim2_new_ret,
                Rotation = Gui.Rotation + math.random(-8, 8)
            });
            local v27 = TweenService:Create(u22.EntryScale, TweenInfo.new(0.55, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                Scale = u22.EntryScale.Scale * 0.8
            });
            u22.ScaleTween = v27;
            v26:Play();
            v27:Play();
            v26.Completed:Once(function() -- Line: 246
                -- upvalues: u22 (ref), Gui (copy)
                u22.ScaleTween = nil;

                if Gui.Parent then
                    Gui.Visible = false;
                end;
            end);
        end);
    end;

    local function focusEntry(p28) -- Line: 256
        -- upvalues: u16 (ref), u10 (copy), TweenService (ref)
        u16 = u16 + 1;

        for _, v in ipairs(u10) do
            if v.Gui and (v.Gui.Parent and not (v.IsErasing or v.IsWinner)) then
                if v.FocusTween then
                    v.FocusTween:Cancel();
                end;

                v.FocusTween = TweenService:Create(v.Gui, TweenInfo.new(0.22, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    GroupTransparency = v == p28 and 0 or 0.325
                });
                v.FocusTween:Play();
            end;
        end;
    end;

    local function clearEntryFocus() -- Line: 278
        -- upvalues: u16 (ref), u10 (copy), TweenService (ref)
        u16 = u16 + 1;

        for _, v in ipairs(u10) do
            if v.Gui and (v.Gui.Parent and not (v.IsErasing or v.IsWinner)) then
                if v.FocusTween then
                    v.FocusTween:Cancel();
                end;

                v.FocusTween = TweenService:Create(v.Gui, TweenInfo.new(0.22, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    GroupTransparency = 0
                });
                v.FocusTween:Play();
            end;
        end;
    end;

    local function selectEntry(u29) -- Line: 298
        -- upvalues: u15 (ref), u16 (ref), u11 (ref), u14 (ref), u12 (copy), TweenService (ref), u13 (ref), TextFrame (copy), u10 (copy), Reveal (copy), Styles (ref), UIStroke (copy)
        if u15 then
            return;
        end;

        if not (u29 and (u29.Gui and u29.Gui.Parent)) then
            return;
        end;

        u15 = true;
        u16 = u16 + 1;

        if u11 then
            u11:Disconnect();
            u11 = nil;
        end;

        u14 = u14 + 1;
        local u30 = u14;

        for i, v in ipairs(u12) do
            task.delay((i - 1) * 0.035, function() -- Line: 321
                -- upvalues: u30 (copy), u14 (ref), v (copy), TweenService (ref), i (copy), u12 (ref), u13 (ref), TextFrame (ref)
                if u30 ~= u14 then
                    return;
                end;

                if not (v.TextLabel and v.TextLabel.Parent) then
                    return;
                end;

                local v31 = TweenService:Create(v.TextLabel, TweenInfo.new(0.18, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                    TextTransparency = 1
                });
                v31:Play();

                if v.Stroke then
                    TweenService:Create(v.Stroke, TweenInfo.new(0.18, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        Transparency = 1
                    }):Play();
                end;

                if i == #u12 then
                    v31.Completed:Once(function() -- Line: 347
                        -- upvalues: u30 (ref), u14 (ref), u13 (ref), u12 (ref), TextFrame (ref)
                        if u30 ~= u14 then
                            return;
                        end;

                        if u13 then
                            u13:Disconnect();
                            u13 = nil;
                        end;

                        for _, v2 in ipairs(u12) do
                            if v2.Frame and v2.Frame.Parent then
                                v2.Frame.Position = v2.BasePosition;
                                v2.Frame.Rotation = v2.BaseRotation;
                            end;
                        end;

                        TextFrame.Visible = false;
                    end);
                end;
            end);
        end;

        u29.IsWinner = true;
        u29.IsHovered = false;
        u29.IsErasing = false;

        for _, v in ipairs(u10) do
            if v.Container then
                v.Container.Active = false;
                v.Container.Interactable = false;
            end;

            v.IsHovered = false;

            if v.ScaleTween then
                v.ScaleTween:Cancel();
                v.ScaleTween = nil;
            end;
        end;

        u29.Gui.ZIndex = 100;

        for _, descendant in ipairs(u29.Gui:GetDescendants()) do
            if descendant:IsA("GuiObject") then
                descendant.ZIndex = descendant.ZIndex + 100;
            end;
        end;

        local v32 = 0;

        for _, v in ipairs(u10) do
            if v ~= u29 then
                v32 = v32 + 1;
                task.delay((v32 - 1) * 0.035, function() -- Line: 194
                    -- upvalues: v (copy), TweenService (ref)
                    local Gui = v.Gui;

                    if not (Gui and Gui.Parent) then
                        return;
                    end;

                    v.IsHovered = false;
                    v.IsErasing = true;

                    if v.ScaleTween then
                        v.ScaleTween:Cancel();
                        v.ScaleTween = nil;
                    end;

                    local v33 = {
                        UDim2.fromScale(0.12, 0),
                        UDim2.fromScale(-0.12, 0),
                        UDim2.fromScale(0, 0.12),
                        UDim2.fromScale(0, -0.12)
                    };
                    local v34 = v33[math.random(1, #v33)];
                    local UDim2_new_ret = UDim2.new(Gui.Position.X.Scale + v34.X.Scale, Gui.Position.X.Offset, Gui.Position.Y.Scale + v34.Y.Scale, Gui.Position.Y.Offset);
                    local v35 = TweenService:Create(Gui, TweenInfo.new(0.55, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                        GroupTransparency = 1,
                        Position = UDim2_new_ret,
                        Rotation = Gui.Rotation + math.random(-8, 8)
                    });
                    local v36 = TweenService:Create(v.EntryScale, TweenInfo.new(0.55, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                        Scale = v.EntryScale.Scale * 0.8
                    });
                    v.ScaleTween = v36;
                    v35:Play();
                    v36:Play();
                    v35.Completed:Once(function() -- Line: 246
                        -- upvalues: v (ref), Gui (copy)
                        v.ScaleTween = nil;

                        if Gui.Parent then
                            Gui.Visible = false;
                        end;
                    end);
                end);
            end;
        end;

        local v37 = TweenService:Create(u29.Gui, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
            Rotation = 0,
            Position = UDim2.fromScale(0.5, 0.5)
        });
        local v38 = TweenService:Create(u29.EntryScale, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Scale = 1.25
        });
        local v39 = TweenService:Create(u29.ContainerScale, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Scale = 1
        });
        u29.ScaleTween = v38;
        v37:Play();
        v38:Play();
        v39:Play();
        v37.Completed:Once(function() -- Line: 430
            -- upvalues: u29 (copy), Reveal (ref), Styles (ref), TweenService (ref), UIStroke (ref)
            if not u29.Gui.Parent then
                return;
            end;

            Reveal.Visible = true;
            Reveal.Text = (u29.Style == "LukaDoncic" and "LUKA DONČIĆ" or string.upper(Styles.Styles[u29.Style].UIName or Styles.Styles[u29.Style].Name)) .. " STYLE CONFIRMED";
            local TweenInfo_new_ret = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            TweenService:Create(Reveal, TweenInfo_new_ret, {
                TextTransparency = 0,
                TextStrokeTransparency = 0
            }):Play();
            TweenService:Create(UIStroke, TweenInfo_new_ret, {
                Transparency = 0
            }):Play();
            u29.ScaleTween = nil;
            local v40 = TweenService:Create(u29.EntryScale, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Scale = 1.35
            });
            local u41 = TweenService:Create(u29.EntryScale, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = 1.25
            });
            u29.ScaleTween = v40;
            v40:Play();
            v40.Completed:Once(function() -- Line: 464
                -- upvalues: u29 (ref), u41 (copy), TweenService (ref), Reveal (ref)
                if not u29.Gui.Parent then
                    return;
                end;

                u29.ScaleTween = u41;
                u41:Play();
                u41.Completed:Once(function() -- Line: 472
                    -- upvalues: u29 (ref), TweenService (ref), Reveal (ref)
                    u29.ScaleTween = nil;
                    TweenService:Create(u29.Gui, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        GroupTransparency = 1
                    }):Play();
                    TweenService:Create(Reveal, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        TextTransparency = 1
                    }):Play();
                    TweenService:Create(Reveal.UIStroke, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        Transparency = 1
                    }):Play();
                end);
            end);
        end);
    end;

    u14 = u14 + 1;
    local u42 = 0;
    u13 = RunService.RenderStepped:Connect(function(p43) -- Line: 500
        -- upvalues: u42 (ref), u12 (copy), u1 (ref)
        u42 = u42 + p43;

        for _, v in ipairs(u12) do
            local TextLabel = v.TextLabel;

            if TextLabel and TextLabel.Parent then
                local v44 = u42 * v.FloatSpeed;

                if v.NextFontChange and u42 >= v.NextFontChange then
                    v.CurrentFontIndex = v.CurrentFontIndex % #u1 + 1;
                    TextLabel.FontFace = u1[v.CurrentFontIndex];
                    v.NextFontChange = u42 + 0.6 + math.random() * 1.2000000000000002;
                end;

                local v45 = math.sin(v44 + v.FloatPhase) * 0.036 * v.FloatMultiplier;
                local v46 = math.sin(v44 * 0.47 + v.RotationPhase) * 0.036 * 0.25;
                TextLabel.Position = UDim2.new(v.BasePosition.X.Scale, v.BasePosition.X.Offset, v.BasePosition.Y.Scale + v45 + v46, v.BasePosition.Y.Offset);
                TextLabel.Rotation = v.BaseRotation + math.sin(v44 * 0.72 + v.RotationPhase) * 4 * v.RotationMultiplier;
            end;
        end;
    end);
    TextFrame.Visible = true;
    LettersFrame.Visible = true;

    for _, v in ipairs(u12) do
        v.Frame.Visible = true;
        v.Frame.Position = v.BasePosition;
        v.Frame.Rotation = v.BaseRotation;
        v.TextLabel.TextTransparency = 1;

        if v.Stroke then
            v.Stroke.Transparency = 1;
        end;
    end;

    local u47 = u14;

    for i, v in ipairs(u12) do
        task.delay((i - 1) * 0.035, function() -- Line: 553
            -- upvalues: u47 (copy), u14 (ref), v (copy), TweenService (ref)
            if u47 ~= u14 then
                return;
            end;

            if not (v.TextLabel and v.TextLabel.Parent) then
                return;
            end;

            TweenService:Create(v.TextLabel, TweenInfo.new(0.18, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                TextTransparency = 0
            }):Play();

            if v.Stroke then
                TweenService:Create(v.Stroke, TweenInfo.new(0.18, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Transparency = 0
                }):Play();
            end;
        end);
    end;

    local u48 = 0;
    u11 = RunService.RenderStepped:Connect(function(p49) -- Line: 583
        -- upvalues: u48 (ref), u10 (copy)
        u48 = u48 + p49;
        local math_rad_ret = math.rad(u48 * 8 * 1);

        for i = #u10, 1, -1 do
            local v50 = u10[i];
            local Gui = v50.Gui;
            local v51;

            if Gui and Gui.Parent then
                if v50.IsWinner or v50.IsErasing then
                    v51 = i;
                else
                    local v52 = u48 * v50.Speed;
                    local v53 = v50.StartAngle + math_rad_ret;

                    if v50.Sunburst and v50.Sunburst.Parent then
                        v50.Sunburst.Rotation = v50.SunburstStartRotation + u48 * 8 * v50.SunburstDirection;
                    end;

                    local v54 = math.sin(v52 + v50.RadialPhase) * 0.022 + math.sin(v52 * 0.47 + v50.SecondaryPhase) * 0.022 * 0.35;
                    local v55 = math.sin(v52 * 0.73 + v50.TangentPhase) * 0.009;
                    local v56 = 0.25 + v54;
                    local v57 = math.cos(v53) * v56;
                    local v58 = math.sin(v53) * v56;
                    local v59 = -math.sin(v53);
                    local math_cos_ret = math.cos(v53);
                    local v60 = math.sin(v52 * 1.13 + v50.HoverPhase) * 0.01;
                    Gui.Position = UDim2.fromScale(0.5 + v57 + v59 * v55, 0.5 + v58 + math_cos_ret * v55 + v60);
                    Gui.Rotation = v50.BaseRotation + math.sin(v52 * 0.92 + v50.RotationPhase) * 9 + math.sin(v52 * 0.41 + v50.SecondaryPhase) * 9 * 0.3;
                    local v61 = math.sin(v52 * 1.08 + v50.ScalePhase) * 0.05;
                    local math_sin_ret = math.sin(v53);
                    local v62 = 1 - math.abs(math_sin_ret) * 0.3;
                    local math_clamp_ret = math.clamp(v62, 0.7, 1);
                    v50.ContainerScale.Scale = math_clamp_ret * (1 + v61);

                    if v50.HasSpawned then
                        local v63 = v50.IsHovered and 1.125 or 1;
                        local v64 = 1 - math.exp(-14 * p49);
                        v50.CurrentHoverScale = v50.CurrentHoverScale + (v63 - v50.CurrentHoverScale) * v64;
                        v50.EntryScale.Scale = v50.CurrentHoverScale;
                        v51 = i;
                    else
                        v51 = i;
                    end;
                end;
            else
                table.remove(u10, i);
                v51 = i;
            end;
        end;
    end);
    local v65 = #p9;

    for i, v in ipairs(p9) do
        local u66 = Template:Clone();
        u66.Name = "CircleEntry_" .. i;
        u66.Visible = true;
        u66.GroupTransparency = 1;
        u66.AnchorPoint = Vector2.new(0.5, 0.5);
        u66.Position = UDim2.fromScale(0.5, 0.5);
        u66.Parent = Main;
        local Sunburst = u66:WaitForChild("Sunburst");
        local v67 = u66:FindFirstChildOfClass("UIGradient");

        if not v67 then
            v67 = Instance.new("UIGradient");
            v67.Parent = u66;
        end;

        v67.Offset = Vector2.new(0, 0);
        v67.Rotation = 0;
        v67.Transparency = NumberSequence.new(0);
        local Container = u66:WaitForChild("Container");
        local StyleName = Container:WaitForChild("StyleName");
        local u68 = u66:FindFirstChildOfClass("UIScale");

        if not u68 then
            u68 = Instance.new("UIScale");
            u68.Scale = 1;
            u68.Parent = u66;
        end;

        local v69 = Container:FindFirstChildOfClass("UIScale");

        if not v69 then
            v69 = Instance.new("UIScale");
            v69.Scale = 1;
            v69.Parent = Container;
        end;

        local v70 = u66:FindFirstChildOfClass("UIGradient");

        if not v70 then
            v70 = Instance.new("UIGradient");
            v70.Parent = u66;
        end;

        u68.Scale = 0.88;
        v69.Scale = 1;
        Container.ImageColor3 = Rarities.Colors[Styles.Styles[v].Rarity] or Color3.fromRGB(255, 255, 255);
        StyleName.Text = Styles.Styles[v].UIName or Styles.Styles[v].Name;
        Container.Active = true;
        Container.Interactable = true;
        Container.AutoButtonColor = false;
        local Random_new_ret = Random.new(i * 971 + v65 * 313);
        local u71 = {
            FocusTween = nil,
            IsWinner = false,
            IsErasing = false,
            IsHovered = false,
            HasSpawned = false,
            CurrentHoverScale = 1,
            ScaleTween = nil,
            Gui = u66,
            Container = Container,
            StyleName = StyleName,
            Gradient = v70,
            EntryScale = u68,
            ContainerScale = v69,
            Style = v,
            StartAngle = (i - 1) / v65 * 3.141592653589793 * 2,
            BaseRotation = Random_new_ret:NextNumber(-4, 4),
            Speed = Random_new_ret:NextNumber(0.65, 1.15),
            RadialPhase = Random_new_ret:NextNumber(0, 6.283185307179586),
            SecondaryPhase = Random_new_ret:NextNumber(0, 6.283185307179586),
            TangentPhase = Random_new_ret:NextNumber(0, 6.283185307179586),
            HoverPhase = Random_new_ret:NextNumber(0, 6.283185307179586),
            RotationPhase = Random_new_ret:NextNumber(0, 6.283185307179586),
            ScalePhase = Random_new_ret:NextNumber(0, 6.283185307179586),
            Sunburst = Sunburst,
            SunburstDirection = Random_new_ret:NextNumber() > 0.5 and 1 or -1,
            SunburstStartRotation = Sunburst.Rotation
        };
        table.insert(u10, u71);
        u71.HoverConnection = Container.MouseEnter:Connect(function() -- Line: 733
            -- upvalues: u15 (ref), u71 (copy), focusEntry (copy)
            if u15 or (not u71.HasSpawned or u71.IsErasing) then
                return;
            end;

            u71.IsHovered = true;
            focusEntry(u71);
        end);
        u71.UnhoverConnection = Container.MouseLeave:Connect(function() -- Line: 742
            -- upvalues: u71 (copy), clearEntryFocus (copy)
            u71.IsHovered = false;
            clearEntryFocus();
        end);
        u71.ActivatedConnection = Container.MouseButton1Down:Connect(function() -- Line: 747
            -- upvalues: selectEntry (copy), u71 (copy)
            selectEntry(u71);
        end);
        task.delay((i - 1) * 0.08, function() -- Line: 751
            -- upvalues: u66 (copy), TweenService (ref), u68 (copy), u71 (copy)
            if not u66.Parent then
                return;
            end;

            local v72 = TweenService:Create(u66, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                GroupTransparency = 0
            });
            local v73 = TweenService:Create(u68, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Scale = 1
            });
            u71.ScaleTween = v73;
            v72:Play();
            v73:Play();
            v73.Completed:Once(function() -- Line: 773
                -- upvalues: u66 (ref), u71 (ref)
                if not u66.Parent then
                    return;
                end;

                u71.HasSpawned = true;
                u71.CurrentHoverScale = 1;
                u71.ScaleTween = nil;
            end);
        end);
    end;

    return u10, selectEntry;
end;