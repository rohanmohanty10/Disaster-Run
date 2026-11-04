  

local u1 = {};
local UserInputService = game:GetService("UserInputService");
local VRService = game:GetService("VRService");
local ClientInfoHandler = require(script.Parent.ClientInfoHandler);
local u2 = require(script.Parent.Parent.Parent.Shared.Modules.Signal).new();
local u3 = nil;

local function DetermineInputTypeString(p4) -- Line: 40
    if p4 == Enum.UserInputType.Keyboard then
        return "keyboard";
    end;

    if p4 == Enum.UserInputType.Touch then
        return "touch";
    end;

    if string.match(tostring(p4), "Gamepad") then
        return "gamepad";
    end;
end;

function u1.GetDeviceType(p5) -- Line: 53
    -- upvalues: UserInputService (copy), VRService (copy)
    local v6 = (UserInputService.VREnabled or VRService.VREnabled) and "vr" or (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and "mobile" or (UserInputService.GamepadEnabled and not UserInputService.KeyboardEnabled and "console" or (UserInputService.KeyboardEnabled and "pc" or "unknown")));
    local v7 = "unknown";

    if v6 == "mobile" then
        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera then
            local v8 = math.max(workspace_CurrentCamera.ViewportSize.X, workspace_CurrentCamera.ViewportSize.Y) / math.min(workspace_CurrentCamera.ViewportSize.X, workspace_CurrentCamera.ViewportSize.Y);

            if v8 > 1.8 then
                return v6, "phone";
            end;

            if v8 <= 1.7 then
                return v6, "tablet";
            end;

            return v6, "phone";
        end;
    else
        if v6 == "console" then
            local ImageForKeyCode = UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonX);

            if string.find(ImageForKeyCode, "Xbox") then
                return v6, "xbox";
            end;

            if string.find(ImageForKeyCode, "PlayStation") then
                return v6, "playstation";
            end;

            return v6, "unknown";
        end;

        if v6 == "vr" then
            return v6, "unknown";
        end;

        v7 = v6 == "pc" and "unknown" or v7;
    end;

    return v6, v7;
end;

function u1.OnInputTypeChanged(p9: table, p10: function) -- Line: 100
    -- upvalues: u2 (copy)
    return u2:Connect(p10);
end;

function u1.GetCurrentInputType(p11) -- Line: 104
    -- upvalues: u3 (ref), UserInputService (copy)
    if not u3 then
        if UserInputService.GamepadEnabled then
            u3 = "gamepad";
        elseif UserInputService.TouchEnabled then
            u3 = "touch";
        else
            u3 = "keyboard";
        end;
    end;

    return u3;
end;

function u1.Init(p12) -- Line: 118
    -- upvalues: u3 (ref), u2 (copy), ClientInfoHandler (copy), u1 (copy), UserInputService (copy)
    local function inputTypeChanged(p13: string) -- Line: 119
        -- upvalues: u3 (ref), u2 (ref), ClientInfoHandler (ref)
        if u3 ~= p13 then
            u3 = p13;
            u2:Fire(u3);
            ClientInfoHandler:UpdateClientInfo("inputType", u3);
        end;
    end;

    local DeviceType, v14 = p12:GetDeviceType();
    ClientInfoHandler:UpdateClientInfo("inputType", u1:GetCurrentInputType());
    ClientInfoHandler:UpdateClientInfo("deviceSubType", v14);
    ClientInfoHandler:UpdateClientInfo("device", DeviceType);
    UserInputService.LastInputTypeChanged:Connect(function(p15) -- Line: 133
        -- upvalues: u3 (ref), u2 (ref), ClientInfoHandler (ref)
        local v16 = p15 == Enum.UserInputType.Keyboard and "keyboard" or (p15 == Enum.UserInputType.Touch and "touch" or (string.match(tostring(p15), "Gamepad") and "gamepad" or nil));

        if v16 and (v16 ~= u3 and u3 ~= v16) then
            u3 = v16;
            u2:Fire(u3);
            ClientInfoHandler:UpdateClientInfo("inputType", u3);
        end;
    end);
    UserInputService.InputChanged:Connect(function(p17) -- Line: 140
        -- upvalues: u3 (ref), u2 (ref), ClientInfoHandler (ref)
        if p17.UserInputType == Enum.UserInputType.MouseMovement and u3 ~= "keyboard" then
            u3 = "keyboard";
            u2:Fire(u3);
            ClientInfoHandler:UpdateClientInfo("inputType", u3);
        end;
    end);
end;

return u1;