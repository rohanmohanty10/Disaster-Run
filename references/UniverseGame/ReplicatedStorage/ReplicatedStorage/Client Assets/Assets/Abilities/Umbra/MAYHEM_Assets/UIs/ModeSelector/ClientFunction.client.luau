  

 

local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local SoundGroups = require(ReplicatedStorage.ReplicatedModules:WaitForChild("SoundGroups"));
require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("ReplicatedLibrary"):WaitForChild("GroupRanks"));
local Common = require(PathShortcuts.ReplicatedModules.StatsFolder.Umbra.MAYHEM.Common);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local LocalPlayer = Players.LocalPlayer;
local ModeButton = script.ModeButton;
local Parent = script.Parent;
local Base = Parent.Base;
local ShardPos = Parent.ShardPos;
local ArrowToggle = ShardPos.ArrowToggle;
local ListFrame = Base.ListFrame;
local ModelistFrame = ListFrame.ModelistFrame;
local _ = ListFrame.Graphic;
local Cover = ModelistFrame.Cover;
local Scroller = ModelistFrame.Scroller;
local SettingsButtonContainer = Parent.SettingsButtonContainer;
local SettingsButton = SettingsButtonContainer.SettingsButton;
local SettingsFrame = ListFrame.SettingsFrame;
local Cover2 = SettingsFrame.Cover;
local u1 = {
    Hue = 72,
    Wings = true,
    Label = true,
    Voicelines = true,
    MusicPlayback = "Global",
    ForceVoiceline = "N/A",
    PickForm = RunService:IsStudio(),
    Color = Color3.new(1, 0, 0)
};
local u2 = RunService:IsStudio() or Common.CheckContributor(LocalPlayer);
local u3 = "Select a form for sovereign";
ModelistFrame.Note.Text = u3;
local u4 = {
    Visible = {},
    Invisible = {},
    SettingsVisible = {},
    SettingsInvisible = {}
};
local u5 = {};
local u6 = "None";
local u7 = false;
local u8 = false;
local u9 = false;
local u10 = {};

for _, child in script:GetChildren() do
    if child:IsA("Sound") then
        SoundGroups:AssignSoundTag(child);
    end;
end;

local function RecolorUI(p11, p12) -- Line: 85
    -- upvalues: Parent (copy), TweenService (copy), Scroller (copy)
    local v13 = {
        Primary = {},
        Secondary = {}
    };

    for _, descendant in Parent:GetDescendants() do
        local v14, v15;

        if string.find(descendant.Name, "Invert") then
            v14 = p11;
            v15 = p12;
        else
            v14 = p12;
            v15 = p11;
        end;

        if not descendant:GetAttribute("IgnoreShift") then
            if descendant:IsA("ImageLabel") or descendant:IsA("ImageButton") then
                TweenService:Create(descendant, TweenInfo.new(0.2), {
                    ImageColor3 = v15
                }):Play();
                table.insert(v13[v15 == p11 and "Primary" or "Secondary"], descendant);
            elseif descendant:IsA("TextLabel") then
                TweenService:Create(descendant, TweenInfo.new(0.2), {
                    TextColor3 = v15,
                    TextStrokeColor3 = v14
                }):Play();
                table.insert(v13[v15 == p11 and "Primary" or "Secondary"], descendant);
            elseif descendant:IsA("UIStroke") and descendant.Parent.Parent ~= Scroller then
                TweenService:Create(descendant, TweenInfo.new(0.2), {
                    Color = v15
                }):Play();
                table.insert(v13[v15 == p11 and "Primary" or "Secondary"], descendant);
            elseif descendant:IsA("Frame") and (descendant.Name == "Center_Invert" or descendant.Name == "Cover") then
                TweenService:Create(descendant, TweenInfo.new(0.2), {
                    BackgroundColor3 = v15
                }):Play();
                table.insert(v13[v15 == p11 and "Primary" or "Secondary"], descendant);
            end;
        end;
    end;

    return v13;
end;

