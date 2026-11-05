  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ReplicatedModules = ReplicatedStorage:FindFirstChild("ReplicatedModules");
local PathShortcuts = require(ReplicatedModules:FindFirstChild("PathShortcuts"));
local Knit = require(PathShortcuts.KnitPath.Knit);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local u1 = Knit.GetService("MountService");

return {
    BypassCharge = true,
    BypassJump = true,
    Yield = true,
    IgnoreSignal = true,

    OnJump = function(p2) -- Line: 17, Name: OnJump
        -- upvalues: u1 (copy), EffectsHandler (copy)
        local Character = p2.Character;
        local Animator = p2.Animator;
        local Trove = p2.Trove;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v3 = Animator:OnGround() and 1 or 2;

        if v3 == 1 then
            u1.MountSkillSignal:Fire("Jump", false, v3);
            p2.Animator:PlayAnimation("Jump", 1.25, 0.01);
            Character.HumanoidRootPart:ApplyImpulse(Vector3.new(0, 2100, 0));
            task.spawn(function() -- Line: 31
                -- upvalues: EffectsHandler (ref), Character (copy)
                EffectsHandler.CallEffect("MechJump", Character);
                EffectsHandler.CallEffect("MechLand", Character, CFrame.Angles(-1.5707963267948966, 0, 0), 12.5, "Mount", true, 10, 0.75);
            end);
        else
            local v4 = Character:GetAttribute("LastThrust") or 0;

            if os.clock() - v4 <= 8 then
                return;
            end;

            u1.MountSkillSignal:Fire("Jump", true, v3);
            p2.Animator:PlayAnimation("Thruster", 1.25, 0.075);

            if HumanoidRootPart:FindFirstChild("PlanarVelocity") then
                HumanoidRootPart:FindFirstChild("PlanarVelocity").Enabled = false;
                Trove:Add(function() -- Line: 47
                    -- upvalues: HumanoidRootPart (copy)
                    HumanoidRootPart:FindFirstChild("PlanarVelocity").Enabled = true;
                end);
            end;

            local LookVector = HumanoidRootPart.CFrame.LookVector;
            HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
            local VectorForce = Instance.new("VectorForce");
            Trove:Add(VectorForce);
            VectorForce.Attachment0 = HumanoidRootPart:FindFirstChild("RootAttachment");
            VectorForce.Force = Vector3.new(0, 1500, -3000);
            Character.HumanoidRootPart:ApplyImpulse(LookVector * Vector3.new(1, 0, 1) * 4000 + Vector3.new(0, 1600, 0));
            EffectsHandler.CallEffect("FOVSwap", 90, 0.08, 0.8);
            EffectsHandler.CallEffect("CameraShake", "ViolentShake");
            EffectsHandler.CallEffect("TemporalEffect", Color3.fromRGB(123, 213, 255), Color3.fromRGB(255, 213, 129), 0.1);
            Character:SetAttribute("LastThrust", os.clock());
            task.wait(1.2);
            local _ = HumanoidRootPart.AssemblyLinearVelocity;
            task.defer(function() -- Line: 75
                task.wait();
            end);

            if VectorForce.Parent then
                VectorForce:Destroy();
            end;
        end;

        u1.MountSkillSignal:Fire("Jump", false, v3);
    end,

    Check = function(p5, p6) -- Line: 88, Name: Check
        return p5:OnGround() or p5.State == "Falling";
    end
};