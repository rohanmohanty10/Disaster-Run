  

 

game:GetService("TweenService");
local u1 = game.ReplicatedStorage["Client Assets"];
local CurrentCamera = workspace.CurrentCamera;
local _ = game.Players.LocalPlayer;
local Animations = require(game.ReplicatedStorage.ReplicatedModules.Animations);

local function CreateInstance(p2, p3) -- Line: 7
    local function CheckProperty(p4, p5) -- Line: 9
        local _ = p4[p5];
    end;

    local u6 = Instance.new(p2);

    for i, v in pairs(p3) do
        if pcall(function() -- Line: 16
            -- upvalues: u6 (copy), i (copy)
            local _ = u6[i];
        end) then
            u6[i] = v;
        end;
    end;

    return u6;
end;

return function(p7, p8) -- Line: 25
    -- upvalues: u1 (copy), CreateInstance (copy), CurrentCamera (copy), Animations (copy)
    local HumanoidRootPart = p7.HumanoidRootPart;
    local Humanoid = p7.Humanoid;
    local u9 = u1["Stone Free"].cam:Clone();
    u9.PrimaryPart.CFrame = HumanoidRootPart.CFrame * p8;
    u9.Parent = p7;
    CreateInstance("Motor6D", {
        Part0 = HumanoidRootPart,
        Part1 = u9.PrimaryPart,
        Parent = u9.PrimaryPart
    });
    CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local u10 = nil;
    coroutine.wrap(function() -- Line: 38
        -- upvalues: u10 (ref), CurrentCamera (ref), u9 (copy)
        while not u10 do
            CurrentCamera.CFrame = u9.camera.CFrame;
            wait();
        end;
    end)();
    Animations.playClient("Stone Free", "Pitcher Fly Camera", nil, nil, Humanoid).Stopped:Wait();
    u10 = true;
    CurrentCamera.CameraType = Enum.CameraType.Custom;
    u9:Destroy();
end;