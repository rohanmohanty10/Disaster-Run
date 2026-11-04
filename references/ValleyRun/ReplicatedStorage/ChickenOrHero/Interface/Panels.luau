 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local ContextActionService = game:GetService("ContextActionService");
local HudNavigation = require(script.Parent.Parent.Presentation.HudNavigation);
local Cursor = require(script.Parent.Cursor);
local Telemetry = require(script.Parent.Telemetry);
local LocalPlayer = Players.LocalPlayer;
local v1 = {};
local u2 = {};
u2.__index = u2;
local u3 = { "ScreenPresentationActive", "AdminRefreshActive" };
local u4 = {};
local u5 = {};
local u6 = false;
local u7 = false;

local function ready() -- Line: 22
    -- upvalues: LocalPlayer (copy), u3 (copy)
    if LocalPlayer:GetAttribute("ClientReady") ~= true then
        return false;
    end;

    for _, v in u3 do
        if LocalPlayer:GetAttribute(v) == true then
            return false;
        end;
    end;

    return true;
end;

local function back(p8, p9) -- Line: 34
    -- upvalues: u5 (copy)
    if p9 ~= Enum.UserInputState.Begin then
        return Enum.ContextActionResult.Pass;
    end;

    local v10 = u5[#u5];

    if not v10 then
        return Enum.ContextActionResult.Pass;
    end;

    v10:close("Back");

    return Enum.ContextActionResult.Sink;
end;

local function refreshBack() -- Line: 47
    -- upvalues: u5 (copy), u7 (ref), ContextActionService (copy), back (copy)
    local v11 = #u5 > 0;

    if v11 == u7 then
        return;
    end;

    u7 = v11;

    if v11 then
        ContextActionService:BindActionAtPriority("CoHPanelBack", back, false, Enum.ContextActionPriority.High.Value + 100, Enum.KeyCode.ButtonB);

        return;
    end;

    ContextActionService:UnbindAction("CoHPanelBack");
end;

local function closeWhere(p12, p13) -- Line: 66
    -- upvalues: u5 (copy)
    for i = #u5, 1, -1 do
        local v14 = u5[i];
        local v15;

        if v14 and p12(v14) then
            v14:close(p13);
            v15 = i;
        else
            v15 = i;
        end;
    end;
end;

local function start() -- Line: 75
    -- upvalues: u6 (ref), HudNavigation (copy), closeWhere (copy), UserInputService (copy), u5 (copy), LocalPlayer (copy), ready (copy), u3 (copy)
    if u6 then
        return;
    end;

    u6 = true;
    HudNavigation.Opening.Event:Connect(function(u16) -- Line: 81
        -- upvalues: closeWhere (ref)
        closeWhere(function(p17) -- Line: 82
            -- upvalues: u16 (copy)
            return p17.id ~= u16;
        end, "Replaced");
    end);
    UserInputService.InputBegan:Connect(function(p18, p19) -- Line: 86
        -- upvalues: u5 (ref)
        local v20 = not p19 and (p18.KeyCode == Enum.KeyCode.Escape and u5[#u5]);

        if v20 then
            v20:close("Back");
        end;
    end);
    LocalPlayer:GetAttributeChangedSignal("InMatch"):Connect(function() -- Line: 94
        -- upvalues: LocalPlayer (ref), closeWhere (ref)
        if LocalPlayer:GetAttribute("InMatch") == true then
            closeWhere(function(p21) -- Line: 96
                return p21.lobbyOnly or p21.closeOnMatch;
            end, "Match");
        end;
    end);

    local function readiness() -- Line: 101
        -- upvalues: ready (ref), closeWhere (ref)
        if not ready() then
            closeWhere(function() -- Line: 103
                return true;
            end, "NotReady");
        end;
    end;

    LocalPlayer:GetAttributeChangedSignal("ClientReady"):Connect(readiness);

    for _, v in u3 do
        LocalPlayer:GetAttributeChangedSignal(v):Connect(readiness);
    end;

    LocalPlayer.CharacterAdded:Connect(function() -- Line: 112
        -- upvalues: closeWhere (ref)
        closeWhere(function(p22) -- Line: 113
            return p22.closeOnRespawn;
        end, "Respawn");
    end);
end;

function v1.define(p23) -- Line: 122
    -- upvalues: u4 (copy), start (copy), u2 (copy), HudNavigation (copy)
    local v24;

    if type(p23.id) == "string" then
        v24 = typeof(p23.frame) == "Instance";
    else
        v24 = false;
    end;

    assert(v24, "Panels.define needs an id and a frame");
    assert(not u4[p23.id], "panel already defined: " .. p23.id);
    start();
    local u25 = setmetatable({
        isOpen = false,
        id = p23.id,
        frame = p23.frame,
        attribute = p23.attribute,
        lobbyOnly = p23.lobbyOnly == true,
        closeOnMatch = p23.closeOnMatch == true,
        closeOnRespawn = p23.closeOnRespawn ~= false,
        cursor = p23.cursor ~= false,
        canOpen = p23.canOpen,
        onOpen = p23.onOpen,
        onClose = p23.onClose,
        connections = {}
    }, u2);
    p23.frame.Visible = false;

    if p23.closeButton then
        table.insert(u25.connections, p23.closeButton.Activated:Connect(function() -- Line: 144
            -- upvalues: u25 (copy)
            u25:close("Button");
        end));
    end;

    if p23.register ~= false then
        HudNavigation.register(p23.id, function() -- Line: 150
            -- upvalues: u25 (copy)
            u25:toggle();
        end);
        HudNavigation.setAvailable(p23.id, true);
    end;

    u4[p23.id] = u25;

    return u25;
end;

function u2.open(p26) -- Line: 159
    -- upvalues: ready (copy), LocalPlayer (copy), Telemetry (copy), HudNavigation (copy), u5 (copy), Cursor (copy), u7 (ref), ContextActionService (copy), back (copy)
    if p26.isOpen then
        return true;
    end;

    if not ready() then
        return false;
    end;

    if p26.lobbyOnly and LocalPlayer:GetAttribute("InMatch") == true or p26.canOpen and not p26.canOpen() then
        Telemetry.track("panel_blocked", p26.id);

        return false;
    end;

    HudNavigation.opening(p26.id);
    p26.isOpen = true;
    p26.openedAt = os.clock();
    Telemetry.track("panel_open", p26.id);
    table.insert(u5, p26);

    if p26.attribute then
        LocalPlayer:SetAttribute(p26.attribute, true);
    end;

    if p26.cursor then
        Cursor.request(p26);
    end;

    p26.frame.Visible = true;
    local v27 = #u5 > 0;

    if v27 ~= u7 then
        u7 = v27;

        if v27 then
            ContextActionService:BindActionAtPriority("CoHPanelBack", back, false, Enum.ContextActionPriority.High.Value + 100, Enum.KeyCode.ButtonB);
        else
            ContextActionService:UnbindAction("CoHPanelBack");
        end;
    end;

    if p26.onOpen then
        task.spawn(p26.onOpen);
    end;

    return true;
end;

function u2.close(p28, p29) -- Line: 190
    -- upvalues: u5 (copy), LocalPlayer (copy), Cursor (copy), u7 (ref), ContextActionService (copy), back (copy), Telemetry (copy)
    if not p28.isOpen then
        return;
    end;

    p28.isOpen = false;
    local table_find_ret = table.find(u5, p28);

    if table_find_ret then
        table.remove(u5, table_find_ret);
    end;

    p28.frame.Visible = false;

    if p28.attribute then
        LocalPlayer:SetAttribute(p28.attribute, nil);
    end;

    Cursor.release(p28);
    local v30 = #u5 > 0;

    if v30 ~= u7 then
        u7 = v30;

        if v30 then
            ContextActionService:BindActionAtPriority("CoHPanelBack", back, false, Enum.ContextActionPriority.High.Value + 100, Enum.KeyCode.ButtonB);
        else
            ContextActionService:UnbindAction("CoHPanelBack");
        end;
    end;

    if p29 ~= "NotReady" and p29 ~= "Destroyed" then
        local track = Telemetry.track;
        local v31 = p28.id .. ":" .. (p29 or "Closed");
        local os_clock_ret = os.clock();
        local v32 = p28.openedAt or os.clock();
        track("panel_close", v31, (math.floor(os_clock_ret - v32)));
    end;

    if p28.onClose then
        task.spawn(p28.onClose, p29 or "Closed");
    end;
end;

function u2.toggle(p33) -- Line: 214
    if p33.isOpen then
        p33:close("Toggle");

        return;
    end;

    p33:open();
end;

function u2.destroy(p34) -- Line: 222
    -- upvalues: u4 (copy)
    p34:close("Destroyed");

    for _, v in p34.connections do
        v:Disconnect();
    end;

    table.clear(p34.connections);

    if u4[p34.id] == p34 then
        u4[p34.id] = nil;
    end;
end;

function v1.get(p35) -- Line: 233
    -- upvalues: u4 (copy)
    return u4[p35];
end;

function v1.anyOpen() -- Line: 237
    -- upvalues: u5 (copy)
    return #u5 > 0;
end;

return v1;