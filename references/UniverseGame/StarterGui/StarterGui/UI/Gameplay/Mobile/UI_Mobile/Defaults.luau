  

 

return {
    PresetPositions = {
        {
            Position = UDim2.fromScale(-1.5, -1)
        },
        {
            Position = UDim2.fromScale(-0.55, -0.383)
        },
        {
            Position = UDim2.fromScale(-0.4, -1.6)
        },
        {
            Position = UDim2.fromScale(-0.383, -0.95)
        },
        {
            Position = UDim2.fromScale(0.717, -1.242)
        },
        {
            Position = UDim2.fromScale(-0.467, 0.35)
        },
        {
            Position = UDim2.fromScale(-1, -1.5)
        },
        {
            Position = UDim2.fromScale(0.117, -0.667)
        },
        {
            Position = UDim2.fromScale(0.817, -0.667)
        },
        {
            Position = UDim2.fromScale(-1.2, -0.5)
        },
        {
            Position = UDim2.fromScale(0.117, -1.258)
        },
        {
            Position = UDim2.fromScale(0.417, -1.758)
        },
        {
            Position = UDim2.fromScale(-1.6, -1.758)
        },
        {
            Position = UDim2.fromScale(-1.05, 0.1)
        },
        {
            Position = UDim2.fromScale(-1.625, 0.1)
        },
        {
            Position = UDim2.fromScale(0, -2.2)
        },
        {
            Position = UDim2.fromScale(0.717, -2.266)
        },
        {
            Position = UDim2.fromScale(0.55, -0.2)
        },
        {
            Position = UDim2.fromScale(-1, -1)
        }
    },
    Run = {
        Position = UDim2.fromScale(-1.85, -0.329),
        Size = UDim2.fromScale(0.55, 0.55),
        Callbacks = {
            Activated = function(p1, p2) -- Line: 66, Name: Activated
                p1.Character.Handler.Event:Fire("Run");
            end
        }
    },
    ["Shift Lock"] = {
        Position = UDim2.fromScale(-1.75, 0.318),
        Size = UDim2.fromScale(0.55, 0.55),
        Callbacks = {
            Activated = function(p3, p4) -- Line: 76, Name: Activated
                local Player = p3.Player;

                if Player:GetAttribute("MouseIsLocked_Mobile") then
                    Player:SetAttribute("MouseIsLocked_Mobile", not Player:GetAttribute("MouseIsLocked_Mobile"));
                else
                    Player:SetAttribute("MouseIsLocked_Mobile", true);
                end;

                local v5 = Player:GetAttribute("MouseIsLocked_Mobile");
                require(Player.PlayerScripts.PlayerModule):GetCameras().activeCameraController:SetIsMouseLocked(v5);
            end
        }
    },
    Lock = {
        Position = UDim2.fromScale(-1.1, 0.3),
        Size = UDim2.fromScale(0.55, 0.55),
        Callbacks = {
            Activated = function(p6, p7) -- Line: 97, Name: Activated
                local Player = p6.Player;
                local v8;

                if Player:GetAttribute("MouseIsLockedOn_Mobile") == nil then
                    v8 = false;
                else
                    v8 = Player:GetAttribute("MouseIsLockedOn_Mobile") or false;
                end;

                local PlayerModule = require(Player.PlayerScripts.PlayerModule);
                local v9 = p7.Knit.GetController("LockOnController");

                if v8 then
                    PlayerModule:GetCameras().activeCameraController:SetIsMouseLocked(Player:GetAttribute("MouseIsLocked_Mobile"));
                    v9:Set(nil);
                    Player:SetAttribute("MouseIsLockedOn_Mobile", false);

                    return;
                end;

                local v10 = RaycastParams.new();
                v10.FilterType = Enum.RaycastFilterType.Exclude;
                v10.FilterDescendantsInstances = { Player.Character, workspace.Effects };
                local HumanoidRootPart = Player.Character.HumanoidRootPart;
                local v11 = workspace:Spherecast(HumanoidRootPart.Position, 10, HumanoidRootPart.CFrame.LookVector * 50, v10);

                if not (v11 and v11.Position) then
                    return;
                end;

                if not v9:Find(v11.Position) then
                    return;
                end;

                Player:SetAttribute("MouseIsLockedOn_Mobile", true);
                PlayerModule:GetCameras().activeCameraController:SetIsMouseLocked(true);
            end
        }
    }
};