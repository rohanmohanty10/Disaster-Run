  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local RichText = require(script.RichText);
local TweenService = game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
local Parent = script.Parent;
local Frame = Parent.Frame;
local DialogueFrame = Frame.DialogueFrame;
local DialogueTXT = DialogueFrame.DialogueTXT;
local DialogueTextFrame = DialogueFrame.DialogueTextFrame;
local Page = Frame.ResponseFrame.Page;
local UIListLayout = Page.UIListLayout;
local Close = Frame.Close;
local Assets = Parent.Assets;
local NameLabel = Frame.NameLabel;
local LocalPlayer = game.Players.LocalPlayer;
local u1 = {};

local function FormatText(u2) -- Line: 30
    -- upvalues: LocalPlayer (copy)
    local v3 = {
        ["<PlayerName>"] = LocalPlayer.Name,
        ["<AbilityName>"] = LocalPlayer.Data.Ability:GetAttribute("AbilityName")
    };

    for i, v in pairs(v3) do
        pcall(function() -- Line: 36
            -- upvalues: u2 (ref), i (copy), v (copy)
            u2 = string.gsub(u2, i, v);
        end);
    end;

    return u2;
end;

local function ClearResponses() -- Line: 43
    -- upvalues: u1 (copy)
    for _, v in ipairs(u1) do
        v:Destroy();
    end;

    table.clear(u1);
end;

local function updateCanvasSize() -- Line: 50
    -- upvalues: UIListLayout (copy)
    local _ = UIListLayout.AbsoluteContentSize;
end;

local function SetTitle(p4) -- Line: 55
    -- upvalues: NameLabel (copy)
    NameLabel.TextBox.Text = p4;
end;

local u5 = false;