local function AddUIButton(u16, u17) -- Line: 113
    -- upvalues: ModeButton (copy), Scroller (copy), u5 (ref), TweenService (copy), RecolorUI (copy), u6 (ref), ModelistFrame (copy), u3 (ref), Parent (copy), u1 (copy)
    local u18 = ModeButton:Clone();
    u18.Name = u16;
    u18.Text = u17.DisplayText or u16;
    u18.BackgroundColor3 = u17.SecondaryColor;
    u18.TextColor3 = u17.PrimaryColor;
    u18.TextStrokeColor3 = u17.SecondaryColor;
    u18.UIStroke.UIGradient.Color = ColorSequence.new(u17.PrimaryColor, u17.SecondaryColor);
    u18.Font = u17.Font;
    u18.LayoutOrder = u17.Layout or 1;
    u18.Parent = Scroller;
    local v19 = Scroller;
    v19.CanvasSize = v19.CanvasSize + UDim2.new(0, 0, 0.01, 50);
    u18.MouseEnter:Connect(function() -- Line: 128
        -- upvalues: u5 (ref), TweenService (ref), Scroller (ref), u17 (copy), RecolorUI (ref), u16 (copy), u6 (ref), ModelistFrame (ref)
        table.clear(u5);
        TweenService:Create(Scroller, TweenInfo.new(0.2), {
            ScrollBarImageColor3 = u17.SecondaryColor
        }):Play();
        local v20 = RecolorUI(u17.PrimaryColor, u17.SecondaryColor);
        u5 = u16 == "Rainbow" and v20.Primary or (u16 == "Chaos" and v20.Secondary or {});
        u6 = u16;
        ModelistFrame.Note.Text = `Music: \n- {u17.MusicName or "Undefined"}`;

        if typeof(u17.PoseMusicName) == "table" then
            local Note = ModelistFrame.Note;
            Note.Text = Note.Text .. "\nPose Musics:";

            for _, v in u17.PoseMusicName do
                local Note2 = ModelistFrame.Note;
                Note2.Text = Note2.Text .. `\n- {v}`;
            end;
        else
            local Note = ModelistFrame.Note;
            Note.Text = Note.Text .. `\nPose Music: \n- {u17.PoseMusicName or "Undefined"}`;
        end;

        ModelistFrame.Note:TweenSize(UDim2.fromScale(2.5, 0.285), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.1, true);
        script.Hover:Play();
    end);
    u18.MouseLeave:Connect(function() -- Line: 151
        -- upvalues: ModelistFrame (ref), u3 (ref)
        ModelistFrame.Note:TweenSize(UDim2.fromScale(1.25, 0.1), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true);
        ModelistFrame.Note.Text = u3;
    end);
    u18.InputBegan:Connect(function(p21) -- Line: 155
        -- upvalues: u18 (copy), Parent (ref), u1 (ref), u16 (copy), u3 (ref)
        if p21.UserInputType == Enum.UserInputType.MouseButton1 or p21.UserInputType == Enum.UserInputType.Touch then
            if u18:GetAttribute("Unavailable") then
                script.Error:Play();

                return;
            end;

            script.Click:Play();
            Parent.Event:FireServer(u1.PickForm and "PickForm" or "ChooseForm", u16);
            u3 = `Selected Sovereign: "{u16}"`;
        end;
    end);

    if u16 == "Rainbow" then
        task.spawn(function() -- Line: 168
            -- upvalues: u18 (copy), u6 (ref), u5 (ref)
            while true do
                local v22;

                repeat
                    task.wait();
                    v22 = Color3.fromHSV(tick() * 0.35 % 1, 1, 1);
                    u18.TextColor3 = v22;
                    u18.UIStroke.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v22), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) });
                until u6 == "Rainbow";

                for _, v in u5 do
                    if v:IsA("Frame") then
                        v.BackgroundColor3 = v22;
                    elseif v:IsA("TextLabel") then
                        v.TextColor3 = v22;
                    elseif v:IsA("ImageLabel") or v:IsA("ImageButton") then
                        v.ImageColor3 = v22;
                    elseif v:IsA("UIStroke") then
                        v.Color = v22;
                    end;
                end;
            end;
        end);

        return;
    end;

    if u16 == "Chaos" then
        task.spawn(function() -- Line: 190
            -- upvalues: u18 (copy), u6 (ref), u5 (ref)
            while true do
                local v23;

                repeat
                    task.wait(0.175);
                    v23 = BrickColor.Random().Color;
                    u18.TextStrokeColor3 = v23;
                until u6 == "Chaos";

                for _, v in u5 do
                    if v:IsA("Frame") then
                        v.BackgroundColor3 = v23;
                    elseif v:IsA("TextLabel") then
                        v.TextColor3 = v23;
                    elseif v:IsA("ImageLabel") or v:IsA("ImageButton") then
                        v.ImageColor3 = v23;
                    elseif v:IsA("UIStroke") then
                        v.Color = v23;
                    end;
                end;
            end;
        end);
    end;
end;

local function ValidInput(p24) -- Line: 213
    return p24.UserInputType == Enum.UserInputType.Touch or p24.UserInputType == Enum.UserInputType.MouseButton1;
end;

