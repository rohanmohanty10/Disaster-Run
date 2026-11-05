  

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local LocalPlayer = Players.LocalPlayer;

if not LocalPlayer then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait();
    LocalPlayer = Players.LocalPlayer;
end;

local u1 = LocalPlayer:GetMouse();
local CameraInput = require(script.Parent:WaitForChild("CameraInput"));
local CameraUI = require(script.Parent:WaitForChild("CameraUI"));
local u2 = false;
local u3 = tick();
local u4 = false;
local u5 = false;
local u6 = false;
CameraUI.setCameraModeToastEnabled(false);

return function(p7) -- Line: 28
    -- upvalues: CameraInput (copy), u2 (ref), u4 (ref), u3 (ref), CameraUI (copy), u6 (ref), u5 (ref), u1 (copy), UserInputService (copy), UserGameSettings (copy)
    local v8 = CameraInput.getTogglePan();

    if p7 and v8 ~= u2 then
        u4 = true;
    end;

    if u2 ~= v8 or tick() - u3 > 3 then
        local v9;

        if v8 then
            v9 = tick() - u3 < 3;
        else
            v9 = v8;
        end;

        CameraUI.setCameraModeToastOpen(v9);

        if v8 then
            u4 = false;
        end;

        u3 = tick();
        u2 = v8;
    end;

    if p7 ~= u6 then
        if p7 then
            u5 = CameraInput.getTogglePan();
            CameraInput.setTogglePan(true);
        elseif not u4 then
            CameraInput.setTogglePan(u5);
        end;
    end;

    if p7 then
        if CameraInput.getTogglePan() then
            u1.Icon = "rbxasset://textures/Cursors/CrossMouseIcon.png";
            UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter;
            UserGameSettings.RotationType = Enum.RotationType.CameraRelative;
        else
            u1.Icon = "";
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
            UserGameSettings.RotationType = Enum.RotationType.CameraRelative;
        end;
    elseif CameraInput.getTogglePan() then
        u1.Icon = "rbxasset://textures/Cursors/CrossMouseIcon.png";
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter;
        UserGameSettings.RotationType = Enum.RotationType.MovementRelative;
    elseif CameraInput.getHoldPan() then
        u1.Icon = "";
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition;
        UserGameSettings.RotationType = Enum.RotationType.MovementRelative;
    else
        u1.Icon = "";
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
        UserGameSettings.RotationType = Enum.RotationType.MovementRelative;
    end;

    u6 = p7;
end;