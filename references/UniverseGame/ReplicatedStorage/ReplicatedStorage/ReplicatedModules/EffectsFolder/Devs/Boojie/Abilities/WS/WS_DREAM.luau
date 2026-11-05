  

 

local RunService = game:GetService("RunService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Promise);
local Trove = require(Knit.Util.Trove);

local function Create(...) -- Line: 7
    return game:GetService("TweenService"):Create(...);
end;

local function PlayAndYield(...) -- Line: 11
    -- upvalues: Create (copy)
    local v1;

    if ... == 1 then
        v1 = ...;
    else
        v1 = Create(...);
    end;

    v1:Play();
    v1.Completed:Wait();
end;

local LocalPlayer = game:GetService("Players").LocalPlayer;

return function(p2) -- Line: 24
    -- upvalues: LocalPlayer (copy), Trove (copy), RunService (copy), PlayAndYield (copy), Create (copy)
    local CurrentCamera = game.Workspace.CurrentCamera;
    local v3 = not game.Players.LocalPlayer and game.StarterGui or game.Players.LocalPlayer.PlayerGui;
    local Character = LocalPlayer.Character;

    if p2 == "ForceStop" then
        for _, child in pairs(v3:GetChildren()) do
            if child.Name == "DreamEyelids" then
                child:Destroy();
            end;
        end;

        for _, child in pairs(CurrentCamera:GetChildren()) do
            if child.Name == "DreamBlur" then
                child:Destroy();
            end;

            if child.Name == "DreamDepth" then
                child:Destroy();
            end;
        end;

        return;
    end;

    if p2 == false then
        for _, child in pairs(v3:GetChildren()) do
            if child.Name == "DreamEyelids" then
                child:SetAttribute("Active", false);
            end;
        end;

        return;
    end;

    local u4 = Trove.new();
    u4:Connect(Character.Humanoid.Died, function() -- Line: 55
        -- upvalues: u4 (copy)
        print("ll");
        u4:Destroy();
    end);
    u4:Add(RunService.Heartbeat:Connect(function() -- Line: 60
        -- upvalues: Character (copy), u4 (copy)
        if not (Character and Character:IsDescendantOf(workspace.Living)) then
            u4:Destroy();
        end;
    end));
    local u5 = script.DreamEyelids:Clone();
    u5.Archivable = false;
    u5.Parent = v3;
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Name = "DreamBlur";
    BlurEffect.Size = 0;
    BlurEffect.Parent = CurrentCamera;
    local DepthOfFieldEffect = Instance.new("DepthOfFieldEffect");
    DepthOfFieldEffect.Name = "DreamDepth";
    DepthOfFieldEffect.FarIntensity = 1;
    DepthOfFieldEffect.FocusDistance = 5;
    DepthOfFieldEffect.InFocusRadius = 5;
    DepthOfFieldEffect.NearIntensity = 0.25;
    DepthOfFieldEffect.Parent = CurrentCamera;
    u4:Add(u5);
    u4:Add(BlurEffect);
    u4:Add(DepthOfFieldEffect);
    task.spawn(function() -- Line: 87
        -- upvalues: PlayAndYield (ref), CurrentCamera (copy), Create (ref)
        PlayAndYield(CurrentCamera, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
            FieldOfView = CurrentCamera.FieldOfView + 40
        });
        Create(CurrentCamera, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FieldOfView = CurrentCamera.FieldOfView - 40
        }):Play();
    end);
    Create(BlurEffect, TweenInfo.new(0.6, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
        Size = 54
    }):Play();
    PlayAndYield(u5.ImageLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(1.3, 0, 0.9, 0)
    });
    Create(BlurEffect, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = 8
    }):Play();
    PlayAndYield(u5.ImageLabel, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
        Size = UDim2.new(1.3, 0, 1.3, 0)
    });
    PlayAndYield(u5.ImageLabel, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(1.3, 0, 0.6, 0)
    });
    Create(BlurEffect, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = 12
    }):Play();
    PlayAndYield(u5.ImageLabel, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(1.3, 0, 0.7, 0)
    });
    Create(BlurEffect, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = 24
    }):Play();
    Create(CurrentCamera, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        FieldOfView = CurrentCamera.FieldOfView - 40
    }):Play();
    PlayAndYield(u5.ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Size = UDim2.new(1.3, 0, 0, 0)
    });
    task.wait(0.5);
    task.spawn(function() -- Line: 102
        -- upvalues: Create (ref), BlurEffect (copy)
        Create(BlurEffect, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 12
        }):Play();
        task.wait(1.6);
        Create(BlurEffect, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.wait(1.2);
        BlurEffect:Destroy();
    end);
    Create(CurrentCamera, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        FieldOfView = CurrentCamera.FieldOfView + 40
    }):Play();
    PlayAndYield(u5.ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
        Size = UDim2.new(1.3, 0, 0.9, 0)
    });
    local u6 = false;

    while u5 and (u5:IsDescendantOf(v3) and u5:GetAttribute("Active")) do
        if not u6 then
            u6 = true;
            task.spawn(function() -- Line: 116
                -- upvalues: PlayAndYield (ref), u5 (copy), u6 (ref)
                PlayAndYield(u5.ImageLabel, TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    Size = UDim2.new(1.3, 0, 1.3, 0)
                });
                PlayAndYield(u5.ImageLabel, TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    Size = UDim2.new(1.3, 0, 1.25, 0)
                });
                u6 = false;
            end);
        end;

        RunService.Stepped:Wait();
    end;

    PlayAndYield(u5.ImageLabel, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(1.3, 0, 0.6, 0)
    });
    PlayAndYield(u5.ImageLabel, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(1.3, 0, 0.7, 0)
    });
    Create(CurrentCamera, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        FieldOfView = CurrentCamera.FieldOfView - 40
    }):Play();
    Create(BlurEffect, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = 24
    }):Play();
    PlayAndYield(u5.ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Size = UDim2.new(1.3, 0, 0, 0)
    });
    task.wait(0.5);
    Create(CurrentCamera, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        FieldOfView = CurrentCamera.FieldOfView + 40
    }):Play();
    u4:Destroy();
    PlayAndYield(u5.ImageLabel, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
        Size = UDim2.new(3, 0, 9, 0)
    });
end;