local function SetSettingEnabled(p25, p26) -- Line: 220
    local TextButton = p25.TextButton;
    TextButton.UIStroke.Color = p26 and Color3.new(0, 1, 0) or Color3.new(1, 0, 0);
    TextButton.CheckmarkIcon.Visible = p26;
end;

local v27 = {};

local function CreateSetting(u28) -- Line: 243
    -- upvalues: u2 (copy), SettingsFrame (copy), TweenService (copy)
    if not u28.Contributor or u2 then
        local Scroller2 = SettingsFrame.Scroller;
        Scroller2.CanvasSize = Scroller2.CanvasSize + UDim2.new(0, 0, 0.01, 85);
        local u29 = script.SettingContainers[u28.Type]:Clone();
        u29.Parent = SettingsFrame.Scroller;
        u29.Visible = true;
        u29.LayoutOrder = u28.Layout or 0;
        u29.Name = u28.Name;
        u29.Description.Text = u28.Description;

        if u28.TextProperties then
            for i, v in u28.TextProperties do
                u29.Description[i] = v;
            end;
        end;

        if u28.Type ~= "Boolean" then
            if u28.Type ~= "Input" then
                if u28.Type == "Dropdown" then
                    local u30 = false;
                    local u31 = u28.DropdownSize or 200;
                    local u32 = u28.IgnoreCanvas and 0 or u31 * 0.95;
                    local v33 = UDim2.new(u29.DropDown.Size.X.Scale, u29.DropDown.Size.X.Offset, u29.DropDown.Size.Y.Scale, u29.DropDown.Size.Y.Offset);
                    local v34 = UDim2.new(u29.DropDown.Size.X.Scale, u29.DropDown.Size.X.Offset, u29.DropDown.Size.Y.Scale, u29.DropDown.Size.Y.Offset + u31);
                    local v35 = UDim2.new(u29.DropDown.Position.X.Scale, u29.DropDown.Position.X.Offset, u29.DropDown.Position.Y.Scale, u29.DropDown.Position.Y.Offset);
                    local v36 = UDim2.new(u29.DropDown.Position.X.Scale, u29.DropDown.Position.X.Offset, u29.DropDown.Position.Y.Scale, u29.DropDown.Position.Y.Offset + u31);
                    local u37 = nil;
                    local u38 = TweenService:Create(u29.DropDown, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = v34,
                        Position = v36
                    });
                    local u39 = TweenService:Create(u29.DropDown, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        Size = v33,
                        Position = v35
                    });
                    u29.Button.InputBegan:Connect(function(p40) -- Line: 304
                        -- upvalues: u30 (ref), u37 (ref), u39 (copy), u29 (copy), u38 (copy), SettingsFrame (ref), u31 (copy), u32 (copy)
                        if p40.UserInputType == Enum.UserInputType.Touch or p40.UserInputType == Enum.UserInputType.MouseButton1 then
                            u30 = not u30;

                            if u30 then
                                if u37 then
                                    u37:Disconnect();
                                end;

                                u39:Cancel();
                                u29.DropDown.Visible = true;
                                u38:Play();
                                local Scroller3 = SettingsFrame.Scroller;
                                Scroller3.CanvasSize = Scroller3.CanvasSize + UDim2.new(0, 0, 0.01, u31);
                                SettingsFrame.Scroller.CanvasPosition = Vector2.new(SettingsFrame.Scroller.CanvasPosition.X, SettingsFrame.Scroller.CanvasPosition.Y + u32);
                            else
                                u38:Cancel();
                                u29.DropDown.Visible = true;
                                u39:Play();
                                u37 = u39.Completed:Once(function() -- Line: 324
                                    -- upvalues: u29 (ref)
                                    u29.DropDown.Visible = false;
                                end);
                                local Scroller3 = SettingsFrame.Scroller;
                                Scroller3.CanvasSize = Scroller3.CanvasSize - UDim2.new(0, 0, 0.01, u31);
                                SettingsFrame.Scroller.CanvasPosition = Vector2.new(SettingsFrame.Scroller.CanvasPosition.X, SettingsFrame.Scroller.CanvasPosition.Y - u32);
                            end;

                            script.Click:Play();
                        end;
                    end);

                    for _, v in u28.Options do
                        local u41 = script.SettingContainers[`DropdownTemplate_{v.Type or "Normal"}`]:Clone();
                        u41.Parent = u29.DropDown;
                        u41.Visible = true;
                        u41.LayoutOrder = v.Layout;
                        u41.Text = v.Text or v.Name;
                        u41.Name = v.Name or u41.Text;

                        if v.Type == "Form" then
                            u41.Font = v.Font;
                            u41.BackgroundColor3 = v.SecondaryColor;
                            u41.TextColor3 = v.PrimaryColor;
                            u41.TextStrokeColor3 = v.SecondaryColor;
                            u41.UIStroke.UIGradient.Color = ColorSequence.new(v.PrimaryColor, v.SecondaryColor);
                        end;

                        u41.InputBegan:Connect(function(p42) -- Line: 350
                            -- upvalues: u28 (copy), u29 (copy), u41 (copy)
                            if p42.UserInputType == Enum.UserInputType.Touch or p42.UserInputType == Enum.UserInputType.MouseButton1 then
                                local v43 = u28.Callback(u29, u41.Name, u41);
                                u29.Button.Text = v43 or u29.Button.Text;
                                script[v43 and "Click" or "Error"]:Play();
                            end;
                        end);
                        local DropDown = u29.DropDown;
                        DropDown.CanvasSize = DropDown.CanvasSize + UDim2.new(0, 0, 0.01, u41.Size.Y.Offset + 10);
                    end;

                    u29.Button.Text = u28.Selected or "Dropdown";
                end;

                return u29;
            end;

            u29.InputField.PlaceholderText = u28.PlaceholderText or "Input";
            u29.InputField.Text = u28.Input or "";
            u29.InputField.FocusLost:Connect(function(p44) -- Line: 279
                -- upvalues: u28 (copy), u29 (copy)
                local v45 = u28.Callback(u29, u29.InputField.Text);
                u29.InputField.Text = v45 or "";
                script[v45 and "Click" or "Error"]:Play();
            end);

            return u29;
        end;

        local Enabled = u28.Enabled;
        local Enabled2 = u28.Enabled;
        local TextButton = u29.TextButton;
        TextButton.UIStroke.Color = Enabled2 and Color3.new(0, 1, 0) or Color3.new(1, 0, 0);
        TextButton.CheckmarkIcon.Visible = Enabled2;
        u29.TextButton.InputBegan:Connect(function(p46) -- Line: 264
            -- upvalues: u28 (copy), u29 (copy), Enabled (ref)
            if p46.UserInputType == Enum.UserInputType.Touch or p46.UserInputType == Enum.UserInputType.MouseButton1 then
                local v47 = u28.Callback(u29, not Enabled);

                if v47 then
                    Enabled = not Enabled;
                    local v48 = Enabled;
                    local TextButton2 = u29.TextButton;
                    TextButton2.UIStroke.Color = v48 and Color3.new(0, 1, 0) or Color3.new(1, 0, 0);
                    TextButton2.CheckmarkIcon.Visible = v48;
                end;

                script[v47 and "Click" or "Error"]:Play();
            end;
        end);

        return u29;
    end;
