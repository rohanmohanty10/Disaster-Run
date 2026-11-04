  

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local workspace_CurrentCamera = workspace.CurrentCamera;
local Children = game.ReplicatedStorage.Assets.Vfx.YukiTexts:GetChildren();
local u1 = 0;
Children[0] = Children[2];
Children[2] = nil;

return function(p2) -- Line: 11
    -- upvalues: u1 (ref), Children (copy), RunService (copy), TweenService (copy), workspace_CurrentCamera (copy)
    u1 = u1 + 1;
    local u3 = Children[u1 % 2]:Clone();
    u3.Parent = workspace.Debris;
    local u4 = time();
    local u5 = time() + 3;
    local u6 = p2 + Vector3.new(0, -4, 0);
    local u7 = p2 + Vector3.new(0, 4, 0);
    local u8 = u7 + Vector3.new(0, 4, 0);
    local CFrame_Angles = CFrame.Angles;
    local math_random_ret = math.random(-8, 8);
    local u9 = CFrame_Angles(0, 0, (math.rad(math_random_ret)));
    RunService.RenderStepped:Connect(function() -- Line: 26
        -- upvalues: u4 (copy), u5 (copy), u7 (copy), u8 (copy), TweenService (ref), u9 (copy), u3 (copy), workspace_CurrentCamera (ref), u6 (copy)
        local v10 = time() - u4;

        if v10 > 3 then
            local v11 = time() - u5;
            local v12 = u7:Lerp(u8, TweenService:GetValue(math.min(1, v11 / 0.7), Enum.EasingStyle.Cubic, Enum.EasingDirection.Out));
            local v13 = CFrame.identity:Lerp(u9, TweenService:GetValue(math.min(1, v11 / 0.9), Enum.EasingStyle.Quad, Enum.EasingDirection.Out));
            u3.CFrame = CFrame.lookAt(v12, workspace_CurrentCamera.CFrame.Position) * v13;
            u3.Transparency = TweenService:GetValue(math.min(1, v11 / 0.9), Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

            if v11 > 1 then
                u3:Destroy();
            end;
        else
            local v14 = u6:Lerp(u7, TweenService:GetValue(math.min(1, v10 / 0.7), Enum.EasingStyle.Cubic, Enum.EasingDirection.Out));
            local v15 = CFrame.identity:Lerp(u9, TweenService:GetValue(math.min(1, v10 / 0.9), Enum.EasingStyle.Quad, Enum.EasingDirection.Out));
            u3.CFrame = CFrame.lookAt(v14, workspace_CurrentCamera.CFrame.Position) * v15;
        end;
    end);
end;