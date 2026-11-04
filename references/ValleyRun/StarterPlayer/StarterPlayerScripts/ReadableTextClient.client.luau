 

 

local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
local u1 = {};
local u2 = {};
local u3 = true;

local function proximityPresentation(p4) -- Line: 6
    while p4 do
        if p4:GetAttribute("SelfManagedText") == true or (p4.Name == "ProximityPrompts" or p4:GetAttribute("ProximityPromptUI") == true) then
            return true;
        end;

        p4 = p4.Parent;
    end;

    return false;
end;

local function loadingPresentation(p5) -- Line: 21
    local v6 = p5:FindFirstAncestorWhichIsA("ScreenGui");

    if v6 then
        if v6.Name == "ScreenOverlay" or v6.Name == "TeleportOverlay" then
            v6 = true;
        elseif v6.Name == "Notifications" then
            v6 = p5:FindFirstAncestor("NotificationsF") ~= nil;
        else
            v6 = false;
        end;
    end;

    return v6;
end;

local function shopTab(p7) -- Line: 30
    local v8 = p7:FindFirstAncestorWhichIsA("ScreenGui");

    if v8 then
        if v8.Name == "ValleyArmory" then
            v8 = p7:FindFirstAncestor("Tabs") ~= nil;
        else
            v8 = false;
        end;
    end;

    return v8;
end;

local function largeScreen() -- Line: 34
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        if workspace_CurrentCamera.ViewportSize.X >= 700 then
            workspace_CurrentCamera = workspace_CurrentCamera.ViewportSize.Y >= 500;
        else
            workspace_CurrentCamera = false;
        end;
    end;

    return workspace_CurrentCamera;
end;

local function resize(p9, p10) -- Line: 38
    -- upvalues: PlayerGui (copy)
    if p10.updating then
        return;
    end;

    p10.updating = true;
    local v11;

    if p9:FindFirstAncestor("UpdatesShade") == nil then
        v11 = p9:FindFirstAncestorWhichIsA("ScreenGui") and (p9:FindFirstAncestorWhichIsA("ScreenGui").Name == "HitboxComparison" and true or p9:FindFirstAncestorWhichIsA("ScreenGui").Name == "HitReplayStatus");
    else
        v11 = true;
    end;

    local v12 = p9:FindFirstAncestorWhichIsA("ScreenGui");

    if v12 then
        if v12.Name == "ValleyArmory" then
            v12 = p9:FindFirstAncestor("Tabs") ~= nil;
        else
            v12 = false;
        end;
    end;

    local v13 = not (v12 or v11);

    if v13 then
        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera then
            if workspace_CurrentCamera.ViewportSize.X >= 700 then
                workspace_CurrentCamera = workspace_CurrentCamera.ViewportSize.Y >= 500;
            else
                workspace_CurrentCamera = false;
            end;
        end;

        v13 = workspace_CurrentCamera and (p9:IsDescendantOf(PlayerGui) and not p9:FindFirstAncestorWhichIsA("BillboardGui")) and not p9:FindFirstAncestorWhichIsA("SurfaceGui");
    end;

    p9.TextScaled = not v13;
    local v14;

    if v13 then
        local math_round_ret = math.round(p10.authored * 1.12);
        v14 = math.clamp(math_round_ret, 12, 40) or p10.authored;
    else
        v14 = p10.authored;
    end;

    p10.appliedSize = v14;
    p9.TextSize = p10.appliedSize;
    p10.updating = false;
end;

local function forget(p15) -- Line: 62
    -- upvalues: u1 (copy)
    local v16 = u1[p15];

    if not v16 then
        return;
    end;

    u1[p15] = nil;

    for _, v in v16.connections do
        v:Disconnect();
    end;
end;

