 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
game:GetService("UserInputService");
game:GetService("SoundService");
local _ = Players.LocalPlayer;
local v1 = require(ReplicatedStorage.Packages.Knit).CreateController({
    Name = script.Name
});

function v1.PlayCar(p2: table, p3: userdata) -- Line: 15
    -- upvalues: TweenService (copy)
    local v4 = script.CarTemplate:Clone();
    v4.Body["Car idle"]:Play();
    v4.Parent = workspace.Debris;
    v4.PrimaryPart.CFrame = p3.CFrame;
    local End = p3:FindFirstChild("End");

    if not End then
        v4:Destroy();

        return;
    end;

    local v5 = TweenService:Create(v4.PrimaryPart, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
        CFrame = End.WorldCFrame
    });
    v5:Play();
    v5.Completed:Wait();
    v4:Destroy();
end;

function v1.Setup(p6) -- Line: 33
    local CarPoints = workspace:WaitForChild("CarPoints", 5);

    if not CarPoints then
        return;
    end;

    local Random_new_ret = Random.new();

    while CarPoints.Parent do
        task.wait(Random_new_ret:NextNumber(1.5, 3));
        local Children = CarPoints:GetChildren();
        local v7 = Children[math.random(1, #Children)];

        if v7 and workspace:FindFirstChild("Map1") then
            p6:PlayCar(v7);
        end;
    end;
end;

function v1.KnitStart(p8) -- Line: 50
    p8:Setup();
end;

return v1;