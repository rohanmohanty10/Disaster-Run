 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local LocalPlayer = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 14
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), VfxManager (copy), Essentials (copy), LocalPlayer (copy)
    local TimeSent = p2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    local BALL = Char:FindFirstChild("BALL", true);

    if p2.Task ~= "Activate" then
        if p2.Task == "Fly" then
            local RaycastParams_new_ret = RaycastParams.new();
            RaycastParams_new_ret.FilterDescendantsInstances = { workspace:FindFirstChild("Courts2") };
            RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;

            local function randInt(p3, p4) -- Line: 57
                return Random.new():NextNumber(p3, p4);
            end;

            for i = 1, 50 do
                local v5 = HumanoidRootPart.CFrame * CFrame.new(math.random(-15, 15), 0, math.random(0, 100));
                local v6 = workspace:Raycast(v5.Position, Vector3.new(0, -30, 0), RaycastParams_new_ret);
                local v7;

                if v6 then
                    local Part = Instance.new("Part");
                    Part.CFrame = CFrame.new(v6.Position) * CFrame.new(Random.new():NextNumber(-3, 3), 0, randInt(-3, 3));
                    Part.Parent = Debris;
                    local v8 = Random.new():NextNumber(0.5, 3);
                    local v9 = Random.new():NextNumber(0.5, 3);
                    Part.Size = Vector3.new(v8, v9, randInt(0.5, 3));
                    Part.Color = v6.Instance.Color;
                    Part.Anchored = false;
                    Part.CanCollide = false;
                    VfxManager.DestroyEffect(Part, 1.5);
                    local BodyVelocity = Instance.new("BodyVelocity");
                    BodyVelocity.Name = "BodyVelocityBasketball";
                    BodyVelocity.MaxForce = Vector3.new(inf, inf, inf);
                    BodyVelocity.Parent = Part;
                    BodyVelocity.P = 100000;
                    local v10 = Random.new():NextNumber(-70, 70);
                    local v11 = Random.new():NextNumber(30, 90);
                    BodyVelocity.Velocity = Vector3.new(v10, v11, randInt(-70, 70));
                    local BodyAngularVelocity = Instance.new("BodyAngularVelocity");
                    BodyAngularVelocity.Name = "BodyAngularVelocityBasketball";
                    BodyAngularVelocity.Parent = Part;
                    local v12 = Random.new():NextNumber(-90, 90);
                    local v13 = Random.new():NextNumber(-90, 90);
                    BodyAngularVelocity.AngularVelocity = Vector3.new(v12, v13, randInt(-90, 90));
                    BodyAngularVelocity.MaxTorque = Vector3.new(inf, inf, inf);
                    BodyAngularVelocity.P = 100000;
                    VfxManager.DestroyEffect(BodyVelocity, 0.25);
                    VfxManager.DestroyEffect(BodyAngularVelocity, 0.1);
                    task.delay(1, function() -- Line: 98
                        -- upvalues: Part (copy)
                        game:GetService("TweenService"):Create(Part, TweenInfo.new(0.1), {
                            Size = Vector3.new(0.00000001, 0.00000001, 0.00000001)
                        }):Play();
                    end);
                    v7 = i;
                else
                    v7 = i;
                end;
            end;

            local u14 = script.OffBall.Fly:Clone();
            u14.Name = Char.Name .. "CyberFly";
            u14:PivotTo(HumanoidRootPart.CFrame);
            u14.Parent = Debris;
            Essentials:Weld(u14.PrimaryPart, HumanoidRootPart);
            VfxManager.Enable(u14.HumanoidRootPart, true);
            VfxManager.Emit(u14.Slam);
            u14:SetAttribute("Active", true);
            task.delay(4, function() -- Line: 119
                -- upvalues: u14 (copy), VfxManager (ref)
                if u14 then
                    u14:SetAttribute("Active", nil);
                    VfxManager.Enable(u14, false);
                    VfxManager.DestroyEffect(u14, 3);
                end;
            end);

            if LocalPlayer.Character == Char then
                p1.CameraController.CamShake:ShakeOnce(5, 25, 0.2, 0.4);
            end;

            local CraterHandler = require(script.OffBall.CraterHandler);
            local CFrame2 = HumanoidRootPart.CFrame;
            local v15 = HumanoidRootPart.CFrame * CFrame.new(0, 0, 150);
            local math_clamp_ret = math.clamp((CFrame2.Position - v15.Position).Magnitude, 0, 150);
            CraterHandler.new("Path", CFrame.lookAt(CFrame2.Position, v15.Position), {
                HoldTime = 1,
                BlockSize = { 6, 20 },
                Distance = (CFrame2.Position - v15.Position).Magnitude > 150 and 150 or (CFrame2.Position - v15.Position).Magnitude,
                Width = { 25, 50 },
                IterateSpeed = {
                    Entrance = "Stepped",
                    EntranceDivision = "Iterate"
                },
                FlourishTypes = {
                    Exit = "Melt",
                    ExitDivision = "Iterate",
                    ExitSpeed = 1
                },
                StepSize = math_clamp_ret * 0.07692307692307693
            });
            task.delay(1.5, function() -- Line: 155
                local Cache = workspace:FindFirstChild("Cache");

                if Cache then
                    for _, descendant in Cache:GetDescendants() do
                        if descendant:IsA("Part") then
                            local v16 = descendant;
                            local v17 = {};

                            for _, descendant2 in descendant:GetDescendants() do
                                table.insert(v17, descendant2);
                            end;

                            if v17[1] ~= nil then
                                for _, v in v17 do
                                    v:Destroy();
                                end;

                                game:GetService("TweenService"):Create(v16, TweenInfo.new(1), {
                                    Position = v16.Position + Vector3.new(0, -50, 0)
                                }):Play();
                            end;
                        end;
                    end;
                end;
            end);
            task.wait(0.6333333333333333);
            local RaycastParams_new_ret2 = RaycastParams.new();
            RaycastParams_new_ret2.FilterDescendantsInstances = { workspace:FindFirstChild("Courts2") };
            RaycastParams_new_ret2.FilterType = Enum.RaycastFilterType.Include;

            while u14 ~= nil and (u14:GetAttribute("Active") == true and Char ~= nil) do
                for i = 1, 2 do
                    local v18 = HumanoidRootPart.CFrame * CFrame.new(7 * (i % 2 == 0 and 1 or -1), 0, 0);
                    local v19 = workspace:Raycast(v18.Position, Vector3.new(0, -30, 0), RaycastParams_new_ret2);
                    local v20;

                    if v19 then
                        local Part = Instance.new("Part");
                        local v21 = v18 * CFrame.new(0, -3, 0);
                        local CFrame_Angles = CFrame.Angles;
                        local math_random_ret = math.random(-360, 360);
                        local math_rad_ret = math.rad(math_random_ret);
                        local math_random_ret2 = math.random(-360, 360);
                        local math_rad_ret2 = math.rad(math_random_ret2);
                        local math_random_ret3 = math.random(-360, 360);
                        Part.CFrame = v21 * CFrame_Angles(math_rad_ret, math_rad_ret2, (math.rad(math_random_ret3)));
                        Part.Parent = Debris;
                        Part.Size = Vector3.new(0.00000001, 0.00000001, 0.00000001);
                        Part.Color = v19.Instance.Color;
                        Part.Anchored = true;
                        Part.CanCollide = false;
                        VfxManager.DestroyEffect(Part, 0.6);
                        game:GetService("TweenService"):Create(Part, TweenInfo.new(0.1), {
                            Size = Vector3.new(4, 4, 4)
                        }):Play();
                        local Part2 = Instance.new("Part");
                        Part2.CFrame = CFrame.new(v19.Position) * CFrame.new(Random.new():NextNumber(-3, 3), 0, randInt(-3, 3));
                        Part2.Parent = Debris;
                        local v22 = Random.new():NextNumber(0.5, 3);
                        local v23 = Random.new():NextNumber(0.5, 3);
                        Part2.Size = Vector3.new(v22, v23, randInt(0.5, 3));
                        Part2.Color = v19.Instance.Color;
                        Part2.Anchored = false;
                        Part2.CanCollide = false;
                        VfxManager.DestroyEffect(Part2, 1.5);
                        local BodyVelocity = Instance.new("BodyVelocity", Part2);
                        BodyVelocity.MaxForce = Vector3.new(inf, inf, inf);
                        BodyVelocity.P = 100000;
                        local v24 = Random.new():NextNumber(-70, 70);
                        local v25 = Random.new():NextNumber(30, 90);
                        BodyVelocity.Velocity = Vector3.new(v24, v25, randInt(-70, 70));
                        local BodyAngularVelocity = Instance.new("BodyAngularVelocity", Part2);
                        local v26 = Random.new():NextNumber(-90, 90);
                        local v27 = Random.new():NextNumber(-90, 90);
                        BodyAngularVelocity.AngularVelocity = Vector3.new(v26, v27, randInt(-90, 90));
                        BodyAngularVelocity.MaxTorque = Vector3.new(inf, inf, inf);
                        BodyAngularVelocity.P = 100000;
                        VfxManager.DestroyEffect(BodyVelocity, 0.25);
                        VfxManager.DestroyEffect(BodyAngularVelocity, 0.1);
                        task.delay(0.5, function() -- Line: 230
                            -- upvalues: Part (copy), Part2 (copy)
                            game:GetService("TweenService"):Create(Part, TweenInfo.new(0.1), {
                                Size = Vector3.new(0.00000001, 0.00000001, 0.00000001)
                            }):Play();
                            task.wait(0.5);
                            game:GetService("TweenService"):Create(Part2, TweenInfo.new(0.1), {
                                Size = Vector3.new(0.00000001, 0.00000001, 0.00000001)
                            }):Play();
                        end);
                        v20 = i;
                    else
                        v20 = i;
                    end;
                end;

                task.wait(0.05);
            end;
        else
            if p2.Task == "Found" then
                SfxManager:playSound({
                    Sound = "BBZ Psychic Flydunk",
                    Parent = HumanoidRootPart
                });
                local u28 = Debris:FindFirstChild(Char.Name .. "CyberFly");

                if u28 then
                    VfxManager.Enable(u28, false);
                    VfxManager.DestroyEffect(u28, 3);
                    task.delay(1.7, function() -- Line: 252
                        -- upvalues: u28 (copy)
                        u28:SetAttribute("Active", nil);
                    end);
                end;

                local u29 = script.OffBall.BallFX:Clone();
                u29.CFrame = BALL.CFrame;
                u29.Parent = Debris;
                Essentials:Weld(u29, BALL);
                local u30 = script.OffBall.HumanoidRootPart:Clone();
                u30.CFrame = HumanoidRootPart.CFrame;
                u30.Parent = Debris;
                Essentials:Weld(u30, HumanoidRootPart);
                VfxManager.Enable(u30, true);
                VfxManager.Enable(u29, true);
                local CFrame2 = workspace:FindFirstChild("Hoops"):FindFirstChild(LocalPlayer.Team.Name).Hoop.CFrame;
                task.delay(1.7, function() -- Line: 271
                    -- upvalues: VfxManager (ref), u29 (copy), u30 (copy), CFrame2 (copy), Debris (ref)
                    VfxManager.Enable(u29, false);
                    VfxManager.Enable(u30, false);
                    VfxManager.DestroyEffect(u29, 3);
                    VfxManager.DestroyEffect(u30, 3);
                    local v31 = script.OffBall.Score:Clone();
                    v31.CFrame = CFrame2;
                    v31.Parent = Debris;
                    VfxManager.Emit(v31);
                    VfxManager.DestroyEffect(v31, 3);
                end);

                return;
            end;

            local v32 = p2.Task == "End" and Debris:FindFirstChild(Char.Name .. "CyberFly");

            if v32 then
                v32:SetAttribute("Active", nil);
                VfxManager.Enable(v32, false);
                VfxManager.DestroyEffect(v32, 3);
            end;
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Psychic SelfPass",
        Parent = HumanoidRootPart
    });
    task.delay(0.65, function() -- Line: 28
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        local v33 = script.Pass:Clone();
        v33.CFrame = HumanoidRootPart.CFrame * CFrame.new(1.0417180061340332, 1.2969436645507812, -2.002422332763672) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
        v33.Parent = Debris;
        VfxManager.Emit(v33);
        VfxManager.DestroyEffect(v33, 3);
    end);
    task.delay(1.033, function() -- Line: 37
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        local v34 = script.Vanish:Clone();
        v34.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.23150920867919922, 0.8581891059875488, -0.0588836669921875) * CFrame.fromEulerAnglesYXZ(-1.5707963705062866, 1.5707963705062866, 0);
        v34.Parent = Debris;
        VfxManager.Emit(v34);
        VfxManager.DestroyEffect(v34, 3);
    end);
    task.delay(1.217, function() -- Line: 46
        -- upvalues: BALL (copy), Debris (ref), VfxManager (ref)
        local v35 = script.BallCatch:Clone();
        v35.CFrame = BALL.CFrame;
        v35.Parent = Debris;
        VfxManager.Emit(v35);
        VfxManager.DestroyEffect(v35, 3);
    end);
end;