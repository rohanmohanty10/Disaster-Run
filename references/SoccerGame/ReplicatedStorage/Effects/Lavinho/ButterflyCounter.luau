  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local u1 = {};

return function(u2) -- Line: 15
    -- upvalues: SpectatorController (copy), TweenService (copy), Lighting (copy), UserInputService (copy), RunService (copy), Debris (copy), SoundManager (copy), u1 (copy), VfxManager (copy), Essentials (copy)
    local Char = u2.Char;
    local LocalPlayer = game.Players.LocalPlayer;

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local HumanoidRootPart = Char.HumanoidRootPart;

    if not HumanoidRootPart then
        return;
    end;

    local function ScreenEffect() -- Line: 24
        -- upvalues: Char (copy), LocalPlayer (copy), TweenService (ref), Lighting (ref)
        if (Char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
            TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
                TintColor = Color3.fromRGB(255, 235, 83)
            }):Play();
            task.delay(0.1, function() -- Line: 28
                -- upvalues: TweenService (ref), Lighting (ref)
                TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.6), {
                    TintColor = Color3.new(1, 1, 1)
                }):Play();
            end);
        end;
    end;

    if u2.Type == "Start" then
        task.spawn(function() -- Line: 36
            -- upvalues: UserInputService (ref), RunService (ref), u2 (ref), TweenService (ref), Debris (ref)
            local u3 = {
                Color3.new(0.945098, 0.333333, 1),
                Color3.new(0.203922, 0.309804, 1),
                Color3.new(0.223529, 0.701961, 1),
                Color3.new(0.419608, 1, 0.258824),
                Color3.new(1, 0.894118, 0.298039),
                Color3.new(1, 0.227451, 0.227451),
                Color3.new(0.631373, 0.447059, 1)
            };
            local u4 = 1;
            local u5 = nil;
            local u6 = UserInputService.TouchEnabled and 0.15 or 0.08;
            local u7 = tick();
            u5 = RunService.Heartbeat:Connect(function() -- Line: 56
                -- upvalues: u2 (ref), u5 (ref), u7 (ref), u6 (ref), u4 (ref), u3 (copy), TweenService (ref), Debris (ref)
                if u2.Char == nil then
                    table.clear(u2);
                    u2 = nil;

                    if u5 then
                        u5:Disconnect();
                        u5 = nil;
                    end;
                end;

                if u7 + u6 < tick() then
                    u7 = tick();
                    u4 = u4 + 1;

                    if u4 > #u3 then
                        u4 = 1;
                    end;

                    u2.Char.Archivable = true;
                    local u8 = u2.Char:Clone();
                    task.delay(0.55, function() -- Line: 76
                        -- upvalues: u8 (copy)
                        u8:Destroy();
                    end);
                    task.spawn(function() -- Line: 80
                        -- upvalues: u8 (copy)
                        for _, child in u8.HumanoidRootPart:GetChildren() do
                            if child:IsA("Sound") then
                                child:Destroy();
                            end;
                        end;
                    end);
                    task.spawn(function() -- Line: 88
                        -- upvalues: u8 (copy)
                        u8.Torso:FindFirstChild("Jersey"):Destroy();
                    end);
                    local Children = u8:GetChildren();

                    for _, v in pairs(Children) do
                        if v:IsA("Accessory") and v.Name == "Cape" then
                            v:Destroy();
                        elseif v:IsA("Accessory") and v.Name == "Peppermint Cape" then
                            v:Destroy();
                        elseif v:IsA("Accessory") and v.Name == "Santa Hat" then
                            v:Destroy();
                        elseif v:IsA("Script") or v:IsA("LocalScript") then
                            v:Destroy();
                        elseif v:IsA("Highlight") then
                            v.FillColor = u3[u4];
                            v.OutlineColor = u3[u4];
                            v.OutlineTransparency = 0;
                            v.FillTransparency = 0;
                            local v9 = TweenService:Create(v, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                FillTransparency = 1,
                                OutlineTransparency = 1
                            });
                            v9:Play();
                            Debris:AddItem(v9, 0.55);
                        elseif v:IsA("MeshPart") or v:IsA("BasePart") then
                            v.CanCollide = false;
                            v.Anchored = true;

                            if v.Name ~= "HumanoidRootPart" then
                                local v10 = TweenService:Create(v, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                    Transparency = 1
                                });
                                v10:Play();
                                Debris:AddItem(v10, 0.55);
                            end;
                        elseif v:IsA("Accessory") then
                            v.Handle.CanCollide = false;
                            v.Handle.Anchored = true;
                            local v11 = TweenService:Create(v.Handle, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                Transparency = 1
                            });
                            v11:Play();
                            Debris:AddItem(v11, 0.55);
                        end;
                    end;

                    table.clear(Children);
                    u8.Parent = workspace;
                end;
            end);
            task.delay(1, function() -- Line: 149
                -- upvalues: u2 (ref), u5 (ref), u3 (copy), u4 (ref)
                table.clear(u2);
                u2 = nil;

                if u5 then
                    u5:Disconnect();
                    u5 = nil;
                end;

                table.clear(u3);
                u4 = nil;
            end);
        end);
        SoundManager.SpawnSound("ButterflyCounter", 0.9, Char.HumanoidRootPart, 130, false);
        warn("hi");
        local v12 = script.Startup:Clone();
        v12.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.300014496, -2.0999999, 0.300479889, -1, 0, 0, 0, 1, 0, 0, 0, -1);
        v12.Parent = workspace.Debris;
        table.insert(u1, v12);
        VfxManager.Emit(v12);
        Debris:AddItem(v12, 2);
        local v13 = script.SideToSideDribble:Clone();
        v13.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.09998703, -0.349999905, 0.600476265, 1, 0, 0, 0, 1, 0, 0, 0, 1);
        v13.Parent = HumanoidRootPart;
        Essentials:WeldOffset(HumanoidRootPart, v13, CFrame.new(-0.09998703, -0.349999905, 0.600476265, 1, 0, 0, 0, 1, 0, 0, 0, 1));
        table.insert(u1, v13);
        VfxManager.Emit(v13);
        Debris:AddItem(v13, 2);
    elseif u2.Type == "Dash" then
        for _, v in u1 do
            if v then
                v:Destroy();
            end;
        end;

        SoundManager.SpawnSound("ButterflyCounterDash", 0.9, Char.HumanoidRootPart, 130, false);
        local v14 = script.Startup:Clone();
        v14.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.300014496, -2.0999999, 0.300479889, -1, 0, 0, 0, 1, 0, 0, 0, -1);
        v14.Parent = workspace.Debris;
        VfxManager.Emit(v14);
        Debris:AddItem(v14, 2);
        task.wait(0.35);
        local u15 = script.Wings:Clone();
        u15.WeldConstraint.Part1 = Char.Torso;
        u15.CFrame = Char.Torso.CFrame * CFrame.new(
            -0.000112533569,
            0.599975586,
            0.599342346,
            1.00000024,
            -0.0000143945217,
            3.36766243e-6,
            0.0000143051147,
            1.00000012,
            5.17070293e-6,
            -3.44216824e-6,
            -5.20050526e-6,
            1
        );
        u15.Parent = Char.Torso;
        VfxManager.Emit(u15);
        task.delay(0.55, function() -- Line: 209
            -- upvalues: u15 (copy), TweenService (ref)
            for _, descendant in u15:GetDescendants() do
                if descendant:IsA("Beam") then
                    TweenService:Create(descendant, TweenInfo.new(0.05), {
                        Width0 = 0,
                        Width1 = 0
                    }):Play();
                end;
            end;
        end);
        Debris:AddItem(u15, 2);
        local v16 = script.JumpEmit:Clone();
        v16.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.112487793, -2.16743398, -2.83056164, 0, 0, 1, 0, 1, 0, -1, 0, 0);
        v16.Parent = workspace.Debris;
        VfxManager.Emit(v16);
        Debris:AddItem(v16, 2);
        table.clear(u1);
    elseif u2.Type == "Dribble" then
        local v17 = script.Startup:Clone();
        v17.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.300014496, -2.0999999, 0.300479889, -1, 0, 0, 0, 1, 0, 0, 0, -1);
        v17.Parent = workspace.Debris;
        VfxManager.Emit(v17);
        Debris:AddItem(v17, 3);
        local u18 = script.Wings:Clone();
        u18.WeldConstraint.Part1 = Char.Torso;
        u18.CFrame = Char.Torso.CFrame * CFrame.new(
            -0.000112533569,
            0.599975586,
            0.599342346,
            1.00000024,
            -0.0000143945217,
            3.36766243e-6,
            0.0000143051147,
            1.00000012,
            5.17070293e-6,
            -3.44216824e-6,
            -5.20050526e-6,
            1
        );
        u18.Parent = Char.Torso;
        VfxManager.Emit(u18);
        VfxManager.Enable(u18, true);

        for _, descendant in u18:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Width0 = 0;
                descendant.Width1 = 0;
                TweenService:Create(descendant, TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                    Width0 = 5,
                    Width1 = 5
                }):Play();
            end;
        end;

        task.delay(1.6, function() -- Line: 253
            -- upvalues: VfxManager (ref), u18 (copy), TweenService (ref)
            VfxManager.Enable(u18, false);

            for _, descendant in u18:GetDescendants() do
                if descendant:IsA("Beam") then
                    TweenService:Create(descendant, TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.In), {
                        Width0 = 0,
                        Width1 = 0
                    }):Play();
                end;
            end;
        end);
        Debris:AddItem(u18, 2);
        task.delay(0.117, function() -- Line: 264
            -- upvalues: HumanoidRootPart (copy), VfxManager (ref), Debris (ref)
            local v19 = script.ShootEmit:Clone();
            v19.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -1.8, -2);
            v19.Parent = workspace.Debris;
            VfxManager.Emit(v19);
            Debris:AddItem(v19, 3);
        end);
        task.delay(0.533, function() -- Line: 274
            -- upvalues: HumanoidRootPart (copy), VfxManager (ref), Debris (ref)
            local v20 = script.JumpEmit:Clone();
            v20.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.112487793, -2.16743398, -2.83056164, 0, 0, 1, 0, 1, 0, -1, 0, 0);
            v20.Parent = workspace.Debris;
            VfxManager.Emit(v20);
            Debris:AddItem(v20, 2);
        end);
        task.delay(1.45, function() -- Line: 284
            -- upvalues: HumanoidRootPart (copy), VfxManager (ref), Debris (ref)
            local v21 = script.Land:Clone();
            v21.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.112487793, -2.16743398, -2.83056164, 0, 0, 1, 0, 1, 0, -1, 0, 0);
            v21.Parent = workspace.Debris;
            VfxManager.Emit(v21);
            Debris:AddItem(v21, 2);
        end);
    end;
end;