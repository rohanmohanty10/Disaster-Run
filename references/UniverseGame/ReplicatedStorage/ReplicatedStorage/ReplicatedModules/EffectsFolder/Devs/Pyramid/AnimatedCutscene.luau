  

 

local TweenService = game:GetService("TweenService");

return function(p1, p2) -- Line: 2
    -- upvalues: TweenService (copy)
    local Animation = Instance.new("Animation");
    local u3;

    if type(p2) == "table" then
        Animation.AnimationId = "rbxassetid://" .. p2[2];
        u3 = p2[1];
    else
        Animation.AnimationId = "rbxassetid://" .. p2;
        u3 = game:GetService("ReplicatedStorage")["Client Assets"].CamRig:Clone();
        u3.Parent = workspace.Effects;
    end;

    local v4 = u3.AnimationController:LoadAnimation(Animation);
    local u7 = {
        [v4] = {
            FOV = function(p5) -- Line: 18
                -- upvalues: TweenService (ref)
                local v6 = string.split(p5, "::");
                TweenService:Create(workspace.CurrentCamera, TweenInfo.new(tonumber(v6[2]), Enum.EasingStyle[v6[3]], Enum.EasingDirection[v6[4]]), {
                    FieldOfView = tonumber(v6[1])
                }):Play();
            end
        }
    };

    for _, v in pairs(p1) do
        local Animation2 = Instance.new("Animation");
        Animation2.AnimationId = "rbxassetid://" .. v.Animation;
        u7[v.Character.Humanoid:LoadAnimation(Animation2)] = v.Events or {};
    end;

    while true do
        task.wait();
        local v8 = true;

        for i, _ in pairs(u7) do
            if i.Length <= 0 then
                v8 = false;
            end;
        end;

        if v8 then
            local NumberValue = Instance.new("NumberValue");
            NumberValue.Value = 1;
            local u9 = game:GetService("RunService").RenderStepped:Connect(function() -- Line: 43
                -- upvalues: u7 (copy), NumberValue (copy), u3 (ref)
                for i, _ in pairs(u7) do
                    if i.IsPlaying then
                        i:AdjustSpeed(NumberValue.Value);
                    end;
                end;

                workspace.CurrentCamera.CFrame = u3.Camera.CFrame;
            end);

            for i, v in pairs(u7) do
                for i2, v2 in pairs(v) do
                    if type(v2) == "function" then
                        i:GetMarkerReachedSignal(i2):Connect(v2);
                    else
                        local _ = type(v2) == "table";
                    end;
                end;

                i:GetMarkerReachedSignal("TweenSpeed"):Connect(function(p10) -- Line: 57
                    -- upvalues: TweenService (ref), NumberValue (copy)
                    local v11 = string.split(p10, "::");
                    TweenService:Create(NumberValue, TweenInfo.new(tonumber(v11[2]), Enum.EasingStyle[v11[3]], Enum.EasingDirection[v11[4]]), {
                        Value = tonumber(v11[1])
                    }):Play();
                end);
                i:Play(0);
            end;

            local u12 = nil;
            local u13 = v4.Stopped:Connect(function() -- Line: 65
                -- upvalues: u12 (ref)
                u12();
            end);

            u12 = function() -- Line: 68
                -- upvalues: u13 (copy), u9 (copy), u7 (copy), u12 (ref)
                u13:Disconnect();
                u9:Disconnect();

                for i, _ in pairs(u7) do
                    i:Stop(0);
                    i:Destroy();
                end;

                u12 = nil;
            end;

            return;
        end;
    end;
end;