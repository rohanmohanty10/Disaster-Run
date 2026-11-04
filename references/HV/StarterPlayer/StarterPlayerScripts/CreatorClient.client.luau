 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local LocalPlayer = Players.LocalPlayer;
local Presentation = game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Presentation");
local Session = Presentation.Parent:WaitForChild("Game"):WaitForChild("Session");
local CreatorPolicy = require(Presentation:WaitForChild("CreatorPolicy"));
local HudNavigation = require(Presentation:WaitForChild("HudNavigation"));
local u1 = require(Presentation:WaitForChild("CreatorVisibility")).new(LocalPlayer);
local u2 = require(Presentation:WaitForChild("CreatorView")).new(LocalPlayer);
local u3 = false;
local u4 = false;
local u5 = {};

local function on(p6, p7) -- Line: 13
    -- upvalues: u5 (copy)
    table.insert(u5, p6:Connect(p7));
end;

local function shown() -- Line: 16
    -- upvalues: LocalPlayer (copy)
    return LocalPlayer:GetAttribute("TestUIHidden") == false;
end;

if LocalPlayer:GetAttribute("CreatorCameraSpeed") == nil then
    LocalPlayer:SetAttribute("CreatorCameraSpeed", 0.65);
end;

if LocalPlayer:GetAttribute("CreatorFOV") == nil then
    LocalPlayer:SetAttribute("CreatorFOV", 60);
end;

local function render() -- Line: 19
    -- upvalues: u2 (copy), u3 (ref), CreatorPolicy (copy), LocalPlayer (copy), Session (copy), u1 (copy), UserInputService (copy)
    local v8 = CreatorPolicy.authorized(LocalPlayer);

    if v8 then
        if LocalPlayer:GetAttribute("ClientReady") == true then
            v8 = LocalPlayer:GetAttribute("TestUIHidden") == false;
        else
            v8 = false;
        end;
    end;

    local v9 = CreatorPolicy.lobby(LocalPlayer, Session);
    local v10 = LocalPlayer:GetAttribute("CreatorCameraActive") == true;
    local hidden = u1.hidden;
    local v11 = LocalPlayer:GetAttribute("CreatorCameraSpeed") or 0.65;
    local v12 = LocalPlayer:GetAttribute("CreatorFOV") or 60;
    u2:render(u3, v8, v9, v10, hidden, v11, v12, UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled);
end;

local function panel(p13) -- Line: 24
    -- upvalues: CreatorPolicy (copy), LocalPlayer (copy), u1 (copy), HudNavigation (copy), u3 (ref), render (copy)
    if p13 then
        if not CreatorPolicy.authorized(LocalPlayer) or LocalPlayer:GetAttribute("ClientReady") ~= true or LocalPlayer:GetAttribute("TestUIHidden") ~= false then
            return;
        end;

        u1:setHidden(false);
        HudNavigation.opening("CreatorStudio");
    end;

    u3 = p13;
    LocalPlayer:SetAttribute("CreatorPanelOpen", p13 or nil);
    render();
end;

local function restore() -- Line: 31
    -- upvalues: u1 (copy), render (copy)
    u1:setHidden(false);
    render();
end;

local function camera() -- Line: 32
    -- upvalues: CreatorPolicy (copy), LocalPlayer (copy), u1 (copy), render (copy), u3 (ref), HudNavigation (copy)
    if not CreatorPolicy.authorized(LocalPlayer) then
        return;
    end;

    u1:setHidden(false);
    render();
    u3 = false;
    LocalPlayer:SetAttribute("CreatorPanelOpen", nil);
    render();
    HudNavigation.activate("CreatorCamera");
end;

local function clean() -- Line: 36
    -- upvalues: u1 (copy), render (copy), CreatorPolicy (copy), LocalPlayer (copy), Session (copy), u3 (ref), HudNavigation (copy)
    if u1.hidden then
        u1:setHidden(false);
        render();

        return;
    end;

    if not CreatorPolicy.lobby(LocalPlayer, Session) then
        return;
    end;

    u3 = false;
    LocalPlayer:SetAttribute("CreatorPanelOpen", nil);
    render();
    HudNavigation.opening("CreatorCapture");
    u1:setHidden(true);
    render();
end;

local function refresh() -- Line: 41
    -- upvalues: LocalPlayer (copy), CreatorPolicy (copy), Session (copy), u1 (copy), render (copy), u3 (ref), u4 (ref)
    local v14 = LocalPlayer:GetAttribute("CreatorCameraActive") == true;

    if not CreatorPolicy.lobby(LocalPlayer, Session) then
        u1:setHidden(false);
        render();

        if u3 then
            u3 = false;
            LocalPlayer:SetAttribute("CreatorPanelOpen", nil);
            render();
        end;
    end;

    if u4 and not v14 then
        u1:setHidden(false);
        render();
    end;

    u4 = v14;
    render();
end;

