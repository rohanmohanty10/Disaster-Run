  

local Players = game:GetService("Players");
local GuiService = game:GetService("GuiService");
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

local function u3(p1, p2) -- Line: 7
    -- upvalues: Players (copy), LocalPlayer (copy)
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p1);

    return not PlayerFromCharacter and true or PlayerFromCharacter.Team == LocalPlayer.Team;
end;

return function(p4: boolean?, p5: function?) -- Line: 15, Name: getPlayerTarget
    -- upvalues: u3 (copy), LocalPlayer (copy), Players (copy), workspace_CurrentCamera (copy), GuiService (copy)
    local v6 = p4 == nil and true or p4;
    local v7 = p5 or u3;
    local v8 = nil;
    local v9 = 9999;
    local v10 = {};
    local Character = LocalPlayer.Character;
    local PassRig = workspace:FindFirstChild("PassRig");

    if PassRig and v7(PassRig, Character) then
        table.insert(v10, PassRig);
    end;

    for _, v in Players:GetPlayers() do
        if v ~= LocalPlayer then
            local Character2 = v.Character;

            if v7(Character2, Character) then
                table.insert(v10, Character2);
            end;
        end;
    end;

    for _, v in v10 do
        local HumanoidRootPart = v:FindFirstChild("HumanoidRootPart");

        if HumanoidRootPart and v:FindFirstChild("Values") then
            local v11, v12 = workspace_CurrentCamera:WorldToScreenPoint(HumanoidRootPart.Position);

            if v12 or not v6 then
                local ViewportSize = workspace_CurrentCamera.ViewportSize;
                local Magnitude = (Vector2.new(v11.X, v11.Y) - (ViewportSize / 2 - GuiService:GetGuiInset())).Magnitude;

                if Magnitude < v9 then
                    v8 = v;
                    v9 = Magnitude;
                end;
            end;
        end;
    end;

    return v8, v9;
end;