  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("PathfindingService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("Debris");
game:GetService("TweenService");
game:GetService("GuiService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local TeamColors = require(ReplicatedStorage.Shared.TeamColors);
require(ReplicatedStorage.Shared.Essentials);
local CameraController = require(ReplicatedStorage2.Controllers.CameraController);
local StylePassiveController = require(ReplicatedStorage2.Controllers.StylePassiveController);
local getFlowData = require(ReplicatedStorage2.Shared.utils.getFlowData);
local Vfx = ReplicatedStorage.Assets.Vfx;
local v1 = Knit.CreateController({
    Name = "HighlightController"
});
local u2 = {
    Outline = { Color3.fromRGB(0, 0, 0), 1 },
    Fill = { Color3.fromRGB(0, 0, 0), 1 }
};
local LocalPlayer = Players.LocalPlayer;

local function getCharacterHighlightProps(p3: userdata, p4: userdata) -- Line: 32
    -- upvalues: TeamColors (copy), ReplicatedStorage (copy), getFlowData (copy), LocalPlayer (copy), StylePassiveController (copy), CameraController (copy), u2 (copy)
    local Attribute = p4:GetAttribute("HighlightOutline");

    if Attribute then
        return {
            Outline = { Attribute, 0 }
        };
    end;

    if p4:GetAttribute("ReoHighlight") then
        return {
            Outline = { Color3.fromRGB(0, 0, 0), 0 },
            Fill = { Color3.fromRGB(255, 255, 255), 0.6 }
        };
    end;

    local v5 = {
        Outline = { Color3.fromRGB(0, 0, 0), 0 }
    };

    if p3.Team == game.Teams.Visitor then
        v5 = {
            Outline = { Color3.fromRGB(0, 0, 0), 0 }
        };
    else
        local v6 = TeamColors[p3.Team.Name][ReplicatedStorage.GameValues[p3.Team.Name .. "Index"].Value];
        local v7 = p3.Character:FindFirstChild("SHADOW") ~= nil;
        local NelReoHighlight = p3.Character:FindFirstChild("NelReoHighlight");
        local GoldenDefense = p3.Character:FindFirstChild("GoldenDefense");
        local BMRinHighlight = p3.Character:FindFirstChild("BMRinHighlight");
        local RinHighlight = p3.Character:FindFirstChild("RinHighlight");
        local BachiraHighlight = p3.Character:FindFirstChild("BachiraHighlight");
        local PIsagiHighlight = p3.Character:FindFirstChild("PIsagiHighlight");
        local GBCharlesHighlight = p3.Character:FindFirstChild("GBCharlesHighlight");
        local AikuHighlight = p3.Character:FindFirstChild("AikuHighlight");
        local SLokiHighlight = p3.Character:FindFirstChild("SLokiHighlight");
        local SLavinhoHighlight = p3.Character:FindFirstChild("SLavinhoHighlight");
        local FWBachiraHighlight = p3.Character:FindFirstChild("FWBachiraHighlight");
        local KuronaHighlight = p3.Character:FindFirstChild("KuronaHighlight");
        local NessHighlight = p3.Character:FindFirstChild("NessHighlight");
        local RaichiHighlight = p3.Character:FindFirstChild("RaichiHighlight");
        local NELNagiHighlight = p3.Character:FindFirstChild("NELNagiHighlight");
        local NELIsagiHighlight = p3.Character:FindFirstChild("NELIsagiHighlight");
        local ChigiriHighlight = p3.Character:FindFirstChild("ChigiriHighlight");
        local KiyoraHighlight = p3.Character:FindFirstChild("KiyoraHighlight");
        local SaeHighlight = p3.Character:FindFirstChild("SaeHighlight");
        local NelBarouHighlight = p3.Character:FindFirstChild("NelBarouHighlight");
        local ClonedCharacterValue = p3.Character:FindFirstChild("ClonedCharacterValue");

        if p3.PlayerStats.InFlow.Value then
            local Value = p3.PlayerStats.Flow.Value;
            local v8 = getFlowData(Value);

            if Value == "Awakened Genius" then
                v5.Outline = { Color3.fromRGB(249, 69, 255), 0 };
            elseif Value == "Soul Harvester" then
                v5.Outline = { Color3.fromRGB(140, 25, 255), 0 };
            elseif Value == "Demon Wings" or Value == "Lightning" then
                v5.Outline = { Color3.fromRGB(248, 30, 255), 0 };
            elseif Value == "Monster" then
                v5.Outline = { Color3.fromRGB(255, 204, 0), 0 };
            elseif Value == "Puzzle" then
                v5.Outline = { Color3.fromRGB(0, 174, 255), 0 };
            elseif Value == "Wild Card" or (Value == "Godspeed" or v8 and v8.Stats.WildCardRNG) then
                v5.Outline = { Color3.fromRGB(255, 115, 0), 0 };
            elseif Value == "Stealth" then
                v5.Outline = { Color3.fromRGB(85, 255, 0), 0 };
            end;
        end;

        if v7 then
            v5.Outline = { v6, 0 };
        end;

        if NelBarouHighlight then
            v5.Fill = { Color3.fromRGB(88, 1, 0), 1 };
            v5.Outline = { Color3.fromRGB(140, 0, 4), 0 };
        end;

        if KiyoraHighlight then
            v5.Fill = { Color3.fromRGB(0, 0, 0), 1 };
            v5.Outline = { Color3.fromRGB(52, 252, 255), 0 };
        end;

        if ChigiriHighlight then
            v5.Fill = { Color3.fromRGB(0, 0, 0), 1 };
            v5.Outline = { Color3.fromRGB(255, 60, 1700, 0, 0), 0 };
        end;

        if NELIsagiHighlight then
            v5.Fill = { Color3.fromRGB(49, 207, 255), 1 };
            v5.Outline = { Color3.fromRGB(87, 87, 255), 0 };
        end;

        if NELNagiHighlight then
            v5.Fill = { Color3.fromRGB(49, 207, 255), 0.8 };
            v5.Outline = { Color3.fromRGB(49, 207, 255), 0 };
        end;

        if RaichiHighlight then
            v5.Outline = { Color3.fromRGB(255, 242, 57), 0 };
        end;

        if RinHighlight then
            v5.Fill = { Color3.fromRGB(57, 110, 255), 1 };
            v5.Outline = { Color3.fromRGB(78, 252, 255), 0 };
        end;

        if NessHighlight then
            v5.Fill = { Color3.fromRGB(57, 110, 255), 0.7 };
            v5.Outline = { Color3.fromRGB(34, 218, 255), 0 };
        end;

        if KuronaHighlight then
            v5.Fill = { Color3.fromRGB(87, 158, 29), 0.85 };
            v5.Outline = { Color3.fromRGB(188, 143, 255), 0 };
        end;

        if BMRinHighlight then
            v5.Fill = { Color3.fromRGB(130, 0, 0), 0.67 };
            v5.Outline = { Color3.fromRGB(255, 0, 0), 0 };
        end;

        if BachiraHighlight then
            v5.Fill = { Color3.fromRGB(255, 232, 55), 0.85 };
            v5.Outline = { Color3.fromRGB(255, 226, 79), 0 };
        end;

        if GoldenDefense then
            v5.Outline = { Color3.fromRGB(93, 39, 255), 0 };
        end;

        if FWBachiraHighlight then
            v5.Outline = { Color3.fromRGB(255, 232, 55), 0 };
            v5.Fill = { Color3.fromRGB(33, 81, 255), 0.85 };
        end;

        if PIsagiHighlight then
            v5.Outline = { Color3.fromRGB(255, 255, 255), 0 };
            v5.Fill = { Color3.fromRGB(0, 0, 0), 0.67 };
        end;

        if SLokiHighlight then
            v5.Outline = { Color3.fromRGB(2, 175, 255), 0 };
            v5.Fill = { Color3.fromRGB(0, 0, 0), 0.67 };
        end;

        if AikuHighlight then
            v5.Outline = { Color3.fromRGB(13, 255, 0), 0 };
            v5.Fill = { Color3.fromRGB(0, 0, 0), 0.67 };
        end;

        if GBCharlesHighlight then
            v5.Outline = { Color3.fromRGB(245, 0, 6), 0 };
            v5.Fill = { Color3.fromRGB(24, 250, 0), 0.5 };
        end;

        if SLavinhoHighlight then
            v5.Outline = { Color3.fromRGB(52, 150, 255), 0 };
            v5.Fill = { Color3.fromRGB(255, 215, 55), 0.85 };
        end;

        if ClonedCharacterValue and ClonedCharacterValue.Value then
            v5.Outline = { Color3.fromRGB(0, 0, 0), 1 };
            v5.Fill = { Color3.fromRGB(0, 0, 0), 1 };
            v5.Clone = ClonedCharacterValue.Value;
        end;

        if NelReoHighlight then
            v5.Outline = { Color3.fromRGB(199, 110, 255), 0 };
            v5.Fill = { Color3.fromRGB(0, 0, 0), 0.6 };
        end;

        if SaeHighlight then
            v5.Outline = { Color3.fromRGB(199, 110, 255), 0 };
            v5.Fill = { Color3.fromRGB(0, 0, 0), 0.6 };
        end;
    end;

    local v9;

    if p3 == LocalPlayer then
        v9 = StylePassiveController:Read("Velocity", "VelocityPercent");
    else
        v9 = p4:GetAttribute("passiveVelocity") or 0;
    end;

    if v9 and v9 > 0 then
        v5.Outline[1] = v5.Outline[1]:Lerp(Color3.fromRGB(255, 138, 43), v9);
    end;

    local Attribute2 = p4:GetAttribute("flashColor");
    local Attribute3 = p4:GetAttribute("flashTimestamp");

    if Attribute2 and Attribute3 then
        local v10 = workspace:GetServerTimeNow() - Attribute3;

        if v10 > 1.5 then
            p4:SetAttribute("flashTimestamp", nil);
            p4:SetAttribute("flashColor", nil);
        elseif v10 > 0.75 then
            v5.Fill = { Attribute2, (math.map(v10 - 0.75, 0, 0.75, 0.6, 1)) };
        else
            v5.Fill = { Attribute2, (math.map(0.75 - v10, 0, 0.75, 0.6, 1)) };
        end;
    end;

    if CameraController.Cutscene then
        v5 = u2;
    end;

    return v5;
end;

function v1.KnitStart(p11) -- Line: 241
    -- upvalues: Players (copy), getCharacterHighlightProps (copy)
    local function OnPlayerAdded(p12: userdata) -- Line: 242
        local function OnCharacterAdded(p13: userdata) -- Line: 243
            local Highlight = Instance.new("Highlight");
            Highlight.FillTransparency = 1;
            Highlight.OutlineTransparency = 1;
            Highlight.Adornee = p13;
            Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
            Highlight.Parent = p13;
        end;

        if p12.Character then
            task.spawn(OnCharacterAdded, p12.Character);
        end;

        p12.CharacterAdded:Connect(OnCharacterAdded);
    end;

    for _, v in Players:GetPlayers() do
        task.spawn(OnPlayerAdded, v);
    end;

    Players.PlayerAdded:Connect(OnPlayerAdded);
    task.spawn(function() -- Line: 264
        -- upvalues: Players (ref), getCharacterHighlightProps (ref)
        while true do
            for _, v in Players:GetPlayers() do
                local Character = v.Character;

                if Character then
                    local v14 = Character:FindFirstChildOfClass("Highlight");

                    if v14 then
                        local v15 = getCharacterHighlightProps(v, Character);

                        if v15.Fill then
                            v14.FillColor = v15.Fill[1];
                            v14.FillTransparency = v15.Fill[2];
                        else
                            v14.FillTransparency = 1;
                        end;

                        if v15.Outline then
                            v14.OutlineColor = v15.Outline[1];
                            v14.OutlineTransparency = v15.Outline[2];
                        else
                            v14.OutlineTransparency = 1;
                        end;

                        if v15.Clone then
                            local Clone = v15.Clone;
                            local v16 = Clone:FindFirstChildOfClass("Highlight");

                            if not v16 then
                                v16 = Instance.new("Highlight");
                                v16.Parent = Clone;
                            end;

                            if v15.Fill then
                                v16.FillColor = v15.Fill[1];
                                v16.FillTransparency = v15.Fill[2];
                            else
                                v16.FillTransparency = 1;
                            end;

                            if v15.Outline then
                                v16.OutlineColor = v15.Outline[1];
                                v16.OutlineTransparency = v15.Outline[2];
                            else
                                v16.OutlineTransparency = 1;
                            end;
                        end;
                    end;
                end;
            end;

            task.wait();
        end;
    end);
end;

function v1.getVFXInstances(p17) -- Line: 357
    -- upvalues: Players (copy), LocalPlayer (copy), Vfx (copy)
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p17);
    local v18 = false;
    local v19 = {};

    for _, v in Players:GetPlayers() do
        if v.Team ~= PlayerFromCharacter.Team and (v.Character and v.Character:GetAttribute("SixthSense")) then
            v18 = true;
        end;
    end;

    if v18 and (p17.Values.HasBall.Value and (p17.Values.IsInPenalty.Value and ((p17.HumanoidRootPart.Position - workspace.PenaltyArea[PlayerFromCharacter.Team.Name == "Away" and "Home" or "Away"].Position).Magnitude < 200 and (PlayerFromCharacter == LocalPlayer or LocalPlayer.Character:GetAttribute("SixthSense"))))) then
        v19.SixthSense = {
            VFX = Vfx.SixthSenseWarning,
            WeldPart = p17.HumanoidRootPart
        };
    end;

    return v19;
end;

return v1;