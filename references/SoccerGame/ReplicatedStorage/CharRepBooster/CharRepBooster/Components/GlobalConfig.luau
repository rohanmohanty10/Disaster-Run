  

game:GetService("Players");

return {
    Visualization = {
        VisualizeServerSnapshot = false,
        VisualizeNativeCharacter = false,
        VisualizeVelocity = false,
        VisualizeNativeCharacterOnTheServer = false
    },
    PlayerOwnedNetworkPartConstraints = "Server",
    Optimizations = {
        IgnoreRedundantServerSyncs = true,
        RectificationMode = "CFrameChangedListener",
        IgnoreRedundantRootCFrameUpdates = {
            EnabledForClientToServer = true,
            EnabledForServerToClient = true,
            PositionalCutoff = 0.1,
            DotResemblance = 0.995
        },
        IgnoreRedundantVelocityUpdates = {
            EnabledForClientToServer = true,
            EnabledForServerToClient = true,
            DotResemblance = 0.99,
            MagnitudeCutoff = {
                Studs = 0.1,
                Percent = 10
            }
        },
        UseSmartCompression = {
            RootCFrame = true,
            RootVelocity = true
        },
        DynamicPlayerUniqueTickRates = {
            Enabled = true,

            GetCFrameTickRate = function(p1: userdata, p2: userdata) -- Line: 66, Name: GetCFrameTickRate
                local v3 = p1.Character and p1.Character:FindFirstChild("HumanoidRootPart");
                local v4 = p2.Character and p2.Character:FindFirstChild("HumanoidRootPart");

                if v3 == nil or v4 == nil then
                    return 0.058823529411764705;
                end;

                local Magnitude = (v3.Position - v4.Position).Magnitude;

                return Magnitude < 35 and 0.03333333333333333 or (Magnitude < 100 and 0.04 or (Magnitude < 200 and 0.06666666666666667 or (Magnitude < 500 and 0.1 or 0.2)));
            end,

            GetVelocityTickRate = function(p5: userdata, p6: userdata) -- Line: 84, Name: GetVelocityTickRate
                local v7 = p5.Character and p5.Character:FindFirstChild("HumanoidRootPart");
                local v8 = p6.Character and p6.Character:FindFirstChild("HumanoidRootPart");

                if v7 == nil or v8 == nil then
                    return 0.058823529411764705;
                end;

                local Magnitude = (v7.Position - v8.Position).Magnitude;

                return Magnitude < 35 and 0.05 or (Magnitude < 60 and 0.06666666666666667 or (Magnitude < 100 and 0.1 or (Magnitude < 200 and 0.16666666666666666 or 0.3333333333333333)));
            end
        }
    },
    ServerRootCFrameDistributionSpeed = 0.05,
    ServerRootVelocityDistributionSpeed = 0.05,
    ClientToServerRootCFrameCacheTickRate = 0.03333333333333333,
    ClientToServerRootVelocityCacheTickRate = 0.05,
    ServerCFrameSyncRate = 0.03333333333333333,
    GloballyEnabled = true,
    WaitForSyncs = true,
    ClientVelocityBasedPrediction = {
        Enabled = true,
        MaxCompensation = 0.45,
        VelocityMultiplier = Vector3.new(1, 0.15, 1),
        VelocityClamps = {
            X = NumberRange.new(-100, 100),
            Y = NumberRange.new(0, 100),
            Z = NumberRange.new(-100, 100)
        }
    },
    BodyPartNames = {
        Head = true,
        Torso = true,
        ["Right Arm"] = true,
        ["Left Arm"] = true,
        ["Right Leg"] = true,
        ["Left Leg"] = true,
        LowerTorso = true,
        UpperTorso = true,
        RightUpperArm = true,
        RightLowerArm = true,
        RightHand = true,
        LeftUpperArm = true,
        LeftLowerArm = true,
        LeftHand = true,
        RightUpperLeg = true,
        RightLowerLeg = true,
        RightFoot = true,
        LeftUpperLeg = true,
        LeftLowerLeg = true,
        LeftFoot = true
    },
    AuxNames = {
        HumanoidRootPart = true,
        Handle = true
    },
    WhitelistedClasses = {
        Weld = true,
        SpecialMesh = true,
        Attachment = true,
        Humanoid = true,
        Animator = true,
        HumanoidDescription = true,
        BodyColors = true,
        Shirt = true,
        Pants = true,
        Accessory = true,
        Hat = true,
        Decal = true,
        Motor6D = true,
        Constraint = true
    }
};