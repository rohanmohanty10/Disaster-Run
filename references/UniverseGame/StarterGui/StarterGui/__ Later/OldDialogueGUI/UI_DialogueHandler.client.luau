  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local RichText = require(script.RichText);
local TweenService = game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
local Parent = script.Parent;
local DialogueFrame = Parent.DialogueFrame;
local DialogueTXT = DialogueFrame.DialogueTXT;
local DialogueTextFrame = DialogueFrame.DialogueTextFrame;
local Page = DialogueFrame.ResponseFrame.Page;
local UIListLayout = Page.UIListLayout;
local Close = DialogueFrame.Close;
local Assets = Parent.Assets;
local NameLabel = DialogueFrame.NameLabel;
local LocalPlayer = game.Players.LocalPlayer;
local u1 = {};

local function FormatText(u2) -- Line: 29
    -- upvalues: LocalPlayer (copy)
    local v3 = {
        ["<PlayerName>"] = LocalPlayer.Name,
        ["<AbilityName>"] = LocalPlayer.Data.Ability:GetAttribute("AbilityName")
    };

    for i, v in pairs(v3) do
        pcall(function() -- Line: 35
            -- upvalues: u2 (ref), i (copy), v (copy)
            u2 = string.gsub(u2, i, v);
        end);
    end;

    return u2;
end;

local function ClearResponses() -- Line: 42
    -- upvalues: u1 (copy)
    for _, v in ipairs(u1) do
        v:Destroy();
    end;

    table.clear(u1);
end;

local function updateCanvasSize() -- Line: 49
    -- upvalues: UIListLayout (copy), Page (copy)
    local AbsoluteContentSize = UIListLayout.AbsoluteContentSize;
    Page.CanvasSize = UDim2.fromOffset(AbsoluteContentSize.X, AbsoluteContentSize.Y);
end;

local function SetTitle(p4) -- Line: 54
    -- upvalues: NameLabel (copy)
    NameLabel.TextBox.Text = p4;
end;

