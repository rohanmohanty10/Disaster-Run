  

 

local u1 = Random.new();
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local CurrentCamera = game.Workspace.CurrentCamera;
local u2 = 0;

local function Create(...) -- Line: 8
    -- upvalues: TweenService (copy)
    return TweenService:Create(...);
end;

local function Invert() -- Line: 12
    -- upvalues: u1 (copy)
    return u1:NextInteger(1, 2) == 2 and -1 or 1;
end;

local function Lerp(p3, p4, p5) -- Line: 16
    return p3 + (p4 - p3) * p5;
end;

return function(p6) -- Line: 20
    -- upvalues: RunService (copy), u2 (ref), u1 (copy), CurrentCamera (copy), TweenService (copy)
    RunService:UnbindFromRenderStep("Disorient");
    u2 = u2 + 1;
    local u7 = u2;
    local u8 = p6 or 0.25;
    local u9 = os.clock();
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 0;
    BlurEffect.Parent = game.Lighting;
    task.delay(u8 + 0.1, function() -- Line: 29
        -- upvalues: BlurEffect (copy)
        BlurEffect:Destroy();
    end);
    RunService:BindToRenderStep("Disorient", Enum.RenderPriority.Camera.Value + 1, function(p10) -- Line: 32
        -- upvalues: u1 (ref), CurrentCamera (ref), u9 (copy), u8 (copy), RunService (ref), u2 (ref), u7 (copy), TweenService (ref), BlurEffect (copy)
        local _ = u1:NextInteger(1, 2) == 2;
        local _ = u1:NextInteger(1, 2) == 2;
        local v11 = CurrentCamera.CFrame * CFrame.new(0.01 * (u1:NextInteger(1, 2) == 2 and -1 or 1), 0.005 * (u1:NextInteger(1, 2) == 2 and -1 or 1), 0);
        local Angles = CFrame.Angles;
        local v12 = u1:NextInteger(1, 2) == 2 and -1 or 1;
        local v13 = math.rad(1 * v12);
        local v14 = u1:NextInteger(1, 2) == 2 and -1 or 1;
        local v15 = v11 * Angles(v13, math.rad(0.5 * v14), 0);
        local v16 = (os.clock() - u9) / u8;

        if u9 < os.clock() - u8 then
            RunService:UnbindFromRenderStep("Disorient");
        end;

        if u2 ~= u7 then
            RunService:UnbindFromRenderStep("Disorient");
        end;

        CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(v15, TweenService:GetValue(v16, Enum.EasingStyle.Sine, Enum.EasingDirection.Out));

        if v16 < 0.5 then
            local Size = BlurEffect.Size;
            BlurEffect.Size = Size + (u1:NextNumber(8, 36) - Size) * (v16 * 2);

            return;
        end;

        local Size = BlurEffect.Size;
        BlurEffect.Size = Size + (0 - Size) * (v16 / 2);
    end);
end;