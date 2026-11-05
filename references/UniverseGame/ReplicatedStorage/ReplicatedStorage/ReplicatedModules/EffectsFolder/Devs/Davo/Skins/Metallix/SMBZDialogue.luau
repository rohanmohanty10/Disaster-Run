  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);

local function Adjustments(p1, p2, p3) -- Line: 11
    -- upvalues: TweenService (copy)
    if p3 then
        p1.Container.BackgroundTransparency = 0;
        TweenService:Create(p1.Container, TweenInfo.new(0.25), {
            BackgroundTransparency = 1
        }):Play();
    end;

    p1.Container.Character.Image = typeof(p2.Image) == "string" and p2.Image or `rbxassetid://{p2.Image}`;
    p1.Container.Character.ImageColor3 = p2.ImageColor or Color3.new(1, 1, 1);

    if p2.Image2 then
        p1.Container.Character2.Visible = true;
        p1.Container.Character2.Image = typeof(p2.Image2) == "string" and p2.Image2 or `rbxassetid://{p2.Image2}`;
        p1.Container.Character2.ImageColor3 = p2.Image2Color or Color3.new(1, 1, 1);
    else
        p1.Container.Character2.Visible = false;
    end;

    if p2.TextProperties then
        for i, v in p2.TextProperties do
            if i == "Font" then
                p1.Container.Dialogue.FontFace = typeof(v) == "string" and Font.new(v) or Font.fromEnum(v);
                p1.Container.Dialogue.Shadow.FontFace = p1.Container.Dialogue.FontFace;
            else
                p1.Container.Dialogue[i] = v;
                p1.Container.Dialogue.Shadow[i] = v;
            end;
        end;
    end;

    p1.Container.Dialogue.Shadow.TextColor3 = Color3.new();
    p1.Container.Dialogue.Shadow.TextStrokeColor3 = Color3.new();
    p1.Container.Background.ImageColor3 = p2.BackgroundColor or p1.Container.Dialogue.TextStrokeColor3;
end;

return function(u4) -- Line: 43
    -- upvalues: LocalPlayer (copy), Trove (copy), TweenService (copy), EffectsHandler (copy), Adjustments (copy)
    local SMBZDialogue = LocalPlayer.PlayerGui:FindFirstChild("SMBZDialogue");

    if SMBZDialogue then
        SMBZDialogue:SetAttribute("Clear", true);
    end;

    local u5 = 1 / (u4.Speed or 1);
    local u6 = Trove.new();
    local u7 = false;
    local u8 = u4.Character:GetAttribute("PSScale") or 1;
    local u9 = u4.ScaleTime and u4.ScaleTime / #u4.Text / u8 or u4.WaitTime;
    local u10 = script.SMBZDialogue:Clone();
    u10.Parent = LocalPlayer.PlayerGui;
    local u11 = { TweenService:Create(u10.Container, TweenInfo.new(u5 / 3), {
            GroupTransparency = 0,
            Size = UDim2.fromScale(u10.Container.Size.X.Scale, u10.Container.Size.Y.Scale),
            Position = UDim2.fromScale(u10.Container.Position.X.Scale, u10.Container.Position.Y.Scale)
        }) };
    local u12 = {
        TweenService:Create(u10.Container, TweenInfo.new(u5 / 2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(u10.Container.Size.X.Scale * 0.1, u10.Container.Size.Y.Scale)
        }),
        TweenService:Create(u10.Container.Dialogue, TweenInfo.new(u5 / 3.5), {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }),
        TweenService:Create(u10.Container.Dialogue.Shadow, TweenInfo.new(u5 / 3.5), {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }),
        TweenService:Create(u10.Container.Character, TweenInfo.new(u5 / 2), {
            ImageTransparency = 1
        }),
        TweenService:Create(u10.Container.Character2, TweenInfo.new(u5 / 1.5), {
            ImageTransparency = 1
        })
    };
    local u13 = TweenService:Create(u10.Container, TweenInfo.new(u5 / 3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        GroupTransparency = 1,
        Size = UDim2.fromScale(0, 0),
        Position = UDim2.fromScale(u10.Container.Position.X.Scale, u10.Container.Position.Y.Scale - 0.05)
    });
    u6:Add(function() -- Line: 91, Name: Clear
        -- upvalues: u7 (ref), u11 (copy), u12 (copy), u13 (copy), EffectsHandler (ref), u5 (copy), u10 (copy)
        if u7 then
            return;
        end;

        u7 = true;

        for _, v in u11 do
            v:Cancel();
        end;

        for _, v in u12 do
            v:Play();
        end;

        u12[1].Completed:Once(function() -- Line: 101
            -- upvalues: u13 (ref)
            u13:Play();
        end);
        task.spawn(function() -- Line: 105
            -- upvalues: EffectsHandler (ref), u5 (ref), u10 (ref)
            EffectsHandler.Wait(u5);

            if not u10 then
                return;
            end;

            u10:Destroy();
        end);
    end);
    u6:Connect(u4.Character.AncestryChanged, function(p14, p15) -- Line: 113
        -- upvalues: u6 (copy)
        if not (p15 and p15:IsDescendantOf(game)) then
            u6:Destroy();
        end;
    end);
    u6:Connect(u4.Character.Destroying, function() -- Line: 118
        -- upvalues: u6 (copy)
        u6:Destroy();
    end);
    u6:Connect(u10:GetAttributeChangedSignal("Clear"), function() -- Line: 121
        -- upvalues: u6 (copy)
        u6:Destroy();
    end);

    if u4.ChangeHook then
        local u16 = nil;
        u16 = u6:Connect(u4.Character:GetAttributeChangedSignal(u4.ChangeHook.Attribute), function() -- Line: 126
            -- upvalues: Adjustments (ref), u10 (copy), u4 (copy), u6 (copy), u16 (ref)
            Adjustments(u10, u4.ChangeHook.Data, true);
            u6:Remove(u16);
        end);
    end;

    Adjustments(u10, u4);
    u10.Container.Dialogue.Text = "";
    u10.Container.Dialogue.Shadow.Text = "";
    u10.Container.Size = UDim2.fromScale(u10.Container.Size.X.Scale * 0.25, u10.Container.Size.Y.Scale * 0.5);
    u10.Container.Position = UDim2.fromScale(u10.Container.Position.X.Scale, u10.Container.Position.Y.Scale - 0.02);
    u10.Enabled = true;

    for _, v in u11 do
        v:Play();
    end;

    task.spawn(function() -- Line: 142
        -- upvalues: EffectsHandler (ref), u11 (copy), u7 (ref), u4 (copy), u9 (copy), u10 (copy), u8 (copy), u6 (copy)
        EffectsHandler.Wait(u11[1].TweenInfo.Time / 1.25);

        if u7 then
            return;
        end;

        local Text = u4.Text;
        local v17 = 0 + u9;

        for i, v in utf8.graphemes(Text) do
            if u7 then
                break;
            end;

            v17 = v17 - u9;
            local Dialogue = u10.Container.Dialogue;
            Dialogue.Text = Dialogue.Text .. Text:sub(i, v);
            u10.Container.Dialogue.Shadow.Text = u10.Container.Dialogue.Text;

            if v17 < u9 then
                v17 = v17 + EffectsHandler.Wait(u9 - v17);
            end;
        end;

        if u4.Endlag then
            EffectsHandler.Wait(u4.Endlag / u8);
        end;

        if u7 then
            return;
        end;

        u6:Destroy();
    end);
end;