end;

local function PlayTweens(p49, p50, p51) -- Line: 69
    -- upvalues: u4 (copy)
    if p50 ~= true then
        for i, v in u4 do
            if not (p50 and table.find(p50, i)) then
                for _, v2 in v do
                    v2:Cancel();
                end;
            end;
        end;
    end;

    for _, v in u4[p49] do
        if not (p51 and table.find(p51, v.Instance)) then
            v:Play();
        end;
    end;
end;

local function CreateInbetweenSetting(p52) -- Line: 226
    -- upvalues: SettingsFrame (copy)
    local Scroller2 = SettingsFrame.Scroller;
    Scroller2.CanvasSize = Scroller2.CanvasSize + UDim2.new(0, 0, 0.01, 35);
    local v53 = script.SettingContainers.Inbetween:Clone();
    v53.Parent = SettingsFrame.Scroller;
    v53.Visible = true;
    v53.LayoutOrder = p52.Layout or 0;
    v53.Name = p52.Name or "Inbetween";
    v53.Description.Text = p52.Description or p52.Name;

    if p52.TextProperties then
        for i, v in p52.TextProperties do
            v53.Description[i] = v;
        end;
    end;

    return v53;
end;

for i, v in Common.FormData do
    if not v.CustomForm or u2 then
        table.insert(v27, {
            Type = "Form",
            PrimaryColor = v.PrimaryColor,
            SecondaryColor = v.SecondaryColor,
            Name = i,
            Text = v.DisplayText or i,
            Font = v.Font,
            Layout = v.Layout or 1
        });
        AddUIButton(i, v);
    end;
end;