local function SetDialogue(p6, p7) -- Line: 61
    -- upvalues: u5 (ref), DialogueTXT (copy), FormatText (copy), RichText (copy), DialogueTextFrame (copy)
    u5 = false;
    DialogueTXT.Text = "";
    local v8 = FormatText(p6);
    local v9 = {
        TextColor3 = "UG",
        Font = Enum.Font.SourceSans
    };
    local v10 = math.floor(#v8 / 200);
    v9.AnimateStepFrequency = math.max(v10, 1);
    v9.ContainerVerticalAlignment = Enum.VerticalAlignment.Top;
    RichText:New(DialogueTextFrame, v8, v9):Animate(p7);
    u5 = true;
end;

local function AddResponse(u11, p12) -- Line: 75
    -- upvalues: u5 (ref), Assets (copy), Page (copy), TweenService (copy), EffectsHandler (copy), SoundService (copy), LocalPlayer (copy), u1 (copy), UIListLayout (copy), AddResponse (copy)
    repeat
        task.wait(0.1);
    until u5;

    local u13 = u11:GetCallback();
    local u14 = Assets.ResponseIMG:Clone();
    local ResponseTXT = u14.ResponseTXT;
    ResponseTXT.Text = u11:GetText();
    u14.Visible = true;
    u14.Parent = Page;
    u14.MouseEnter:Connect(function() -- Line: 88
        -- upvalues: TweenService (ref), u14 (copy), EffectsHandler (ref), SoundService (ref)
        TweenService:Create(u14, TweenInfo.new(0.25), {
            BackgroundColor3 = Color3.fromRGB(150, 150, 150)
        }):Play();
        EffectsHandler.CallEffect("ClientAudio", SoundService.DialogueSounds.Hover);
    end);
    u14.MouseLeave:Connect(function() -- Line: 93
        -- upvalues: TweenService (ref), u14 (copy)
        TweenService:Create(u14, TweenInfo.new(0.25), {
            BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        }):Play();
    end);
    ResponseTXT.MouseButton1Click:Connect(function() -- Line: 97
        -- upvalues: u13 (copy), LocalPlayer (ref), u1 (ref), UIListLayout (ref), u11 (copy), AddResponse (ref), EffectsHandler (ref), SoundService (ref)
        local v15 = u13(LocalPlayer);

        if v15 == "ClearResponses" then
            for _, v in ipairs(u1) do
                v:Destroy();
            end;

            table.clear(u1);
            local _ = UIListLayout.AbsoluteContentSize;
        elseif v15 == "Continue" then
            for _, v in ipairs(u1) do
                v:Destroy();
            end;

            table.clear(u1);

            for _, v in ipairs(u11:GetLinkedResponses()) do
                AddResponse(v);
            end;

            local _ = UIListLayout.AbsoluteContentSize;
        end;

        EffectsHandler.CallEffect("ClientAudio", SoundService.DialogueSounds.Hover);
    end);

    function u11.RefreshResponses(p16) -- Line: 115
        -- upvalues: u1 (ref), u11 (copy), AddResponse (ref), UIListLayout (ref)
        for _, v in ipairs(u1) do
            v:Destroy();
        end;

        table.clear(u1);

        for _, v in ipairs(u11:GetLinkedResponses()) do
            AddResponse(v);
        end;

        local _ = UIListLayout.AbsoluteContentSize;
    end;

    table.insert(u1, u14);
end;

Knit.OnStart():await();
local Dialogues = require(PathShortcuts.ReplicatedModules.DialoguePackage.Dialogues);
local v17 = Knit.GetService("DialogueService");
local u18 = nil;
v17.DialogueSignal:Connect(function(p19, p20, p21, ...) -- Line: 134
    -- upvalues: Dialogues (copy), u18 (ref), u1 (copy), SetDialogue (copy), NameLabel (copy), Parent (copy), Page (copy), AddResponse (copy), UIListLayout (copy)
    local u22 = Dialogues[p19];

    if not u22 then
        return;
    end;

    if u18 == u22 then
        return;
    end;

    if not u18 then
        u18 = u22;
    end;

    if u18 ~= u22 then
        u18:Destroy();
        u18 = u22;

        for _, v in ipairs(u1) do
            v:Destroy();
        end;

        table.clear(u1);
    end;

    u22:SetNPCName(p20);
    u22:SetNPCModel(p21);

    if u22.Setup then
        u22:Setup(...);
    end;

    local v23 = u22:CheckStep(...);
    u22:AddCallback("TextChanged", function(p24, p25) -- Line: 158
        -- upvalues: SetDialogue (ref), u22 (copy)
        SetDialogue(p25, u22.YieldResponses);
    end);
    u22:AddCallback("TitleChanged", function(p26, p27) -- Line: 161
        -- upvalues: NameLabel (ref)
        NameLabel.TextBox.Text = p27;
    end);
    u22:AddCallback("OnDestroy", function(p28) -- Line: 165
        -- upvalues: u18 (ref), u22 (copy), Parent (ref), Page (ref), NameLabel (ref), SetDialogue (ref), u1 (ref)
        if u18 == u22 then
            u18 = nil;
        end;

        Parent.Enabled = false;
        Page.Visible = false;
        NameLabel.TextBox.Text = "";
        SetDialogue("");

        for _, v in ipairs(u1) do
            v:Destroy();
        end;

        table.clear(u1);
    end);
    local v29 = u22:GetTitle();
    NameLabel.TextBox.Text = v29;
    SetDialogue(u22:GetText(), u22.YieldResponses);

    for _, v in ipairs(u22:GetResponses(v23)) do
        AddResponse(v);
    end;

    local _ = UIListLayout.AbsoluteContentSize;
    local v30 = u22:GetNPC(v23);

    if v30 and (p20 and v30.NPC ~= p20) then
        for _, v in ipairs(u1) do
            v:Destroy();
        end;

        table.clear(u1);
        local _ = UIListLayout.AbsoluteContentSize;
        u22:SetText(v30.Texts and v30.Texts[p20] or string.format("Talk to <Color=Blue>%s<Color=/> to continue", v30.NPC));
        NameLabel.TextBox.Text = p20;
    end;

    Parent.Enabled = true;
    Page.Visible = true;
end);
Close.MouseButton1Click:Connect(function() -- Line: 200
    -- upvalues: u18 (ref), Parent (copy), Page (copy), NameLabel (copy), SetDialogue (copy), u1 (copy)
    if u18.CannotClose then
        return;
    end;

    task.delay(0.2, function() -- Line: 207
        -- upvalues: Parent (ref), Page (ref), NameLabel (ref), SetDialogue (ref), u1 (ref), u18 (ref)
        Parent.Enabled = false;
        Page.Visible = false;
        NameLabel.TextBox.Text = "";
        SetDialogue("");

        for _, v in ipairs(u1) do
            v:Destroy();
        end;

        table.clear(u1);

        if u18 then
            u18:Destroy();
            u18 = nil;
        end;
    end);
end);
DialogueTextFrame.ChildAdded:Connect(function() -- Line: 221
    -- upvalues: DialogueTextFrame (copy)
    local UIListLayout2 = DialogueTextFrame:FindFirstChild("UIListLayout");

    if not UIListLayout2 or UIListLayout2:GetAttribute("Binded") then
        return;
    end;

    UIListLayout2:SetAttribute("Binded", true);
end);