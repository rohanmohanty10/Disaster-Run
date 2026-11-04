 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Teams = game:GetService("Teams");
local Knit = require(ReplicatedStorage.Packages.Knit);
local LocalPlayer = Players.LocalPlayer;
local Home = Teams.Home;
local Away = Teams.Away;
local v1 = Knit.CreateController({
    Name = "LagController"
});

function v1.KnitStart(p2) -- Line: 20
    -- upvalues: Knit (copy), RunService (copy), LocalPlayer (copy), Home (copy), Away (copy), Players (copy)
    local Service = Knit.GetService("LagService");
    local u3 = 0;
    RunService.Heartbeat:Connect(function() -- Line: 24
        -- upvalues: u3 (ref), LocalPlayer (ref), Home (ref), Away (ref), Players (ref), Service (copy)
        if os.clock() - u3 < 0.03333333333333333 then
            return;
        end;

        if LocalPlayer.Team ~= Home and LocalPlayer.Team ~= Away then
            return;
        end;

        local Character = LocalPlayer.Character;
        local v4;

        if Character then
            v4 = Character:FindFirstChild("HumanoidRootPart");
        else
            v4 = Character;
        end;

        if not v4 then
            return;
        end;

        local v5 = 120;
        local v6 = nil;

        for _, v in Players:GetPlayers() do
            local v7;

            if v.Character == Character then
                v7 = false;
            else
                v7 = v.Character and v.Character:FindFirstChild("HumanoidRootPart");
            end;

            local v8;

            if v7 then
                v8 = (v7.Position - v4.Position).Magnitude;
            else
                v8 = v7;
            end;

            if v8 and v8 < v5 then
                v6 = v7;
                v5 = v8;
            end;
        end;

        u3 = os.clock();
        local PositionReport = Service.PositionReport;
        local ServerTimeNow = workspace:GetServerTimeNow();
        local v9;

        if v6 then
            v9 = v6.Parent;
        else
            v9 = v6;
        end;

        if v6 then
            v6 = v6.Position;
        end;

        PositionReport:Fire(ServerTimeNow, v4.Position, v9, v6);
    end);
end;

return v1;