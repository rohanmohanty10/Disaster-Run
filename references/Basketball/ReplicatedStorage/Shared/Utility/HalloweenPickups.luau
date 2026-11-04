 
 

return function(p1, u2) -- Line: 1
    local Players = game:GetService("Players");
    local ReplicatedStorage = game:GetService("ReplicatedStorage");
    local RunService = game:GetService("RunService");
    local u3 = require(ReplicatedStorage.Shared.Utility.HalloweenPickupEffects)(p1:WaitForChild("BG"));
    local LocalPlayer = Players.LocalPlayer;
    local HalloweenCandy = workspace:WaitForChild("HalloweenCandy");
    local Halloween = require(ReplicatedStorage.Shared.Tables.Halloween);
    local CandyFrame = p1:WaitForChild("BG"):WaitForChild("CandyFrame");
    local Icon = CandyFrame:WaitForChild("Icon");
    local AmountLabel = CandyFrame:WaitForChild("AmountLabel");
    local UDim2_fromScale_ret = UDim2.fromScale(-0.25, 0);
    local Color3_fromRGB_ret = Color3.fromRGB(255, 170, 60);
    Color3.fromRGB(255, 255, 255);
    local TweenInfo_new_ret = TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    local TweenInfo_new_ret2 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
    local TweenInfo_new_ret3 = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local TweenInfo_new_ret4 = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
    local TweenInfo_new_ret5 = TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.In);
    local TweenInfo_new_ret6 = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    local TweenInfo_new_ret7 = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.In);
    local TweenInfo_new_ret8 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local u4 = {};
    local u5 = 0;
    local u6 = 0;
    local u7 = false;
    local u8 = 0;
    local u9 = 0;
    local u10 = 0;
    local Position = CandyFrame.Position;
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = u5;

    local function FormatNumber(p11) -- Line: 84
        local math_floor_ret = math.floor(p11 + 0.5);
        local v12 = tostring(math_floor_ret);
        local v13;

        repeat
            v12, v13 = v12:gsub("^(%d+)(%d%d%d)", "%1,%2");
        until v13 == 0;

        return v12;
    end;

    local function PlayPickup() -- Line: 95
        -- upvalues: u2 (copy)
        u2.PlaySound("Pickup", 0.95 + math.random() * 0.13000000000000012);
    end;

    local function PlayCandy(p14, p15) -- Line: 99
        -- upvalues: u2 (copy)
        u2.PlaySound("Candy", 1 + (p14 - 1) * 0.09 + p15);
    end;

    local function GetRoot() -- Line: 103
        -- upvalues: LocalPlayer (copy)
        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        return Character;
    end;

    local function ToScreen(p16) -- Line: 108
        -- upvalues: u3 (copy), Icon (copy)
        local v17, v18 = workspace.CurrentCamera:WorldToViewportPoint(p16);

        if v18 then
            return Vector2.new(v17.X, v17.Y) - u3.Layer.AbsolutePosition;
        end;

        return u3.Center(Icon);
    end;

    local function ShowFrame() -- Line: 115
        -- upvalues: u8 (ref), u7 (ref), u3 (copy), CandyFrame (copy), TweenInfo_new_ret6 (copy), Position (copy)
        u8 = u8 + 1;

        if u7 then
            return;
        end;

        u7 = true;
        u3.Tween(CandyFrame, TweenInfo_new_ret6, {
            Position = Position
        });
    end;

    local function ReleaseFrame() -- Line: 122
        -- upvalues: u8 (ref), u6 (ref), u7 (ref), u3 (copy), CandyFrame (copy), TweenInfo_new_ret7 (copy), Position (copy), UDim2_fromScale_ret (copy)
        u8 = u8 + 1;
        local u19 = u8;
        task.delay(1.8, function() -- Line: 126
            -- upvalues: u19 (copy), u8 (ref), u6 (ref), u7 (ref), u3 (ref), CandyFrame (ref), TweenInfo_new_ret7 (ref), Position (ref), UDim2_fromScale_ret (ref)
            if u19 ~= u8 or u6 > 0 then
                return;
            end;

            u7 = false;
            u3.Tween(CandyFrame, TweenInfo_new_ret7, {
                Position = Position + UDim2_fromScale_ret
            });
        end);
    end;

    local function Arrive(p20) -- Line: 133
        -- upvalues: u5 (ref), LocalPlayer (copy), u3 (copy), NumberValue (copy), TweenInfo_new_ret8 (copy), Icon (copy), AmountLabel (copy), CandyFrame (copy), Color3_fromRGB_ret (copy)
        u5 = LocalPlayer:GetAttribute("HalloweenCandy") or u5;
        u3.Tween(NumberValue, TweenInfo_new_ret8, {
            Value = u5
        });
        u3.Punch(Icon, 1.35);
        u3.Punch(AmountLabel, 1.15);
        u3.Punch(CandyFrame, 1.05);
        u3.Sparkles(Icon, 3, Color3_fromRGB_ret, 35);
    end;

    local function Finish(p21) -- Line: 142
        -- upvalues: u3 (copy), CandyFrame (copy), Icon (copy), Color3_fromRGB_ret (copy), AmountLabel (copy)
        u3.Punch(CandyFrame, 1.12);
        u3.Wiggle(Icon, 16, 0.5);
        u3.Ring(Icon, Color3_fromRGB_ret, 3, 5);
        u3.Sparkles(Icon, 8, nil, 70);
        u3.FloatText(CandyFrame, AmountLabel, "+" .. p21, 45, 1.2);
    end;

    local function Register(u22) -- Line: 151
        -- upvalues: u3 (copy), TweenInfo_new_ret (copy), u4 (copy), TweenInfo_new_ret5 (copy)
        if not (u22:IsA("Model") and u22.PrimaryPart) then
            return;
        end;

        local PrimaryPart = u22.PrimaryPart;
        local BillboardGui = PrimaryPart:WaitForChild("BillboardGui");
        local Holder = BillboardGui:WaitForChild("Holder");
        local Sunburst = Holder:WaitForChild("Sunburst");
        local CounterSunburst = Holder:WaitForChild("CounterSunburst");
        local Render = Holder:WaitForChild("Render");
        local u23 = {
            Collected = false,
            Part = PrimaryPart,
            Model = u22,
            Home = u22:GetAttribute("Origin") or PrimaryPart.Position,
            Born = u22:GetAttribute("Born") or workspace:GetServerTimeNow(),
            FadeProperties = {},
            Billboard = BillboardGui,
            Holder = Holder,
            HolderScale = u3.GetScale(Holder),
            Sunburst = Sunburst,
            SunScale = Sunburst:WaitForChild("UIScale"),
            Counter = CounterSunburst,
            CounterScale = CounterSunburst:WaitForChild("UIScale"),
            Render = Render,
            RenderScale = Render:WaitForChild("UIScale"),
            Phase = math.random() * 10
        };

        for _, descendant in ipairs(BillboardGui:GetDescendants()) do
            local v24 = descendant:IsA("ImageLabel") and "ImageTransparency" or (descendant:IsA("TextLabel") and "TextTransparency" or ((descendant:IsA("UIStroke") or descendant:IsA("UIShadow")) and "Transparency" or nil));

            if v24 then
                table.insert(u23.FadeProperties, {
                    Instance = descendant,
                    Property = v24,
                    Base = descendant[v24]
                });
            end;
        end;

        u23.HolderScale.Scale = 0;
        BillboardGui.Enabled = true;
        u3.Tween(u23.HolderScale, TweenInfo_new_ret, {
            Scale = 1
        });
        u4[u22] = u23;
        u22:GetAttributeChangedSignal("RemovedAt"):Connect(function() -- Line: 193
            -- upvalues: u22 (copy), u23 (copy), u3 (ref), TweenInfo_new_ret5 (ref)
            if not u22:GetAttribute("RemovedAt") then
                return;
            end;

            u23.Removing = true;
            u3.Tween(u23.HolderScale, TweenInfo_new_ret5, {
                Scale = 0
            });
        end);
    end;

    local function Collect(p25, p26, p27, p28) -- Line: 200
        -- upvalues: u6 (ref), u8 (ref), u7 (ref), u3 (copy), CandyFrame (copy), TweenInfo_new_ret6 (copy), Position (copy), u2 (copy), u10 (ref), u9 (ref), TweenInfo_new_ret3 (copy), TweenInfo_new_ret4 (copy), TweenInfo_new_ret2 (copy), Icon (copy), TweenInfo_new_ret5 (copy), PlayCandy (copy), Arrive (copy), Finish (copy), u5 (ref), LocalPlayer (copy), NumberValue (copy), TweenInfo_new_ret8 (copy), TweenInfo_new_ret7 (copy), UDim2_fromScale_ret (copy)
        if p25 and p25.Collected then
            return;
        end;

        if p25 then
            p25.Collected = true;
            p25.CollectedAt = workspace:GetServerTimeNow();
        end;

        local math_min_ret = math.min(p27, 8);
        local u29 = 0;
        u6 = u6 + 1;
        u8 = u8 + 1;

        if not u7 then
            u7 = true;
            u3.Tween(CandyFrame, TweenInfo_new_ret6, {
                Position = Position
            });
        end;

        u2.PlaySound("Pickup", 0.95 + math.random() * 0.13000000000000012);

        if os.clock() - u10 > 1.5 then
            u9 = 0;
        end;

        u10 = os.clock();
        local v30 = u9 * 0.04;
        u9 = math.min(u9 + 1, 6);

        if p25 then
            u3.Tween(p25.RenderScale, TweenInfo_new_ret3, {
                Scale = 1.5
            });
            u3.Tween(p25.SunScale, TweenInfo_new_ret4, {
                Scale = 1.9
            });
            u3.Tween(p25.CounterScale, TweenInfo_new_ret4, {
                Scale = 1.7
            });

            if p26 then
                u3.Tween(p25.Part, TweenInfo_new_ret2, {
                    Position = p25.Part.Position:Lerp(p26.Position + Vector3.new(0, 1, 0), 0.7)
                });
            end;
        end;

        task.wait(0.12);

        if p25 and p25.Part.Parent then
            p28 = p25.Part.Position or p28;
        end;

        local v31, v32 = workspace.CurrentCamera:WorldToViewportPoint(p28);
        local v33;

        if v32 then
            v33 = Vector2.new(v31.X, v31.Y) - u3.Layer.AbsolutePosition;
        else
            v33 = u3.Center(Icon);
        end;

        if p25 then
            u3.Tween(p25.HolderScale, TweenInfo_new_ret5, {
                Scale = 0
            });
        end;

        for i = 1, math_min_ret do
            task.delay((i - 1) * 0.045, PlayCandy, i, v30);
            task.spawn(u3.FlyFromPoint, "rbxassetid://137060198636418", v33, Icon, {
                StartSize = 46,
                Scatter = 55,
                Duration = 0.45,
                Delay = (i - 1) * 0.04,

                OnArrive = function() -- Line: 234, Name: OnArrive
                    -- upvalues: u29 (ref), Arrive (ref)
                    u29 = u29 + 1;
                    Arrive();
                end
            });
            local _ = i;
        end;

        local v34 = os.clock() + 3;

        while u29 < math_min_ret and os.clock() < v34 do
            task.wait();
        end;

        Finish(p27);
        u6 = u6 - 1;

        if u6 == 0 then
            u5 = LocalPlayer:GetAttribute("HalloweenCandy") or u5;
            u3.Tween(NumberValue, TweenInfo_new_ret8, {
                Value = u5
            });
        end;

        u8 = u8 + 1;
        local u35 = u8;
        task.delay(1.8, function() -- Line: 126
            -- upvalues: u35 (copy), u8 (ref), u6 (ref), u7 (ref), u3 (ref), CandyFrame (ref), TweenInfo_new_ret7 (ref), Position (ref), UDim2_fromScale_ret (ref)
            if u35 ~= u8 or u6 > 0 then
                return;
            end;

            u7 = false;
            u3.Tween(CandyFrame, TweenInfo_new_ret7, {
                Position = Position + UDim2_fromScale_ret
            });
        end);
    end;

    RunService.RenderStepped:Connect(function() -- Line: 252
        -- upvalues: LocalPlayer (copy), u4 (copy), Halloween (copy), TweenInfo_new_ret4 (copy)
        local ServerTimeNow = workspace:GetServerTimeNow();
        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        for i, v in u4 do
            local v36 = ServerTimeNow - v.Born;
            local math_clamp_ret = math.clamp(v36 / Halloween.Pickups.FadeDuration, 0, 1);
            local Attribute = i:GetAttribute("RemovedAt");

            if Attribute then
                math_clamp_ret = math.clamp((Attribute - v.Born) / Halloween.Pickups.FadeDuration, 0, 1) * (1 - math.clamp((ServerTimeNow - Attribute) / Halloween.Pickups.FadeDuration, 0, 1));
            end;

            local v37 = v;

            for _, v2 in ipairs(v.FadeProperties) do
                local v38;

                if v37.CollectedAt and (v2.Instance == v37.Sunburst or v2.Instance == v37.Counter) then
                    v38 = math_clamp_ret * (1 - math.clamp((ServerTimeNow - v37.CollectedAt) / TweenInfo_new_ret4.Time, 0, 1));
                else
                    v38 = math_clamp_ret;
                end;

                v2.Instance[v2.Property] = 1 - (1 - v2.Base) * v38;
            end;

            if not (v37.Collected or v37.Removing) then
                local v39 = v36 + v37.Phase;
                v37.Sunburst.Rotation = v39 * 25;
                v37.Counter.Rotation = v39 * -40;
                v37.SunScale.Scale = math.sin(v39 * 3) * 0.06 + 1;
                v37.CounterScale.Scale = 1 - math.sin(v39 * 3) * 0.06;
                v37.Render.Rotation = math.sin(v39 * 1.6) * 8;
                local Billboard = v37.Billboard;
                local v40 = math.sin(v39 * 2.2) * 0.35;
                Billboard.StudsOffset = Vector3.new(0, v40, 0);

                if Character then
                    local math_clamp_ret2 = math.clamp((12 - (Character.Position - v37.Part.Position).Magnitude) / 12, 0, 1);
                    v37.RenderScale.Scale = math_clamp_ret2 * 0.18 + 1;
                end;
            end;
        end;
    end);
    NumberValue.Changed:Connect(function(p41) -- Line: 291
        -- upvalues: AmountLabel (copy), FormatNumber (copy)
        AmountLabel.Text = FormatNumber(p41);
    end);
    LocalPlayer:GetAttributeChangedSignal("HalloweenCandy"):Connect(function() -- Line: 295
        -- upvalues: u5 (ref), LocalPlayer (copy), u6 (ref), u3 (copy), NumberValue (copy), TweenInfo_new_ret8 (copy)
        u5 = LocalPlayer:GetAttribute("HalloweenCandy") or 0;

        if u6 == 0 then
            u3.Tween(NumberValue, TweenInfo_new_ret8, {
                Value = u5
            });
        end;
    end);
    u5 = LocalPlayer:GetAttribute("HalloweenCandy") or 0;
    NumberValue.Value = u5;
    AmountLabel.Text = FormatNumber(u5);
    CandyFrame.Position = Position + UDim2_fromScale_ret;
    CandyFrame.Visible = true;
    HalloweenCandy.ChildAdded:Connect(Register);
    HalloweenCandy.ChildRemoved:Connect(function(p42) -- Line: 307
        -- upvalues: u4 (copy)
        u4[p42] = nil;
    end);

    for _, child in HalloweenCandy:GetChildren() do
        task.spawn(Register, child);
    end;

    return {
        Collected = function(p43, p44, p45) -- Line: 315, Name: Collected
            -- upvalues: u4 (copy), LocalPlayer (copy), Collect (copy)
            if p45 then
                p45 = u4[p45];
            end;

            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChild("HumanoidRootPart");
            end;

            if not p44 then
                if Character then
                    p44 = Character.Position;
                else
                    p44 = Character;
                end;
            end;

            if not p44 then
                return;
            end;

            task.spawn(Collect, p45, Character, p43, p44);
        end
    };
end;