AddUIButton("[Random]", {
    Layout = 99,
    PrimaryColor = Color3.new(1, 1, 1),
    SecondaryColor = Color3.new(),
    Font = Enum.Font.ArialBold
});
AddUIButton("None", {
    Layout = 98,
    PrimaryColor = Color3.new(1, 1, 1),
    SecondaryColor = Color3.new(),
    Font = Enum.Font.ArialBold
});
local v54 = {
    Type = "Form",
    Name = "N/A",
    Text = "N/A",
    Layout = 99,
    PrimaryColor = Color3.new(1, 1, 1),
    SecondaryColor = Color3.new(),
    Font = Enum.Font.ArialBold
};
table.insert(v27, v54);
local Visible = u4.Visible;
local v55 = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
local v56 = {
    Position = UDim2.new(0, 0, 0.5, 0)
};
table.insert(Visible, TweenService:Create(Base, v55, v56));
local Visible2 = u4.Visible;
local v57 = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
local v58 = {
    Position = UDim2.new(0, 3, 0.5, 0)
};
table.insert(Visible2, TweenService:Create(ModelistFrame, v57, v58));
local Visible3 = u4.Visible;
local v59 = TweenInfo.new(0.9);
table.insert(Visible3, TweenService:Create(Cover, v59, {
    BackgroundTransparency = 1
}));
local Visible4 = u4.Visible;
local v60 = TweenInfo.new(0.8);
local v61 = {
    Rotation = 0,
    Position = UDim2.new(0, -5, 0.265, 0)
};
table.insert(Visible4, TweenService:Create(ShardPos, v60, v61));
local Visible5 = u4.Visible;
local v62 = TweenInfo.new(0.8);
table.insert(Visible5, TweenService:Create(ArrowToggle, v62, {
    ImageTransparency = 0.5
}));
local Visible6 = u4.Visible;
local RotatorInner_Invert = ListFrame.RotatorInner_Invert;
local v63 = TweenInfo.new(0.8);
local v64 = {
    ImageTransparency = 0.8,
    Size = UDim2.new(3.5, 0, 3.5, 0)
};
table.insert(Visible6, TweenService:Create(RotatorInner_Invert, v63, v64));
local Visible7 = u4.Visible;
local RotatorOuter = ListFrame.RotatorOuter;
local v65 = TweenInfo.new(0.8);
local v66 = {
    ImageTransparency = 0.9,
    Size = UDim2.new(4.25, 0, 4.25, 0)
};
table.insert(Visible7, TweenService:Create(RotatorOuter, v65, v66));
local Visible8 = u4.Visible;
local Glow_Invert = ListFrame.Glow_Invert;
local v67 = TweenInfo.new(0.8);
local v68 = {
    ImageTransparency = 0.5,
    Size = UDim2.new(4.5, 0, 4.5, 0)
};
table.insert(Visible8, TweenService:Create(Glow_Invert, v67, v68));
local Visible9 = u4.Visible;
local BackText = ShardPos.BackText;
local v69 = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
table.insert(Visible9, TweenService:Create(BackText, v69, {
    Rotation = 360,
    TextTransparency = 0,
    TextStrokeTransparency = 0.25
}));
local Visible10 = u4.Visible;
local OpenText = ShardPos.OpenText;
local v70 = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
table.insert(Visible10, TweenService:Create(OpenText, v70, {
    Rotation = 540,
    TextTransparency = 1,
    TextStrokeTransparency = 1
}));
local Visible11 = u4.Visible;
local v71 = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local v72 = {
    Position = UDim2.fromScale(0, 0.5)
};
table.insert(Visible11, TweenService:Create(SettingsButtonContainer, v71, v72));

for i = 1, 5 do
    local Visible12 = u4.Visible;
    local v73 = ShardPos[`ExtraShard{i}`];
    local v74 = TweenInfo.new(0.8);
    table.insert(Visible12, TweenService:Create(v73, v74, {
        Rotation = i * -60
    }));
    local Visible13 = u4.Visible;
    local Shard = ShardPos[`ExtraShard{i}`].Shard;
    local v75 = TweenInfo.new(0.5);
    table.insert(Visible13, TweenService:Create(Shard, v75, {
        ImageTransparency = 0.5
    }));
end;

