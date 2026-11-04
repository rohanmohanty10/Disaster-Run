 

 

local CollectionService = game:GetService("CollectionService");
local TextService = game:GetService("TextService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local v1 = {};

function getColor(p2, p3)
    local _ = p3[#p3];
    local Value = p3[1].Value;

    for i = 1, #p3 - 1 do
        if p3[i].Time <= p2 and p2 <= p3[i + 1].Time then
            local v4 = p3[i];
            local v5 = p3[i + 1];

            return v4.Value:lerp(v5.Value, (p2 - v4.Time) / (v5.Time - v4.Time));
        end;

        local _ = i;
    end;

    return Value;
end;

local function EndDialogue(p6) -- Line: 28
    -- upvalues: TweenService (copy)
    for _, child in p6:GetChildren() do
        if child.Name == "letter" then
            child:SetAttribute("Ending", true);
            TweenService:Create(child, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                TextTransparency = 1,
                TextStrokeTransparency = 1,
                Position = child.Position + UDim2.new(0, 0, 0, 50)
            }):Play();
            game.Debris:AddItem(child, 0.5);
        end;
    end;
end;

local function CreateDialogue(p7, p8, p9, u10) -- Line: 42
    -- upvalues: LocalPlayer (copy), CollectionService (copy), TweenService (copy), EndDialogue (copy), TextService (copy)
    local v11 = p8 or LocalPlayer;
    local u12 = game.StarterGui:FindFirstChild(v11 .. "CUSTOM_DIALOGUE") or script.CUSTOM_DIALOGUE:Clone();
    local v13 = "";
    local u14 = 0;
    local u15 = 0;
    local v16 = 0;

    if p9 then
        u12.Holder.Template:FindFirstChild("Name").TextColor3 = p9.Color or Color3.new(1, 1, 1);
        u12.Holder.Template:FindFirstChild("Name").TextStrokeColor3 = p9.StrokeColor or Color3.new(0, 0, 0);
    end;

    if u12:GetAttribute("Created") then
        u12:SetAttribute("Created", os.clock());
    else
        local Template = u12:WaitForChild("Holder"):WaitForChild("Template");
        local Holder = u12.Holder;
        Holder.Position = Holder.Position - UDim2.new(0, 0, 0, #CollectionService:GetTagged("CUSTOM_DIALOGUE") * 100);
        local ImageLabel = Template:WaitForChild("ImageLabel");
        ImageLabel.Position = ImageLabel.Position - UDim2.new(0, 0, 0, 100);
        Template:WaitForChild("ImageLabel").ImageTransparency = 1;
        local Name = Template:WaitForChild("Name");
        Name.Position = Name.Position - UDim2.new(0, 0, 0, 100);
        Template:WaitForChild("Name").TextColor3 = Color3.new(0.2, 0.988235, 1);
        Template:WaitForChild("Name").TextTransparency = 1;
        Template:WaitForChild("Name").TextStrokeTransparency = 1;
        TweenService:Create(Template:WaitForChild("ImageLabel"), TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ImageTransparency = 0,
            Position = Template:WaitForChild("ImageLabel").Position + UDim2.new(0, 0, 0, 100)
        }):Play();
        TweenService:Create(Template:WaitForChild("Name"), TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            Position = Template:WaitForChild("Name").Position + UDim2.new(0, 0, 0, 100)
        }):Play();
        task.spawn(function() -- Line: 85
            -- upvalues: u12 (copy), u10 (copy), EndDialogue (ref), TweenService (ref), Template (copy)
            u12:SetAttribute("Created", os.clock());

            repeat
                task.wait();
            until (u10 or 3) < os.clock() - u12:GetAttribute("Created") or not u12.Parent;

            u12.Name = "deleting";
            EndDialogue(u12.Holder.Template);
            TweenService:Create(Template:WaitForChild("ImageLabel"), TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                ImageTransparency = 1,
                Position = Template:WaitForChild("ImageLabel").Position - UDim2.new(0, 0, 0, 100)
            }):Play();
            TweenService:Create(Template:WaitForChild("Name"), TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                TextTransparency = 1,
                TextStrokeTransparency = 1,
                Position = Template:WaitForChild("Name").Position - UDim2.new(0, 0, 0, 100)
            }):Play();
            task.delay(1, function() -- Line: 102
                -- upvalues: u12 (ref)
                u12:Destroy();
            end);
        end);
    end;

    u12.Parent = game.StarterGui;
    u12.Enabled = true;
    u12.Name = v11 .. "CUSTOM_DIALOGUE";
    u12:AddTag("CUSTOM_DIALOGUE");
    u12:WaitForChild("Holder"):WaitForChild("Template"):WaitForChild("Name").Text = v11;

    for _, v in p7 do
        print(v);
        v13 = v13 .. v.Text;
    end;

    local v17 = false;

    for _, v in p7 do
        if v.HigherUp then
            game:GetService("TweenService"):Create(u12.Holder, TweenInfo.new(0.2), {
                Position = UDim2.new(0.5, 0, 0.935, 0)
            }):Play();
            v17 = true;
        end;
    end;

    if not v17 and u12.Holder.Position ~= UDim2.new(0.5, 0, 1, 0) then
        game:GetService("TweenService"):Create(u12.Holder, TweenInfo.new(1), {
            Position = UDim2.new(0.5, 0, 1, 0)
        }):Play();
    end;

    EndDialogue(u12.Holder.Template);

    for _, v in p7 do
        local string_split_ret = string.split(v.Text, "");
        local v18 = v.Bold and Enum.Font.SourceSansBold or (v.Italic and Enum.Font.SourceSansItalic or Enum.Font.SourceSans);

        for _, v2 in string_split_ret do
            u14 = u14 + TextService:GetTextSize(v2, 25, v18, Vector2.new(100, 100)).X;
        end;
    end;

    for _, v in p7 do
        local string_split_ret = string.split(v.Text, "");
        local v19 = v.Bold and Enum.Font.SourceSansBold or (v.Italic and Enum.Font.SourceSansItalic or Enum.Font.SourceSans);
        local u20 = v;

        for _, v2 in string_split_ret do
            local TextSize = TextService:GetTextSize(v2, 25, v19, Vector2.new(100, 100));
            local TextLabel = Instance.new("TextLabel");
            TextLabel.AnchorPoint = Vector2.new(0, 0.5);
            TextLabel.Position = UDim2.new(0.5, u15 - u14 / 2 // 1, 0.5, 10);
            TextLabel.Size = UDim2.new(0, TextSize.X, 0, TextSize.Y);
            TextLabel.Text = v2;
            TextLabel.Name = "letter";
            TextLabel.Font = v19;
            TextLabel.TextSize = 25;
            TextLabel.Parent = u12.Holder.Template;
            TextLabel.BackgroundTransparency = 1;
            TextLabel.TextStrokeColor3 = u20.TextStrokeColor;
            TextLabel.TextStrokeTransparency = 0;
            TextLabel.TextStrokeTransparency = 1;
            TextLabel.TextTransparency = 1;
            task.delay(v16, function() -- Line: 174
                -- upvalues: u20 (copy), TextLabel (copy), u15 (copy), u14 (copy), u12 (copy)
                local os_clock_ret = os.clock();

                repeat
                    local v21 = (os.clock() - os_clock_ret) / 0.35;
                    local math_min_ret = math.min(v21, 1);
                    local v22 = (os.clock() - os_clock_ret) / u20.Shake.Lifetime;
                    local math_min_ret2 = math.min(v22, 1);
                    local v23 = not u20.Shake.Enabled and UDim2.new(0, 0, 0, 0) or UDim2.new(0, math.random(-u20.Shake.Intensity, u20.Shake.Intensity) * (1 - math_min_ret2), 0, math.random(-u20.Shake.Intensity, u20.Shake.Intensity) * (1 - math_min_ret2));
                    local v24 = 1 - (math.pow(math_min_ret - 1, 3) * 2.70158 + 1 + math.pow(math_min_ret - 1, 2) * 1.70158);
                    TextLabel.TextStrokeTransparency = (1 - math_min_ret) ^ 10;
                    TextLabel.TextTransparency = v24;
                    TextLabel.TextSize = v24 * 25 + 25;
                    TextLabel.TextColor3 = getColor(math_min_ret, u20.Color.Keypoints);
                    TextLabel.Position = UDim2.new(0.5, u15 - u14 / 2 // 1, 0.5, 0) + v23;
                    task.wait();
                until os.clock() - os_clock_ret > math.max(0.35, u20.Shake.Lifetime) or not (TextLabel and (TextLabel:IsDescendantOf(u12) and not TextLabel:GetAttribute("Ending")));

                if TextLabel then
                    TextLabel.TextStrokeTransparency = 0;
                    TextLabel.TextTransparency = 0;
                    TextLabel.TextSize = 25;
                    TextLabel.TextColor3 = u20.Color.Keypoints[#u20.Color.Keypoints].Value;
                    TextLabel.Position = UDim2.new(0.5, u15 - u14 / 2 // 1, 0.5, 0);
                end;
            end);
            v16 = v16 + u20.TypeSpeed;
            u15 = u15 + TextSize.X;
        end;
    end;
end;

function v1.Speak(p25, p26, p27) -- Line: 208
    -- upvalues: CreateDialogue (copy)
    CreateDialogue(p26, p25, p27);
end;

return v1;