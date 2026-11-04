 

 

local Players = game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local Presentation = ChickenOrHero:WaitForChild("Presentation");
local Game = ChickenOrHero:WaitForChild("Game");
local FFlags = require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags"));

if FFlags.GhostKeyTrader ~= true then
    CollectionService:GetInstanceAddedSignal("GhostTraderShowcase"):Connect(function(p1) -- Line: 28, Name: hideShowcase
        if p1:IsA("SurfaceGui") or p1:IsA("BillboardGui") then
            p1.Enabled = false;
        end;
    end);

    for _, v in CollectionService:GetTagged("GhostTraderShowcase") do
        if v:IsA("SurfaceGui") or v:IsA("BillboardGui") then
            v.Enabled = false;
        end;
    end;

    return;
end;

local ControlGate = require(ChickenOrHero:WaitForChild("Movement"):WaitForChild("ControlGate"));
local GhostTraderView = require(Presentation:WaitForChild("GhostTraderView"));
local Color3_fromRGB_ret = Color3.fromRGB(120, 255, 170);
local u2 = nil;
local u3 = nil;
local u4 = (-1 / 0);
local u5 = {};

local function live() -- Line: 54
    -- upvalues: FFlags (copy), u2 (ref), u3 (ref)
    local v6;

    if FFlags.GhostKeyTrader == true and u2 ~= nil then
        v6 = u3 == nil and true or u3.live ~= false;
    else
        v6 = false;
    end;

    return v6;
end;

local function ask() -- Line: 57
    -- upvalues: u2 (ref), u4 (ref)
    if u2 and os.clock() - u4 >= 12 then
        u4 = os.clock();
        u2:FireServer("State");
    end;
end;

local function refresh(p7, p8) -- Line: 66
    -- upvalues: FFlags (copy), u2 (ref), u3 (ref), LocalPlayer (copy), GhostTraderView (copy), ControlGate (copy)
    local v9;

    if FFlags.GhostKeyTrader == true and u2 ~= nil then
        v9 = u3 == nil and true or u3.live ~= false;
    else
        v9 = false;
    end;

    if v9 then
        if LocalPlayer:GetAttribute("ClientReady") == true and LocalPlayer:GetAttribute("InMatch") ~= true then
            v9 = not GhostTraderView.isOpen() and ControlGate.reason(LocalPlayer) == nil;
        else
            v9 = false;
        end;
    end;

    if p8.prompt.Enabled ~= v9 then
        p8.prompt.Enabled = v9;
    end;

    local v10;

    if u3 and type(u3.keys) == "number" then
        v10 = u3.keys or nil;
    else
        v10 = nil;
    end;

    local sign = p8.sign;
    local v11;

    if v10 == nil then
        v11 = false;
    else
        if FFlags.GhostKeyTrader == true and u2 ~= nil then
            v11 = u3 == nil and true or u3.live ~= false;
        else
            v11 = false;
        end;

        if v11 then
            v11 = LocalPlayer:GetAttribute("InMatch") ~= true;
        end;
    end;

    sign.Enabled = v11;

    if v10 then
        sign.Count.Text = tostring(v10);
    end;
end;

local function lanternSign(p12) -- Line: 85
    -- upvalues: Color3_fromRGB_ret (copy)
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "GhostKeysSign";
    BillboardGui.Adornee = p12;
    BillboardGui.Size = UDim2.fromScale(1.5, 0.75);
    BillboardGui.StudsOffsetWorldSpace = Vector3.new(0, 1.15, 0);
    BillboardGui.MaxDistance = 40;
    BillboardGui.LightInfluence = 0;
    BillboardGui.AlwaysOnTop = false;
    BillboardGui.ResetOnSpawn = false;
    BillboardGui.Enabled = false;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Count";
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Size = UDim2.fromScale(1, 0.62);
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);
    TextLabel.TextColor3 = Color3_fromRGB_ret;
    TextLabel.TextScaled = true;
    TextLabel.Text = "";
    TextLabel.Parent = BillboardGui;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Name = "Caption";
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Position = UDim2.fromScale(0, 0.62);
    TextLabel2.Size = UDim2.fromScale(1, 0.38);
    TextLabel2.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold);
    TextLabel2.TextColor3 = Color3.fromRGB(230, 255, 240);
    TextLabel2.TextScaled = true;
    TextLabel2.Text = "GHOST KEYS";
    TextLabel2.Parent = BillboardGui;

    for _, v in { TextLabel, TextLabel2 } do
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = Color3.fromRGB(8, 24, 16);
        UIStroke.Thickness = 2;
        UIStroke.Parent = v;
    end;

    BillboardGui.Parent = p12;

    return BillboardGui;
end;