local function SetDialogue(p5) -- Line: 58
    -- upvalues: DialogueTXT (copy), FormatText (copy), RichText (copy), DialogueTextFrame (copy)
    DialogueTXT.Text = "";
    local v6 = FormatText(p5);
    local v7 = {
        Font = "Ubuntu"
    };
    local v8 = math.floor(#v6 / 200);
    v7.AnimateStepFrequency = math.max(v8, 1);
    RichText:New(DialogueTextFrame, v6, v7):Animate();
end;

local function AddResponse(p9, p10) -- Line: 68
    -- upvalues: Assets (copy), Page (copy), TweenService (copy), EffectsHandler (copy), SoundService (copy), LocalPlayer (copy), u1 (copy), UIListLayout (copy), AddResponse (copy)
    local u11 = p9:GetLinkedResponses();
    local u12 = p9:GetCallback();
    local u13 = Assets.ResponseIMG:Clone();
    local ResponseTXT = u13.ResponseTXT;
    ResponseTXT.Text = p9:GetText();
    u13.Visible = true;
    u13.Parent = Page;
    u13.MouseEnter:Connect(function() -- Line: 78
        -- upvalues: TweenService (ref), u13 (copy), EffectsHandler (ref), SoundService (ref)
        TweenService:Create(u13, TweenInfo.new(0.25), {
            Size = UDim2.new(1.15, 0, 0, 50)
        }):Play();
        EffectsHandler.CallEffect("ClientAudio", SoundService.DialogueSounds.Hover);
    end);
    u13.MouseLeave:Connect(function() -- Line: 83
        -- upvalues: TweenService (ref), u13 (copy)
        TweenService:Create(u13, TweenInfo.new(0.25), {
            Size = UDim2.new(1, 0, 0, 50)
        }):Play();
    end);
    ResponseTXT.MouseButton1Click:Connect(function() -- Line: 87
        -- upvalues: u12 (copy), LocalPlayer (ref), u1 (ref), UIListLayout (ref), Page (ref), u11 (copy), AddResponse (ref), EffectsHandler (ref), SoundService (ref)
        local v14 = u12(LocalPlayer);

        if v14 == "ClearResponses" then
            for _, v in ipairs(u1) do
                v:Destroy();
            end;

            table.clear(u1);
            local AbsoluteContentSize = UIListLayout.AbsoluteContentSize;
            Page.CanvasSize = UDim2.fromOffset(AbsoluteContentSize.X, AbsoluteContentSize.Y);
        end;

        if #u11 > 0 and v14 == "Continue" then
            for _, v in ipairs(u1) do
                v:Destroy();
            end;

            table.clear(u1);

            for _, v in ipairs(u11) do
                AddResponse(v);
            end;

            local AbsoluteContentSize = UIListLayout.AbsoluteContentSize;
            Page.CanvasSize = UDim2.fromOffset(AbsoluteContentSize.X, AbsoluteContentSize.Y);
        end;

        EffectsHandler.CallEffect("ClientAudio", SoundService.DialogueSounds.Hover);
    end);
    table.insert(u1, u13);
end;

Knit.OnStart():await();
local Dialogues = require(PathShortcuts.ReplicatedModules.DialoguePackage.Dialogues);
local v15 = Knit.GetService("DialogueService");
local u16 = nil;
v15.DialogueSignal:Connect(function(p17, p18) -- Line: 113
    -- upvalues: Dialogues (copy), u16 (ref), u1 (copy), SetDialogue (copy), NameLabel (copy), Parent (copy), Page (copy), AddResponse (copy), UIListLayout (copy)
    local u19 = Dialogues[p17];

    if not u19 then
        return;
    end;

    if u16 == u19 then
        return;
    end;

    if not u16 then
        u16 = u19;
    end;

    if u16 ~= u19 then
        u16:Destroy();
        u16 = u19;

        for _, v in ipairs(u1) do
            v:Destroy();
        end;

        table.clear(u1);
    end;

    local v20 = u19:CheckStep();
    u19:AddCallback("TextChanged", function(p21) -- Line: 129
        -- upvalues: SetDialogue (ref)
        SetDialogue(p21);
    end);
    u19:AddCallback("TitleChanged", function(p22) -- Line: 132
        -- upvalues: NameLabel (ref)
        NameLabel.TextBox.Text = p22;
    end);
    u19:AddCallback("OnDestroy", function() -- Line: 136
        -- upvalues: u16 (ref), u19 (copy), Parent (ref), Page (ref), NameLabel (ref), SetDialogue (ref), u1 (ref)
        if u16 == u19 then
            u16 = nil;
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
    local v23 = u19:GetTitle();
    NameLabel.TextBox.Text = v23;
    SetDialogue(u19:GetText());

    for _, v in ipairs(u19:GetResponses(v20)) do
        AddResponse(v);
    end;

    local AbsoluteContentSize = UIListLayout.AbsoluteContentSize;
    Page.CanvasSize = UDim2.fromOffset(AbsoluteContentSize.X, AbsoluteContentSize.Y);
    local v24 = u19:GetNPC(v20);

    if v24 and (p18 and v24.NPC ~= p18) then
        for _, v in ipairs(u1) do
            v:Destroy();
        end;

        table.clear(u1);
        local AbsoluteContentSize2 = UIListLayout.AbsoluteContentSize;
        Page.CanvasSize = UDim2.fromOffset(AbsoluteContentSize2.X, AbsoluteContentSize2.Y);
        u19:SetText(v24.Texts and v24.Texts[p18] or string.format("Talk to <Color=Blue>%s<Color=/> to continue", v24.NPC));
        NameLabel.TextBox.Text = p18;
    end;

    Parent.Enabled = true;
    Page.Visible = true;
end);
Close.MouseButton1Click:Connect(function() -- Line: 167
    -- upvalues: u16 (ref), Parent (copy), Page (copy), NameLabel (copy), SetDialogue (copy), u1 (copy)
    if u16 then
        u16:Destroy();
        u16 = nil;
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
DialogueTextFrame.ChildAdded:Connect(function() -- Line: 179
    -- upvalues: DialogueTextFrame (copy)
    local UIListLayout2 = DialogueTextFrame:FindFirstChild("UIListLayout");

    if not UIListLayout2 or UIListLayout2:GetAttribute("Binded") then
        return;
    end;

    UIListLayout2:SetAttribute("Binded", true);
    UIListLayout2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 183
        -- upvalues: DialogueTextFrame (ref), UIListLayout2 (copy)
        DialogueTextFrame.CanvasSize = UDim2.fromOffset(0, UIListLayout2.AbsoluteContentSize.Y + 20);
    end);
end);