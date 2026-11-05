  

 

local RunService = game:GetService("RunService");
local CurrentCamera = game:GetService("Workspace").CurrentCamera;
local Value = Enum.RenderPriority.Camera.Value;
local u1 = false;
local u2 = {
    attachment = nil
};

local function update(p3) -- Line: 18
    -- upvalues: CurrentCamera (copy), u2 (ref)
    CurrentCamera.CFrame = u2.attachment.WorldCFrame;
end;

return {
    setParameters = function(p4, p5) -- Line: 25, Name: setParameters
        -- upvalues: u2 (ref)
        u2 = p5;
    end,

    enable = function(p6) -- Line: 29, Name: enable
        -- upvalues: u1 (ref), RunService (copy), Value (copy), update (copy)
        if u1 then
            return;
        end;

        u1 = true;
        RunService:BindToRenderStep("CarFixedCamera", Value, update);
    end,

    disable = function(p7) -- Line: 38, Name: disable
        -- upvalues: u1 (ref), RunService (copy)
        if not u1 then
            return;
        end;

        u1 = false;
        RunService:UnbindFromRenderStep("CarFixedCamera");
    end
};