local function floating(p13) -- Line: 128
    local v14 = {};
    local Trader = p13:FindFirstChild("Trader");
    local v15;

    if Trader and Trader:IsA("Model") then
        v15 = Trader:GetPivot();
    else
        v15 = p13:GetPivot();
    end;

    for _, v in { "Trader", "Lantern", "LanternFrame" } do
        local v16 = p13:FindFirstChild(v);

        if v16 then
            local v17 = v16:IsA("Model") and v16:FindFirstChildOfClass("Humanoid") and v16:FindFirstChild("HumanoidRootPart");

            for _, v2 in v16:IsA("BasePart") and { v16 } or (v17 and (v17:IsA("BasePart") and v17.Anchored) and { v17 } or v16:GetDescendants()) do
                if v2:IsA("BasePart") then
                    local v18 = {
                        part = v2,
                        offset = v15:ToObjectSpace(v2.CFrame)
                    };
                    table.insert(v14, v18);
                end;
            end;
        end;
    end;

    return v14, v15;
end;

local u19 = {};

local function setup(u20) -- Line: 148
    -- upvalues: u5 (copy), u19 (copy), setup (copy), lanternSign (copy), floating (copy), FFlags (copy), u2 (ref), u3 (ref), GhostTraderView (copy), LocalPlayer (copy), ask (copy), refresh (copy)
    if u5[u20] or not u20:IsDescendantOf(workspace) then
        return;
    end;

    local PromptSpot = u20:FindFirstChild("PromptSpot", true);
    local Lantern = u20:FindFirstChild("Lantern", true);

    if not (PromptSpot and PromptSpot:IsA("Attachment")) then
        if not u19[u20] then
            u19[u20] = u20.DescendantAdded:Connect(function(p21) -- Line: 158
                -- upvalues: setup (ref), u20 (copy)
                if p21.Name == "PromptSpot" or p21.Name == "Lantern" then
                    task.defer(setup, u20);
                end;
            end);
            task.delay(10, function() -- Line: 163
                -- upvalues: u19 (ref), u20 (copy), u5 (ref)
                if u19[u20] and (not u5[u20] and u20:IsDescendantOf(workspace)) then
                    warn("GhostTraderClient: " .. u20:GetFullName() .. " still has no PromptSpot attachment after 10 s; waiting for it");
                end;
            end);
        end;

        return;
    end;

    if u19[u20] then
        u19[u20]:Disconnect();
        u19[u20] = nil;
    end;

    local v22 = {
        connections = {}
    };
    u5[u20] = v22;
    local ProximityPrompt = Instance.new("ProximityPrompt");
    ProximityPrompt.Name = "TradeKeysPrompt";
    ProximityPrompt.ActionText = "Trade Keys";
    ProximityPrompt.ObjectText = "Ghost Key Trader";
    ProximityPrompt.HoldDuration = 0;
    ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.E;
    ProximityPrompt.MaxActivationDistance = 11;
    ProximityPrompt.RequiresLineOfSight = false;
    ProximityPrompt.Enabled = false;
    ProximityPrompt.Parent = PromptSpot;
    v22.prompt = ProximityPrompt;

    if not (Lantern and Lantern:IsA("BasePart")) then
        Lantern = PromptSpot.Parent;
    end;

    v22.sign = lanternSign(Lantern);
    local v23, v24 = floating(u20);
    v22.parts = v23;
    v22.base = v24;
    table.insert(v22.connections, ProximityPrompt.Triggered:Connect(function() -- Line: 190
        -- upvalues: ProximityPrompt (copy), FFlags (ref), u2 (ref), u3 (ref), GhostTraderView (ref), LocalPlayer (ref), u20 (copy)
        ProximityPrompt.Enabled = false;
        local v25;

        if FFlags.GhostKeyTrader == true and u2 ~= nil then
            v25 = u3 == nil and true or u3.live ~= false;
        else
            v25 = false;
        end;

        if not v25 then
            GhostTraderView.notice(GhostTraderView.UNAVAILABLE);

            return;
        end;

        if LocalPlayer:GetAttribute("InMatch") == true or GhostTraderView.isOpen() then
            return;
        end;

        GhostTraderView.open(u20);
    end));
    table.insert(v22.connections, ProximityPrompt.PromptShown:Connect(ask));
    refresh(u20, v22);
end;

local function teardown(p26) -- Line: 207
    -- upvalues: u19 (copy), u5 (copy)
    if u19[p26] then
        u19[p26]:Disconnect();
        u19[p26] = nil;
    end;

    local u27 = u5[p26];

    if not u27 then
        return;
    end;

    u5[p26] = nil;

    for _, v in u27.connections do
        v:Disconnect();
    end;

    pcall(function() -- Line: 221
        -- upvalues: u27 (copy)
        local v28 = {};
        local v29 = {};

        for _, v in u27.parts do
            if v.part.Parent then
                table.insert(v28, v.part);
                table.insert(v29, u27.base * v.offset);
            end;
        end;

        workspace:BulkMoveTo(v28, v29, Enum.BulkMoveMode.FireCFrameChanged);
    end);

    if u27.prompt then
        u27.prompt:Destroy();
    end;

    if u27.sign then
        u27.sign:Destroy();
    end;
end;

