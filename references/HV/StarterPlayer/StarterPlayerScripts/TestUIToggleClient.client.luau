 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local TextChatService = game:GetService("TextChatService");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local u1 = {
    StudioAbilityTests = true,
    HitboxComparison = true,
    HitReplayStatus = true,
    StudioCheatTest = true,
    StudioKnifePreview = true,
    StudioEmotePreview = true
};
local u2 = {};
local u3 = {};
local u4 = true;
LocalPlayer:SetAttribute("TestUIHidden", true);

local function apply(p5, p6) -- Line: 29
    -- upvalues: u4 (ref)
    if u4 then
        if p5.Enabled then
            p6.restore = true;
            p5.Enabled = false;
        end;
    else
        p5.Enabled = p6.restore;
    end;
end;

local function track(u7) -- Line: 39
    -- upvalues: u2 (copy), u1 (copy), u4 (ref)
    if not u7:IsA("ScreenGui") or (u2[u7] or not u1[u7.Name] and u7:GetAttribute("TestOnlyUI") ~= true) then
        return;
    end;

    local u8 = {
        restore = u4 or u7.Enabled
    };
    u2[u7] = u8;
    u8.changed = u7:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 46
        -- upvalues: u4 (ref), u7 (copy), u8 (copy)
        if u4 and u7.Enabled then
            u8.restore = true;
            u7.Enabled = false;
        end;
    end);

    if u4 then
        if u7.Enabled then
            u8.restore = true;
            u7.Enabled = false;
        end;
    else
        u7.Enabled = u8.restore;
    end;
end;

local function setHidden(p9) -- Line: 61
    -- upvalues: u2 (copy), u4 (ref), LocalPlayer (copy)
    if p9 then
        for i, v in u2 do
            v.restore = i.Enabled;
        end;
    end;

    u4 = p9;
    LocalPlayer:SetAttribute("TestUIHidden", p9);

    for i, v in u2 do
        if u4 then
            if i.Enabled then
                v.restore = true;
                i.Enabled = false;
            end;
        else
            i.Enabled = v.restore;
        end;
    end;
end;

table.insert(u3, PlayerGui.ChildAdded:Connect(track));
table.insert(u3, PlayerGui.ChildRemoved:Connect(function(p10) -- Line: 54, Name: untrack
    -- upvalues: u2 (copy)
    local v11 = u2[p10];

    if v11 then
        u2[p10] = nil;
        v11.changed:Disconnect();
    end;
end));

for _, child in PlayerGui:GetChildren() do
    track(child);
end;

table.insert(u3, UserInputService.InputBegan:Connect(function(p12, p13) -- Line: 80
    -- upvalues: UserInputService (copy), LocalPlayer (copy), PlayerGui (copy), setHidden (copy), u4 (ref)
    if p13 or (p12.KeyCode ~= Enum.KeyCode.F4 or UserInputService:GetFocusedTextBox()) then
        return;
    end;

    if LocalPlayer:GetAttribute("AdminAuthorized") == true and PlayerGui:FindFirstChild("StaffPanel") then
        return;
    end;

    setHidden(not u4);
end));
local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("StaffOverlaysWanted");
table.insert(u3, AttributeChangedSignal:Connect(function() -- Line: 93
    -- upvalues: LocalPlayer (copy), u4 (ref), setHidden (copy)
    local Attribute = LocalPlayer:GetAttribute("StaffOverlaysWanted");

    if Attribute ~= nil and Attribute == true == u4 then
        setHidden(not Attribute);
    end;
end));
local TextChatCommand = Instance.new("TextChatCommand");
TextChatCommand.Name = "AdminUIToggleCommand";
TextChatCommand.PrimaryAlias = ":adminui";
TextChatCommand.SecondaryAlias = ":testui";
TextChatCommand.AutocompleteVisible = false;
table.insert(u3, TextChatCommand.Triggered:Connect(function() -- Line: 108
    -- upvalues: setHidden (copy), u4 (ref), LocalPlayer (copy), TextChatService (copy)
    setHidden(not u4);

    if LocalPlayer:GetAttribute("StaffOverlaysWanted") ~= nil then
        LocalPlayer:SetAttribute("StaffOverlaysWanted", not u4);
    end;

    local TextChannels = TextChatService:FindFirstChild("TextChannels");

    if TextChannels then
        TextChannels = TextChannels:FindFirstChild("RBXSystem");
    end;

    if TextChannels then
        TextChannels:DisplaySystemMessage(u4 and "[Admin UI] Hidden. Press F4 or chat :adminui to show it." or "[Admin UI] Shown. Press F4 or chat :adminui to hide it.");
    end;
end));
TextChatCommand.Parent = TextChatService;
script.Destroying:Connect(function() -- Line: 124
    -- upvalues: u3 (copy), u2 (copy), TextChatCommand (copy)
    for _, v in u3 do
        v:Disconnect();
    end;

    table.clear(u3);

    for _, v in u2 do
        v.changed:Disconnect();
    end;

    table.clear(u2);
    TextChatCommand:Destroy();
end);