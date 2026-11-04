  

local CollectionService = game:GetService("CollectionService");
local TextService = game:GetService("TextService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = game.Players.LocalPlayer;
local v1 = {};
local _ = {
    {
        Text = "This will be the ",
        Bold = false,
        Italic = false,
        TypeSpeed = 0.03,
        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 17, 17)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
        TextStrokeColor = Color3.new(0, 0, 0),
        Shake = {
            Enabled = false,
            Intensity = 1,
            Lifetime = 2
        }
    },
    {
        Text = "LAST TIME!",
        Bold = true,
        Italic = true,
        TypeSpeed = 0.04,
        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 17, 17)) }),
        TextStrokeColor = Color3.new(0, 0, 0),
        Shake = {
            Enabled = true,
            Intensity = 5,
            Lifetime = 1
        }
    }
};

local function easeOutElastic(p2, p3, p4, p5) -- Line: 47
    if p2 == p5 then
        return p3 + p4;
    end;

    return math.pow(p2 - 1, 3) * 2.70158 + 1 + math.pow(p2 - 1, 2) * 1.70158;
end;

local function getInterpolatedColor(p6, p7) -- Line: 56
    local _ = p7[#p7];
    local Value = p7[1].Value;

    for i = 1, #p7 - 1 do
        local v8 = p7[i];
        local v9 = p7[i + 1];

        if v8.Time <= p6 and p6 <= v9.Time then
            return v8.Value:lerp(v9.Value, (p6 - v8.Time) / (v9.Time - v8.Time));
        end;

        local _ = i;
    end;

    return Value;
end;

local function fadeOutLetters(p10) -- Line: 74
    -- upvalues: TweenService (copy)
    for _, child in p10:GetChildren() do
        if child.Name == "letter" then
            child:SetAttribute("Ending", true);
            TweenService:Create(child, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            game.Debris:AddItem(child, 0.5);
        end;
    end;
end;

local function normalizeSpeakerData(p11) -- Line: 88
    -- upvalues: LocalPlayer (copy)
    return p11 == nil and {
        Name = LocalPlayer.Name
    } or (typeof(p11) == "string" and {
        Name = p11
    } or (typeof(p11) == "Instance" and {
        Name = p11.Name
    } or {
        Name = p11.Name or LocalPlayer.Name,
        Icon = p11.Icon,
        NameColor = p11.NameColor
    }));
end;

local function displayDialogue(p12, p13, p14) -- Line: 115
    -- upvalues: normalizeSpeakerData (copy), LocalPlayer (copy), CollectionService (copy), TweenService (copy), fadeOutLetters (copy), TextService (copy), getInterpolatedColor (copy)
    local v15 = normalizeSpeakerData(p13);
    local u16 = p14 or 3;
    local u17 = LocalPlayer.PlayerGui:FindFirstChild(v15.Name .. "DialogueUI") or script.Dialogue:Clone();
    local v18 = "";
    local v19 = 0;
    local u20 = 0;
    local v21 = 0;

    if u17:GetAttribute("Created") then
        u17:SetAttribute("Created", os.clock());
    else
        local Template = u17:WaitForChild("Holder"):WaitForChild("Template");
        local Holder = u17.Holder;
        local Name = Template:WaitForChild("Name");
        local Icon = Template:FindFirstChild("Icon");
        local v22 = Icon and Icon:IsA("ImageLabel");

        if v22 then
            if typeof(v15.Icon) == "string" then
                v22 = v15.Icon ~= "";
            else
                v22 = false;
            end;
        end;

        Holder.Position = Holder.Position - UDim2.new(0, 0, 0, #CollectionService:GetTagged("DialogueUI") * 100);
        Name.Position = Name.Position - UDim2.new(0, 0, 0, 100);
        Name.TextTransparency = 1;
        Name.TextStrokeTransparency = 1;
        Name.Text = v15.Name;

        if Icon and Icon:IsA("ImageLabel") then
            Icon.Visible = v22;
            Icon.Image = v22 and (v15.Icon or "") or "";
            Icon.ImageTransparency = 1;
        end;

        TweenService:Create(Name, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            Position = Name.Position + UDim2.new(0, 0, 0, 100)
        }):Play();

        if v22 and Icon then
            TweenService:Create(Icon, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ImageTransparency = 0
            }):Play();
        end;

        task.spawn(function() -- Line: 157
            -- upvalues: u17 (copy), u16 (ref), fadeOutLetters (ref), Template (copy), TweenService (ref), Name (copy), Icon (copy)
            u17:SetAttribute("Created", os.clock());

            repeat
                task.wait();
            until u16 < os.clock() - u17:GetAttribute("Created") or not u17.Parent;

            u17.Name = "deleting";
            fadeOutLetters(Template);
            TweenService:Create(Name, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();

            if Icon and Icon.Visible then
                TweenService:Create(Icon, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                    ImageTransparency = 1
                }):Play();
            end;

            task.delay(1, function() -- Line: 171
                -- upvalues: u17 (ref)
                u17:Destroy();
            end);
        end);
    end;

    local Template = u17:WaitForChild("Holder"):WaitForChild("Template");
    local Name = Template:WaitForChild("Name");
    local Icon = Template:FindFirstChild("Icon");
    local v23 = Icon and Icon:IsA("ImageLabel");

    if v23 then
        if typeof(v15.Icon) == "string" then
            v23 = v15.Icon ~= "";
        else
            v23 = false;
        end;
    end;

    u17.Parent = LocalPlayer.PlayerGui;
    u17.Enabled = true;
    u17.Name = v15.Name .. "DialogueUI";
    u17:AddTag("DialogueUI");
    Name.Text = v15.Name;

    if v15.NameColor then
        Name.TextColor3 = v15.NameColor;
    end;

    if Icon and Icon:IsA("ImageLabel") then
        Icon.Visible = v23;
        Icon.Image = v23 and v15.Icon or "";
        Icon.ImageTransparency = v23 and 0 or 1;
    end;

    for _, v in p12 do
        v18 = v18 .. v.Text;
    end;

    fadeOutLetters(Template);

    for _, v in p12 do
        local string_split_ret = string.split(v.Text, "");
        local v24 = v.Bold and Enum.Font.SourceSansBold or (v.Italic and Enum.Font.SourceSansItalic or Enum.Font.SourceSans);
        local v25 = v.TextSize or 25;

        for _, v2 in string_split_ret do
            v19 = v19 + TextService:GetTextSize(v2, v25, v24, Vector2.new(100, 100)).X;
        end;
    end;

    for _, v in p12 do
        local string_split_ret = string.split(v.Text, "");
        local v26 = v.Bold and Enum.Font.SourceSansBold or (v.Italic and Enum.Font.SourceSansItalic or Enum.Font.SourceSans);
        local u27 = v.TextSize or 25;
        local u28 = v;

        for _, v2 in string_split_ret do
            local TextSize = TextService:GetTextSize(v2, u27, v26, Vector2.new(100, 100));
            local TextLabel = Instance.new("TextLabel");
            local u29 = v19 / 2;
            TextLabel.AnchorPoint = Vector2.new(0, 0.5);
            TextLabel.Position = UDim2.new(0.5, u20 - math.floor(u29), 0.5, 10);
            TextLabel.Size = UDim2.new(0, TextSize.X, 0, TextSize.Y);
            TextLabel.Text = v2;
            TextLabel.Name = "letter";
            TextLabel.Font = v26;
            TextLabel.TextSize = u27;
            TextLabel.Parent = u17.Holder.Template;
            TextLabel.BackgroundTransparency = 1;
            TextLabel.TextStrokeColor3 = u28.TextStrokeColor;
            TextLabel.TextStrokeTransparency = 1;
            TextLabel.TextTransparency = 1;
            TextLabel.ZIndex = 10;
            task.delay(v21, function() -- Line: 242
                -- upvalues: u28 (copy), TextLabel (copy), u27 (copy), getInterpolatedColor (ref), u20 (copy), u29 (copy), u17 (copy)
                local os_clock_ret = os.clock();

                repeat
                    local v30 = (os.clock() - os_clock_ret) / 0.35;
                    local math_min_ret = math.min(v30, 1);
                    local v31 = (os.clock() - os_clock_ret) / u28.Shake.Lifetime;
                    local math_min_ret2 = math.min(v31, 1);
                    local v32 = u28.Shake.Enabled and UDim2.new(0, math.random(-u28.Shake.Intensity, u28.Shake.Intensity) * (1 - math_min_ret2), 0, math.random(-u28.Shake.Intensity, u28.Shake.Intensity) * (1 - math_min_ret2)) or UDim2.new();
                    local v33 = 1 - (math_min_ret == 1 and 1 or math.pow(math_min_ret - 1, 3) * 2.70158 + 1 + math.pow(math_min_ret - 1, 2) * 1.70158);
                    TextLabel.TextStrokeTransparency = (1 - math_min_ret) ^ 10;
                    TextLabel.TextTransparency = v33;
                    TextLabel.TextSize = u27 + 25 * v33;
                    TextLabel.TextColor3 = getInterpolatedColor(math_min_ret, u28.Color.Keypoints);
                    TextLabel.Position = UDim2.new(0.5, u20 - math.floor(u29), 0.5, 0) + v32;
                    task.wait();
                until os.clock() - os_clock_ret > math.max(0.35, u28.Shake.Lifetime) or not (TextLabel and (TextLabel:IsDescendantOf(u17) and not TextLabel:GetAttribute("Ending")));

                if TextLabel then
                    TextLabel.TextStrokeTransparency = 0;
                    TextLabel.TextTransparency = 0;
                    TextLabel.TextSize = u27;
                    TextLabel.TextColor3 = u28.Color.Keypoints[#u28.Color.Keypoints].Value;
                    TextLabel.Position = UDim2.new(0.5, u20 - math.floor(u29), 0.5, 0);
                end;
            end);
            v21 = v21 + u28.TypeSpeed;
            u20 = u20 + TextSize.X;
        end;
    end;
end;

function v1.Speak(p34, p35, p36) -- Line: 275
    -- upvalues: displayDialogue (copy)
    displayDialogue(typeof(p35) == "string" and {
        {
            Bold = false,
            Italic = false,
            TypeSpeed = 0.03,
            Text = p35,
            Color = ColorSequence.new(Color3.new(1, 1, 1)),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = false,
                Intensity = 1,
                Lifetime = 0.5
            }
        }
    } or p35, p34, p36);
end;

return v1;