local u30 = 0;
RunService.Heartbeat:Connect(function() -- Line: 241
    -- upvalues: u30 (ref), u5 (copy), refresh (copy), teardown (copy)
    local os_clock_ret = os.clock();

    if os_clock_ret < u30 then
        return;
    end;

    u30 = os_clock_ret + 0.2;

    for i, v in u5 do
        if i:IsDescendantOf(workspace) then
            refresh(i, v);
        else
            teardown(i);
        end;
    end;
end);
RunService.RenderStepped:Connect(function() -- Line: 256
    -- upvalues: u5 (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return;
    end;

    local os_clock_ret = os.clock();

    for _, v in u5 do
        if #v.parts > 0 and (workspace_CurrentCamera.CFrame.Position - v.base.Position).Magnitude < 120 then
            local v31 = v.base * CFrame.new(0, math.sin(os_clock_ret * 1.6) * 0.22, 0) * CFrame.Angles(0, math.sin(os_clock_ret * 1.6 * 0.5) * 0.04363323129985824, math.sin(os_clock_ret * 1.6 * 0.7) * 0.04363323129985824 * 0.6);
            local v32 = {};
            local v33 = {};

            for _, v2 in v.parts do
                table.insert(v32, v2.part);
                table.insert(v33, v31 * v2.offset);
            end;

            pcall(workspace.BulkMoveTo, workspace, v32, v33, Enum.BulkMoveMode.FireCFrameChanged);
        end;
    end;
end);
CollectionService:GetInstanceAddedSignal("GhostTrader"):Connect(function(p34) -- Line: 275
    -- upvalues: setup (copy)
    task.defer(setup, p34);
end);
CollectionService:GetInstanceRemovedSignal("GhostTrader"):Connect(teardown);

for _, v in CollectionService:GetTagged("GhostTrader") do
    task.defer(setup, v);
end;

local GhostTraderEvent = Game:WaitForChild("GhostTraderEvent", 30);

if not GhostTraderEvent then
    warn("GhostTraderClient: Game.GhostTraderEvent never arrived after 30 s; waiting for it");
    GhostTraderEvent = Game:WaitForChild("GhostTraderEvent");
end;

u2 = GhostTraderEvent;
GhostTraderView.start({
    send = function(p35, ...) -- Line: 291, Name: send
        -- upvalues: u2 (ref)
        u2:FireServer(p35, ...);
    end
});
u2.OnClientEvent:Connect(function(p36, u37) -- Line: 295
    -- upvalues: u3 (ref), GhostTraderView (copy), Presentation (copy), LocalPlayer (copy), u5 (copy), refresh (copy)
    if type(u37) ~= "table" then
        return;
    end;

    if p36 == "State" or p36 == "Skipped" then
        u3 = u37;
        GhostTraderView.setState(u37, p36 == "Skipped");
    elseif p36 == "Spot" then
        GhostTraderView.spot(u37.spot);
    elseif p36 == "Result" then
        if type(u37.state) == "table" then
            u3 = u37.state;
        end;

        if not (GhostTraderView.result(u37) or (GhostTraderView.isOpen() or type(u37.reward) ~= "table")) then
            GhostTraderView.notice("The trader gave you " .. tostring(u37.reward.name or "a reward") .. "!");
        end;
    elseif p36 == "Refused" then
        GhostTraderView.refused(u37);
    elseif p36 == "KeyDrop" then
        local success, result = pcall(function() -- Line: 317
            -- upvalues: Presentation (ref), u37 (copy), u3 (ref), LocalPlayer (ref), GhostTraderView (ref)
            local show = require(Presentation:FindFirstChild("GhostKeyDrop")).show;
            local v38 = {};
            local v39;

            if u3 and u37.userId == LocalPlayer.UserId then
                v39 = u3.keys;
            else
                v39 = nil;
            end;

            v38.keys = v39;
            v38.notice = GhostTraderView.notice;
            show(u37, v38);
        end);

        if not success then
            warn("GhostTraderClient: couldn\'t show a dropped Ghost Key: " .. tostring(result));
        end;
    elseif p36 == "KeyEarned" then
        local success, result = pcall(function() -- Line: 329
            -- upvalues: Presentation (ref), u37 (copy), GhostTraderView (ref)
            require(Presentation:FindFirstChild("GhostKeyDrop")).earned(u37, {
                notice = GhostTraderView.notice
            });
        end);

        if not success then
            warn("GhostTraderClient: couldn\'t show won Ghost Keys: " .. tostring(result));
        end;
    end;

    for i, v in u5 do
        refresh(i, v);
    end;
end);
task.spawn(function() -- Line: 341
    -- upvalues: FFlags (copy), LocalPlayer (copy), u5 (copy), u2 (ref), u4 (ref)
    local v40 = 0;

    while FFlags.GhostKeyTrader == true and (LocalPlayer:GetAttribute("ClientReady") ~= true and v40 < 120) do
        task.wait(1);
        v40 = v40 + 1;
    end;

    if FFlags.GhostKeyTrader == true and (next(u5) ~= nil and (u2 and os.clock() - u4 >= 12)) then
        u4 = os.clock();
        u2:FireServer("State");
    end;
end);