 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Teams = game:GetService("Teams");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Trove);
local Knit = require(ReplicatedStorage.Packages.Knit);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 17
    -- upvalues: Players (copy), Teams (copy), Knit (copy), SfxManager (copy), LocalPlayer (copy), Essentials (copy), ReplicatedStorage (copy), Debris (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local v3 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if p2.Task == "Disable" then
        if not v3 or v3.Team == Teams.Visitor then
            return;
        end;

        local Controller = Knit.GetController("AbilityController");
        SfxManager:playSound({
            Sound = "BBZ Genius Disable",
            Parent = workspace
        });

        if v3.Team ~= LocalPlayer.Team then
            local v4 = tick() + 15;

            if Controller.CDS[1] < v4 then
                Controller.CDS[1] = v4;
            end;

            local v5 = tick() + 15;

            if Controller.CDS[2] < v5 then
                Controller.CDS[2] = v5;
            end;
        end;

        local v6 = {};

        for _, v in Teams[Essentials:ActualTeam(v3.Team.Name)]:GetPlayers() do
            if v.Character and v.Character:FindFirstChild("Head") then
                local Head = v.Character.Head;
                local v7 = script.Overhead:Clone();
                v7.Parent = Head;
                table.insert(v6, v7);
            end;
        end;

        local MapFolder = workspace:FindFirstChild("MapFolder");

        if MapFolder then
            MapFolder.Parent = ReplicatedStorage;
            task.delay(15, function() -- Line: 57
                -- upvalues: MapFolder (copy)
                if not workspace:FindFirstChild("MapFolder") then
                    MapFolder.Parent = workspace;
                end;
            end);
        end;

        local _, v8, _ = CFrame.new(Vector3.new(0, 4, -297.5), (Vector3.new(workspace.Hoops[v3.Team.Name].Hoop.Position.X, 4, -297.5))):ToOrientation();
        local v9 = script.Map:Clone();
        v9.Parent = Debris;
        v9:PivotTo(CFrame.new(0, 0.5, -297.5) * CFrame.fromOrientation(0, v8 + 1.5707963267948966, 0));
        VfxManager.DestroyEffect(v9, 15);
        local v10 = script.Aura:Clone();
        v10.Parent = Debris;
        v10.CFrame = HumanoidRootPart.CFrame;
        Essentials:Weld(v10, HumanoidRootPart);
        local v11 = tick();

        while tick() - v11 < 15 do
            for _, v in v6 do
                if v and v:FindFirstChild("Timer") then
                    local Timer = v.Timer;
                    local v12 = 15 - (tick() - v11);
                    Timer.Text = `{math.round(v12)}s`;
                end;
            end;

            task.wait();
        end;

        for _, v in v6 do
            v:Destroy();
        end;

        VfxManager.Enable(v10, false);
        VfxManager.DestroyEffect(v10, 1);
    end;
end;