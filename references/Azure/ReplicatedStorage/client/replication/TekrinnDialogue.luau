 

 

local TextService = game:GetService("TextService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local LocalPlayer = game.Players.LocalPlayer;
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local wiki = require(ReplicatedStorage.wiki);
require(ReplicatedStorage.util.KatUtil);
local v1 = {};
local u2 = nil;
local u3 = {};
local u4 = 0;
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

local function easeOutQuad(p5, p6, p7, p8) -- Line: 80
    if p5 == p8 then
        return p6 + p7;
    end;

    return math.pow(p5 - 1, 3) * 2.70158 + 1 + math.pow(p5 - 1, 2) * 1.70158;
end;

function getColor(p9, p10)
    local _ = p10[#p10];
    local Value = p10[1].Value;

    for i = 1, #p10 - 1 do
        if p10[i].Time <= p9 and p9 <= p10[i + 1].Time then
            local v11 = p10[i];
            local v12 = p10[i + 1];

            return v11.Value:lerp(v12.Value, (p9 - v11.Time) / (v12.Time - v11.Time));
        end;

        local _ = i;
    end;

    return Value;
end;

local function retireTexts(p13) -- Line: 108
    -- upvalues: TweenService (copy)
    for _, child in p13:GetChildren() do
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

local function resolvePlayerFromSpeaker(p14) -- Line: 124
    -- upvalues: Players (copy)
    if typeof(p14) ~= "Instance" then
        return nil;
    end;

    if p14:IsA("Player") then
        return p14;
    end;

    return Players:GetPlayerFromCharacter(p14);
end;

local function characterHasAccessory(p15: userdata?, p16: string) -- Line: 142
    -- upvalues: vfxUtil (copy)
    return vfxUtil.characterHasAccessory(p15, p16);
end;

local function resolveOverrideValue(p17: any, p18: userdata?) -- Line: 146
    if typeof(p17) == "function" then
        return p17(p18);
    end;

    return p17;
end;

local u21 = {
    [2447122302] = {
        name = "vera",

        icon = function(p19) -- Line: 155, Name: icon
            -- upvalues: vfxUtil (copy)
            if vfxUtil.characterHasAccessory(p19, "Pastel Blue") then
                return "rbxassetid://136220149343988";
            end;

            if vfxUtil.characterHasAccessory(p19, "Red") then
                return "rbxassetid://91021624426522";
            end;
        end,

        color = function(p20) -- Line: 163, Name: color
            -- upvalues: vfxUtil (copy)
            if vfxUtil.characterHasAccessory(p20, "Pastel Blue") then
                return ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 220, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 200, 255)) });
            end;

            if vfxUtil.characterHasAccessory(p20, "Red") then
                return ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 30, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 20, 20)) });
            end;
        end
    },
    [1549164509] = {
        icon = "rbxassetid://117964161376698",
        awkicon = "rbxassetid://90519187969299",
        color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(64, 64, 64)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(128, 128, 128)), ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200)) })
    },
    [967187368] = {
        icon = "rbxassetid://88207123448011",
        color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(219, 71, 183)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(236, 162, 191)), ColorSequenceKeypoint.new(1, Color3.fromRGB(219, 71, 183)) })
    },
    [1144804222] = {
        icon = "rbxassetid://122694363798630",
        color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(37, 37, 37)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(214, 2, 2)), ColorSequenceKeypoint.new(1, Color3.fromRGB(37, 37, 37)) })
    },
    [5639442027] = {
        icon = "rbxassetid://94488927675832",
        name = "Faith",
        color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(115, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 35, 255)) })
    },
    [1974243283] = {
        icon = "rbxassetid://104021709643547",
        name = "Vagos",
        color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(115, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 35, 255)) })
    },
    [9823387274] = {
        name = "Nights"
    },
    [260526009] = {
        icon = "rbxassetid://138785340846568",
        name = "Toast",
        color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(250, 230, 230)), ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 30, 40)) })
    },
    [5077795305] = {
        icon = "rbxassetid://79355565430841",
        name = "Geoality",
        color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 0, 127)) })
    },
    [4358080146] = {
        icon = "rbxassetid://97906908728053",
        name = "Nathan",
        color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 180, 226)), ColorSequenceKeypoint.new(1, Color3.fromRGB(230, 230, 240)) })
    },
    [387041454] = {
        icon = "rbxassetid://115066816160954",
        name = "Rain",
        color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(115, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 35, 255)) })
    },
    [103548428] = {
        icon = "rbxassetid://75654103490954",
        name = "Stephex",
        color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(115, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 35, 255)) })
    },
    [432828236] = {
        icon = "rbxassetid://85200876778522",
        name = "Top",
        color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(134, 134, 134)) })
    },
    [1102361643] = {
        icon = "rbxassetid://96641786606519",
        name = "Tanya",
        color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(39, 16, 61)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(41, 15, 56)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 27, 74)) })
    },
    [8651277689] = {
        icon = "rbxassetid://76229668295022",
        name = "Theo",
        color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
    },
    [52229617] = {
        icon = "rbxassetid://103200587031369"
    },
    [3743427133] = {
        icon = "rbxassetid://101908404969508"
    },
    [325765268] = {
        icon = "rbxassetid://99203695088249"
    },
    [4982293450] = {
        icon = "rbxassetid://100197586747282",
        name = "Divine"
    },
    [393718809] = {
        icon = "rbxassetid://138346004287764"
    }
};

