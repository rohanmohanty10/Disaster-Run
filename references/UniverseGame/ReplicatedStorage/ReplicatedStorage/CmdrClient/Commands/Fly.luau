  

 

return {
    Name = "fly",
    Description = "Toggles flight for the player.",
    Group = { "ScriptDevs", "Admins", "Mods", "HeadDevs", "Devs" },
    Args = { {
            Type = "boolean",
            Name = "Flying",
            Description = "Whether to enable or disable flying. Defaults to true.",
            Default = true
        } },

    ClientRun = function(p1, p2) -- Line: 14, Name: ClientRun
        local LocalPlayer = game:GetService("Players").LocalPlayer;
        local Character = LocalPlayer.Character;
        local u3;

        if Character then
            u3 = Character:FindFirstChildOfClass("Humanoid");
        else
            u3 = Character;
        end;

        local u4;

        if Character then
            u4 = Character:FindFirstChild("HumanoidRootPart");
        else
            u4 = Character;
        end;

        if not (Character and (u3 and u4)) then
            return "Invalid Character.";
        end;

        if p2 == false then
            if not u3:GetAttribute("Flying") then
                return `{LocalPlayer.Name} is already not flying.`;
            end;

            u3:SetAttribute("Flying", nil);
            u3.PlatformStand = false;
            u4.Massless = false;

            return `{LocalPlayer.Name} is now not flying.`;
        end;

        if u3:GetAttribute("Flying") then
            return `{LocalPlayer.Name} is already flying.`;
        end;

        local PlayerScripts = LocalPlayer.PlayerScripts;

        if not PlayerScripts:FindFirstChild("ControlModule", true) then
            return "Failed to find control module.";
        end;

        u3:SetAttribute("Flying", true);
        local CFrame2 = u4.CFrame;
        local ControlModule = require(PlayerScripts:FindFirstChild("ControlModule", true));
        task.spawn(function() -- Line: 47
            -- upvalues: u3 (copy), Character (copy), ControlModule (copy), CFrame2 (ref), u4 (copy)
            while u3:GetAttribute("Flying") and (Character.Parent and u3.Health ~= 0) do
                u3.PlatformStand = true;
                local CurrentCamera = workspace.CurrentCamera;
                local CFrame3 = CurrentCamera.CFrame;
                local Unit = ControlModule.activeController:GetMoveVector().Unit;
                CFrame2 = CFrame2 + CFrame3:Inverse():VectorToObjectSpace(Unit ~= Unit and Vector3.new(0, 0, 0) or Unit) * 1.5;
                u4.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
                u4.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
                u4.Massless = true;
                u4.CFrame = CFrame.lookAt(CFrame2.Position, CFrame2.Position + CurrentCamera.CFrame.LookVector * 5);
                task.wait();
            end;
        end);

        return `{LocalPlayer.Name} is now flying.`;
    end
};