local SettingsVisible = u4.SettingsVisible;
local v76 = TweenInfo.new(0.9);
table.insert(SettingsVisible, TweenService:Create(Cover2, v76, {
    BackgroundTransparency = 1
}));
local SettingsVisible2 = u4.SettingsVisible;
local v77 = TweenInfo.new(0.4);
table.insert(SettingsVisible2, TweenService:Create(Cover, v77, {
    BackgroundTransparency = 0
}));
local SettingsVisible3 = u4.SettingsVisible;
local v78 = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
local v79 = {
    Position = UDim2.new(0, 3, 0.5, 0)
};
table.insert(SettingsVisible3, TweenService:Create(SettingsFrame, v78, v79));
local SettingsVisible4 = u4.SettingsVisible;
local v80 = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
local v81 = {
    Position = UDim2.fromScale(-1.2, 0.5)
};
table.insert(SettingsVisible4, TweenService:Create(ModelistFrame, v80, v81));
local Invisible = u4.Invisible;
local v82 = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
local v83 = {
    Position = UDim2.new(-0.3, 0, 0.5, 0)
};
table.insert(Invisible, TweenService:Create(Base, v82, v83));
local Invisible2 = u4.Invisible;
local v84 = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
local v85 = {
    Position = UDim2.new(-1.2, 0, 0.5, 0)
};
table.insert(Invisible2, TweenService:Create(ModelistFrame, v84, v85));
local Invisible3 = u4.Invisible;
local v86 = TweenInfo.new(0.4);
table.insert(Invisible3, TweenService:Create(Cover, v86, {
    BackgroundTransparency = 0
}));
local Invisible4 = u4.Invisible;
local v87 = TweenInfo.new(0.8);
local v88 = {
    Rotation = 540,
    Position = UDim2.new(0, -5, 0.5, 0)
};
table.insert(Invisible4, TweenService:Create(ShardPos, v87, v88));
local Invisible5 = u4.Invisible;
local v89 = TweenInfo.new(0.8);
table.insert(Invisible5, TweenService:Create(ArrowToggle, v89, {
    ImageTransparency = 0
}));
local Invisible6 = u4.Invisible;
local RotatorInner_Invert2 = ListFrame.RotatorInner_Invert;
local v90 = TweenInfo.new(0.8);
local v91 = {
    ImageTransparency = 1,
    Size = UDim2.new(1, 0, 1, 0)
};
table.insert(Invisible6, TweenService:Create(RotatorInner_Invert2, v90, v91));
local Invisible7 = u4.Invisible;
local RotatorOuter2 = ListFrame.RotatorOuter;
local v92 = TweenInfo.new(0.8);
local v93 = {
    ImageTransparency = 1,
    Size = UDim2.new(1, 0, 1, 0)
};
table.insert(Invisible7, TweenService:Create(RotatorOuter2, v92, v93));
local Invisible8 = u4.Invisible;
local Glow_Invert2 = ListFrame.Glow_Invert;
local v94 = TweenInfo.new(0.8);
local v95 = {
    ImageTransparency = 1,
    Size = UDim2.new(1, 0, 1, 0)
};
table.insert(Invisible8, TweenService:Create(Glow_Invert2, v94, v95));
local Invisible9 = u4.Invisible;
local BackText2 = ShardPos.BackText;
local v96 = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
table.insert(Invisible9, TweenService:Create(BackText2, v96, {
    Rotation = 0,
    TextTransparency = 1,
    TextStrokeTransparency = 1
}));
local Invisible10 = u4.Invisible;
local OpenText2 = ShardPos.OpenText;
local v97 = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
table.insert(Invisible10, TweenService:Create(OpenText2, v97, {
    Rotation = 180,
    TextTransparency = 0,
    TextStrokeTransparency = 0.25
}));

for i = 1, 5 do
    local Invisible11 = u4.Invisible;
    local v98 = ShardPos[`ExtraShard{i}`];
    local v99 = TweenInfo.new(0.8);
    table.insert(Invisible11, TweenService:Create(v98, v99, {
        Rotation = 0
    }));
    local Invisible12 = u4.Invisible;
    local Shard = ShardPos[`ExtraShard{i}`].Shard;
    local v100 = TweenInfo.new(0.5);
    table.insert(Invisible12, TweenService:Create(Shard, v100, {
        ImageTransparency = 1
    }));
end;

