  

 

local CourseGenerator = require(script:WaitForChild("CourseGenerator"));
local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Minigame = ReplicatedStorage["Client Assets"]["Planet Shaper"].Minigame;
local new = CFrame.new;
local new2 = Vector3.new;
local Angles = CFrame.Angles;
local _ = math.rad;
local asin = math.asin;

function Tween(p1, p2, p3, p4, p5)
    -- upvalues: TweenService (copy)
    local v6 = TweenService:Create(p1, TweenInfo.new(p4, Enum.EasingStyle[p3], Enum.EasingDirection[p2]), p5);
    v6:Play();

    return v6;
end;

return function(u7, u8) -- Line: 51
    -- upvalues: Minigame (copy), CourseGenerator (copy), new (copy), Angles (copy), new2 (copy), asin (copy), UserInputService (copy)
    return {
        Events = {},
        Assets = {},
        Internal = {
            CurrentRing = 1,
            Lives = 3,
            LastRingPass = 0,
            Time = 8
        },
        Rings = {},

        Initialize = function(u9) -- Line: 60, Name: Initialize
            -- upvalues: Minigame (ref), CourseGenerator (ref), u8 (copy), new (ref), Angles (ref)
            local Ring_Win = Minigame.Ring_Win;
            u9.Assets._RingNav = Minigame.Ring_Nav:Clone();
            u9.Assets._RingWin = Ring_Win:Clone();
            local Model = Instance.new("Model");
            Model.Name = "minigame_COURSE";
            local v10 = CourseGenerator.new(25, u8.StartingCFrame.p, Vector3.new(140, 0, 0), {
                x = 60,
                y = 40
            });
            local u11 = 0;
            v10:Generate():Propagate(function(p12, p13, p14) -- Line: 79
                -- upvalues: u11 (ref), u9 (copy), new (ref), Angles (ref), Model (copy)
                u11 = u11 + 1;

                if p14 ~= "Segment" then
                    local v15 = u9.Assets._RingWin:Clone();
                    v15.CFrame = new(p12, p13) * Angles(1.5707963267948966, 1.5707963267948966, -3.141592653589793);
                    v15.Parent = Model;
                    v15:SetAttribute("Type", "Ring_Goal");
                    v15.Name = u11;

                    return;
                end;

                local v16 = u9.Assets._RingNav:Clone();
                v16.CFrame = new(p12, p13) * Angles(-1.5707963267948966, 1.5707963267948966, -3.141592653589793);
                v16.Parent = Model;
                v16:SetAttribute("Type", "Ring_Path");
                v16.Name = u11;
                u9.Rings[u11] = v16;
            end):Obstacles(30, {
                x = 35,
                y = 35
            }, function(p17) -- Line: 100
                -- upvalues: Model (copy), Angles (ref)
                local Part = Instance.new("Part");
                local v18 = math.random(10, 20) / 10;
                Part.Size = Vector3.new(2, 2, v18) * math.random(10, 30) / 10;
                Part.Anchored = true;
                Part.Material = Enum.Material.Slate;
                Part.CanCollide = false;
                Part.Name = "Asteroid";
                Part.Parent = Model;
                local v19 = Random.new();
                Part.CFrame = Part.CFrame * Angles(v19:NextNumber(-3.141592653589793, 3.141592653589793), v19:NextNumber(-3.141592653589793, 3.141592653589793), v19:NextNumber(-3.141592653589793, 3.141592653589793));
                Part.Position = p17;
                Part:SetAttribute("Type", "Asteroid");
            end);
            u9.Connection = Instance.new("BindableEvent");
            u9.Course = Model;
            Model.Parent = workspace;
        end,

        Play = function(u20) -- Line: 124, Name: Play
            -- upvalues: u7 (copy), new (ref), u8 (copy), new2 (ref), Angles (ref), asin (ref), UserInputService (ref)
            local Character = u7.Character;
            local CurrentCamera = workspace.CurrentCamera;

            if not (Character and Character:FindFirstChild("HumanoidRootPart")) then
                return;
            end;

            Character:SetPrimaryPartCFrame(new(u8.StartingCFrame.p, u8.StartingCFrame.p + new2(140)));
            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
            u20.Internal.CurrentRing = 1;
            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.MaxForce = Vector3.new(inf, inf, inf);
            BodyVelocity.Name = "Minigame_FlyingVelocity";
            BodyVelocity.Velocity = Vector3.new(0, 0, 0);
            local BodyGyro = Instance.new("BodyGyro");
            BodyGyro.MaxTorque = Vector3.new(inf, inf, inf);
            BodyGyro.Name = "Flying Stabilizer";
            BodyGyro.D = 2500;
            BodyGyro.P = 300000;
            local BindableEvent = Instance.new("BindableEvent");
            u20.Internal.GameEvent = BindableEvent;
            u20.Internal.Stabilizer = BodyGyro;
            u20.Internal.FlyingVelocity = BodyVelocity;
            local u21 = OverlapParams.new();
            u21.MaxParts = 10;
            u21.FilterType = Enum.RaycastFilterType.Whitelist;
            u21.FilterDescendantsInstances = { u20.Course };

            local function CheckForCollisions(p22, p23) -- Line: 153
                -- upvalues: u21 (copy), BindableEvent (copy), u20 (copy)
                local v24 = workspace:GetPartBoundsInRadius(p22, p23, u21);

                for i = 1, #v24 do
                    local v25 = v24[i];
                    local v26 = v25:GetAttribute("Type");

                    if v26 then
                        if v26 == "Asteroid" then
                            v25.CanQuery = false;
                            BindableEvent:Fire(v26, v24[i]);
                        elseif tonumber(v25.Name) == u20.Internal.CurrentRing then
                            local Internal = u20.Internal;
                            Internal.CurrentRing = Internal.CurrentRing + 1;
                            v25.CanQuery = false;
                            local v27;

                            if u20.Rings[u20.Internal.CurrentRing] then
                                v27 = u20.Rings[u20.Internal.CurrentRing];
                            else
                                v27 = nil;
                            end;

                            BindableEvent:Fire(v26, v24[i], v27);
                        end;
                    end;
                end;
            end;

            local function GameStart() -- Line: 177
                -- upvalues: u20 (copy), BodyVelocity (copy), HumanoidRootPart (copy), BodyGyro (copy), CurrentCamera (copy), Angles (ref), asin (ref), CheckForCollisions (copy)
                u20.Active = true;
                BodyVelocity.Parent = HumanoidRootPart;
                BodyGyro.Parent = HumanoidRootPart;
                u20.Internal.LastRingPass = os.clock();
                u20.Events.Flying = game:GetService("RunService").Heartbeat:Connect(function() -- Line: 183
                    -- upvalues: HumanoidRootPart (ref), CurrentCamera (ref), BodyVelocity (ref), BodyGyro (ref), Angles (ref), asin (ref), CheckForCollisions (ref), u20 (ref)
                    local LookVector = HumanoidRootPart.CFrame:ToObjectSpace(CurrentCamera.CFrame).LookVector;
                    local Position = HumanoidRootPart.CFrame.Position;
                    local v28 = Position + HumanoidRootPart.AssemblyLinearVelocity.Unit * 10;
                    BodyVelocity.Velocity = CurrentCamera.CFrame.LookVector * 75;
                    BodyGyro.CFrame = BodyGyro.CFrame:Lerp(CFrame.lookAt(Position, v28), 0.5);
                    HumanoidRootPart.RootJoint.C0 = HumanoidRootPart.RootJoint.C0:Lerp(Angles(-1.5707963267948966, 0, 3.141592653589793 - asin(LookVector.X)), 0.2);
                    CheckForCollisions(Position, HumanoidRootPart.Size.Magnitude / 2);

                    if os.clock() - u20.Internal.LastRingPass >= u20.Internal.Time then
                        u20:Restart();
                    end;
                end);
            end;

            u20.Events.OnInput = UserInputService.InputBegan:Connect(function(p29, p30) -- Line: 199
                -- upvalues: u20 (copy), GameStart (copy)
                if p30 then
                    return;
                end;

                if p29.UserInputType == Enum.UserInputType.Keyboard and (p29.KeyCode == Enum.KeyCode.W and not u20.Active) then
                    GameStart();
                end;
            end);
            u20.Events.Collision = BindableEvent.Event:Connect(function(...) -- Line: 209
                -- upvalues: u20 (copy)
                u20:RespondToCollision(...);
            end);
        end,

        Stop = function(p31) -- Line: 214, Name: Stop
            for i, v in pairs(p31.Events) do
                v:Disconnect();
                rawset(p31.Events, i, nil);
            end;

            for i, v in pairs(p31.Internal) do
                if typeof(v) == "Instance" then
                    v:Destroy();
                    rawset(p31.Internal, i, nil);
                end;
            end;

            p31.Active = false;
        end,

        Destroy = function(p32) -- Line: 229, Name: Destroy
            -- upvalues: u7 (copy)
            u7.Character:PivotTo(CFrame.new(workspace.Map.GateLocations.ParkPos:GetAttribute("Position")));
            p32:Stop();
            p32.Connection:Destroy();

            if p32.Course ~= nil then
                p32.Course:Destroy();
            end;
        end,

        Restart = function(p33) -- Line: 239, Name: Restart
            p33:Stop();
            task.wait();
            p33.Connection:Fire("RESTART");
            p33.Internal.CurrentRing = 1;
            p33.Internal.Lives = 3;
            p33.Internal.LastRingPass = 0;

            for i = 1, #p33.Rings do
                local v34 = p33.Rings[i];
                v34.Transparency = 0;
                v34:FindFirstChildWhichIsA("Decal", true).Transparency = 0;

                if i == #p33.Rings then
                    v34.Color = Color3.fromRGB(248, 107, 218);
                else
                    v34.Color = Color3.fromRGB(248, 217, 109);
                end;
            end;

            for _, child in pairs(p33.Course:GetChildren()) do
                child.CanQuery = true;
            end;

            p33:Play();
        end,

        RespondToCollision = function(p35, p36, p37, ...) -- Line: 268, Name: RespondToCollision
            if p36 ~= "Ring_Path" then
                if p36 ~= "Ring_Goal" then
                    if p36 == "Asteroid" then
                        local Internal = p35.Internal;
                        Internal.Lives = Internal.Lives - 1;

                        if p35.Internal.Lives < 1 then
                            p35.Connection:Fire("DIED");

                            return;
                        end;

                        p35.Connection:Fire("DAMAGE_TAKEN");
                    end;

                    return;
                end;

                Tween(p37, "InOut", "Quad", 0.3, {
                    Transparency = 1
                });
                Tween(p37:FindFirstChildWhichIsA("Decal", true), "InOut", "Quad", 0.3, {
                    Transparency = 1
                });
                p35.Connection:Fire("GAME_WON");
                p35:Destroy();

                return;
            end;

            local v38 = ({ ... })[1];
            Tween(p37, "InOut", "Quad", 0.3, {
                Transparency = 1
            });
            Tween(p37:FindFirstChildWhichIsA("Decal", true), "InOut", "Quad", 0.3, {
                Transparency = 1
            });

            if v38 then
                v38.Color = Color3.fromRGB(255, 87, 65);
            end;

            p35.Internal.LastRingPass = os.clock();
            p35.Connection:Fire("RING_PASSED");
        end
    };
end;