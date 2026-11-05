  

 

local Value = Enum.ContextActionPriority.Medium.Value;

return function(u1) -- Line: 3
    -- upvalues: Value (copy)
    game:GetService("UserInputService");
    local ContextActionService = game:GetService("ContextActionService");
    local Knit = u1.Knit;
    Knit.GetController("MoveInputController");
    local u2 = Knit.GetController("LockOnController");
    local Player = u1.Player;
    local _ = workspace.CurrentCamera;
    local PlayerModule = require(Player.PlayerScripts:WaitForChild("PlayerModule"));
    local u3 = PlayerModule:GetCameras();
    PlayerModule:GetControls();
    local u4 = false;
    local u5 = false;
    local u6 = false;
    local u7 = false;
    local u8 = true;

    local function HandleButton(p9, p10, p11) -- Line: 28
        -- upvalues: u5 (ref), Player (copy), u4 (ref), u3 (copy), u6 (ref), u2 (copy), u7 (ref), u8 (ref), u1 (copy)
        if p10 == Enum.UserInputState.Begin then
            if p9 == "PlayerRun" then
                u5 = not u5;
                Player.Character.Handler.Event:Fire("Run", u5);
            elseif p9 == "LockOn" then
                u4 = not u4;

                if not u4 then
                    u3.activeCameraController:SetIsMouseLocked(u6);
                    u2:Set(nil);

                    return Enum.ContextActionResult.Pass;
                end;

                local v12 = RaycastParams.new();
                v12.FilterType = Enum.RaycastFilterType.Exclude;
                v12.FilterDescendantsInstances = { Player.Character, workspace.Effects };
                local HumanoidRootPart = Player.Character.HumanoidRootPart;
                local v13 = workspace:Spherecast(HumanoidRootPart.Position, 10, HumanoidRootPart.CFrame.LookVector * 50, v12);

                if not (v13 and v13.Position) then
                    return Enum.ContextActionResult.Pass;
                end;

                if not u2:Find(v13.Position) then
                    return Enum.ContextActionResult.Pass;
                end;

                u3.activeCameraController:SetIsMouseLocked(true);
            elseif p9 == "ShiftLock" then
                if u7 == true and p11.KeyCode == Enum.KeyCode.ButtonR3 then
                    u6 = not u6;
                    u3.activeCameraController:SetIsMouseLocked(u6);

                    if u3.activeMouseLockController then
                        u3.activeCameraController:SetMouseLockOffset(u3.activeMouseLockController:GetMouseLockOffset());
                    end;

                    u8 = not u8;
                    u1.SetMoveBackpackVisible(u8);

                    return Enum.ContextActionResult.Sink;
                end;

                if p11.KeyCode == Enum.KeyCode.ButtonL3 then
                    u7 = true;

                    return Enum.ContextActionResult.Pass;
                end;
            elseif p9 == "ToggleMoves" then
                u8 = not u8;
                u1.SetMoveBackpackVisible(u8);
            end;
        elseif p10 == Enum.UserInputState.End and (p9 == "ShiftLock" and p11.KeyCode == Enum.KeyCode.ButtonL3) then
            u7 = false;
        end;

        return Enum.ContextActionResult.Pass;
    end;

    for i, v in {
        PlayerRun = {
            Name = "Run",
            Position = UDim2.fromScale(0.625, -0.1),
            AdditionalInputs = { Enum.KeyCode.ButtonR2 }
        },
        LockOn = {
            Name = "Lock",
            Position = UDim2.fromScale(0.625, -0.4),
            AdditionalInputs = { Enum.KeyCode.ButtonL2 }
        },
        ToggleMoves = {
            Name = "Toggle Moves",
            Position = UDim2.fromScale(0.625, 0.2),
            AdditionalInputs = { Enum.KeyCode.ButtonL3 }
        },
        ShiftLock = {
            Name = "Shift Lock",
            Position = UDim2.fromScale(0.4, 0.2),
            AdditionalInputs = { Enum.KeyCode.ButtonL3, Enum.KeyCode.ButtonR3 }
        }
    } do
        ContextActionService:BindActionAtPriority(i, HandleButton, false, Value + 1, unpack(v.AdditionalInputs));
        ContextActionService:SetTitle(i, v.Name);
        ContextActionService:SetPosition(i, v.Position);
    end;
end;