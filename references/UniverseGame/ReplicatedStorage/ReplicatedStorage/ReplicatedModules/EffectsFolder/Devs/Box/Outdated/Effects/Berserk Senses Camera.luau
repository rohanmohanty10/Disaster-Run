  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local CurrentCamera = workspace.CurrentCamera;
require(game:GetService("ReplicatedStorage").ReplicatedModules.Animations);
local AnimationHandler = require(game.ReplicatedStorage.ReplicatedModules.AnimationHandler);

local function CreateInstance(p2, p3) -- Line: 6
    local function CheckProperty(p4, p5) -- Line: 8
        local _ = p4[p5];
    end;

    local u6 = Instance.new(p2);

    for i, v in pairs(p3) do
        if pcall(function() -- Line: 15
            -- upvalues: u6 (copy), i (copy)
            local _ = u6[i];
        end) then
            u6[i] = v;
        end;
    end;

    return u6;
end;

return function(u7) -- Line: 24
    -- upvalues: u1 (copy), CreateInstance (copy), CurrentCamera (copy), AnimationHandler (copy)
    if game.Players.LocalPlayer.Settings.CutsceneCamera.Value == false then
        return;
    end;

    local HumanoidRootPart = u7.HumanoidRootPart;
    local Humanoid = u7.Humanoid;
    local u8 = u1["Gold Experience"].CameraRig:Clone();
    u8.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
    u8.Parent = u7;
    CreateInstance("Motor6D", {
        Part0 = HumanoidRootPart,
        Part1 = u8.PrimaryPart,
        Parent = u8.PrimaryPart
    });
    CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local u9 = Humanoid:LoadAnimation((AnimationHandler.CreateAnimationByName("Gold Experience", nil, "Berserk Senses Camera")));
    u9:Play();
    local u10 = nil;
    coroutine.wrap(function() -- Line: 46
        -- upvalues: u10 (ref), CurrentCamera (ref), u8 (copy), u7 (copy), Humanoid (copy), u9 (ref)
        while not u10 do
            CurrentCamera.CFrame = u8.camera.CFrame;
            wait();

            if not u7 or (not u7.Parent or (not Humanoid or Humanoid.Parent ~= u7)) then
                u9:Stop();

                return;
            end;
        end;
    end)();
    u9.Stopped:Wait();
    u10 = true;
    CurrentCamera.CameraType = Enum.CameraType.Custom;
    u8:Destroy();
end;