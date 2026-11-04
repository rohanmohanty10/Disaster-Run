 
 

local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local workspace_CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = game.Players.LocalPlayer;
local u1 = {};
u1.__index = u1;

local function SCurveTransform(p2) -- Line: 17
    local math_clamp_ret = math.clamp(p2, -1, 1);

    if math_clamp_ret >= 0 then
        return 0.5 * math_clamp_ret / (0.5 - math_clamp_ret + 1);
    end;

    return -(0.9 * -math_clamp_ret / (0.9 + math_clamp_ret + 1));
end;

local function toSCurveSpace(p3) -- Line: 26
    return (math.abs(p3) * 2 - 1) * 1.25 - 0.25;
end;

local function fromSCurveSpace(p4) -- Line: 30
    return p4 / 2 + 0.5;
end;

local function gamepadLinearToCurve(p5) -- Line: 36
    if p5 then
        local Vector2_new = Vector2.new;
        local math_sign_ret = math.sign(p5.X);
        local math_abs_ret = math.abs(p5.X);
        local v6 = (math.abs(math_abs_ret) * 2 - 1) * 1.25 - 0.25;
        local math_clamp_ret = math.clamp(v6, -1, 1);
        local v7;

        if math_clamp_ret >= 0 then
            v7 = 0.5 * math_clamp_ret / (0.5 - math_clamp_ret + 1);
        else
            v7 = -(0.9 * -math_clamp_ret / (0.9 + math_clamp_ret + 1));
        end;

        local math_clamp_ret2 = math.clamp(math_sign_ret * (v7 / 2 + 0.5), -1, 1);
        local math_sign_ret2 = math.sign(p5.Y);
        local math_abs_ret2 = math.abs(p5.Y);
        local v8 = (math.abs(math_abs_ret2) * 2 - 1) * 1.25 - 0.25;
        local math_clamp_ret3 = math.clamp(v8, -1, 1);
        local v9;

        if math_clamp_ret3 >= 0 then
            v9 = 0.5 * math_clamp_ret3 / (0.5 - math_clamp_ret3 + 1);
        else
            v9 = -(0.9 * -math_clamp_ret3 / (0.9 + math_clamp_ret3 + 1));
        end;

        return Vector2_new(math_clamp_ret2, (math.clamp(math_sign_ret2 * (v9 / 2 + 0.5), -1, 1)));
    end;
end;

function u1.new(p10) -- Line: 45
    -- upvalues: u1 (copy), workspace_CurrentCamera (copy), UserInputService (copy)
    local v11 = setmetatable({}, u1);
    v11.camera = workspace_CurrentCamera;
    v11.setting = p10;
    v11.connections = {};
    v11.active = false;
    v11.isGamepad = UserInputService.GamepadEnabled;
    v11.isTouchEnabled = UserInputService.TouchEnabled;

    return v11;
end;

function u1.Bind(u12) -- Line: 67
    -- upvalues: UserInputService (copy), RunService (copy), gamepadLinearToCurve (copy), LocalPlayer (copy)
    u12.active = true;

    if not u12.isGamepad then
        if not u12.isTouchEnabled then
            UserInputService.InputChanged:Connect(function(p13, p14) -- Line: 149
                -- upvalues: UserInputService (ref), u12 (copy)
                if p13.UserInputType ~= Enum.UserInputType.MouseMovement then
                    return;
                end;

                if UserInputService.MouseBehavior == Enum.MouseBehavior.Default then
                    return;
                end;

                local sensitivity = u12.setting:FindFirstChild("sensitivity");

                if not sensitivity then
                    return;
                end;

                local v15 = p13.Delta * sensitivity.Value;
                local workspace_CurrentCamera2 = workspace.CurrentCamera;
                local math_clamp_ret = math.clamp(workspace_CurrentCamera2.CFrame.LookVector.Y, -0.99, 0.99);
                local math_asin_ret = math.asin(math_clamp_ret);
                local v16 = -v15.Y * 0.002;
                local _ = math_asin_ret + v16;
                local v17 = 1.4 - math_asin_ret;
                local v18 = -1.4 - math_asin_ret;
                local math_clamp_ret2 = math.clamp(v16, v18, v17);
                local v19 = math_asin_ret >= 1.3999 and math_clamp_ret2 > 0 and 0 or (math_asin_ret <= -1.3999 and math_clamp_ret2 < 0 and 0 or math_clamp_ret2);

                if v17 < v19 then
                    v18 = v17;
                elseif v19 >= v18 then
                    v18 = v19;
                end;

                workspace_CurrentCamera2.CFrame = workspace_CurrentCamera2.CFrame * CFrame.Angles(v18, -v15.X * 0.002, 0);
            end);
        end;

        return;
    end;

    local v21 = UserInputService.InputChanged:Connect(function(p20) -- Line: 79
        -- upvalues: u12 (copy)
        if p20.KeyCode == Enum.KeyCode.Thumbstick2 then
            u12.input = Vector2.new(p20.Position.X, p20.Position.Y);
        end;
    end);
    local v23 = UserInputService.InputEnded:Connect(function(p22) -- Line: 85
        -- upvalues: u12 (copy)
        if p22.KeyCode == Enum.KeyCode.Thumbstick2 then
            u12.input = Vector2.new(p22.Position.X, p22.Position.Y);
        end;
    end);
    table.insert(u12.connections, v21);
    table.insert(u12.connections, v23);
    RunService:BindToRenderStep("gamepadSensitivity", Enum.RenderPriority.Camera.Value - 1, function(p24) -- Line: 95
        -- upvalues: u12 (copy), gamepadLinearToCurve (ref), LocalPlayer (ref)
        local sensitivity = u12.setting:FindFirstChild("sensitivity");

        if not sensitivity then
            return;
        end;

        local Value = sensitivity.Value;
        local v25 = gamepadLinearToCurve(u12.input);

        if not (v25 and (LocalPlayer.Character and not LocalPlayer.Character:GetAttribute("lockrotation"))) then
            return;
        end;

        local _ = -v25.X * Value * p24 * 4;
        local _ = v25.Y * Value * p24 * 4;
        local math_clamp_ret = math.clamp(workspace.CurrentCamera.CFrame.LookVector.Y, -0.99, 0.99);
        local math_asin_ret = math.asin(math_clamp_ret);
        local v26 = v25.Y * Value * p24 * 4;
        local _ = math_asin_ret + v26;
        local v27 = 1.4 - math_asin_ret;
        local v28 = -1.4 - math_asin_ret;
        local math_clamp_ret2 = math.clamp(v26, v28, v27);
        local v29 = math_asin_ret >= 1.3999 and math_clamp_ret2 > 0 and 0 or (math_asin_ret <= -1.3999 and math_clamp_ret2 < 0 and 0 or math_clamp_ret2);

        if v27 < v29 then
            v28 = v27;
        elseif v29 >= v28 then
            v28 = v29;
        end;

        local v30 = CFrame.Angles(0, -v25.X * Value * p24 * 4, 0) * u12.camera.CFrame * CFrame.Angles(v28, 0, 0);
        u12.camera.CFrame = v30;
    end);
end;

function u1.Unbind(p31) -- Line: 195
    -- upvalues: RunService (copy)
    if not p31.active then
        return;
    end;

    p31.active = false;
    RunService:UnbindFromRenderStep("gamepadSensitivity");

    for _, v in p31.connections do
        v:Disconnect();
    end;

    table.clear(p31.connections);
end;

return u1;