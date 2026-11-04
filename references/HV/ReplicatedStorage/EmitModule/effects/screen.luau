 

 

local RunService = game:GetService("RunService");
require("../types");
local u1 = require("../mod/utility");

return {
    emit = function(u2: userdata, p3: any) -- Line: 8, Name: emit
        -- upvalues: u1 (copy), RunService (copy)
        if u2:GetAttribute("Enabled") then
            local Attribute = u1.getAttribute(u2, "PartScale", Vector3.new(1, 1, 1));
            local Attribute2 = u1.getAttribute(u2, "PartDistance", 1.5);
            local Attribute3 = u1.getAttribute(u2, "OffsetPosition", Vector3.new(0, 0, 0));
            local u4 = u1.getAttribute(u2, "OffsetRotation", Vector3.new(0, 0, 0)) * u1.DEG_TO_RAD;
            local CFrame2 = u2.CFrame;
            local Size = u2.Size;
            local CollisionGroup = u2.CollisionGroup;
            u2.CollisionGroup = "ForgeMouseIgnore";
            table.insert(p3, function() -- Line: 25
                -- upvalues: u2 (copy), Size (copy), CFrame2 (copy), CollisionGroup (copy)
                u2.Size = Size;
                u2.CFrame = CFrame2;
                u2.CollisionGroup = CollisionGroup == "" and "Default" or (CollisionGroup or "Default");
            end);

            local function frame() -- Line: 32
                -- upvalues: Attribute2 (copy), u2 (copy), Attribute (copy), Attribute3 (copy), u4 (copy)
                local workspace_CurrentCamera = workspace.CurrentCamera;
                local math_rad_ret = math.rad(workspace_CurrentCamera.FieldOfView / 2);
                local v5 = math.tan(math_rad_ret) * Attribute2 * 2;
                local v6 = workspace_CurrentCamera.ViewportSize.X / workspace_CurrentCamera.ViewportSize.Y * v5;
                local v7 = workspace_CurrentCamera.CFrame * CFrame.new(0, 0, -Attribute2);
                u2.Size = Vector3.new(v6, v5, u2.Size.Z) * Attribute;
                u2.CFrame = v7 * CFrame.new(Attribute3) * CFrame.fromOrientation(u4.x, u4.y, u4.z);
            end;

            if RunService:IsRunning() then
                local RandomId = u1.getRandomId();
                RunService:BindToRenderStep(RandomId, u1.RENDER_PRIORITY + p3.depth, frame);
                table.insert(p3, function() -- Line: 52
                    -- upvalues: RunService (ref), RandomId (copy)
                    RunService:UnbindFromRenderStep(RandomId);
                end);
            else
                table.insert(p3, RunService.RenderStepped:Connect(frame));
            end;

            return true;
        end;
    end
};