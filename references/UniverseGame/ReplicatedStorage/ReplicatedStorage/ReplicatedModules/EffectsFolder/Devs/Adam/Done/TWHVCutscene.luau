  

 

local LocalPlayer = game.Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;

return function() -- Line: 4
    -- upvalues: LocalPlayer (copy), CurrentCamera (copy)
    if game.Players.LocalPlayer.Settings.CutsceneCamera.Value == false then
        return;
    end;

    local Character = LocalPlayer.Character;
    local u1 = 0;
    local u2 = 0;

    local function rs() -- Line: 13
        -- upvalues: u1 (ref), u2 (ref)
        u1 = u1 + 1;
        u2 = 0;
    end;

    local _ = Character.HumanoidRootPart.CFrame;
    CurrentCamera.CameraType = Enum.CameraType.Scriptable;

    local function updcam(p3) -- Line: 19
        -- upvalues: CurrentCamera (ref)
        CurrentCamera.CFrame = p3;
    end;

    local v5 = game:GetService("RunService").RenderStepped:Connect(function(p4) -- Line: 22
        -- upvalues: Character (copy), u1 (ref), u2 (ref), CurrentCamera (ref)
        if Character == nil or #Character:GetChildren() <= 0 then
            u1 = -1;
        end;

        u2 = u2 + p4;

        if u1 == 0 then
            CurrentCamera.CFrame = CFrame.new((Character.HumanoidRootPart.CFrame * CFrame.new(5, 10, -10)).p, Character.HumanoidRootPart.CFrame.p);

            return;
        end;

        if u1 == 1 then
            CurrentCamera.CFrame = CFrame.new((Character.HumanoidRootPart.CFrame * CFrame.new(5, 10, -10)).p, Character.HumanoidRootPart.CFrame.p) * CFrame.Angles(math.sin(u2 * 20) / (u2 * 16 + 1), math.cos(u2 * 20) / (u2 * 16 + 1), 0);

            return;
        end;

        if u1 == 2 then
            CurrentCamera.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(5, 0, 5 - u2 / 2) * CFrame.Angles(0, 0.25, 0);

            return;
        end;

        if u1 == 3 then
            CurrentCamera.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(0, u2, -3) * CFrame.Angles(0, 3.141592653589793, 0);

            return;
        end;

        if u1 == 4 then
            CurrentCamera.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(5, 0, -u2 / 2) * CFrame.Angles(0, 1.5707963267948966, 0);

            return;
        end;

        if u1 == 5 then
            CurrentCamera.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(5, 0, 5) * CFrame.Angles(0, 0.25, 0) * CFrame.Angles(math.random(-100, 100) / 10000, math.random(-100, 100) / 10000, math.random(-100, 100) / 10000);

            return;
        end;

        if u1 == 6 then
            CurrentCamera.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(0, 5, 5) * CFrame.Angles(-0.25, 0, 0) * CFrame.Angles(math.random(-100, 100) / 10000, math.random(-100, 100) / 10000, math.random(-100, 100) / 10000);

            return;
        end;

        if u1 == 7 then
            CurrentCamera.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(-5, 0, 5) * CFrame.Angles(0, -0.25, 0) * CFrame.Angles(math.random(-100, 100) / 10000, math.random(-100, 100) / 10000, math.random(-100, 100) / 10000);

            return;
        end;

        if u1 == 8 then
            CurrentCamera.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -u2 * 16) * CFrame.Angles(0, 3.141592653589793, u2 / 4 + -0.5);
        end;
    end);
    wait(0.5);
    u1 = u1 + 1;
    u2 = 0;
    wait(1.5);
    u1 = u1 + 1;
    u2 = 0;
    wait(2);
    u1 = u1 + 1;
    u2 = 0;
    wait(1);
    u1 = u1 + 1;
    u2 = 0;
    wait(2.5);
    u1 = u1 + 1;
    u2 = 0;
    wait(0.2);
    u1 = u1 + 1;
    u2 = 0;
    wait(0.2);
    u1 = u1 + 1;
    u2 = 0;
    wait(0.3);
    u1 = u1 + 1;
    u2 = 0;
    wait(1);
    u1 = u1 + 1;
    u2 = 0;
    CurrentCamera.CameraType = Enum.CameraType.Custom;
    wait(3);
    v5:Disconnect();
end;