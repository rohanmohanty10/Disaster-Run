 

 

local RunService = game:GetService("RunService");
local LocalPlayer = game.Players.LocalPlayer;
local Presentation = game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Presentation");
local ThreatIndicatorConfig = require(Presentation:WaitForChild("ThreatIndicatorConfig"));
local ThreatIndicatorModel = require(Presentation:WaitForChild("ThreatIndicatorModel"));
local ParticipantDirectory = require(Presentation:WaitForChild("ParticipantDirectory"));
local Session = Presentation.Parent.Game.Session;
local Ring = script.Parent:WaitForChild("Ring");
local u1 = {};
local u2 = {};
local u3 = {};
local u4 = 0;

for _, child in Ring:GetChildren() do
    if child:IsA("Frame") and child:GetAttribute("Angle") then
        table.insert(u1, child);
        u2[child] = 0;
        u3[child] = 0;
    end;
end;

local function eligible() -- Line: 14
    -- upvalues: LocalPlayer (copy), Session (copy), ThreatIndicatorConfig (copy)
    local Character = LocalPlayer.Character;
    local v5;

    if Character then
        v5 = Character:FindFirstChildOfClass("Humanoid");
    else
        v5 = Character;
    end;

    local Attribute = Session:GetAttribute("Phase");
    local Enabled = ThreatIndicatorConfig.Enabled;

    if Enabled then
        if LocalPlayer:GetAttribute("InMatch") == true and (LocalPlayer:GetAttribute("GameRole") == "Runner" and LocalPlayer:GetAttribute("RunState") == "Active") then
            if Character then
                if v5 then
                    if v5.Health > 0 then
                        v5 = not (Character:GetAttribute("MovementLocked") or (LocalPlayer:GetAttribute("ChoiceSpotlightActive") or LocalPlayer:GetAttribute("ScreenPresentationActive"))) and ((Attribute == "HeroRun" or Attribute == "GroupRun") and true or Attribute == "FinalRun");
                    else
                        v5 = false;
                    end;
                end;
            else
                v5 = Character;
            end;
        else
            v5 = false;
        end;
    else
        v5 = Enabled;
    end;

    return v5;
end;

local function publishThreat(p6) -- Line: 23
    -- upvalues: LocalPlayer (copy)
    LocalPlayer:SetAttribute("CatcherThreatIntensity", p6);
    LocalPlayer:SetAttribute("CatcherThreatUpdatedAt", workspace:GetServerTimeNow());
end;

local function sample() -- Line: 27
    -- upvalues: LocalPlayer (copy), u1 (copy), u3 (copy), ParticipantDirectory (copy), ThreatIndicatorModel (copy), ThreatIndicatorConfig (copy)
    LocalPlayer:SetAttribute("CatcherThreatIntensity", 0);
    LocalPlayer:SetAttribute("CatcherThreatUpdatedAt", workspace:GetServerTimeNow());

    for _, v in u1 do
        u3[v] = 0;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not (Character and workspace_CurrentCamera) then
        return;
    end;

    local v7 = ParticipantDirectory.list();
    local v8 = {};

    for _, v in v7 do
        if v.Character then
            table.insert(v8, v.Character);
        end;
    end;

    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = v8;
    RaycastParams_new_ret.RespectCanCollide = true;
    local v9 = {};

    for _, v in v7 do
        if v.UserId ~= LocalPlayer.UserId and (v:GetAttribute("GameRole") == "Catcher" and v:GetAttribute("RunState") == "Active") then
            local Character2 = v.Character;
            local v10;

            if Character2 then
                v10 = Character2:FindFirstChild("HumanoidRootPart");
            else
                v10 = Character2;
            end;

            local v11;

            if Character2 then
                v11 = Character2:FindFirstChildOfClass("Humanoid");
            else
                v11 = Character2;
            end;

            if v10 and (v11 and (v11.Health > 0 and not Character2:GetAttribute("MovementLocked"))) then
                local v12 = ThreatIndicatorModel.sample(Character.Position, Character.AssemblyLinearVelocity, workspace_CurrentCamera.CFrame.LookVector, v10.Position, v10.AssemblyLinearVelocity, ThreatIndicatorConfig);

                if v12 and not workspace:Raycast(Character.Position, v10.Position - Character.Position, RaycastParams_new_ret) then
                    table.insert(v9, v12);
                end;
            end;
        end;
    end;

    table.sort(v9, function(p13, p14) -- Line: 47
        return p13.strength > p14.strength;
    end);

    while #v9 > ThreatIndicatorConfig.MaxThreats do
        table.remove(v9);
    end;

    LocalPlayer:SetAttribute("CatcherThreatIntensity", v9[1] and (v9[1].strength or 0) or 0);
    LocalPlayer:SetAttribute("CatcherThreatUpdatedAt", workspace:GetServerTimeNow());

    for _, v in u1 do
        u3[v] = ThreatIndicatorModel.sector(v:GetAttribute("Angle"), v9, ThreatIndicatorConfig.ArcWidth);
    end;
end;

local u20 = RunService.RenderStepped:Connect(function(p15) -- Line: 53
    -- upvalues: eligible (copy), LocalPlayer (copy), Ring (copy), u4 (ref), ThreatIndicatorConfig (copy), u1 (copy), u2 (copy), u3 (copy), sample (copy)
    if eligible() then
        u4 = u4 + p15;

        if u4 >= ThreatIndicatorConfig.UpdateInterval then
            u4 = 0;
            sample();
        end;

        local v16 = false;

        for _, v in u1 do
            local v17 = u2[v];
            local v18 = u3[v];
            local v19 = v17 + (v18 - v17) * (1 - math.exp(-p15 / (v17 < v18 and ThreatIndicatorConfig.FadeInTime or ThreatIndicatorConfig.FadeOutTime)));
            u2[v] = v19;
            v.BackgroundTransparency = 1 - v19 * ThreatIndicatorConfig.MaxOpacity;

            if v19 > 0.015 then
                v16 = true;
            end;
        end;

        Ring.Visible = v16;

        return;
    end;

    LocalPlayer:SetAttribute("CatcherThreatIntensity", 0);
    LocalPlayer:SetAttribute("CatcherThreatUpdatedAt", workspace:GetServerTimeNow());
    Ring.Visible = false;
    u4 = ThreatIndicatorConfig.UpdateInterval;

    for _, v in u1 do
        u2[v] = 0;
        u3[v] = 0;
        v.BackgroundTransparency = 1;
    end;
end);
script.Destroying:Connect(function() -- Line: 71
    -- upvalues: u20 (copy), Ring (copy), LocalPlayer (copy)
    u20:Disconnect();
    Ring.Visible = false;
    LocalPlayer:SetAttribute("CatcherThreatIntensity", 0);
    LocalPlayer:SetAttribute("CatcherThreatUpdatedAt", workspace:GetServerTimeNow());
end);