local function apply(u17) -- Line: 72
    -- upvalues: u3 (ref), proximityPresentation (copy), u1 (copy), resize (copy)
    if u3 then
        local v18 = u17:FindFirstAncestorWhichIsA("ScreenGui");

        if v18 then
            if v18.Name == "ScreenOverlay" or v18.Name == "TeleportOverlay" then
                v18 = true;
            elseif v18.Name == "Notifications" then
                v18 = u17:FindFirstAncestor("NotificationsF") ~= nil;
            else
                v18 = false;
            end;
        end;

        if not (v18 or proximityPresentation(u17)) then
            if u17:IsA("UITextSizeConstraint") then
                u17:Destroy();

                return;
            end;

            if not (u17:IsA("TextLabel") or (u17:IsA("TextButton") or u17:IsA("TextBox"))) or u1[u17] then
                return;
            end;

            local u19 = {
                authored = u17:GetAttribute("ReadableAuthoredSize") or u17.TextSize,
                connections = {}
            };
            u1[u17] = u19;
            u17:SetAttribute("ReadableAuthoredSize", u19.authored);
            local connections = u19.connections;
            local PropertyChangedSignal = u17:GetPropertyChangedSignal("TextScaled");
            table.insert(connections, PropertyChangedSignal:Connect(function() -- Line: 88
                -- upvalues: resize (ref), u17 (copy), u19 (copy)
                resize(u17, u19);
            end));
            local connections2 = u19.connections;
            local PropertyChangedSignal2 = u17:GetPropertyChangedSignal("TextSize");
            table.insert(connections2, PropertyChangedSignal2:Connect(function() -- Line: 94
                -- upvalues: u19 (copy), u17 (copy), resize (ref)
                if u19.updating or u17.TextSize == u19.appliedSize then
                    return;
                end;

                u19.authored = u17.TextSize;
                u17:SetAttribute("ReadableAuthoredSize", u19.authored);
                resize(u17, u19);
            end));
            table.insert(u19.connections, u17.Destroying:Connect(function() -- Line: 105
                -- upvalues: u17 (copy), u1 (ref)
                local v20 = u17;
                local v21 = u1[v20];

                if not v21 then
                    return;
                end;

                u1[v20] = nil;

                for _, v in v21.connections do
                    v:Disconnect();
                end;
            end));
            resize(u17, u19);
        end;
    end;
end;

local function refresh() -- Line: 111
    -- upvalues: u1 (copy), resize (copy)
    for i, v in u1 do
        resize(i, v);
    end;
end;

local u22 = nil;

local function cameraChanged() -- Line: 117
    -- upvalues: u22 (ref), refresh (copy), u1 (copy), resize (copy)
    if u22 then
        u22:Disconnect();
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        u22 = workspace_CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(refresh);
    end;

    for i, v in u1 do
        resize(i, v);
    end;
end;

for _, v in { PlayerGui, workspace } do
    table.insert(u2, v.DescendantAdded:Connect(apply));
    table.insert(u2, v.DescendantRemoving:Connect(forget));

    for _, descendant in v:GetDescendants() do
        apply(descendant);
    end;
end;

local PropertyChangedSignal = workspace:GetPropertyChangedSignal("CurrentCamera");
table.insert(u2, PropertyChangedSignal:Connect(cameraChanged));

if u22 then
    u22:Disconnect();
end;

local workspace_CurrentCamera = workspace.CurrentCamera;

if workspace_CurrentCamera then
    u22 = workspace_CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(refresh);
end;

for i, v in u1 do
    resize(i, v);
end;

script.Destroying:Connect(function() -- Line: 136
    -- upvalues: u3 (ref), u22 (ref), u2 (copy), u1 (copy)
    u3 = false;

    if u22 then
        u22:Disconnect();
    end;

    for _, v in u2 do
        v:Disconnect();
    end;

    local v23 = {};

    for i in u1 do
        table.insert(v23, i);
    end;

    for _, v in v23 do
        local v24 = u1[v];

        if v24 then
            u1[v] = nil;

            for _, v2 in v24.connections do
                v2:Disconnect();
            end;
        end;
    end;
end);