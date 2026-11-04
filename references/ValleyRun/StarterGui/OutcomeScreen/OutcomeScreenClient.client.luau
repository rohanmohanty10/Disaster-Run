 

 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local script_Parent = script.Parent;
local Edges = script_Parent:WaitForChild("Edges");
local u1 = {};

for _, v in { "Top", "Bottom", "Left", "Right" } do
    table.insert(u1, Edges:WaitForChild(v));
end;

local u2 = 0;
local u3 = {};
local u4 = {};
local Attribute = LocalPlayer:GetAttribute("RunState");

local function stopTweens() -- Line: 13
    -- upvalues: u3 (copy)
    for _, v in u3 do
        v:Cancel();
    end;

    table.clear(u3);
end;

local function clear() -- Line: 17
    -- upvalues: u2 (ref), u3 (copy), Edges (copy), u1 (copy)
    u2 = u2 + 1;

    for _, v in u3 do
        v:Cancel();
    end;

    table.clear(u3);
    Edges.Visible = false;

    for _, v in u1 do
        v.BackgroundTransparency = 1;
    end;
end;

local function allowed() -- Line: 21
    -- upvalues: LocalPlayer (copy)
    local v5;

    if LocalPlayer:GetAttribute("InMatch") == true and (LocalPlayer:GetAttribute("GameRole") == "Runner" and (LocalPlayer:GetAttribute("InitialLoadingComplete") == true and LocalPlayer:GetAttribute("ScreenPresentationActive") ~= true)) then
        v5 = LocalPlayer:GetAttribute("MatchSummaryVisible") ~= true;
    else
        v5 = false;
    end;

    return v5;
end;

local function animate(p6, p7) -- Line: 27
    -- upvalues: u3 (copy), u1 (copy), TweenService (copy)
    for _, v in u3 do
        v:Cancel();
    end;

    table.clear(u3);

    for _, v in u1 do
        local v8 = TweenService:Create(v, TweenInfo.new(p6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = p7
        });
        table.insert(u3, v8);
        v8:Play();
    end;
end;

local function pulse(p9) -- Line: 35
    -- upvalues: u2 (ref), u3 (copy), Edges (copy), u1 (copy), allowed (copy), script_Parent (copy), animate (copy)
    u2 = u2 + 1;

    for _, v in u3 do
        v:Cancel();
    end;

    table.clear(u3);
    Edges.Visible = false;

    for _, v in u1 do
        v.BackgroundTransparency = 1;
    end;

    if not allowed() then
        return;
    end;

    local u10 = u2;
    local v11 = script_Parent:GetAttribute("FadeIn") or 0.1;
    local v12 = script_Parent:GetAttribute("HoldTime") or 0.28;
    local u13 = script_Parent:GetAttribute("FadeOut") or 0.75;
    local Attribute2 = script_Parent:GetAttribute(p9 == "Safe" and "SafeColor" or "CaughtColor");

    for _, v in u1 do
        v.BackgroundColor3 = Attribute2;
    end;

    Edges.Visible = true;
    animate(v11, script_Parent:GetAttribute("PeakTransparency") or 0.38);
    task.delay(v11 + v12, function() -- Line: 46
        -- upvalues: u2 (ref), u10 (copy), animate (ref), u13 (copy)
        if u2 ~= u10 then
            return;
        end;

        animate(u13, 1);
    end);
    task.delay(v11 + v12 + u13, function() -- Line: 50
        -- upvalues: u2 (ref), u10 (copy), u3 (ref), Edges (ref), u1 (ref)
        if u2 == u10 then
            u2 = u2 + 1;

            for _, v in u3 do
                v:Cancel();
            end;

            table.clear(u3);
            Edges.Visible = false;

            for _, v in u1 do
                v.BackgroundTransparency = 1;
            end;
        end;
    end);
end;

local function stateChanged() -- Line: 54
    -- upvalues: LocalPlayer (copy), Attribute (ref), pulse (copy), u2 (ref), u3 (copy), Edges (copy), u1 (copy)
    local Attribute2 = LocalPlayer:GetAttribute("RunState");
    local v14 = Attribute;
    Attribute = Attribute2;

    if v14 == "Active" and (Attribute2 == "Safe" or Attribute2 == "Caught") then
        pulse(Attribute2);

        return;
    end;

    if Attribute2 ~= "Safe" and Attribute2 ~= "Caught" then
        u2 = u2 + 1;

        for _, v in u3 do
            v:Cancel();
        end;

        table.clear(u3);
        Edges.Visible = false;

        for _, v in u1 do
            v.BackgroundTransparency = 1;
        end;
    end;
end;

local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("RunState");
table.insert(u4, AttributeChangedSignal:Connect(stateChanged));

for _, v in { "InMatch", "GameRole", "InitialLoadingComplete", "ScreenPresentationActive", "MatchSummaryVisible" } do
    local AttributeChangedSignal2 = LocalPlayer:GetAttributeChangedSignal(v);
    table.insert(u4, AttributeChangedSignal2:Connect(function() -- Line: 63
        -- upvalues: allowed (copy), u2 (ref), u3 (copy), Edges (copy), u1 (copy)
        if not allowed() then
            u2 = u2 + 1;

            for _, v2 in u3 do
                v2:Cancel();
            end;

            table.clear(u3);
            Edges.Visible = false;

            for _, v2 in u1 do
                v2.BackgroundTransparency = 1;
            end;
        end;
    end));
end;

table.insert(u4, LocalPlayer.CharacterRemoving:Connect(clear));
table.insert(u4, LocalPlayer.CharacterAdded:Connect(function() -- Line: 68
    -- upvalues: Attribute (ref), LocalPlayer (copy), u2 (ref), u3 (copy), Edges (copy), u1 (copy)
    Attribute = LocalPlayer:GetAttribute("RunState");
    u2 = u2 + 1;

    for _, v in u3 do
        v:Cancel();
    end;

    table.clear(u3);
    Edges.Visible = false;

    for _, v in u1 do
        v.BackgroundTransparency = 1;
    end;
end));
script.Destroying:Connect(function() -- Line: 71
    -- upvalues: u4 (copy), u2 (ref), u3 (copy), Edges (copy), u1 (copy)
    for _, v in u4 do
        v:Disconnect();
    end;

    u2 = u2 + 1;

    for _, v in u3 do
        v:Cancel();
    end;

    table.clear(u3);
    Edges.Visible = false;

    for _, v in u1 do
        v.BackgroundTransparency = 1;
    end;
end);
u2 = u2 + 1;

for _, v in u3 do
    v:Cancel();
end;

table.clear(u3);
Edges.Visible = false;

for _, v in u1 do
    v.BackgroundTransparency = 1;
end;