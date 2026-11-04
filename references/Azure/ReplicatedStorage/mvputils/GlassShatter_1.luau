 
 

local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local v1 = {};

local function rng(p2, p3) -- Line: 7
    return p2 + math.random() * (p3 - p2);
end;

local function slice(p4, p5, p6, p7, p8, p9, p10) -- Line: 11
    -- upvalues: slice (copy)
    if p8 <= 0 or (p6 < p9 or p7 < p9) then
        table.insert(p10, {
            x = p4,
            y = p5,
            w = p6,
            h = p7
        });

        return;
    end;

    if p7 < p6 then
        local v11 = p6 * (0.3 + math.random() * 0.39999999999999997);
        slice(p4, p5, v11, p7, p8 - 1, p9, p10);
        slice(p4 + v11, p5, p6 - v11, p7, p8 - 1, p9, p10);

        return;
    end;

    local v12 = p7 * (0.3 + math.random() * 0.39999999999999997);
    slice(p4, p5, p6, v12, p8 - 1, p9, p10);
    slice(p4, p5 + v12, p6, p7 - v12, p8 - 1, p9, p10);
end;

function v1.Play(p13) -- Line: 28
    -- upvalues: slice (copy), TweenService (copy), Debris (copy), RunService (copy)
    local v14 = p13 or {};
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return;
    end;

    local v15 = v14.Depth or 3;
    local v16 = v14.ImpactPosition or Vector2.new(0.5, 0.5);
    local v17 = v14.Color or Color3.fromRGB(245, 245, 250);
    local v18 = v14.Distance or 4;
    local v19 = v14.HoldTime or 0.01;
    local u20 = v14.FallAcceleration or 150;
    local v21 = v14.Thickness or 0.01;
    local CFrame2 = workspace_CurrentCamera.CFrame;
    local LookVector = CFrame2.LookVector;
    local UpVector = CFrame2.UpVector;
    local RightVector = CFrame2.RightVector;
    local ViewportSize = workspace_CurrentCamera.ViewportSize;
    local math_rad_ret = math.rad(workspace_CurrentCamera.FieldOfView * 0.5);
    local v22 = v18 * math.tan(math_rad_ret) * 1.1;
    local v23 = v22 * (ViewportSize.X / ViewportSize.Y) * 2;
    local v24 = v22 * 2;
    local Vector2_new_ret = Vector2.new(v23 * v16.X, v24 * v16.Y);
    local v25 = {};
    slice(0, 0, v23, v24, v15, math.min(v23, v24) / 8, v25);
    local Folder = Instance.new("Folder");
    Folder.Name = "shards";
    Folder.Parent = workspace.Effects;
    local v26 = v19;
    local u27 = {};

    for i = 1, #v25 do
        local v28 = v25[i];
        local Vector2_new_ret2 = Vector2.new(v28.x + v28.w * 0.5, v28.y + v28.h * 0.5);
        local CFrame_fromMatrix_ret = CFrame.fromMatrix(CFrame2.Position + LookVector * v18 + RightVector * (Vector2_new_ret2.X - v23 * 0.5) + UpVector * -(Vector2_new_ret2.Y - v24 * 0.5), LookVector, UpVector, RightVector);
        local WedgePart = Instance.new("WedgePart");
        WedgePart.Size = Vector3.new(v21, v28.h, v28.w);
        WedgePart.CFrame = CFrame_fromMatrix_ret;
        WedgePart.Anchored = true;
        WedgePart.CanCollide = false;
        WedgePart.CanTouch = false;
        WedgePart.CanQuery = false;
        WedgePart.CastShadow = false;
        WedgePart.Reflectance = 0.8;
        WedgePart.Transparency = 0.8;
        WedgePart.Material = Enum.Material.Glass;
        WedgePart.Color = v17;
        WedgePart.Parent = Folder;
        local v29 = WedgePart:Clone();
        v29.CFrame = CFrame_fromMatrix_ret * CFrame.Angles(3.141592653589793, 0, 0);
        v29.Parent = Folder;
        local v30 = (Vector2_new_ret2 - Vector2_new_ret).Magnitude > 0.1 and (Vector2_new_ret2 - Vector2_new_ret).Unit or Vector2.new(-1 + math.random() * 2, -1 + math.random() * 2).Unit;
        local v31 = v26 + (Vector2_new_ret2 - Vector2_new_ret).Magnitude / (math.max(v23, v24) * 1.4);
        local _ = i;

        for _, v in ipairs({ WedgePart, v29 }) do
            local v32 = 4 + math.random() * 5;
            local u33 = 1.1 + math.random() * 0.5;
            local u34 = {
                active = false,
                part = v,
                vel = RightVector * v30.X * v32 - UpVector * v30.Y * v32 + LookVector * (-1 + math.random() * 3)
            };
            local v35 = -6 + math.random() * 12;
            local v36 = -6 + math.random() * 12;
            local v37 = -6 + math.random() * 12;
            u34.rot = Vector3.new(v35, v36, v37);
            table.insert(u27, u34);
            v19 = math.max(v19, v31 + u33);
            task.delay(v31, function() -- Line: 96
                -- upvalues: v (copy), u34 (copy), TweenService (ref), u33 (copy), Debris (ref)
                if not v.Parent then
                    return;
                end;

                u34.active = true;
                TweenService:Create(v, TweenInfo.new(u33, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Transparency = 1
                }):Play();
                Debris:AddItem(v, u33 + 0.1);
            end);
        end;
    end;

    local u41 = RunService.Heartbeat:Connect(function(p38) -- Line: 106
        -- upvalues: u27 (copy), u20 (copy)
        for i = 1, #u27 do
            local v39 = u27[i];
            local v40;

            if v39.active and v39.part.Parent then
                v39.vel = v39.vel + Vector3.new(0, -u20 * p38, 0);
                v39.part.CFrame = (v39.part.CFrame + v39.vel * p38) * CFrame.Angles(v39.rot.X * p38, v39.rot.Y * p38, v39.rot.Z * p38);
                v40 = i;
            else
                v40 = i;
            end;
        end;
    end);
    task.delay(v19 + 0.3, function() -- Line: 116
        -- upvalues: u41 (ref)
        u41:Disconnect();
    end);
    Debris:AddItem(Folder, v19 + 0.5);
end;

return v1;