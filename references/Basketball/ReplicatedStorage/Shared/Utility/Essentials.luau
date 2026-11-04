 
 

local u1 = {};
local TweenService = game:GetService("TweenService");
game:GetService("Players");
local StatsSettings = require(script.Parent.Parent.Tables.StatsSettings);

function u1.HideCharacter(p2: table, p3: userdata, p4: any, p5: any, p6: any) -- Line: 7
    -- upvalues: TweenService (copy)
    local v7 = p6 == nil and 0.1 or p6;
    p3:SetAttribute("Invis", true);

    for _, descendant in p3:GetDescendants() do
        if descendant:IsA("BasePart") or (descendant:IsA("Decal") or (descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")))) then
            if not (table.find(p4, descendant) or descendant:GetAttribute("Invis")) then
                descendant:SetAttribute("Invis", true);
                local v8 = p5 and (typeof(p5) == "number" and p5 and p5 or 0.8) or 1;
                TweenService:Create(descendant, TweenInfo.new(v7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    LocalTransparencyModifier = v8
                }):Play();
            end;
        elseif descendant:IsA("SurfaceGui") and (descendant.Enabled and not descendant:GetAttribute("Invis")) then
            descendant:SetAttribute("Invis", true);
            descendant.Enabled = false;
        end;
    end;
end;

function u1.OVR(p9, p10) -- Line: 33
    -- upvalues: StatsSettings (copy)
    local v11 = 50;

    for i, v in StatsSettings.CalculateOVR do
        v11 = v11 + p10.Statistics[i] / v.OnePoint / math.clamp((p10.Statistics.Matches + 1) / 15, 1, v.MatchFactor);
    end;

    return math.ceil(v11 >= 100 and 100 or v11);
end;

function u1.RagdollBack(p12, p13) -- Line: 48
    -- upvalues: u1 (copy)
    if workspace:FindFirstChild("CamRig") then
        return;
    end;

    for _, v in u1:GetPlayers() do
        if v.Character ~= nil and (v.Character:FindFirstChild("HumanoidRootPart") ~= nil and (v.Team ~= p13.ScoreTeam and v.Team ~= game.Teams.Visitor)) then
            local Character = v.Character;
            local HumanoidRootPart = v.Character.HumanoidRootPart;

            if not HumanoidRootPart.Anchored then
                Character.IsRagdoll.Value = true;
                task.delay(1.8, function() -- Line: 63
                    -- upvalues: Character (copy)
                    Character.IsRagdoll.Value = false;
                end);
                task.wait(0.01);
                HumanoidRootPart.AssemblyLinearVelocity = ((HumanoidRootPart.Position - p13.CFrame.Position).Unit + Vector3.new(0, 0.75, 0)) * 220;
            end;
        end;
    end;
end;

function u1.UnhideCharacter(p14: table, p15: userdata, p16: any) -- Line: 72
    -- upvalues: TweenService (copy)
    p15:SetAttribute("Invis", nil);

    for _, descendant in p15:GetDescendants() do
        if descendant:IsA("BasePart") or (descendant:IsA("Decal") or (descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")))) then
            if not table.find(p16, descendant) and descendant:GetAttribute("Invis") then
                descendant:SetAttribute("Invis", nil);
                TweenService:Create(descendant, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    LocalTransparencyModifier = 0
                }):Play();
            end;
        elseif descendant:IsA("SurfaceGui") and descendant:GetAttribute("Invis") then
            descendant:SetAttribute("Invis", nil);
            descendant.Enabled = true;
        end;
    end;
end;

function u1.CreateClone(p17: table, p18: userdata, p19: any) -- Line: 91
    -- upvalues: TweenService (copy)
    p18.Archivable = true;
    local v20 = p18:Clone();
    v20.Parent = workspace.Debris;
    local v21 = p19 or 0.5;

    for _, descendant in v20:GetDescendants() do
        if descendant:IsA("Script") or (descendant:IsA("LocalScript") or (descendant:IsA("Highlight") or (descendant:IsA("Sound") or (descendant:IsA("SurfaceGui") or (descendant:IsA("BillboardGui") or (descendant:IsA("Decal") or (descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail"))))))))) then
            descendant:Destroy();
        elseif descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;

            if descendant.Name ~= "Ball" then
                descendant.LocalTransparencyModifier = 0;
            end;

            TweenService:Create(descendant, TweenInfo.new(v21), {
                Transparency = 1
            }):Play();
        elseif descendant:IsA("Humanoid") then
            descendant.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        end;
    end;

    p18.Archivable = false;

    return v20;
end;

function u1.ActualTeam(p22, p23) -- Line: 119
    return p23 == "Home" and "Away" or "Home";
end;

function u1.Lerp(p24, p25, p26, p27) -- Line: 127
    return p25 + (p26 - p25) * p27;
end;

function u1.Highlight(p28, p29) -- Line: 131
    local Highlight = Instance.new("Highlight");
    Highlight.Parent = p29;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillTransparency = 1;
    Highlight.OutlineTransparency = 1;
    Highlight.FillColor = Color3.new(1, 1, 1);

    return Highlight;
end;

function u1.TableLength(p30, p31) -- Line: 142
    local v32 = 0;

    for _, _ in p31 do
        v32 = v32 + 1;
    end;

    return v32;
end;

function u1.DeepCopy(p33, p34) -- Line: 150
    -- upvalues: u1 (copy)
    local table_clone_ret = table.clone(p34);

    for i, v in table_clone_ret do
        if typeof(v) == "table" then
            table_clone_ret[i] = u1:DeepCopy(v);
        end;
    end;

    return table_clone_ret;
end;

function u1.Bezier(p35, p36, p37, p38, p39) -- Line: 162
    -- upvalues: u1 (copy)
    return u1:Lerp(u1:Lerp(p36, p37, p39), u1:Lerp(p37, p38, p39), p39);
end;

function u1.SetProperty(p40, p41, p42) -- Line: 170
    for _, v in p41 do
        v.Priority = p42;
    end;
end;

function u1.ReturnRorL(p43, p44) -- Line: 176
    return ({
        ["true"] = "R",
        ["false"] = "L"
    })[tostring(p44.OnRight)];
end;

function u1.EnoughPlayers(p45) -- Line: 184
    return #game.Teams.Home:GetPlayers() + #game.Teams.Away:GetPlayers() >= 4;
end;

function u1.GetPlayers(p46, p47) -- Line: 192
    local v48 = {};

    if p47 then
        local v49;

        if typeof(p47) == "string" then
            v49 = game.Teams[p47] or p47;
        else
            v49 = p47;
        end;

        for _, v in v49:GetPlayers() do
            table.insert(v48, v);
        end;
    else
        for _, v in game.Players:GetPlayers() do
            table.insert(v48, v);
        end;
    end;

    if workspace:FindFirstChild("Bots") then
        for _, child in workspace.Bots:GetChildren() do
            if not p47 or child:GetAttribute("Team") == (typeof(p47) == "string" and p47 and p47 or p47.Name) then
                local v55 = {
                    IsBot = true,
                    Name = child.Name,
                    Character = child.Value,
                    Style = child.Style,
                    Zone = child.Zone,
                    UserId = child.Value:GetAttribute("UserId"),
                    Team = game.Teams[child:GetAttribute("Team")],

                    SetAttribute = function(p50, p51, p52) -- Line: 217, Name: SetAttribute
                        -- upvalues: child (copy)
                        child:SetAttribute(p51, p52);
                    end,

                    GetAttribute = function(p53, p54) -- Line: 218, Name: GetAttribute
                        -- upvalues: child (copy)
                        return child:GetAttribute(p54);
                    end,

                    GetNetworkPing = function() -- Line: 219, Name: GetNetworkPing
                        return 0;
                    end
                };
                table.insert(v48, v55);
            end;
        end;
    end;

    return v48;
end;

function u1.GetBotFromRig(p56, p57) -- Line: 227
    if workspace:FindFirstChild("Bots") then
        for _, child in workspace.Bots:GetChildren() do
            if child.Value == p57 then
                return {
                    IsBot = true,
                    Name = child.Name,
                    Character = child.Value,
                    Style = child.Style,
                    Zone = child.Zone,
                    UserId = child.Value:GetAttribute("UserId"),
                    Team = game.Teams[child:GetAttribute("Team")],

                    SetAttribute = function(p58, p59, p60) -- Line: 239, Name: SetAttribute
                        -- upvalues: child (copy)
                        child:SetAttribute(p59, p60);
                    end,

                    GetAttribute = function(p61, p62) -- Line: 240, Name: GetAttribute
                        -- upvalues: child (copy)
                        return child:GetAttribute(p62);
                    end,

                    GetNetworkPing = function() -- Line: 241, Name: GetNetworkPing
                        return 0;
                    end
                };
            end;
        end;
    end;
end;

function u1.formatTime(p63, p64) -- Line: 248
    local math_floor_ret = math.floor(p64 / 3600);
    local math_floor_ret2 = math.floor((p64 - math_floor_ret * 3600) / 60);

    return ("%01d:%02d"):format(math_floor_ret2, (math.floor(p64 - math_floor_ret * 3600 - math_floor_ret2 * 60)));
end;

function u1.formatCompleteTime(p65, p66) -- Line: 256
    local math_floor_ret = math.floor(p66 / 3600);
    local math_floor_ret2 = math.floor((p66 - math_floor_ret * 3600) / 60);

    return ("%02d:%02d:%02d"):format(math_floor_ret, math_floor_ret2, (math.floor(p66 - math_floor_ret * 3600 - math_floor_ret2 * 60)));
end;

function u1.Weld(p67, p68, p69) -- Line: 264
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Parent = p68;
    WeldConstraint.Part0 = p68;
    WeldConstraint.Part1 = p69;

    return WeldConstraint;
end;

function u1.formatNumberWithCommas(p70, p71) -- Line: 272
    local string_format_ret = string.format("%d", p71);
    local string_match_ret, v72, v73 = string.match(string_format_ret, "^([^%d]*%d)(%d*)(.-)$");

    return string_match_ret .. v72:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v73;
end;

return u1;