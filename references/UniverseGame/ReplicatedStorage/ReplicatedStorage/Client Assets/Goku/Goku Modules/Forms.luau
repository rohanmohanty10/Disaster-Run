  

 

local Funcs = require(game.ReplicatedStorage["Client Assets"].Goku["Goku Modules"].Funcs);
local Tween = Funcs.Tween;
local _ = Funcs.Raycast;
local GetFloor = Funcs.GetFloor;
local Thread = Funcs.Thread;
local Glue = Funcs.Glue;
local Wait = Funcs.Wait;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Models = ReplicatedStorage["Client Assets"].Goku.Assets.Models;
local Effects = Models.Effects;
local Output = ReplicatedStorage.Remotes.Output;

local function createEffect(p1, p2, p3) -- Line: 12
    -- upvalues: Output (copy)
    if p3 and p3:IsA("Player") then
        for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
            if v:DistanceFromCharacter(p3.Character.HumanoidRootPart.Position) < 30 then
                Output:FireClient(p3, "FX", "Goku Create", p1, p2);
            end;
        end;

        return;
    end;

    Output:FireAllClients("FX", "Goku Create", p1, p2);
end;

return {
    Base = function(u4, p5, p6, p7, p8) -- Line: 25
        -- upvalues: Wait (copy), Thread (copy), Tween (copy), createEffect (copy)
        if u4:FindFirstChild("HumanoidRootPart") == nil or u4:FindFirstChildOfClass("Humanoid") == nil then
            return;
        end;

        local HumanoidRootPart = u4:FindFirstChild("HumanoidRootPart");
        u4:FindFirstChildOfClass("Humanoid");
        u4.UIHair.UIOutline.Transparency = 1;
        HumanoidRootPart.MUITheme:Stop();
        HumanoidRootPart.UITheme:Stop();
        Wait(0.015);
        pcall(function() -- Line: 33
            -- upvalues: u4 (copy)
            workspace:FindFirstChild(u4.Name .. "UI"):Destroy();
        end);
        pcall(function() -- Line: 36
            -- upvalues: u4 (copy)
            workspace:FindFirstChild(u4.Name .. "MUI"):Destroy();
        end);
        pcall(function() -- Line: 39
            -- upvalues: u4 (copy)
            workspace:FindFirstChild(u4.Name .. "Egg"):Destroy();
        end);
        Thread(function() -- Line: 42
            -- upvalues: u4 (copy), Tween (ref), HumanoidRootPart (copy)
            for _, child in ipairs(u4:GetChildren()) do
                if child:IsA("BasePart") and child.Name:find("Hair") then
                    child.Transparency = 1;
                end;
            end;

            Tween(u4.BaseHair, 0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
                Transparency = 0,
                Color = Color3.fromRGB(17, 17, 17)
            });
            u4.BaseHair.Color = Color3.fromRGB(17, 17, 17);

            for _, child in ipairs(u4.FakeHead:GetChildren()) do
                if child:IsA("Decal") then
                    child.Transparency = 1;
                end;
            end;

            u4.FakeHead.BaseFace.Transparency = 0;
            local v9 = next;
            local v10, v11 = HumanoidRootPart:GetChildren();

            for _, v in v9, v10, v11 do
                if v:IsA("Sound") and v.Name:find("Aura") then
                    v:Stop();
                end;
            end;
        end);

        for _, descendant in ipairs(u4:GetDescendants()) do
            if descendant:IsA("Part") and (descendant.Name == "Glow" and descendant:FindFirstChild("Mesh") ~= nil) then
                Thread(function() -- Line: 67
                    -- upvalues: Tween (ref), descendant (copy)
                    Tween(descendant, 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
                        Transparency = 1
                    });
                    game:GetService("Debris"):AddItem(descendant, 1);
                end);
            end;
        end;

        createEffect("Transform", {
            Time = 0.1,
            Color = Color3.fromRGB(255, 255, 255)
        }, game:GetService("Players"):GetPlayerFromCharacter(u4));

        if table.find({ "SSJ", "SSJ2", "SSJ3", "SSJ4" }, p8) then
            HumanoidRootPart.SSJDisable:Play();
        else
            HumanoidRootPart.SSJGDisable:Play();
        end;

        for _, descendant in ipairs(u4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == p6 .. "AuraParticle" then
                descendant.Enabled = true;
            end;
        end;
    end,

    SSJ = function(u12, p13, p14, p15) -- Line: 98
        -- upvalues: Tween (copy), Thread (copy), Wait (copy), GetFloor (copy), Output (copy), createEffect (copy)
        if u12:FindFirstChild("HumanoidRootPart") == nil or u12:FindFirstChildOfClass("Humanoid") == nil then
            return;
        end;

        local HumanoidRootPart = u12:FindFirstChild("HumanoidRootPart");
        u12:FindFirstChildOfClass("Humanoid");
        HumanoidRootPart.SSJTransformation:Play();
        HumanoidRootPart.MUITheme:Stop();
        HumanoidRootPart.UITheme:Stop();
        Tween(u12.BaseHair, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Color = p13.SSJColor
        });
        u12.SSJHair.Color = p13.SSJColor;
        Thread(function() -- Line: 109
            -- upvalues: Wait (ref), Tween (ref), u12 (copy)
            Wait(0.75);
            Tween(u12.BaseHair, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
                Transparency = 1
            });
        end);
        Tween(u12.FakeHead.SSJFace, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 0
        });
        Tween(u12.SSJHair, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 0,
            Color = p13.SSJColor
        });
        Thread(function() -- Line: 123
            -- upvalues: GetFloor (ref), u12 (copy), HumanoidRootPart (copy), Wait (ref), Output (ref)
            local v16 = GetFloor(u12, HumanoidRootPart);
            local v17 = 0;

            while true do
                Wait(0.1);
                v17 = v17 + 1;
                Output:FireAllClients("FX", "Goku Create", "Circle", {
                    Transparency = 0,
                    Size = Vector3.new(1, 1, 0.065),
                    Time = 0.46,
                    CFrame = u12.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0) * CFrame.Angles(1.5707963267948966, 0, 0),
                    Color = Color3.fromRGB(255, 255, 255),
                    Style = Enum.EasingStyle.Cubic,
                    Direction = Enum.EasingDirection.Out,
                    PartProperties = {
                        Size = Vector3.new(15, 15, 0.2),
                        Transparency = 1
                    },
                    MeshProperties = {
                        Scale = Vector3.new(15, 15, 0.2)
                    }
                });

                if v16 ~= nil and v16:IsA("BasePart") then
                    local v18 = u12.HumanoidRootPart.CFrame * CFrame.new(math.random(-50, 50) / 10, math.random(-35, 0) / 10, math.random(-50, 50) / 10);
                    Output:FireAllClients("FX", "Goku Create", "Cube", {
                        Transparency = 0,
                        Time = 1,
                        CFrame = v18,
                        Color = v16.Color,
                        Size = Vector3.new(1, 1, 1) * math.random(3, 10) / 10,
                        Material = v16.Material,
                        Style = Enum.EasingStyle.Sine,
                        Direction = Enum.EasingDirection.Out,
                        Properties = {
                            Transparency = 1,
                            CFrame = v18 * CFrame.new(0, 5, 0)
                        }
                    });
                end;

                if v17 > 8 then
                    return;
                end;
            end;
        end);
        Wait(0.9);
        Wait(0.515);
        HumanoidRootPart.TransformationBass:Play();
        Output:FireAllClients("FX", "Goku Create", "Circle", {
            Transparency = 0,
            Size = Vector3.new(1, 1, 1),
            Time = 1.5,
            CFrame = u12.HumanoidRootPart.CFrame * CFrame.new(0, -1.5, 0) * CFrame.Angles(1.5707963267948966, 0, 0),
            Color = Color3.fromRGB(255, 255, 255),
            Style = Enum.EasingStyle.Cubic,
            Direction = Enum.EasingDirection.Out,
            PartProperties = {
                Size = Vector3.new(40, 40, 6),
                Transparency = 1
            },
            MeshProperties = {
                Scale = Vector3.new(40, 40, 6)
            }
        });
        Output:FireAllClients("FX", "Goku Create", "Sphere", {
            Transparency = 0,
            Size = Vector3.new(1, 1, 1),
            Time = 1.5,
            CFrame = u12.HumanoidRootPart.CFrame,
            Color = Color3.fromRGB(255, 250, 99),
            Material = Enum.Material.Neon,
            Style = Enum.EasingStyle.Cubic,
            Direction = Enum.EasingDirection.Out,
            Properties = {
                Size = Vector3.new(25, 25, 25),
                Transparency = 1
            }
        });

        for _ = 1, math.random(12, 18) do
            local CFrame2 = u12.HumanoidRootPart.CFrame;
            local Angles = CFrame.Angles;
            local v19 = math.random(-360, 360);
            local v20 = math.rad(v19);
            local v21 = math.random(-360, 360);
            local v22 = math.rad(v21);
            local v23 = math.random(-360, 360);
            local v24 = CFrame2 * Angles(v20, v22, (math.rad(v23))) * CFrame.new(0, 0, math.random(12, 22));
            Output:FireAllClients("FX", "Goku Create", "Sphere", {
                Transparency = 0,
                Size = Vector3.new(1, 1, 1),
                CFrame = u12.HumanoidRootPart.CFrame,
                Color = Color3.fromRGB(255, 250, 99),
                Time = math.random(9, 18) / 10,
                Material = Enum.Material.Neon,
                Style = Enum.EasingStyle.Quad,
                Direction = Enum.EasingDirection.Out,
                Properties = {
                    Size = Vector3.new(0.1, 0.1, 3),
                    Transparency = 1,
                    CFrame = v24
                }
            });
        end;

        createEffect("TransformShake", {}, game:GetService("Players"):GetPlayerFromCharacter(u12));
        createEffect("Transform", {
            Time = 0.4,
            Color = Color3.fromRGB(255, 255, 0)
        }, game:GetService("Players"):GetPlayerFromCharacter(u12));
        p15:Fire();

        for _, descendant in ipairs(u12:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == p14 .. "AuraParticle" then
                descendant.Enabled = true;
            end;
        end;
    end,

    SSJ2 = function(u25, p26, p27, p28) -- Line: 234
        -- upvalues: Thread (copy), Wait (copy), GetFloor (copy), Output (copy), Tween (copy), createEffect (copy)
        if u25:FindFirstChild("HumanoidRootPart") == nil or u25:FindFirstChildOfClass("Humanoid") == nil then
            return;
        end;

        local HumanoidRootPart = u25:FindFirstChild("HumanoidRootPart");
        u25:FindFirstChildOfClass("Humanoid");
        HumanoidRootPart.MUITheme:Stop();
        HumanoidRootPart.UITheme:Stop();
        Thread(function() -- Line: 240
            -- upvalues: Wait (ref), GetFloor (ref), u25 (copy), HumanoidRootPart (copy), Output (ref)
            Wait(0.5);
            local v29 = GetFloor(u25, HumanoidRootPart);
            local v30 = 0;

            while true do
                Wait(0.1);
                v30 = v30 + 1;
                Output:FireAllClients("FX", "Goku Create", "Circle", {
                    Transparency = 0,
                    Size = Vector3.new(1, 1, 0.065),
                    Time = 0.46,
                    CFrame = u25.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0) * CFrame.Angles(1.5707963267948966, 0, 0),
                    Color = Color3.fromRGB(255, 255, 255),
                    Style = Enum.EasingStyle.Cubic,
                    Direction = Enum.EasingDirection.Out,
                    PartProperties = {
                        Size = Vector3.new(15, 15, 0.2),
                        Transparency = 1
                    },
                    MeshProperties = {
                        Scale = Vector3.new(15, 15, 0.2)
                    }
                });

                if v29 ~= nil and v29:IsA("BasePart") then
                    local v31 = u25.HumanoidRootPart.CFrame * CFrame.new(math.random(-50, 50) / 10, math.random(-35, 0) / 10, math.random(-50, 50) / 10);
                    Output:FireAllClients("FX", "Goku Create", "Cube", {
                        Transparency = 0,
                        Time = 1,
                        CFrame = v31,
                        Color = v29.Color,
                        Size = Vector3.new(1, 1, 1) * math.random(3, 10) / 10,
                        Material = v29.Material,
                        Style = Enum.EasingStyle.Sine,
                        Direction = Enum.EasingDirection.Out,
                        Properties = {
                            Transparency = 1,
                            CFrame = v31 * CFrame.new(0, 5, 0)
                        }
                    });
                end;

                if v30 > 8 then
                    return;
                end;
            end;
        end);
        HumanoidRootPart.SSJ2Transformation:Play();
        Output:FireAllClients("FX", "Goku Create", "Sphere", {
            Transparency = 1,
            Size = Vector3.new(30, 30, 30),
            Time = 1.5,
            TweenAgain = true,
            Time2 = 1,
            TimeBetween = 0,
            CFrame = u25.HumanoidRootPart.CFrame,
            Color = Color3.fromRGB(255, 253, 174),
            Material = Enum.Material.Neon,
            Style = Enum.EasingStyle.Sine,
            Direction = Enum.EasingDirection.Out,
            Properties = {
                Size = Vector3.new(6, 6, 6),
                Transparency = 0.5
            },
            Properties2 = {
                Transparency = 1
            }
        });
        Wait(0.9);
        Tween(u25.SSJHair, 0.69, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 1,
            Color = Color3.fromRGB(202, 163, 85)
        });
        Tween(u25.SSJ2Hair, 0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 0,
            Color = p26.SSJColor
        });
        Tween(u25.FakeHead.SSJFace, 0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 1
        });
        Tween(u25.FakeHead.SSJ2Face, 0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 0
        });
        Wait(0.5);
        HumanoidRootPart.TransformationBass:Play();
        createEffect("TransformShake", {}, game:GetService("Players"):GetPlayerFromCharacter(u25));
        createEffect("Transform", {
            Time = 0.4,
            Color = Color3.fromRGB(255, 255, 0)
        }, game:GetService("Players"):GetPlayerFromCharacter(u25));

        for _ = 1, math.random(15, 20) do
            local CFrame2 = u25.HumanoidRootPart.CFrame;
            local Angles = CFrame.Angles;
            local v32 = math.random(-360, 360);
            local v33 = math.rad(v32);
            local v34 = math.random(-360, 360);
            local v35 = math.rad(v34);
            local v36 = math.random(-360, 360);
            local v37 = CFrame2 * Angles(v33, v35, (math.rad(v36))) * CFrame.new(0, 0, math.random(12, 22));
            local v38 = math.random(1, 2) == 1;
            Output:FireAllClients("FX", "Goku Create", "Sphere", {
                Transparency = 0,
                Size = Vector3.new(1, 1, 1),
                CFrame = u25.HumanoidRootPart.CFrame,
                Color = v38 == true and Color3.fromRGB(255, 250, 99) or Color3.fromRGB(255, 255, 255),
                Time = math.random(9, 18) / 10,
                Material = Enum.Material.Neon,
                Style = Enum.EasingStyle.Cubic,
                Direction = Enum.EasingDirection.Out,
                Properties = {
                    Size = Vector3.new(0.2, 0.2, 7),
                    Transparency = 1,
                    CFrame = v37
                }
            });
        end;

        Wait(0.05);
        Output:FireAllClients("FX", "Goku Create", "Circle", {
            Transparency = 0,
            Size = Vector3.new(1, 1, 1),
            Time = 1.5,
            CFrame = u25.HumanoidRootPart.CFrame * CFrame.new(0, -1.5, 0) * CFrame.Angles(1.5707963267948966, 0, 0),
            Color = Color3.fromRGB(255, 255, 255),
            Style = Enum.EasingStyle.Cubic,
            Direction = Enum.EasingDirection.Out,
            PartProperties = {
                Size = Vector3.new(40, 40, 6),
                Transparency = 1
            },
            MeshProperties = {
                Scale = Vector3.new(40, 40, 6)
            }
        });

        for i = 1, 2 do
            Output:FireAllClients("FX", "Goku Create", "Sphere", {
                Transparency = 0,
                Size = Vector3.new(1, 1, 1),
                CFrame = u25.HumanoidRootPart.CFrame,
                Color = Color3.fromRGB(255, 250, 99),
                Time = 1.5 / i,
                Material = Enum.Material.Neon,
                Style = Enum.EasingStyle.Cubic,
                Direction = Enum.EasingDirection.Out,
                Properties = {
                    Transparency = 1,
                    Size = Vector3.new(17, 17, 17) * i
                }
            });
            Wait(0.05);
        end;

        p28:Fire();

        for _, descendant in ipairs(u25:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == p27 .. "AuraParticle" then
                descendant.Enabled = true;
            end;
        end;
    end,

    SSJ3 = function(u39, p40, p41, p42) -- Line: 396
        -- upvalues: Output (copy), Thread (copy), Wait (copy), GetFloor (copy), Tween (copy), createEffect (copy)
        if u39:FindFirstChild("HumanoidRootPart") == nil or u39:FindFirstChildOfClass("Humanoid") == nil then
            return;
        end;

        local HumanoidRootPart = u39:FindFirstChild("HumanoidRootPart");
        u39:FindFirstChildOfClass("Humanoid");
        HumanoidRootPart.MUITheme:Stop();
        HumanoidRootPart.UITheme:Stop();
        Output:FireAllClients("FX", "Goku Create", "Earthquake", nil);
        Thread(function() -- Line: 403
            -- upvalues: Wait (ref), GetFloor (ref), u39 (copy), HumanoidRootPart (copy), Output (ref)
            Wait(0.57);
            local v43 = GetFloor(u39, HumanoidRootPart);
            local v44 = 0;

            while true do
                Wait(0.1);
                v44 = v44 + 1;
                local v45 = HumanoidRootPart.CFrame * CFrame.new(math.random(-20, 20) / 10 * math.random(7, 40) / 10, math.random(-35, 0) / 10, math.random(-20, 20) / 10 * math.random(7, 40) / 10);
                Output:FireAllClients("FX", "Goku Create", "Circle", {
                    Transparency = 0,
                    Size = Vector3.new(1, 1, 0.065),
                    Time = 0.46,
                    CFrame = u39.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0) * CFrame.Angles(1.5707963267948966, 0, 0),
                    Color = Color3.fromRGB(255, 255, 255),
                    Style = Enum.EasingStyle.Cubic,
                    Direction = Enum.EasingDirection.Out,
                    PartProperties = {
                        Size = Vector3.new(15, 15, 0.2),
                        Transparency = 1
                    },
                    MeshProperties = {
                        Scale = Vector3.new(15, 15, 0.2)
                    }
                });
                Output:FireAllClients("FX", "Goku Create", "Sphere", {
                    Transparency = 1,
                    Size = Vector3.new(0.21, 1.45, 0.33),
                    Time = 0.4,
                    TweenAgain = true,
                    Time2 = 0.25,
                    TimeBetween = 0,
                    CFrame = v45 * CFrame.new(0, math.random(-6, -3), 0),
                    Color = Color3.fromRGB(255, 230, 102),
                    Material = Enum.Material.Neon,
                    Style = Enum.EasingStyle.Sine,
                    Direction = Enum.EasingDirection.InOut,
                    Properties = {
                        Transparency = 0,
                        CFrame = v45 * CFrame.new(0, math.random(4, 10), 0)
                    },
                    Properties2 = {
                        Transparency = 1,
                        CFrame = v45 * CFrame.new(0, math.random(13, 19), 0)
                    }
                });

                if v43 ~= nil and v43:IsA("BasePart") then
                    local v46 = u39.HumanoidRootPart.CFrame * CFrame.new(math.random(-50, 50) / 10, math.random(-35, 0) / 10, math.random(-50, 50) / 10);
                    Output:FireAllClients("FX", "Goku Create", "Cube", {
                        Transparency = 0,
                        Time = 1,
                        CFrame = v46,
                        Color = v43.Color,
                        Size = Vector3.new(1, 1, 1) * math.random(3, 10) / 10,
                        Material = v43.Material,
                        Style = Enum.EasingStyle.Sine,
                        Direction = Enum.EasingDirection.Out,
                        Properties = {
                            Transparency = 1,
                            CFrame = v46 * CFrame.new(0, 5, 0)
                        }
                    });
                end;

                if v44 > 45 then
                    return;
                end;
            end;
        end);
        Tween(u39.SSJ2Hair, 3.65, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 1,
            Color = Color3.fromRGB(255, 250, 99)
        });
        Tween(u39.FakeHead.SSJ2Face, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 1
        });
        HumanoidRootPart.SSJ3Transformation:Play();
        Tween(u39.FakeHead.SSJ3Face, 0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 0
        });
        Wait(1.35);
        u39.SSJ3Hair.Color = Color3.fromRGB(255, 250, 99);
        Tween(u39.SSJ3Hair, 1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 0
        }, true);
        Wait(1.5);
        Wait(0.5);
        HumanoidRootPart.TransformationBass:Play();
        createEffect("TransformShake", {}, game:GetService("Players"):GetPlayerFromCharacter(u39));
        createEffect("Transform", {
            Time = 0.4,
            Color = Color3.fromRGB(255, 255, 0)
        }, game:GetService("Players"):GetPlayerFromCharacter(u39));

        for _ = 1, math.random(16, 20) do
            local CFrame2 = u39.HumanoidRootPart.CFrame;
            local Angles = CFrame.Angles;
            local v47 = math.random(-360, 360);
            local v48 = math.rad(v47);
            local v49 = math.random(-360, 360);
            local v50 = math.rad(v49);
            local v51 = math.random(-360, 360);
            local v52 = CFrame2 * Angles(v48, v50, (math.rad(v51))) * CFrame.new(0, 0, math.random(12, 32));
            local v53 = math.random(1, 2) == 1;
            Output:FireAllClients("FX", "Goku Create", "Sphere", {
                Transparency = 0,
                Size = Vector3.new(1, 1, 1),
                CFrame = u39.HumanoidRootPart.CFrame,
                Color = v53 == true and Color3.fromRGB(255, 250, 99) or Color3.fromRGB(255, 255, 255),
                Time = math.random(9, 18) / 10,
                Material = Enum.Material.Neon,
                Style = Enum.EasingStyle.Quad,
                Direction = Enum.EasingDirection.InOut,
                Properties = {
                    Size = Vector3.new(0, 0, 10),
                    Transparency = 1,
                    CFrame = v52
                }
            });
        end;

        Wait(0.05);
        Output:FireAllClients("FX", "Goku Create", "Circle", {
            Transparency = 0,
            Size = Vector3.new(1, 1, 1),
            Time = 1.5,
            CFrame = u39.HumanoidRootPart.CFrame * CFrame.new(0, -1.5, 0) * CFrame.Angles(1.5707963267948966, 0, 0),
            Color = Color3.fromRGB(255, 255, 255),
            Style = Enum.EasingStyle.Cubic,
            Direction = Enum.EasingDirection.Out,
            PartProperties = {
                Size = Vector3.new(40, 40, 6),
                Transparency = 1
            },
            MeshProperties = {
                Scale = Vector3.new(40, 40, 6)
            }
        });
        Output:FireAllClients("FX", "Goku Create", "Wave", {
            WaveType = 6,
            Transparency = 1,
            StartSize = Vector3.new(5, 1, 5),
            Time = 0.55,
            TweenAgain = true,
            Time2 = 0.4,
            TimeBetween = 0,
            CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -1, 0),
            Color = Color3.fromRGB(255, 255, 255),
            Style = Enum.EasingStyle.Sine,
            Direction = Enum.EasingDirection.InOut,
            Properties = {
                Size = Vector3.new(25, 10, 25),
                Transparency = 0
            },
            Properties2 = {
                Size = Vector3.new(60, 10, 60),
                Transparency = 1
            }
        });

        for i = 1, 2 do
            Output:FireAllClients("FX", "Goku Create", "Sphere", {
                Transparency = 0,
                Size = Vector3.new(1, 1, 1),
                CFrame = u39.HumanoidRootPart.CFrame,
                Color = Color3.fromRGB(255, 250, 99),
                Time = 1.5 / i,
                Material = Enum.Material.Neon,
                Style = Enum.EasingStyle.Cubic,
                Direction = Enum.EasingDirection.Out,
                Properties = {
                    Transparency = 1,
                    Size = Vector3.new(17, 17, 17) * i
                }
            });
            Wait(0.05);
        end;

        p42:Fire();

        for _, descendant in ipairs(u39:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == p41 .. "AuraParticle" then
                descendant.Enabled = true;
            end;
        end;
    end,

    SSJ4 = function(u54, p55, p56, p57) -- Line: 588
        -- upvalues: Thread (copy), Wait (copy), GetFloor (copy), Output (copy), Tween (copy), createEffect (copy)
        if u54:FindFirstChild("HumanoidRootPart") == nil or u54:FindFirstChildOfClass("Humanoid") == nil then
            return;
        end;

        local HumanoidRootPart = u54:FindFirstChild("HumanoidRootPart");
        u54:FindFirstChildOfClass("Humanoid");
        HumanoidRootPart.MUITheme:Stop();
        HumanoidRootPart.UITheme:Stop();
        Thread(function() -- Line: 594
            -- upvalues: Wait (ref), GetFloor (ref), u54 (copy), HumanoidRootPart (copy), Output (ref)
            Wait(0.5);
            local v58 = GetFloor(u54, HumanoidRootPart);
            local v59 = 0;

            while true do
                Wait(0.1);
                v59 = v59 + 1;
                Output:FireAllClients("FX", "Goku Create", "Circle", {
                    Transparency = 0,
                    Size = Vector3.new(1, 1, 0.065),
                    Time = 0.46,
                    CFrame = u54.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0) * CFrame.Angles(1.5707963267948966, 0, 0),
                    Color = Color3.fromRGB(255, 255, 255),
                    Style = Enum.EasingStyle.Cubic,
                    Direction = Enum.EasingDirection.Out,
                    PartProperties = {
                        Size = Vector3.new(15, 15, 0.2),
                        Transparency = 1
                    },
                    MeshProperties = {
                        Scale = Vector3.new(15, 15, 0.2)
                    }
                });

                if v58 ~= nil and v58:IsA("BasePart") then
                    local v60 = u54.HumanoidRootPart.CFrame * CFrame.new(math.random(-50, 50) / 10, math.random(-35, 0) / 10, math.random(-50, 50) / 10);
                    Output:FireAllClients("FX", "Goku Create", "Cube", {
                        Transparency = 0,
                        Time = 1,
                        CFrame = v60,
                        Color = v58.Color,
                        Size = Vector3.new(1, 1, 1) * math.random(3, 10) / 10,
                        Material = v58.Material,
                        Style = Enum.EasingStyle.Sine,
                        Direction = Enum.EasingDirection.Out,
                        Properties = {
                            Transparency = 1,
                            CFrame = v60 * CFrame.new(0, 5, 0)
                        }
                    });
                end;

                if v59 > 8 then
                    return;
                end;
            end;
        end);
        HumanoidRootPart.SSJ4Act:Play();
        Output:FireAllClients("FX", "Goku Create", "Sphere", {
            Transparency = 1,
            Size = Vector3.new(30, 30, 30),
            Time = 1.5,
            TweenAgain = true,
            Time2 = 1,
            TimeBetween = 0,
            CFrame = u54.HumanoidRootPart.CFrame,
            Color = Color3.fromRGB(255, 226, 0),
            Material = Enum.Material.Neon,
            Style = Enum.EasingStyle.Sine,
            Direction = Enum.EasingDirection.Out,
            Properties = {
                Size = Vector3.new(6, 6, 6),
                Transparency = 0
            },
            Properties2 = {
                Transparency = 1
            }
        });
        Wait(0.9);
        u54.SSJ4Hair.Color = Color3.fromRGB(17, 17, 17);
        Tween(u54.SSJ3Hair, 0.69, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 1,
            Color = Color3.fromRGB(17, 17, 17)
        });
        Tween(u54.SSJ4Hair, 0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 0
        });
        Tween(u54.FakeHead.SSJ3Face, 0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 1
        });
        Tween(u54.FakeHead.SSJ4Face, 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 0
        });
        Wait(0.5);
        HumanoidRootPart.TransformationBass:Play();
        createEffect("TransformShake", {}, game:GetService("Players"):GetPlayerFromCharacter(u54));
        createEffect("Transform", {
            Time = 0.4,
            Color = Color3.fromRGB(255, 102, 0)
        }, game:GetService("Players"):GetPlayerFromCharacter(u54));

        for _ = 1, math.random(16, 20) do
            local CFrame2 = u54.HumanoidRootPart.CFrame;
            local Angles = CFrame.Angles;
            local v61 = math.random(-360, 360);
            local v62 = math.rad(v61);
            local v63 = math.random(-360, 360);
            local v64 = math.rad(v63);
            local v65 = math.random(-360, 360);
            local v66 = CFrame2 * Angles(v62, v64, (math.rad(v65))) * CFrame.new(0, 0, math.random(12, 38));
            local _ = math.random(1, 2) == 1;
            Output:FireAllClients("FX", "Goku Create", "Sphere", {
                Transparency = 0,
                Size = Vector3.new(1, 1, 1),
                CFrame = u54.HumanoidRootPart.CFrame,
                Color = Color3.fromRGB(255, 81, 0),
                Time = math.random(5, 18) / 10,
                Material = Enum.Material.Neon,
                Style = Enum.EasingStyle.Quad,
                Direction = Enum.EasingDirection.InOut,
                Properties = {
                    Size = Vector3.new(0, 0, 4),
                    Transparency = 1,
                    CFrame = v66
                }
            });
        end;

        Wait(0.05);
        Output:FireAllClients("FX", "Goku Create", "Circle", {
            Transparency = 0,
            Size = Vector3.new(1, 1, 1),
            Time = 1.5,
            CFrame = u54.HumanoidRootPart.CFrame * CFrame.new(0, -1.5, 0) * CFrame.Angles(1.5707963267948966, 0, 0),
            Color = Color3.fromRGB(255, 255, 255),
            Style = Enum.EasingStyle.Cubic,
            Direction = Enum.EasingDirection.Out,
            PartProperties = {
                Size = Vector3.new(40, 40, 6),
                Transparency = 1
            },
            MeshProperties = {
                Scale = Vector3.new(40, 40, 6)
            }
        });

        for i = 1, 2 do
            Output:FireAllClients("FX", "Goku Create", "Sphere", {
                Transparency = 0,
                Size = Vector3.new(1, 1, 1),
                CFrame = u54.HumanoidRootPart.CFrame,
                Color = Color3.fromRGB(255, 81, 0),
                Time = 1.5 / i,
                Material = Enum.Material.Neon,
                Style = Enum.EasingStyle.Cubic,
                Direction = Enum.EasingDirection.Out,
                Properties = {
                    Transparency = 1,
                    Size = Vector3.new(17, 17, 17) * i
                }
            });
            Output:FireAllClients("FX", "Goku Create", "Sphere", {
                Transparency = 0,
                Size = Vector3.new(1, 1, 1),
                CFrame = u54.HumanoidRootPart.CFrame,
                Color = Color3.fromRGB(247, 255, 189),
                Time = i * 1.5,
                Material = Enum.Material.Neon,
                Style = Enum.EasingStyle.Cubic,
                Direction = Enum.EasingDirection.Out,
                Properties = {
                    Transparency = 1,
                    Size = Vector3.new(17, 17, 17) / i
                }
            });
            Wait(0.05);
        end;

        p57:Fire();

        for _, descendant in ipairs(u54:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == p56 .. "AuraParticle" then
                descendant.Enabled = true;
            end;
        end;
    end,

    SSJG = function(u67, p68, p69, p70) -- Line: 762
        -- upvalues: Tween (copy), Thread (copy), Wait (copy), GetFloor (copy), Output (copy), createEffect (copy)
        if u67:FindFirstChild("HumanoidRootPart") == nil or u67:FindFirstChildOfClass("Humanoid") == nil then
            return;
        end;

        local HumanoidRootPart = u67:FindFirstChild("HumanoidRootPart");
        u67:FindFirstChildOfClass("Humanoid");
        HumanoidRootPart.MUITheme:Stop();
        HumanoidRootPart.UITheme:Stop();
        HumanoidRootPart.SSJ4Theme:Stop();
        u67.BaseHair.Transparency = 1;
        u67.SSJGHair.Transparency = 0;
        Tween(u67.SSJ4Hair, 0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 1
        });
        Tween(u67.FakeHead.SSJ4Face, 0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 1
        });
        HumanoidRootPart.SSJGTransformation:Play();
        Thread(function() -- Line: 780
            -- upvalues: Wait (ref), GetFloor (ref), u67 (copy), HumanoidRootPart (copy), Output (ref)
            Wait(0.1);
            GetFloor(u67, HumanoidRootPart);
            local v71 = 0;

            repeat
                Wait(0.1);
                v71 = v71 + 1;
                Output:FireAllClients("FX", "Goku Create", "Wave", {
                    WaveType = 6,
                    Transparency = 0,
                    StartSize = Vector3.new(5, 1, 5),
                    Time = 0.25,
                    CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0) * CFrame.Angles(0, math.rad(v71 * 10), 0),
                    Color = Color3.fromRGB(255, 64, 6),
                    Style = Enum.EasingStyle.Sine,
                    Direction = Enum.EasingDirection.InOut,
                    Properties = {
                        Size = Vector3.new(7, 2, 7),
                        Transparency = 1
                    }
                });
                local CFrame2 = u67.HumanoidRootPart.CFrame;
                local Angles = CFrame.Angles;
                local v72 = math.random(-360, 360);
                local v73 = math.rad(v72);
                local v74 = math.random(-360, 360);
                local v75 = math.rad(v74);
                local v76 = math.random(-360, 360);
                local v77 = CFrame2 * Angles(v73, v75, (math.rad(v76))) * CFrame.new(0, 0, math.random(16, 20));
                local v78 = math.random(8, 18) / 10;
                Output:FireAllClients("FX", "Goku Create", "Sphere", {
                    Transparency = 0,
                    Size = Vector3.new(0, 0, 0),
                    CFrame = u67.HumanoidRootPart.CFrame,
                    Color = Color3.fromRGB(255, 64, 6),
                    Time = math.random(9, 18) / 10,
                    Material = Enum.Material.Neon,
                    Style = Enum.EasingStyle.Quad,
                    Direction = Enum.EasingDirection.InOut,
                    Properties = {
                        Transparency = 1,
                        Size = Vector3.new(v78, v78, v78),
                        CFrame = v77
                    }
                });
            until v71 > 20;
        end);
        Output:FireAllClients("FX", "Goku Create", "Glow", {
            MoveTime = 1.6,
            PartTime = 1.2,
            Character = u67,
            Color = Color3.fromRGB(255, 64, 6),
            Style = Enum.EasingStyle.Sine,
            Direction = Enum.EasingDirection.InOut,
            PartProperties = {
                Transparency = 1
            }
        });
        Wait(1.7);
        Tween(u67.FakeHead.SSJGFace, 0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 0
        });

        for i = 1, 2 do
            Output:FireAllClients("FX", "Goku Create", "Sphere", {
                Transparency = 0,
                Size = Vector3.new(1, 1, 1),
                CFrame = u67.HumanoidRootPart.CFrame,
                Color = Color3.fromRGB(255, 64, 6),
                Time = 1.5 / i,
                Material = Enum.Material.Neon,
                Style = Enum.EasingStyle.Cubic,
                Direction = Enum.EasingDirection.Out,
                Properties = {
                    Transparency = 1,
                    Size = Vector3.new(17, 17, 17) * i
                }
            });
            Wait(0.05);
        end;

        HumanoidRootPart.TransformationBass:Play();
        createEffect("TransformShake", {}, game:GetService("Players"):GetPlayerFromCharacter(u67));
        Output:FireAllClients("FX", "Goku Create", "Circle", {
            Transparency = 0,
            Size = Vector3.new(1, 1, 1),
            Time = 1.5,
            CFrame = u67.HumanoidRootPart.CFrame * CFrame.new(0, -1.5, 0) * CFrame.Angles(1.5707963267948966, 0, 0),
            Color = Color3.fromRGB(255, 255, 255),
            Style = Enum.EasingStyle.Cubic,
            Direction = Enum.EasingDirection.Out,
            PartProperties = {
                Size = Vector3.new(40, 40, 6),
                Transparency = 1
            },
            MeshProperties = {
                Scale = Vector3.new(40, 40, 6)
            }
        });

        for _ = 1, math.random(15, 20) do
            local CFrame2 = u67.HumanoidRootPart.CFrame;
            local Angles = CFrame.Angles;
            local v79 = math.random(-360, 360);
            local v80 = math.rad(v79);
            local v81 = math.random(-360, 360);
            local v82 = math.rad(v81);
            local v83 = math.random(-360, 360);
            local v84 = CFrame2 * Angles(v80, v82, (math.rad(v83))) * CFrame.new(0, 0, math.random(12, 22));
            local v85 = math.random(1, 2) == 1;
            Output:FireAllClients("FX", "Goku Create", "Sphere", {
                Transparency = 0,
                Size = Vector3.new(1, 1, 1),
                CFrame = u67.HumanoidRootPart.CFrame,
                Color = v85 == true and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 133, 133),
                Time = math.random(9, 18) / 10,
                Material = Enum.Material.Neon,
                Style = Enum.EasingStyle.Sine,
                Direction = Enum.EasingDirection.Out,
                Properties = {
                    Size = Vector3.new(0.2, 0.2, 7),
                    Transparency = 1,
                    CFrame = v84
                }
            });
        end;

        u67.FakeHead.Transparency = 0;
        p70:Fire();

        for _, descendant in ipairs(u67:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == p69 .. "AuraParticle" then
                descendant.Enabled = true;
            end;
        end;
    end,

    SSJB = function(u86, p87, p88, p89) -- Line: 910
        -- upvalues: Tween (copy), Thread (copy), Wait (copy), GetFloor (copy), Output (copy), createEffect (copy)
        if u86:FindFirstChild("HumanoidRootPart") == nil or u86:FindFirstChildOfClass("Humanoid") == nil then
            return;
        end;

        local HumanoidRootPart = u86:FindFirstChild("HumanoidRootPart");
        u86:FindFirstChildOfClass("Humanoid");
        HumanoidRootPart.MUITheme:Stop();
        HumanoidRootPart.UITheme:Stop();
        HumanoidRootPart.SSJGTheme:Stop();
        u86.SSJGHair.Transparency = 1;
        u86.SSJBHair.Transparency = 0;
        u86.SSJBHair.Color = Color3.fromRGB(13, 143, 248);
        Tween(u86.FakeHead.SSJGFace, 0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 1
        });
        Tween(u86.FakeHead.SSJBFace, 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 0
        });
        HumanoidRootPart.SSJBOrbs:Play();
        Thread(function() -- Line: 927
            -- upvalues: Wait (ref), GetFloor (ref), u86 (copy), HumanoidRootPart (copy), Output (ref)
            Wait(0.1);
            GetFloor(u86, HumanoidRootPart);
            local v90 = 0;

            repeat
                Wait(0.1);
                v90 = v90 + 1;
                local v91 = math.random(12, 17);
                Output:FireAllClients("FX", "Goku Create", "Wave", {
                    WaveType = 6,
                    Transparency = 0,
                    StartSize = Vector3.new(1, 0, 1),
                    CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0) * CFrame.Angles(0, math.rad(v90 * 10), 0),
                    Color = Color3.fromRGB(80, 217, 255),
                    Time = math.random(3, 6) / 10,
                    Style = Enum.EasingStyle.Sine,
                    Direction = Enum.EasingDirection.InOut,
                    Properties = {
                        Transparency = 1,
                        Size = Vector3.new(v91, 2 + v91 / 10, v91)
                    }
                });
                local CFrame2 = u86.HumanoidRootPart.CFrame;
                local Angles = CFrame.Angles;
                local v92 = math.random(-360, 360);
                local v93 = math.rad(v92);
                local v94 = math.random(-360, 360);
                local v95 = math.rad(v94);
                local v96 = math.random(-360, 360);
                local v97 = CFrame2 * Angles(v93, v95, (math.rad(v96))) * CFrame.new(0, 0, math.random(16, 20));
                local v98 = math.random(8, 18) / 10;
                Output:FireAllClients("FX", "Goku Create", "Sphere", {
                    Transparency = 0,
                    Size = Vector3.new(0, 0, 0),
                    CFrame = u86.HumanoidRootPart.CFrame,
                    Color = Color3.fromRGB(101, 189, 255),
                    Time = math.random(9, 18) / 10,
                    Material = Enum.Material.Neon,
                    Style = Enum.EasingStyle.Quad,
                    Direction = Enum.EasingDirection.InOut,
                    Properties = {
                        Transparency = 1,
                        Size = Vector3.new(v98, v98, v98),
                        CFrame = v97
                    }
                });
            until v90 > 20;
        end);
        Thread(function() -- Line: 970
            -- upvalues: Wait (ref), GetFloor (ref), u86 (copy), HumanoidRootPart (copy), Output (ref)
            Wait(0.1);
            local v99 = 0;

            while true do
                local v100 = GetFloor(u86, HumanoidRootPart);

                if v100 ~= nil and v100:IsA("BasePart") then
                    local v101 = u86.HumanoidRootPart.CFrame * CFrame.new(math.random(-15, 15), math.random(-10, 0), math.random(-15, 15));
                    Output:FireAllClients("FX", "Goku Create", "Cube", {
                        Transparency = 0,
                        Time = 1,
                        CFrame = v101,
                        Color = v100.Color,
                        Size = Vector3.new(1, 1, 1) * math.random(3, 10) / 10,
                        Material = v100.Material,
                        Style = Enum.EasingStyle.Sine,
                        Direction = Enum.EasingDirection.Out,
                        Properties = {
                            Transparency = 1,
                            CFrame = v101 * CFrame.new(0, 5, 0)
                        }
                    });
                end;

                Wait(0.035);
                v99 = v99 + 1;

                if v99 > 60 then
                    return;
                end;
            end;
        end);
        Output:FireAllClients("FX", "Goku Create", "Glow", {
            MoveTime = 1.6,
            PartTime = 1.2,
            Character = u86,
            Color = Color3.fromRGB(60, 161, 255),
            Style = Enum.EasingStyle.Sine,
            Direction = Enum.EasingDirection.InOut,
            PartProperties = {
                Transparency = 1
            }
        });
        Wait(1.7);
        HumanoidRootPart.SSJBTransformation:Play();

        for i = 1, 2 do
            Output:FireAllClients("FX", "Goku Create", "Sphere", {
                Transparency = 0,
                Size = Vector3.new(1, 1, 1),
                CFrame = u86.HumanoidRootPart.CFrame,
                Color = Color3.fromRGB(2, 200, 255),
                Time = 1.5 / i,
                Material = Enum.Material.Neon,
                Style = Enum.EasingStyle.Cubic,
                Direction = Enum.EasingDirection.Out,
                Properties = {
                    Transparency = 1,
                    Size = Vector3.new(17, 17, 17) * i
                }
            });
            Wait(0.05);
        end;

        HumanoidRootPart.TransformationBass:Play();
        createEffect("TransformShake", {}, game:GetService("Players"):GetPlayerFromCharacter(u86));
        Output:FireAllClients("FX", "Goku Create", "Circle", {
            Transparency = 0,
            Size = Vector3.new(1, 1, 1),
            Time = 1.5,
            CFrame = u86.HumanoidRootPart.CFrame * CFrame.new(0, -1.5, 0) * CFrame.Angles(1.5707963267948966, 0, 0),
            Color = Color3.fromRGB(255, 255, 255),
            Style = Enum.EasingStyle.Cubic,
            Direction = Enum.EasingDirection.Out,
            PartProperties = {
                Size = Vector3.new(40, 40, 6),
                Transparency = 1
            },
            MeshProperties = {
                Scale = Vector3.new(40, 40, 6)
            }
        });

        for _ = 1, math.random(15, 20) do
            local CFrame2 = u86.HumanoidRootPart.CFrame;
            local Angles = CFrame.Angles;
            local v102 = math.random(-360, 360);
            local v103 = math.rad(v102);
            local v104 = math.random(-360, 360);
            local v105 = math.rad(v104);
            local v106 = math.random(-360, 360);
            local v107 = CFrame2 * Angles(v103, v105, (math.rad(v106))) * CFrame.new(0, 0, math.random(12, 22));
            local v108 = math.random(1, 2) == 1;
            Output:FireAllClients("FX", "Goku Create", "Sphere", {
                Transparency = 0,
                Size = Vector3.new(1, 1, 1),
                CFrame = u86.HumanoidRootPart.CFrame,
                Color = v108 == true and Color3.fromRGB(2, 200, 255) or Color3.fromRGB(120, 167, 255),
                Time = math.random(9, 18) / 10,
                Material = Enum.Material.Neon,
                Style = Enum.EasingStyle.Sine,
                Direction = Enum.EasingDirection.Out,
                Properties = {
                    Size = Vector3.new(0.2, 0.2, 7),
                    Transparency = 1,
                    CFrame = v107
                }
            });
        end;

        u86.FakeHead.Transparency = 0;
        Wait(0.3);
        p89:Fire();

        for _, descendant in ipairs(u86:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == p88 .. "AuraParticle" then
                descendant.Enabled = true;
            end;
        end;
    end,

    SSJBK = function(u109, p110, p111, p112) -- Line: 1086
        -- upvalues: Wait (copy), Thread (copy), GetFloor (copy), Output (copy), createEffect (copy)
        if u109:FindFirstChild("HumanoidRootPart") == nil or u109:FindFirstChildOfClass("Humanoid") == nil then
            return;
        end;

        local HumanoidRootPart = u109:FindFirstChild("HumanoidRootPart");
        u109:FindFirstChildOfClass("Humanoid");
        HumanoidRootPart.MUITheme:Stop();
        HumanoidRootPart.UITheme:Stop();
        HumanoidRootPart.SSJBTheme:Stop();
        local v113 = next;
        local v114, v115 = HumanoidRootPart:GetChildren();

        for _, v in v113, v114, v115 do
            if v:IsA("Sound") and v.Name:find("Aura") then
                v:Stop();
            end;
        end;

        Wait(0.1);
        HumanoidRootPart.SSJBKVoiceline:Play();
        Thread(function() -- Line: 1100
            -- upvalues: Wait (ref), GetFloor (ref), u109 (copy), HumanoidRootPart (copy), Output (ref)
            Wait(0.1);
            local v116 = 0;

            while true do
                local v117, _ = GetFloor(u109, HumanoidRootPart);

                if v117 ~= nil and v117:IsA("BasePart") then
                    local v118 = u109.HumanoidRootPart.CFrame * CFrame.new(math.random(-18, 18), math.random(-10, 0), math.random(-18, 18));
                    Output:FireAllClients("FX", "Goku Create", "Circle", {
                        Transparency = 0,
                        Size = Vector3.new(15, 15, 0.065),
                        Time = 0.46,
                        CFrame = u109.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0) * CFrame.Angles(1.5707963267948966, 0, 0),
                        Color = Color3.fromRGB(255, 255, 255),
                        Style = Enum.EasingStyle.Cubic,
                        Direction = Enum.EasingDirection.Out,
                        PartProperties = {
                            Size = Vector3.new(0, 0, 0.2),
                            Transparency = 1
                        },
                        MeshProperties = {
                            Scale = Vector3.new(18, 18, 0.2)
                        }
                    });
                    Output:FireAllClients("FX", "Goku Create", "Cube", {
                        Transparency = 0,
                        CFrame = v118,
                        Color = v117.Color,
                        Size = Vector3.new(1, 1, 1) * math.random(3, 10) / 10,
                        Time = math.random(8, 15) / 10,
                        Material = v117.Material,
                        Style = Enum.EasingStyle.Sine,
                        Direction = Enum.EasingDirection.Out,
                        Properties = {
                            Transparency = 1,
                            CFrame = v118 * CFrame.new(0, math.random(40, 70) / 10, 0)
                        }
                    });
                end;

                Wait(0.3);
                v116 = v116 + 1;

                if v116 > 5 then
                    return;
                end;
            end;
        end);
        Wait(0.95);
        HumanoidRootPart.thek:Play();
        HumanoidRootPart.TransformationBass:Play();
        createEffect("TransformShake", {}, game:GetService("Players"):GetPlayerFromCharacter(u109));
        Output:FireAllClients("FX", "Goku Create", "Circle", {
            Transparency = 0,
            Size = Vector3.new(1, 1, 1),
            Time = 1.5,
            CFrame = u109.HumanoidRootPart.CFrame * CFrame.new(0, -1.5, 0) * CFrame.Angles(1.5707963267948966, 0, 0),
            Color = Color3.fromRGB(255, 255, 255),
            Style = Enum.EasingStyle.Cubic,
            Direction = Enum.EasingDirection.Out,
            PartProperties = {
                Size = Vector3.new(60, 60, 6),
                Transparency = 1
            },
            MeshProperties = {
                Scale = Vector3.new(60, 60, 6)
            }
        });

        for i = 1, 3 do
            Output:FireAllClients("FX", "Goku Create", "Sphere", {
                Transparency = 0,
                Size = Vector3.new(0, 0, 0),
                CFrame = u109.HumanoidRootPart.CFrame,
                Color = (i == 1 or i == 3) and Color3.fromRGB(255, 34, 45) or Color3.fromRGB(88, 113, 255),
                Time = i / 3 + 0.4,
                Material = Enum.Material.Neon,
                Style = Enum.EasingStyle.Quad,
                Direction = Enum.EasingDirection.InOut,
                Properties = {
                    Transparency = 1,
                    Size = Vector3.new(i * 8 + 35, i * 8 + 35, i * 8 + 35)
                }
            });
        end;

        for _ = 1, math.random(15, 20) do
            local CFrame2 = u109.HumanoidRootPart.CFrame;
            local Angles = CFrame.Angles;
            local v119 = math.random(-360, 360);
            local v120 = math.rad(v119);
            local v121 = math.random(-360, 360);
            local v122 = math.rad(v121);
            local v123 = math.random(-360, 360);
            local v124 = CFrame2 * Angles(v120, v122, (math.rad(v123))) * CFrame.new(0, 0, math.random(12, 22));
            local v125 = math.random(1, 2) == 1;
            Output:FireAllClients("FX", "Goku Create", "Sphere", {
                Transparency = 0,
                Size = Vector3.new(1, 1, 1),
                CFrame = u109.HumanoidRootPart.CFrame,
                Color = v125 == true and Color3.fromRGB(255, 34, 45) or Color3.fromRGB(88, 113, 255),
                Time = math.random(9, 18) / 10,
                Material = Enum.Material.Neon,
                Style = Enum.EasingStyle.Sine,
                Direction = Enum.EasingDirection.Out,
                Properties = {
                    Size = Vector3.new(0.2, 0.2, 7),
                    Transparency = 1,
                    CFrame = v124
                }
            });
        end;

        u109.FakeHead.Transparency = 0;
        p112:Fire();

        for _, descendant in ipairs(u109:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == p111 .. "AuraParticle" then
                descendant.Enabled = true;
            end;
        end;
    end,

    UI = function(u126, p127, p128, p129) -- Line: 1212
        -- upvalues: Wait (copy), Tween (copy), Models (copy), Glue (copy), Thread (copy), Output (copy), GetFloor (copy), createEffect (copy)
        if u126:FindFirstChild("HumanoidRootPart") == nil or u126:FindFirstChildOfClass("Humanoid") == nil then
            return;
        end;

        local HumanoidRootPart = u126:FindFirstChild("HumanoidRootPart");
        local v130 = u126:FindFirstChildOfClass("Humanoid");
        u126.UIHair.Color = Color3.fromRGB(17, 17, 17);
        HumanoidRootPart.SSJBKTheme:Stop();
        HumanoidRootPart.MUITheme:Stop();
        Wait(1);
        HumanoidRootPart.UIAct:Play();
        HumanoidRootPart.UITheme:Play();
        Tween(u126.SSJBHair, 2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, {
            Color = u126.UIHair.Color
        });
        Tween(u126.FakeHead.SSJBFace, 0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 1
        });
        Tween(u126.FakeHead.UITransformFace, 0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 0
        });
        local _ = v130.Health;
        local Folder = Instance.new("Folder");
        Folder.Name = u126.Name .. "UI";
        local v131 = next;
        local v132, v133 = u126:GetChildren();

        for _, v in v131, v132, v133 do
            if v:IsA("BasePart") and (string.match(v.Name, "Leg") or (string.match(v.Name, "Arm") or (v.Name == "Head" or v.Name == "Torso"))) then
                local v134 = v:Clone();

                for _, child in ipairs(v134:GetChildren()) do
                    if not (child:IsA("SpecialMesh") or child:IsA("BlockMesh")) then
                        if not child:IsA("FileMesh") then
                            child:Destroy();
                        end;
                    end;
                end;

                v134.Size = v134.Size;
                v134.Color = Color3.fromRGB(171, 182, 255);
                v134.CanCollide = false;
                v134.Massless = true;
                v134.Transparency = 1;
                v134.Material = Enum.Material.Neon;
                v134.Name = "Glow";
                v134.Parent = Folder;

                if string.match(v.Name, "Leg") or string.match(v.Name, "Arm") then
                    Models.Invert.Limbs.Mesh:Clone().Parent = v134;
                elseif v.Name == "Head" then
                    Models.Invert.Head.Mesh:Clone().Parent = v134;
                elseif v.Name == "Torso" then
                    Models.Invert.Torso.Mesh:Clone().Parent = v134;
                end;

                Glue(v134, v);
                Tween(v134, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, {
                    Transparency = 0
                });
            end;
        end;

        Folder.Parent = workspace;
        local v135 = next;
        local v136, v137 = u126.FakeHead:GetChildren();

        for _, v in v135, v136, v137 do
            if v:IsA("Decal") and v.Name:find("Face") then
                v.Color3 = Color3.new();
            end;
        end;

        u126.FakeHead.UIFace.Color3 = Color3.new(1, 1, 1);
        u126.FakeHead.UITransformFace.Color3 = Color3.new(1, 1, 1);
        local Model = Instance.new("Model");
        Thread(function() -- Line: 1276
            -- upvalues: Wait (ref), Tween (ref), u126 (copy), Model (copy)
            for i = 1, 16 do
                Wait(0.03);
                local Part = Instance.new("Part");
                Part.Material = "SmoothPlastic";
                Part.Transparency = 1;
                Tween(Part, 0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
                    Transparency = (i - 1) / 16.2 + 0
                });
                Part.Color = Color3.new();
                Part.Name = "faceShade";
                Part.Size = Vector3.new(1.01, 0.5, 1.01);
                Part.Anchored = false;
                Part.CanCollide = false;
                Part.Massless = true;
                Part.CastShadow = false;
                u126.FakeHead:FindFirstChildOfClass("SpecialMesh"):Clone().Parent = Part;
                Part.Parent = Model;
                local Weld = Instance.new("Weld");
                Weld.Parent = Part;
                Weld.Part0 = u126.FakeHead;
                Weld.Part1 = Part;
                Weld.C0 = CFrame.new(0, 0.35 - (i - 1) / 35, 0);
            end;
        end);
        Model.Parent = u126.FakeHead;

        for _ = 1, math.random(6, 10) do
            local v138 = u126.HumanoidRootPart.CFrame * CFrame.new(math.random(-12, 12), math.random(2, 5), math.random(-12, 12));
            Output:FireAllClients("FX", "Goku Create", "Sphere", {
                Transparency = 0,
                CFrame = v138,
                Color = Color3.fromRGB(255, 255, 255),
                Size = Vector3.new(1, 1, 1) * math.random(9, 14) / 10,
                Time = math.random(6, 10) / 10,
                Material = Enum.Material.Neon,
                Style = Enum.EasingStyle.Quad,
                Direction = Enum.EasingDirection.InOut,
                Properties = {
                    Transparency = 1,
                    Size = Vector3.new(2, 2, 2) * math.random(8, 12) / 10,
                    CFrame = v138 * CFrame.new(0, 1.5, 0)
                }
            });
        end;

        Thread(function() -- Line: 1322
            -- upvalues: GetFloor (ref), u126 (copy), HumanoidRootPart (copy), Wait (ref), Output (ref)
            local v139 = GetFloor(u126, HumanoidRootPart);

            for _ = 1, 50 do
                Wait(0.1);
                Output:FireAllClients("FX", "Goku Create", "Circle", {
                    Transparency = 0,
                    Size = Vector3.new(1, 1, 0.065),
                    Time = 0.46,
                    CFrame = u126.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0) * CFrame.Angles(1.5707963267948966, 0, 0),
                    Color = Color3.fromRGB(255, 255, 255),
                    Style = Enum.EasingStyle.Cubic,
                    Direction = Enum.EasingDirection.Out,
                    PartProperties = {
                        Size = Vector3.new(15, 15, 0.2),
                        Transparency = 1
                    },
                    MeshProperties = {
                        Scale = Vector3.new(15, 15, 0.2)
                    }
                });

                if v139 ~= nil and v139:IsA("BasePart") then
                    local v140 = u126.HumanoidRootPart.CFrame * CFrame.new(math.random(-20, 20), math.random(-10, 0), math.random(-20, 20));
                    Output:FireAllClients("FX", "Goku Create", "Cube", {
                        Transparency = 0,
                        CFrame = v140,
                        Color = v139.Color,
                        Size = Vector3.new(1, 1, 1) * math.random(3, 10) / 10,
                        Time = math.random(8, 15) / 10,
                        Material = v139.Material,
                        Style = Enum.EasingStyle.Sine,
                        Direction = Enum.EasingDirection.Out,
                        Properties = {
                            Transparency = 1,
                            CFrame = v140 * CFrame.new(0, math.random(40, 70) / 10, 0)
                        }
                    });
                    Output:FireAllClients("FX", "Goku Create", "Sphere", {
                        Transparency = 0,
                        Size = Vector3.new(0.5, 1, 0.5),
                        CFrame = v140 * CFrame.new(0, -10, 0),
                        Color = Color3.fromRGB(255, 255, 255),
                        Time = math.random(15, 35) / 10,
                        Material = Enum.Material.Neon,
                        Style = Enum.EasingStyle.Quad,
                        Direction = Enum.EasingDirection.InOut,
                        Properties = {
                            Size = Vector3.new(0, 2.5, 0),
                            Transparency = 1,
                            CFrame = v140 * CFrame.new(0, math.random(40, 70) / 3.5, 0)
                        }
                    });
                end;
            end;
        end);
        Wait(2);

        for _, child in ipairs(u126.FakeHead:GetChildren()) do
            if child:IsA("Decal") and child.Name == "ShadingFace" then
                Thread(function() -- Line: 1381
                    -- upvalues: Tween (ref), child (copy)
                    Tween(child, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
                        Transparency = 1
                    });
                end);
            end;
        end;

        Tween(u126.FakeHead.UIFace, 0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 0
        });
        Tween(u126.FakeHead.UITransformFace, 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 1
        });
        Output:FireAllClients("FX", "Goku Create", "Sphere", {
            Transparency = 0.3,
            Size = Vector3.new(0, 0, 0),
            Time = 3.5,
            CFrame = u126.HumanoidRootPart.CFrame,
            Color = Color3.fromRGB(255, 255, 255),
            Material = Enum.Material.Neon,
            Style = Enum.EasingStyle.Quad,
            Direction = Enum.EasingDirection.InOut,
            Properties = {
                Size = Vector3.new(110, 100, 110),
                Transparency = 1
            }
        });
        Output:FireAllClients("FX", "Goku Create", "Sphere", {
            Transparency = 0,
            Size = Vector3.new(0, 0, 0),
            Time = 4,
            CFrame = u126.HumanoidRootPart.CFrame,
            Color = Color3.fromRGB(255, 255, 255),
            Material = Enum.Material.Neon,
            Style = Enum.EasingStyle.Quad,
            Direction = Enum.EasingDirection.InOut,
            Properties = {
                Size = Vector3.new(100, 90, 100),
                Transparency = 1
            }
        });
        Wait(0.515);
        Tween(u126.SSJBHair, 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 1
        });
        Model:Destroy();
        local v141 = next;
        local v142, v143 = u126.FakeHead:GetChildren();

        for _, v in v141, v142, v143 do
            if v:IsA("Decal") and v.Name:find("Face") then
                v.Color3 = Color3.new(1, 1, 1);
            end;
        end;

        Tween(u126.UIHair, 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 0
        });
        Tween(u126.UIHair.UIOutline, 0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 0
        });

        for i = 1, 6 do
            Wait(0.05);
            local v144 = {
                WaveType = 6,
                Transparency = 0,
                StartSize = Vector3.new(1, 0, 1)
            };
            local v145 = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0);
            local Angles = CFrame.Angles;
            local v146 = math.random(-20, 20);
            v144.CFrame = v145 * Angles(0, math.rad(v146), 0);
            v144.Color = Color3.fromRGB(255, 255, 255);
            v144.Time = math.random(3, 6) / 10;
            v144.Style = Enum.EasingStyle.Sine;
            v144.Direction = Enum.EasingDirection.InOut;
            v144.Properties = {
                Transparency = 1,
                Size = Vector3.new(i / 3 * 60, i / 5 * 10, i / 3 * 60)
            };
            Output:FireAllClients("FX", "Goku Create", "Wave", v144);
        end;

        Output:FireAllClients("FX", "Goku Create", "Sphere", {
            Transparency = 0,
            Size = Vector3.new(20, 250, 20),
            Time = 4,
            CFrame = u126.HumanoidRootPart.CFrame,
            Color = Color3.fromRGB(255, 255, 255),
            Material = Enum.Material.Neon,
            Style = Enum.EasingStyle.Quad,
            Direction = Enum.EasingDirection.InOut,
            Properties = {
                Size = Vector3.new(1, 250, 1),
                Transparency = 1
            }
        });
        u126.FakeHead.Transparency = 0;
        HumanoidRootPart.UIShow:Play();
        HumanoidRootPart.UITransformation:Play();
        HumanoidRootPart.TransformationBass:Play();
        createEffect("TransformShake", {}, game:GetService("Players"):GetPlayerFromCharacter(u126));
        createEffect("Transform", {
            Time = 0.4,
            Color = Color3.fromRGB(255, 255, 255)
        }, game:GetService("Players"):GetPlayerFromCharacter(u126));
        p129:Fire();

        for _, descendant in ipairs(u126:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == p128 .. "AuraParticle" then
                descendant.Enabled = true;
            end;
        end;
    end,

    MUI = function(u147, p148, p149, p150) -- Line: 1490
        -- upvalues: Effects (copy), Tween (copy), Wait (copy), Models (copy), Glue (copy), Output (copy), Thread (copy), GetFloor (copy), createEffect (copy)
        if u147:FindFirstChild("HumanoidRootPart") == nil or u147:FindFirstChildOfClass("Humanoid") == nil then
            return;
        end;

        local HumanoidRootPart = u147:FindFirstChild("HumanoidRootPart");
        u147:FindFirstChildOfClass("Humanoid");
        HumanoidRootPart.UITheme:Stop();
        local v151 = Effects.GlO:Clone();
        v151.Parent = u147.Effects;
        v151:SetPrimaryPartCFrame(HumanoidRootPart.CFrame * CFrame.new(0, -3, 0));
        local v152 = next;
        local v153, v154 = v151:GetDescendants();

        for _, v in v152, v153, v154 do
            if v:IsA("Beam") then
                Tween(v, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
                    Width0 = 2,
                    Width1 = 2
                });
            end;
        end;

        Wait(1);

        if not HumanoidRootPart.UITheme.IsPlaying then
            HumanoidRootPart.UITheme:Play();
        end;

        local v155 = next;
        local v156, v157 = u147.FakeHead:GetChildren();

        for _, v in v155, v156, v157 do
            if v:IsA("Decal") and v.Name:find("Face") then
                v.Color3 = Color3.new();
            end;
        end;

        local Folder = Instance.new("Folder");
        Folder.Name = u147.Name .. "MUI";
        local v158 = next;
        local v159, v160 = u147:GetChildren();

        for _, v in v158, v159, v160 do
            if v:IsA("BasePart") and (string.match(v.Name, "Leg") or (string.match(v.Name, "Arm") or (v.Name == "Head" or v.Name == "Torso"))) then
                local v161 = v:Clone();

                for _, child in ipairs(v161:GetChildren()) do
                    if not (child:IsA("SpecialMesh") or child:IsA("BlockMesh")) then
                        if not child:IsA("FileMesh") then
                            child:Destroy();
                        end;
                    end;
                end;

                v161.Size = v161.Size;
                v161.Color = Color3.fromRGB(171, 182, 255);
                v161.CanCollide = false;
                v161.Massless = true;
                v161.Transparency = 1;
                v161.Material = Enum.Material.Neon;
                v161.Name = "Glow";
                v161.Parent = Folder;

                if string.match(v.Name, "Leg") or string.match(v.Name, "Arm") then
                    local v162 = Models.Invert.Limbs.Mesh:Clone();
                    v162.VertexColor = Vector3.new(1000, 1000, 1000);
                    v162.Parent = v161;
                elseif v.Name == "Head" then
                    local v163 = Models.Invert.Head.Mesh:Clone();
                    v163.VertexColor = Vector3.new(1000, 1000, 1000);
                    v163.Parent = v161;
                elseif v.Name == "Torso" then
                    local v164 = Models.Invert.Torso.Mesh:Clone();
                    v164.VertexColor = Vector3.new(1000, 1000, 1000);
                    v164.Parent = v161;
                end;

                Glue(v161, v);
                Tween(v161, 0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, {
                    Transparency = 0
                });
            end;
        end;

        Folder.Parent = workspace;
        HumanoidRootPart.MUITransformation:Play();
        u147.FakeHead.UIFace.Color3 = Color3.new(1, 1, 1);
        u147.FakeHead.MUIFace.Color3 = Color3.new(1, 1, 1);
        Tween(u147.FakeHead.UIFace, 0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 1
        });
        Tween(u147.UIHair.UIOutline, 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Color = Color3.new(1, 1, 1)
        });
        Tween(u147.FakeHead.MUIFace, 0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 0
        });
        HumanoidRootPart.Rumble:Play();
        Output:FireAllClients("FX", "Goku Create", "Glow", {
            MoveTime = 1.4,
            PartTime = 3,
            Character = u147,
            Color = Color3.fromRGB(255, 255, 255),
            Style = Enum.EasingStyle.Quad,
            Direction = Enum.EasingDirection.InOut,
            PartProperties = {
                Transparency = 1
            }
        });
        Thread(function() -- Line: 1582
            -- upvalues: GetFloor (ref), u147 (copy), HumanoidRootPart (copy), Wait (ref), Output (ref)
            local v165 = GetFloor(u147, HumanoidRootPart);
            local v166 = 5;

            for _ = 1, 50 do
                Wait(0.1);
                v166 = v166 + 1;
                Output:FireAllClients("FX", "Goku Create", "Circle", {
                    Transparency = 0,
                    Size = Vector3.new(1, 1, 0.065),
                    Time = 0.46,
                    CFrame = u147.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0) * CFrame.Angles(1.5707963267948966, 0, 0),
                    Color = Color3.fromRGB(255, 255, 255),
                    Style = Enum.EasingStyle.Cubic,
                    Direction = Enum.EasingDirection.Out,
                    PartProperties = {
                        Size = Vector3.new(15, 15, 0.2),
                        Transparency = 1
                    },
                    MeshProperties = {
                        Scale = Vector3.new(15, 15, 0.2)
                    }
                });

                if v165 ~= nil and v165:IsA("BasePart") then
                    local v167 = u147.HumanoidRootPart.CFrame * CFrame.new(math.random(-v166, v166), math.random(-10, 0), math.random(-v166, v166));
                    Output:FireAllClients("FX", "Goku Create", "Cube", {
                        Transparency = 0,
                        CFrame = v167,
                        Color = v165.Color,
                        Size = Vector3.new(1, 1, 1) * math.random(6, 15) / 10,
                        Time = math.random(8, 15) / 10,
                        Material = v165.Material,
                        Style = Enum.EasingStyle.Sine,
                        Direction = Enum.EasingDirection.Out,
                        Properties = {
                            Transparency = 1,
                            CFrame = v167 * CFrame.new(0, math.random(40, 70) / 10, 0)
                        }
                    });
                    Output:FireAllClients("FX", "Goku Create", "Sphere", {
                        Transparency = 0,
                        Size = Vector3.new(1, 2, 1),
                        CFrame = v167 * CFrame.new(0, -10, 0),
                        Color = Color3.fromRGB(255, 255, 255),
                        Time = math.random(15, 35) / 10,
                        Material = Enum.Material.Neon,
                        Style = Enum.EasingStyle.Quad,
                        Direction = Enum.EasingDirection.InOut,
                        Properties = {
                            Size = Vector3.new(0, 4, 0),
                            Transparency = 1,
                            CFrame = v167 * CFrame.new(0, math.random(40, 70) / 3.5, 0)
                        }
                    });
                end;
            end;
        end);
        Thread(function() -- Line: 1639
            -- upvalues: GetFloor (ref), u147 (copy), HumanoidRootPart (copy), Wait (ref), Output (ref)
            GetFloor(u147, HumanoidRootPart);

            for _ = 1, 10 do
                Wait(0.1);
                Output:FireAllClients("FX", "Goku Create", "Sphere", {
                    Transparency = 1,
                    Size = Vector3.new(45, 45, 45),
                    Time = 1.5,
                    CFrame = u147.HumanoidRootPart.CFrame,
                    Color = Color3.fromRGB(255, 255, 255),
                    Material = Enum.Material.Neon,
                    Style = Enum.EasingStyle.Quad,
                    Direction = Enum.EasingDirection.InOut,
                    Properties = {
                        Size = Vector3.new(0, 0, 0),
                        Transparency = 0
                    }
                });
            end;
        end);
        Wait(1.2);
        pcall(function() -- Line: 1662
            -- upvalues: u147 (copy)
            workspace:FindFirstChild(u147.Name .. "UI"):Destroy();
        end);

        for i = 1, 4 do
            Output:FireAllClients("FX", "Goku Create", "Sphere", {
                Transparency = 0,
                Size = Vector3.new(0, 0, 0),
                CFrame = u147.HumanoidRootPart.CFrame,
                Color = Color3.fromRGB(255, 255, 255),
                Time = i / 3 + 1,
                Material = Enum.Material.Neon,
                Style = Enum.EasingStyle.Quad,
                Direction = Enum.EasingDirection.InOut,
                Properties = {
                    Transparency = 1,
                    Size = Vector3.new(i * 12 + 25, i * 12 + 25, i * 12 + 25)
                }
            });
        end;

        Wait(0.515);
        local v168 = next;
        local v169, v170 = v151:GetDescendants();

        for _, v in v168, v169, v170 do
            if v:IsA("Beam") then
                Tween(v, 0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
                    Width0 = 0,
                    Width1 = 0
                });
            end;
        end;

        game:GetService("Debris"):AddItem(v151, 0.91);
        Tween(u147.UIHair, 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Color = Color3.fromRGB(166, 166, 166)
        });

        for i = 1, 15 do
            Wait(0.05);
            Output:FireAllClients("FX", "Goku Create", "Wave", {
                WaveType = 6,
                Transparency = 0,
                StartSize = Vector3.new(1, 0, 1),
                CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0) * CFrame.Angles(0, math.rad(i * 24), 0),
                Color = Color3.fromRGB(255, 255, 255),
                Time = math.random(i + 3, i + 6) / 5,
                Style = Enum.EasingStyle.Sine,
                Direction = Enum.EasingDirection.InOut,
                Properties = {
                    Transparency = 1,
                    Size = Vector3.new(i / 3 * 60, i / 5 * 10, i / 3 * 60)
                }
            });
        end;

        Output:FireAllClients("FX", "Goku Create", "Sphere", {
            Transparency = 0,
            Size = Vector3.new(20, 250, 20),
            Time = 4,
            CFrame = u147.HumanoidRootPart.CFrame,
            Color = Color3.fromRGB(255, 255, 255),
            Material = Enum.Material.Neon,
            Style = Enum.EasingStyle.Quad,
            Direction = Enum.EasingDirection.InOut,
            Properties = {
                Size = Vector3.new(1, 250, 1),
                Transparency = 1
            }
        });
        Output:FireAllClients("FX", "Goku Create", "Sphere", {
            Transparency = 0,
            Size = Vector3.new(35, 500, 35),
            Time = 4,
            CFrame = u147.HumanoidRootPart.CFrame,
            Color = Color3.fromRGB(255, 255, 255),
            Material = Enum.Material.Neon,
            Style = Enum.EasingStyle.Quad,
            Direction = Enum.EasingDirection.InOut,
            Properties = {
                Size = Vector3.new(1, 250, 1),
                Transparency = 1
            }
        });
        u147.FakeHead.Transparency = 0;
        local v171 = next;
        local v172, v173 = u147.FakeHead:GetChildren();

        for _, v in v171, v172, v173 do
            if v:IsA("Decal") and v.Name:find("Face") then
                v.Color3 = Color3.new(1, 1, 1);
            end;
        end;

        HumanoidRootPart.MUIExplosion:Play();
        HumanoidRootPart.Rumble:Stop();
        HumanoidRootPart.TransformationBass:Play();
        createEffect("TransformShake", {}, game:GetService("Players"):GetPlayerFromCharacter(u147));
        createEffect("Transform", {
            Time = 0.4,
            Color = Color3.fromRGB(255, 255, 255)
        }, game:GetService("Players"):GetPlayerFromCharacter(u147));
        p150:Fire();

        for _, descendant in ipairs(u147:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == p149 .. "AuraParticle" then
                descendant.Enabled = true;
            end;
        end;
    end,

    Egg = function(u174, p175, p176, p177) -- Line: 1766
        -- upvalues: Thread (copy), GetFloor (copy), Wait (copy), Output (copy), Tween (copy), Models (copy), Glue (copy)
        if u174:FindFirstChild("HumanoidRootPart") == nil or u174:FindFirstChildOfClass("Humanoid") == nil then
            return;
        end;

        local HumanoidRootPart = u174:FindFirstChild("HumanoidRootPart");
        u174:FindFirstChildOfClass("Humanoid");
        local v178 = HumanoidRootPart:GetChildren();

        for i = 1, #v178 do
            if v178[i]:IsA("Sound") and string.find(v178[i].Name, "Theme") then
                v178[i]:Stop();
            end;
        end;

        HumanoidRootPart.UIAct:Play();
        Thread(function() -- Line: 1778
            -- upvalues: GetFloor (ref), u174 (copy), HumanoidRootPart (copy), Wait (ref), Output (ref)
            local v179 = GetFloor(u174, HumanoidRootPart);

            for _ = 1, 50 do
                Wait(0.1);
                Output:FireAllClients("FX", "Goku Create", "Circle", {
                    Transparency = 0,
                    Size = Vector3.new(1, 1, 0.065),
                    Time = 0.46,
                    CFrame = u174.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0) * CFrame.Angles(1.5707963267948966, 0, 0),
                    Color = Color3.fromRGB(255, 255, 255),
                    Style = Enum.EasingStyle.Cubic,
                    Direction = Enum.EasingDirection.Out,
                    PartProperties = {
                        Size = Vector3.new(15, 15, 0.2),
                        Transparency = 1
                    },
                    MeshProperties = {
                        Scale = Vector3.new(15, 15, 0.2)
                    }
                });

                if v179 ~= nil and v179:IsA("BasePart") then
                    local v180 = u174.HumanoidRootPart.CFrame * CFrame.new(math.random(-20, 20), math.random(-10, 0), math.random(-20, 20));
                    Output:FireAllClients("FX", "Goku Create", "Cube", {
                        Transparency = 0,
                        CFrame = v180,
                        Color = v179.Color,
                        Size = Vector3.new(1, 1, 1) * math.random(3, 10) / 10,
                        Time = math.random(8, 15) / 10,
                        Material = v179.Material,
                        Style = Enum.EasingStyle.Sine,
                        Direction = Enum.EasingDirection.Out,
                        Properties = {
                            Transparency = 1,
                            CFrame = v180 * CFrame.new(0, math.random(40, 70) / 10, 0)
                        }
                    });
                    Output:FireAllClients("FX", "Goku Create", "Sphere", {
                        Transparency = 0,
                        Size = Vector3.new(0.5, 1, 0.5),
                        CFrame = v180 * CFrame.new(0, -10, 0),
                        Color = Color3.fromRGB(255, 255, 255),
                        Time = math.random(15, 35) / 10,
                        Material = Enum.Material.Neon,
                        Style = Enum.EasingStyle.Quad,
                        Direction = Enum.EasingDirection.InOut,
                        Properties = {
                            Size = Vector3.new(0, 2.5, 0),
                            Transparency = 1,
                            CFrame = v180 * CFrame.new(0, math.random(40, 70) / 3.5, 0)
                        }
                    });
                end;
            end;
        end);
        Wait(0.69);
        local v181 = u174.FakeHead:GetChildren();

        for i = 1, #v181 do
            if v181[i]:IsA("Decal") then
                v181[i].Transparency = 1;
            end;
        end;

        local u182 = u174:GetChildren();

        for i = 1, #u182 do
            if u182[i]:IsA("BasePart") and (string.find(v178[i].Name, "Hair") or string.match(v178[i].Name, "Hair")) and u182[i].Name ~= "UIHair" then
                Thread(function() -- Line: 1845
                    -- upvalues: Tween (ref), u182 (copy), i (copy)
                    Tween(u182[i], 2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
                        Transparency = 1
                    });
                end);
            end;
        end;

        Tween(u174.FakeHead.UITransformFace, 0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 0
        });
        local Folder = Instance.new("Folder");
        Folder.Name = u174.Name .. "Egg";
        local v183 = next;
        local v184, v185 = u174:GetChildren();

        for _, v in v183, v184, v185 do
            if v:IsA("BasePart") and (string.match(v.Name, "Leg") or (string.match(v.Name, "Arm") or (v.Name == "Head" or v.Name == "Torso"))) then
                local v186 = v:Clone();

                for _, child in ipairs(v186:GetChildren()) do
                    if not (child:IsA("SpecialMesh") or child:IsA("BlockMesh")) then
                        if not child:IsA("FileMesh") then
                            child:Destroy();
                        end;
                    end;
                end;

                v186.Size = v186.Size;
                v186.Color = Color3.fromRGB(171, 182, 255);
                v186.CanCollide = false;
                v186.Massless = true;
                v186.Transparency = 1;
                v186.Material = Enum.Material.Neon;
                v186.Name = "Glow";
                v186.Parent = Folder;

                if string.match(v.Name, "Leg") or string.match(v.Name, "Arm") then
                    Models.Invert.Limbs.Mesh:Clone().Parent = v186;
                elseif v.Name == "Head" then
                    Models.Invert.Head.Mesh:Clone().Parent = v186;
                elseif v.Name == "Torso" then
                    Models.Invert.Torso.Mesh:Clone().Parent = v186;
                end;

                v186.Mesh.VertexColor = Vector3.new(10000, 10000, 10000);
                v186.Mesh.TextureId = "";
                Glue(v186, v);
                Tween(v186, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, {
                    Transparency = 0
                });
            end;
        end;

        Folder.Parent = workspace;
        u174.FakeHead.Transparency = 0;
        u174.FakeHead.UIFace.Color3 = Color3.new(1, 1, 1);
        Tween(u174.FakeHead.UIFace, 0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 0
        });
        Tween(u174.FakeHead.UITransformFace, 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 1
        });
        Wait(0.1);
        u174.FakeHead.Transparency = 0;
        local v187 = next;
        local v188, v189 = u174.FakeHead:GetChildren();

        for _, v in v187, v188, v189 do
            if v:IsA("Decal") and v.Name:find("Face") then
                v.Color3 = Color3.new(1, 1, 1);
            end;
        end;

        Tween(u174.UIHair, 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 0
        });
        Tween(u174.UIHair.UIOutline, 0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Transparency = 0
        });

        for i = 1, 6 do
            Wait(0.05);
            local v190 = {
                WaveType = 6,
                Transparency = 0,
                StartSize = Vector3.new(1, 0, 1)
            };
            local v191 = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0);
            local Angles = CFrame.Angles;
            local v192 = math.random(-20, 20);
            v190.CFrame = v191 * Angles(0, math.rad(v192), 0);
            v190.Color = Color3.fromRGB(255, 255, 255);
            v190.Time = math.random(3, 6) / 10;
            v190.Style = Enum.EasingStyle.Sine;
            v190.Direction = Enum.EasingDirection.InOut;
            v190.Properties = {
                Transparency = 1,
                Size = Vector3.new(i / 3 * 60, i / 5 * 10, i / 3 * 60)
            };
            Output:FireAllClients("FX", "Goku Create", "Wave", v190);
        end;

        Output:FireAllClients("FX", "Goku Create", "Sphere", {
            Transparency = 0,
            Size = Vector3.new(20, 250, 20),
            Time = 4,
            CFrame = u174.HumanoidRootPart.CFrame,
            Color = Color3.fromRGB(255, 255, 255),
            Material = Enum.Material.Neon,
            Style = Enum.EasingStyle.Quad,
            Direction = Enum.EasingDirection.InOut,
            Properties = {
                Size = Vector3.new(1, 250, 1),
                Transparency = 1
            }
        });
        u174.FakeHead.Transparency = 0;
        HumanoidRootPart.UITransformation:Play();
        HumanoidRootPart.TransformationBass:Play();
        Output:FireAllClients("FX", "Goku Create", "TransformShake", nil);
        Output:FireAllClients("FX", "Goku Create", "Transform", {
            Time = 0.4,
            Color = Color3.fromRGB(255, 255, 255)
        });
        p177:Fire();

        for _, descendant in ipairs(u174:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and (descendant.Name == "SSJGAuraParticle" or (descendant.Name == "MUIAuraParticle" or descendant.Name == "EggAuraParticle")) then
                descendant.Enabled = true;
            end;
        end;
    end
};