local Invisible11 = u4.Invisible;
local v101 = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local v102 = {
    Position = UDim2.fromScale(-0.5, 0.5)
};
table.insert(Invisible11, TweenService:Create(SettingsButtonContainer, v101, v102));
local SettingsInvisible = u4.SettingsInvisible;
local v103 = TweenInfo.new(0.4);
table.insert(SettingsInvisible, TweenService:Create(Cover2, v103, {
    BackgroundTransparency = 0
}));
local SettingsInvisible2 = u4.SettingsInvisible;
local v104 = TweenInfo.new(0.9);
table.insert(SettingsInvisible2, TweenService:Create(Cover, v104, {
    BackgroundTransparency = 1
}));
local SettingsInvisible3 = u4.SettingsInvisible;
local v105 = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
local v106 = {
    Position = UDim2.fromScale(-1.2, 0.5)
};
table.insert(SettingsInvisible3, TweenService:Create(SettingsFrame, v105, v106));
local SettingsInvisible4 = u4.SettingsInvisible;
local v107 = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
local v108 = {
    Position = UDim2.new(0, 3, 0.5, 0)
};
table.insert(SettingsInvisible4, TweenService:Create(ModelistFrame, v107, v108));
ArrowToggle.InputBegan:Connect(function(p109) -- Line: 448
    -- upvalues: u7 (ref), u9 (ref), PlayTweens (copy), Cover (copy), u8 (ref), ModelistFrame (copy), u4 (copy)
    if (p109.UserInputType == Enum.UserInputType.Touch or p109.UserInputType == Enum.UserInputType.MouseButton1) and not u7 then
        u9 = not u9;
        u7 = true;
        PlayTweens(u9 and "Visible" or "Invisible");

        if u9 then
            script.Open:Play();
        else
            script.Close:Play();
            Cover.Visible = true;
            u8 = false;
            local v110 = { Cover, ModelistFrame };

            for _, v in u4.SettingsInvisible do
                if not (v110 and table.find(v110, v.Instance)) then
                    v:Play();
                end;
            end;
        end;

        task.wait(1);

        if u9 then
            Cover.Visible = false;
        end;

        u7 = false;
    end;
end);
SettingsButton.InputBegan:Connect(function(p111) -- Line: 471
    -- upvalues: u9 (ref), u7 (ref), u8 (ref), Cover2 (copy), Cover (copy), PlayTweens (copy)
    if (p111.UserInputType == Enum.UserInputType.Touch or p111.UserInputType == Enum.UserInputType.MouseButton1) and (u9 and not u7) then
        u7 = true;
        u8 = not u8;

        if u8 then
            script.SettingsOpen:Play();
            Cover2.BackgroundTransparency = 0;
        else
            script.SettingsClose:Play();
            Cover2.Visible = true;
            Cover.BackgroundTransparency = 0;
        end;

        PlayTweens(u8 and "SettingsVisible" or "SettingsInvisible", { "Invisible", "Visible" });
        task.wait(1);

        if u8 then
            Cover2.Visible = false;
        end;

        u7 = false;
    end;
end);
u1.Color = ParticleHandler.HSVShift(u1.Color, {
    HueShift = u1.Hue * 5
});
CreateInbetweenSetting({
    Description = "🎨 - APPEARANCE - 🎨",
    Layout = 1,
    TextProperties = {
        TextStrokeTransparency = 0,
        TextColor3 = Color3.new(1, 1, 1),
        TextStrokeColor3 = Color3.new()
    }
});
CreateSetting({
    Type = "Input",
    Name = "HueChanger",
    Layout = 2,
    PlaceholderText = "1-72",
    Description = `Custom Hue: <font color="rgb({math.floor(u1.Color.R * 255)}, {math.floor(u1.Color.G * 255)}, {math.floor(u1.Color.B * 255)})">■</font>`,
    Input = u1.Hue,

    Callback = function(p112, p113) -- Line: 516, Name: Callback
        -- upvalues: u1 (copy), ParticleHandler (copy), Parent (copy)
        local v114 = string.lower(p113) == "inf" and (1 / 0) or tonumber(p113);

        if v114 and v114 >= 1 then
            local v115;

            if v114 >= 9e99 then
                v115 = (1 / 0);
            else
                local v116 = math.clamp(v114, 1, 72);
                v115 = math.floor(v116);
            end;

            u1.Hue = v115;
            u1.Color = ParticleHandler.HSVShift(Color3.new(1, 0, 0), {
                HueShift = v115 * 5
            });
            p112.Description.Text = `Custom Hue: <font color="rgb({math.floor(u1.Color.R * 255)}, {math.floor(u1.Color.G * 255)}, {math.floor(u1.Color.B * 255)})">■</font>`;
            Parent.Event:FireServer("ChangeHue", v115);

            return v115 >= 9e99 and "inf" or v115;
        end;
    end,

    TextProperties = {
        RichText = true
    }
});
CreateSetting({
    Type = "Boolean",
    Name = "Wings",
    Description = "Wings",
    Layout = 3,
    Enabled = u1.Wings,

    Callback = function(p117, p118) -- Line: 542, Name: Callback
        -- upvalues: u1 (copy), Parent (copy)
        u1.Wings = p118;
        Parent.Event:FireServer("WingToggle", p118);

        return true;
    end
});
CreateSetting({
    Type = "Boolean",
    Name = "Label",
    Description = "Form Label",
    Layout = 4,
    Enabled = u1.Label,

    Callback = function(p119, p120) -- Line: 557, Name: Callback
        -- upvalues: u1 (copy), Parent (copy)
        u1.Label = p120;
        Parent.Event:FireServer("LabelToggle", p120);

        return true;
    end
});
CreateInbetweenSetting({
    Description = "🔊 - AUDIO - 🔊",
    Layout = 10,
    TextProperties = {
        TextStrokeTransparency = 0,
        TextColor3 = Color3.new(1, 1, 1),
        TextStrokeColor3 = Color3.new()
    }
});
CreateSetting({
    Type = "Boolean",
    Name = "Voicelines",
    Description = "Voicelines",
    Layout = 11,
    Enabled = u1.Voicelines,

    Callback = function(p121, p122) -- Line: 583, Name: Callback
        -- upvalues: u1 (copy), Parent (copy)
        u1.Voicelines = p122;
        Parent.Event:FireServer("VoicelineToggle", p122);

        return true;
    end
});
CreateSetting({
    Type = "Dropdown",
    Name = "Music Playback",
    Description = "Music Playback",
    Layout = 12,
    DropdownSize = 150,
    IgnoreCanvas = true,
    Selected = u1.MusicPlayback,
    Options = { {
            Name = "Global",
            Text = "Global",
            Layout = 1
        }, {
            Name = "Local",
            Text = "Local",
            Layout = 2
        }, {
            Name = "Off",
            Text = "Off",
            Layout = 3
        } },

    Callback = function(p123, p124) -- Line: 618, Name: Callback
        -- upvalues: u1 (copy), Parent (copy)
        u1.MusicPlayback = p124;
        Parent.Event:FireServer("SetMusicPlayback", p124);

        return p124;
    end
});