table.insert(u5, u2.commands.Activated:Connect(function() -- Line: 47
    -- upvalues: u1 (copy), render (copy), u3 (ref), LocalPlayer (copy), Presentation (copy)
    u1:setHidden(false);
    render();
    u3 = false;
    LocalPlayer:SetAttribute("CreatorPanelOpen", nil);
    render();
    Presentation.Parent.Admin.AdminEvent:FireServer("Command", ";help");
end));
table.insert(u5, u2.open.Activated:Connect(function() -- Line: 51
    -- upvalues: panel (copy), u3 (ref)
    panel(not u3);
end));
table.insert(u5, u2.close.Activated:Connect(function() -- Line: 52
    -- upvalues: u3 (ref), LocalPlayer (copy), render (copy)
    u3 = false;
    LocalPlayer:SetAttribute("CreatorPanelOpen", nil);
    render();
end));
table.insert(u5, u2.camera.Activated:Connect(camera));
table.insert(u5, u2.hide.Activated:Connect(clean));
table.insert(u5, u2.restore.Activated:Connect(restore));

for _, v in u2.speeds do
    table.insert(u5, v.button.Activated:Connect(function() -- Line: 54
        -- upvalues: LocalPlayer (copy), v (copy), render (copy)
        LocalPlayer:SetAttribute("CreatorCameraSpeed", v.value);
        render();
    end));
end;

for _, v in u2.lenses do
    table.insert(u5, v.button.Activated:Connect(function() -- Line: 55
        -- upvalues: LocalPlayer (copy), v (copy), render (copy)
        LocalPlayer:SetAttribute("CreatorFOV", v.value);
        render();
    end));
end;

table.insert(u5, UserInputService.InputBegan:Connect(function(p15, p16) -- Line: 56
    -- upvalues: u1 (copy), render (copy), CreatorPolicy (copy), LocalPlayer (copy), UserInputService (copy), GuiService (copy), u3 (ref), HudNavigation (copy), clean (copy)
    if p15.KeyCode == Enum.KeyCode.Escape and u1.hidden then
        u1:setHidden(false);
        render();

        return;
    end;

    if not CreatorPolicy.authorized(LocalPlayer) or (p16 or (UserInputService:GetFocusedTextBox() or GuiService.MenuIsOpen)) then
        return;
    end;

    if p15.KeyCode ~= Enum.KeyCode.F6 then
        if p15.KeyCode == Enum.KeyCode.F8 then
            clean();
        end;

        return;
    end;

    if not CreatorPolicy.authorized(LocalPlayer) then
        return;
    end;

    u1:setHidden(false);
    render();
    u3 = false;
    LocalPlayer:SetAttribute("CreatorPanelOpen", nil);
    render();
    HudNavigation.activate("CreatorCamera");
end));
table.insert(u5, GuiService.MenuOpened:Connect(restore));
table.insert(u5, HudNavigation.Opening.Event:Connect(function(p17) -- Line: 64
    -- upvalues: u3 (ref), LocalPlayer (copy), render (copy)
    if p17 ~= "CreatorStudio" and u3 then
        u3 = false;
        LocalPlayer:SetAttribute("CreatorPanelOpen", nil);
        render();
    end;
end));

for _, v in { "CreatorAuthorized", "ClientReady", "GameRole", "CreatorCameraActive", "CreatorFOV", "CreatorCameraSpeed" } do
    local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal(v);
    table.insert(u5, AttributeChangedSignal:Connect(refresh));
end;

for _, v in CreatorPolicy.PlayerBlockers do
    local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal(v);
    table.insert(u5, AttributeChangedSignal:Connect(refresh));
end;

local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("TestUIHidden");
table.insert(u5, AttributeChangedSignal:Connect(function() -- Line: 67
    -- upvalues: u3 (ref), LocalPlayer (copy), render (copy)
    if not u3 or LocalPlayer:GetAttribute("TestUIHidden") == false then
        render();

        return;
    end;

    u3 = false;
    LocalPlayer:SetAttribute("CreatorPanelOpen", nil);
    render();
end));

for _, v in { "MapChanging", "GlobalPaused" } do
    local AttributeChangedSignal2 = Session:GetAttributeChangedSignal(v);
    table.insert(u5, AttributeChangedSignal2:Connect(refresh));
end;

table.insert(u5, LocalPlayer.CharacterRemoving:Connect(function() -- Line: 69
    -- upvalues: u1 (copy), render (copy), u3 (ref), LocalPlayer (copy)
    u1:setHidden(false);
    render();
    u3 = false;
    LocalPlayer:SetAttribute("CreatorPanelOpen", nil);
    render();
end));
table.insert(u5, UserInputService.LastInputTypeChanged:Connect(render));
refresh();
script.Destroying:Connect(function() -- Line: 72
    -- upvalues: u5 (copy), u1 (copy), LocalPlayer (copy), u2 (copy)
    for _, v in u5 do
        v:Disconnect();
    end;

    u1:destroy();
    LocalPlayer:SetAttribute("CreatorPanelOpen", nil);
    u2:destroy();
end);