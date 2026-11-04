 

 

local u1 = game:GetService("RunService"):IsServer();

return {
    Lock = function(p2: userdata?) -- Line: 20, Name: LockCFReplication
        -- upvalues: u1 (copy)
        if p2 then
            local CFrame = p2.CFrame;
            local __CHRONO_LOCKER = p2:FindFirstChild("__CHRONO_LOCKER");

            if __CHRONO_LOCKER then
                local __CHRONO_WELD = __CHRONO_LOCKER:FindFirstChild("__CHRONO_WELD");

                if __CHRONO_WELD then
                    __CHRONO_WELD.Part1 = p2;
                    p2.CFrame = CFrame;

                    return __CHRONO_WELD.Part0;
                end;

                pcall(__CHRONO_LOCKER.Destroy, __CHRONO_LOCKER);
            end;

            local Camera = Instance.new("Camera", p2);
            Camera.Archivable = false;
            Camera.Name = "__CHRONO_LOCKER";
            local Weld = Instance.new("Weld", Camera);
            Weld.Name = "__CHRONO_WELD";
            local Part = Instance.new("Part");
            Part.CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0, 0, 0);
            Part.Name = "__CHRONO_LOCKER_PART";
            Part.Parent = Camera;
            Part.CanCollide = false;
            Part.CanQuery = false;
            Part.CanTouch = false;
            Part.Transparency = u1 and 0 or 1;
            Part.Color = Color3.new(1, 0, 0);
            Part.Massless = false;
            Part.RootPriority = 126;
            Part.Size = Vector3.new(0, 0, 0);
            Weld.Part0 = Part;
            Weld.Part1 = p2;
            p2.CFrame = CFrame;

            return Part;
        end;
    end,

    Unlock = function(p3: userdata?) -- Line: 60, Name: UnlockCFReplication
        if not p3 then
            return;
        end;

        local CFrame = p3.CFrame;
        local __CHRONO_LOCKER = p3:FindFirstChild("__CHRONO_LOCKER");

        if __CHRONO_LOCKER then
            __CHRONO_LOCKER:Destroy();
            p3.CFrame = CFrame;
        end;
    end,

    GetLockedRoot = function(p4: userdata) -- Line: 12, Name: GetLockedRoot
        local __CHRONO_LOCKER = p4:FindFirstChild("__CHRONO_LOCKER");

        if __CHRONO_LOCKER then
            return __CHRONO_LOCKER:FindFirstChildWhichIsA("BasePart") or p4;
        end;

        return nil;
    end,

    SafeSetNetworkOwner = function(p5: userdata, p6: userdata?) -- Line: 6, Name: SafeSetNetworkOwner
        if p5:CanSetNetworkOwnership() then
            p5:SetNetworkOwner(p6);
        end;
    end
};