if u2 then
    CreateInbetweenSetting({
        Description = "🕴️ - CONTRIBUTOR - 🕴️",
        Layout = 90,
        TextProperties = {
            TextStrokeTransparency = 0,
            TextColor3 = Color3.new(1, 0, 0),
            TextStrokeColor3 = Color3.new()
        }
    });
    CreateSetting({
        Type = "Boolean",
        Name = "Instant Switch",
        Description = "Instant Switch",
        Layout = 91,
        Contributor = true,
        Enabled = u1.PickForm,

        Callback = function(p125, p126) -- Line: 645, Name: Callback
            -- upvalues: u1 (copy)
            u1.PickForm = p126;

            return true;
        end
    });
    CreateSetting({
        Type = "Dropdown",
        Name = "Voiceline Selector",
        Description = "Force Voiceline",
        Layout = 92,
        Contributor = true,
        Selected = u1.ForceVoiceline,
        Options = v27,

        Callback = function(p127, p128) -- Line: 663, Name: Callback
            -- upvalues: Common (copy), Parent (copy)
            if p128 == "N/A" then
                p128 = nil;
            end;

            local v129 = p128 and (Common.FormData[p128] or {}) or {};
            p127.Button.Font = v129.Font or Enum.Font.ArialBold;
            p127.Button.TextColor3 = v129.PrimaryColor or Color3.new(1, 1, 1);
            p127.Button.TextStrokeColor3 = v129.SecondaryColor or Color3.new();
            Parent.Event:FireServer("SetVoicelines", p128);

            return p128 or "N/A";
        end
    });
end;

for _, child in SettingsFrame.Scroller:GetChildren() do
    if child:IsA("Frame") then
        local Background = child:FindFirstChild("Background", true);

        if Background and Background:IsA("ImageLabel") then
            table.insert(u10, Background);
        end;
    end;
end;

local u130 = 0;
RunService.RenderStepped:Connect(function(p131) -- Line: 693
    -- upvalues: ListFrame (copy), SettingsButton (copy), u130 (ref), u8 (ref), u10 (copy)
    local RotatorInner_Invert3 = ListFrame.RotatorInner_Invert;
    RotatorInner_Invert3.Rotation = RotatorInner_Invert3.Rotation + 0.5 * (60 * p131) % 360;
    local RotatorOuter3 = ListFrame.RotatorOuter;
    RotatorOuter3.Rotation = RotatorOuter3.Rotation - 0.25 * (60 * p131) % 360;
    local v132 = SettingsButton;
    v132.Rotation = v132.Rotation + 0.25 * (60 * p131) % 360;
    u130 = (u130 + 0.005 * (60 * p131)) % 1;

    if u8 and #u10 > 0 then
        for _, v in u10 do
            v.Position = UDim2.fromScale(u130 - 1, u130 - 1);
        end;
    end;
end);