local function applyNameColor(p22, p23) -- Line: 329
    local v24 = p22:FindFirstChildOfClass("UIGradient");

    if typeof(p23) ~= "ColorSequence" then
        if typeof(p23) == "Color3" then
            if v24 then
                v24:Destroy();
            end;

            p22.TextColor3 = p23;
        end;

        return;
    end;

    local v25 = v24 or Instance.new("UIGradient");
    v25.Color = p23;
    v25.Parent = p22;
    p22.TextColor3 = Color3.new(1, 1, 1);
end;

local function splitGraphemes(p26: string) -- Line: 345
    local v27 = {};

    for i, v in utf8.graphemes(p26) do
        v27[#v27 + 1] = string.sub(p26, i, v);
    end;

    return v27;
end;

local function doText(p28: table, p29: any, p30: any, p31: any, p32: any, p33: any, p34: any) -- Line: 355
    -- upvalues: LocalPlayer (copy), Players (copy), u21 (copy), UserInputService (copy), u2 (ref), u3 (copy), wiki (copy), actionUtil (copy), applyNameColor (copy), TweenService (copy), u4 (ref), retireTexts (copy), splitGraphemes (copy), TextService (copy)
    local setting = LocalPlayer:FindFirstChild("setting");

    if not (setting and (setting:FindFirstChild("subtitle") and not setting.subtitle.Value)) then
        local v35;

        if typeof(p29) == "Instance" then
            if p29:IsA("Player") then
                v35 = p29;
            else
                v35 = Players:GetPlayerFromCharacter(p29);
            end;
        else
            v35 = nil;
        end;

        local v36;

        if v35 then
            v36 = u21[v35.UserId];
        else
            v36 = v35;
        end;

        if v35 and v35:FindFirstChild("special_icon") then
            local special_icon = v35.special_icon;
            local v37 = v36 or {};
            local Attribute = special_icon:GetAttribute("icon");

            if tonumber(Attribute) then
                Attribute = `rbxassetid://{Attribute}`;
            end;

            v36 = {
                icon = Attribute or v37.icon,
                awkicon = v37.awkicon,
                name = special_icon:GetAttribute("name") or v37.name,
                color = special_icon:GetAttribute("color") or v37.color
            };
        end;

        local v38 = typeof(p29) == "Instance" and p29:GetAttribute("AIGK") and "-" or (typeof(p29) == "string" and p29 or p29.Name);

        if v36 and v36.name then
            v38 = v36.name;
        end;

        local u39 = UserInputService.TouchEnabled and 0.8 or 1;
        local u40 = p30 or 3;
        local u41 = u2;

        if not (u41 and u41.Parent) then
            u41 = script.Dialogue:Clone();
            u2 = u41;
        end;

        local v42 = not u41:GetAttribute("Created");
        local v43 = u41:GetAttribute("Ending") == true;
        local v44;

        if v42 then
            v44 = v42;
        elseif v43 then
            v44 = os.clock() - (u41:GetAttribute("EndingStarted") or os.clock()) >= 0.5;
        else
            v44 = v43;
        end;

        if not v42 then
            for _, v in u3[u41] or {} do
                v:Cancel();
            end;

            u3[u41] = nil;
        end;

        if v43 then
            u41:SetAttribute("Ending", nil);
            u41:SetAttribute("EndingStarted", nil);
        end;

        if v42 then
            u41.Holder.Size = UDim2.new(u41.Holder.Size.X.Scale * u39, u41.Holder.Size.X.Offset * u39, u41.Holder.Size.Y.Scale * u39, u41.Holder.Size.Y.Offset * u39);
        end;

        local v45 = "";
        local Template = u41:WaitForChild("Holder"):WaitForChild("Template");

        if v42 then
            local NameText = Template.NameText;
            NameText.TextSize = NameText.TextSize * u39;
            Template.ImageLabel.Size = UDim2.new(Template.ImageLabel.Size.X.Scale * u39, Template.ImageLabel.Size.X.Offset * u39, Template.ImageLabel.Size.Y.Scale * u39, Template.ImageLabel.Size.Y.Offset * u39);
            u41:SetAttribute("BaseImagePosition", Template.ImageLabel.Position);
            u41:SetAttribute("BaseNamePosition", Template.NameText.Position);
            u41:SetAttribute("BaseImageSize", Template.ImageLabel.Size);
        elseif v43 then
            for _, child in Template:GetChildren() do
                if child:IsA("TextLabel") and child.Name == "letter" then
                    child.TextTransparency = 1;
                    child.TextStrokeTransparency = 1;
                end;
            end;
        end;

        local Template2 = script.Dialogue.Holder.Template;
        Template.ImageLabel.Image = Template2.ImageLabel.Image;
        Template.ImageLabel.Visible = Template2.ImageLabel.Visible;
        Template.ImageLabel.ScaleType = Template2.ImageLabel.ScaleType;
        Template.ImageLabel.Size = u41:GetAttribute("BaseImageSize") or Template.ImageLabel.Size;
        Template.NameText.TextColor3 = Template2.NameText.TextColor3;
        local v46 = Template.NameText:FindFirstChildOfClass("UIGradient");

        if v46 then
            v46:Destroy();
        end;

        local v47 = Template2.NameText:FindFirstChildOfClass("UIGradient");

        if v47 then
            v47:Clone().Parent = Template.NameText;
        end;

        local u48 = 0;
        local u49 = 0;
        local v50 = 0;
        local u51 = false;
        local v52 = false;
        local v53 = false;
        local v54;

        if typeof(p29) == "string" then
            v54 = false;
        else
            v54 = wiki.styles[actionUtil.checkStyle(p29:IsA("Player") and p29 and p29 or v35)];
        end;

        local v55;

        if p29 and typeof(p29) == "Instance" then
            v55 = p29:GetAttribute("FlowActive") or false;
        else
            v55 = false;
        end;

        if v55 and v54 then
            v52 = (v54.awkicon or v54.awkiconot) and true or v52;

            if v54.awkcolor then
                v53 = true;
            end;
        end;

        if not (v54 or (typeof(p29) ~= "Instance" or not (p29:IsA("Model") and (p29:FindFirstChild("state") and p29.state:FindFirstChild("style"))))) then
            v54 = wiki.styles[p29.state.style.Value];
        end;

        local v56;

        if v54 then
            v56 = v54.color or p32;
        else
            v56 = p32;
        end;

        local v57;

        if v54 then
            v57 = v54.icon or p31;
        else
            v57 = p31;
        end;

        if v52 then
            local workspace = game:GetService("ReplicatedStorage"):FindFirstChild("workspace");

            if workspace then
                workspace = workspace:FindFirstChild("overtime");
            end;

            local v58;

            if workspace == nil or workspace.Value ~= true then
                if typeof(p29) == "Instance" then
                    v58 = p29:HasTag("overtimeTest");
                else
                    v58 = false;
                end;
            else
                v58 = true;
            end;

            local v59 = v54 and v58 and v54.awkiconot;

            if v59 then
                v57 = v59;
            elseif v54 then
                v57 = v54.awkicon or v57;
            end;
        end;

        if v54 and typeof(p29) == "Instance" then
            local v60;

            if p29:IsA("Player") then
                v60 = p29.Character or p29;
            else
                v60 = p29;
            end;

            if v60 then
                if v60:GetAttribute("FlowIntercept") then
                    v57 = v54.intercept_icon or v57;
                    v56 = v54.intercept_color or v56;
                elseif v60:GetAttribute("femlock") then
                    v57 = v54.female or v57;
                end;
            end;
        end;

        if v53 then
            if v54 then
                v56 = v54.awkcolor or v56;
            end;
        end;

        if typeof(p29) == "Instance" and (v35 and p29:GetAttribute("CustomIcon")) then
            v57 = p29:GetAttribute("CustomIcon");
            p33 = true;
        end;

        local v61 = p32 or v56;

        if typeof(p29) == "Instance" then
            if p29:GetAttribute("CustomIcon") then
                v57 = p29:GetAttribute("CustomIcon");
            end;

            if p29:GetAttribute("CustomDialogueColor") then
                v61 = p29:GetAttribute("CustomDialogueColor");
            end;
        end;

        local v62 = p31 or v57;
        local v63;

        if v36 then
            if v55 and v36.awkicon then
                v63 = v36.awkicon;

                if typeof(v63) == "function" then
                    v63 = v63(p29);
                end;

                if v63 then
                    p33 = true;
                else
                    v63 = v62;
                end;
            elseif v36.icon then
                v63 = v36.icon;

                if typeof(v63) == "function" then
                    v63 = v63(p29);
                end;

                if v63 then
                    p33 = true;
                else
                    v63 = v62;
                end;
            else
                v63 = v62;
            end;

            if v36.color then
                v61 = v36.color;

                if typeof(v61) == "function" then
                    v61 = v61(p29);
                end;
            end;
        else
            v63 = v62;
        end;

        if p34 then
            p33 = true;
        else
            p34 = v63;
        end;

        if p33 then
            Template:WaitForChild("ImageLabel").ScaleType = Enum.ScaleType.Fit;
        end;

        if p34 then
            Template:WaitForChild("ImageLabel").Visible = true;
            Template:WaitForChild("ImageLabel").Image = p34;
        end;

        if v61 then
            applyNameColor(Template:WaitForChild("NameText"), v61);
        end;

        if v54 and v54.imageSize then
            Template:WaitForChild("ImageLabel").Size = v54.imageSize;
        end;

        local v64 = u41:GetAttribute("BaseImagePosition") + UDim2.new(0, 0, 0, v54 and v54.raiseMeALittleBruh and -15 or 0);
        local Attribute = u41:GetAttribute("BaseNamePosition");

        if v44 then
            Template.ImageLabel.Position = v64 - UDim2.new(0, 0, 0, 100);
            Template.ImageLabel.ImageTransparency = 1;
            Template.NameText.Position = Attribute - UDim2.new(0, 0, 0, 100);
            Template.NameText.TextTransparency = 1;
            Template.NameText.TextStrokeTransparency = 1;
            local v65 = TweenService:Create(Template.ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ImageTransparency = 0,
                Position = v64
            });
            local v66 = TweenService:Create(Template.NameText, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                TextTransparency = 0,
                TextStrokeTransparency = 0,
                Position = Attribute
            });
            u3[u41] = { v65, v66 };
            v65:Play();
            v66:Play();
        else
            Template.ImageLabel.Position = v64;
            Template.ImageLabel.ImageTransparency = 0;
            Template.NameText.Position = Attribute;
            Template.NameText.TextTransparency = 0;
            Template.NameText.TextStrokeTransparency = 0;
        end;

        u4 = u4 + 1;
        local u67 = u4;
        u41:SetAttribute("Created", os.clock());
        u41:SetAttribute("DialogueId", u67);
        task.spawn(function() -- Line: 619
            -- upvalues: u41 (ref), u40 (ref), u51 (ref), u67 (copy), retireTexts (ref), u3 (ref), TweenService (ref), Template (copy), u2 (ref)
            repeat
                task.wait();
            until u40 < os.clock() - u41:GetAttribute("Created") or not (u41.Parent and (not u51 and u41:GetAttribute("DialogueId") == u67));

            if not u41.Parent or u41:GetAttribute("DialogueId") ~= u67 then
                return;
            end;

            u41:SetAttribute("Ending", true);
            u41:SetAttribute("EndingStarted", os.clock());
            u41.Name = "deleting";

            if u41:FindFirstChild("Holder") and u41.Holder:FindFirstChild("Template") then
                retireTexts(u41.Holder.Template);
            end;

            for _, v in u3[u41] or {} do
                v:Cancel();
            end;

            local v68 = TweenService:Create(Template.ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                ImageTransparency = 1,
                Position = Template.ImageLabel.Position - UDim2.new(0, 0, 0, 100)
            });
            local v69 = TweenService:Create(Template.NameText, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            });
            u3[u41] = { v68, v69 };
            v68:Play();
            v69:Play();
            task.delay(1, function() -- Line: 650
                -- upvalues: u41 (ref), u67 (ref), u2 (ref), u3 (ref)
                if u41:GetAttribute("DialogueId") ~= u67 then
                    return;
                end;

                if u2 == u41 then
                    u2 = nil;
                end;

                u3[u41] = nil;
                u41:Destroy();
            end);
        end);
        u41.Parent = LocalPlayer.PlayerGui;
        u41.Enabled = true;
        u41.Name = LocalPlayer.Name .. "DialogueUI";
        u41:AddTag("DialogueUI");
        u41:WaitForChild("Holder"):WaitForChild("Template"):WaitForChild("NameText").Text = v38;

        for _, v in p28 do
            v45 = v45 .. v.Text;
        end;

        retireTexts(u41.Holder.Template);

        for _, v in p28 do
            local v70 = v.SpecialText and splitGraphemes(v.Text) or string.split(v.Text, "");
            local v71 = v.Font or v.Bold and Enum.Font.SourceSansBold or (v.Italic and Enum.Font.SourceSansItalic or Enum.Font.SourceSans);

            for _, v2 in v70 do
                u48 = u48 + TextService:GetTextSize(v2, u39 * 25, v71, Vector2.new(100, 100)).X;
            end;
        end;

        for _, v in p28 do
            local v72 = v.SpecialText and splitGraphemes(v.Text) or string.split(v.Text, "");
            local v73 = v.Font or v.Bold and Enum.Font.SourceSansBold or (v.Italic and Enum.Font.SourceSansItalic or Enum.Font.SourceSans);

            if v.yield then
                task.wait(v.yield);
                print("waited");
            end;

            local u74 = v;

            for _, v2 in v72 do
                local TextSize = TextService:GetTextSize(v2, u39 * 25, v73, Vector2.new(100, 100));
                local TextLabel = Instance.new("TextLabel");
                UDim2.new(0.5, u49 - u48 / 2 // 1, 0.5, 0);
                TextLabel.AnchorPoint = Vector2.new(0, 0.5);
                TextLabel.Position = UDim2.new(0.5, u49 - u48 / 2 // 1, 0.5, 10);
                TextLabel.Size = UDim2.new(0, TextSize.X, 0, TextSize.Y);
                TextLabel.Text = v2;
                TextLabel.Name = "letter";
                TextLabel.Font = v73;
                TextLabel.TextSize = u39 * 25;
                TextLabel.Parent = u41.Holder.Template;
                TextLabel.BackgroundTransparency = 1;
                TextLabel.TextStrokeColor3 = u74.TextStrokeColor or Color3.new(0, 0, 0);
                TextLabel.TextStrokeTransparency = 0;
                TextLabel.TextStrokeTransparency = 1;
                TextLabel.TextTransparency = 1;
                TextLabel.ZIndex = 10;
                task.delay(v50, function() -- Line: 720
                    -- upvalues: u74 (copy), TextLabel (copy), u39 (ref), u49 (copy), u48 (copy), u41 (ref)
                    local os_clock_ret = os.clock();

                    while true do
                        local v75 = (os.clock() - os_clock_ret) / 0.35;
                        local math_min_ret = math.min(v75, 1);

                        if u74.Shake and u74.Shake.Duration then
                            local v76 = (os.clock() - os_clock_ret) / u74.Shake.Duration;
                            math.min(v76, 1);
                        end;

                        local UDim2_new_ret = UDim2.new(0, 0, 0, 0);

                        if u74.Shake and u74.Shake.Enabled then
                            local v77 = (u74.Shake.Duration or 1) * 1.75;
                            local math_floor_ret = math.floor(u74.Shake.Intensity or 1);
                            local math_max_ret = math.max(1, math_floor_ret);
                            local v78 = (os.clock() - os_clock_ret) / v77;
                            local math_clamp_ret = math.clamp(v78, 0, 1);
                            local math_lerp_ret = math.lerp(0, 1, math_clamp_ret);
                            local UDim2_new = UDim2.new;
                            local math_random_ret = math.random(-math_max_ret, math_max_ret);
                            local math_lerp_ret2 = math.lerp(math_random_ret, 0, math_lerp_ret);
                            local math_random_ret2 = math.random(-math_max_ret, math_max_ret);
                            UDim2_new_ret = UDim2_new(0, math_lerp_ret2, 0, (math.lerp(math_random_ret2, 0, math_lerp_ret)));
                        end;

                        local v79;

                        if math_min_ret == nil then
                            v79 = nil + nil;
                        else
                            v79 = math.pow(math_min_ret - 1, 3) * 2.70158 + 1 + math.pow(math_min_ret - 1, 2) * 1.70158;
                        end;

                        local v80 = 1 - v79;
                        TextLabel.TextStrokeTransparency = (1 - math_min_ret) ^ 10;
                        TextLabel.TextTransparency = v80;
                        TextLabel.TextSize = u39 * 25 + u39 * 25 * v80;
                        TextLabel.TextColor3 = typeof(u74.Color) == "Color3" and u74.Color or getColor(math_min_ret, u74.Color.Keypoints);
                        TextLabel.Position = UDim2.new(0.5, u49 - u48 / 2 // 1, 0.5, 0) + UDim2_new_ret;
                        task.wait();

                        if os.clock() - os_clock_ret > math.max(0.35, u74.Shake and u74.Shake.Lifetime or 0.35) or not (TextLabel and (TextLabel:IsDescendantOf(u41) and not TextLabel:GetAttribute("Ending"))) then
                            if TextLabel then
                                TextLabel.TextStrokeTransparency = 0;
                                TextLabel.TextTransparency = 0;
                                TextLabel.TextSize = u39 * 25;
                                TextLabel.TextColor3 = typeof(u74.Color) == "Color3" and u74.Color or u74.Color.Keypoints[#u74.Color.Keypoints].Value;
                                TextLabel.Position = UDim2.new(0.5, u49 - u48 / 2 // 1, 0.5, 0);
                            end;

                            return;
                        end;
                    end;
                end);
                v50 = v50 + (u74.TypeSpeed or 0.01);
                u49 = u49 + TextSize.X;
            end;

            if u74.Pause then
                task.wait(u74.Pause);
            end;
        end;

        return function() -- Line: 791
            -- upvalues: u51 (ref)
            u51 = true;
        end;
    end;
end;

function v1.Speak(p81: any, p82: table, p83: any, p84: any, p85: any, p86: any, p87: any) -- Line: 796
    -- upvalues: doText (copy)
    return doText(p82, p81, p83, p84, p85, p86, p87);
end;

return v1;