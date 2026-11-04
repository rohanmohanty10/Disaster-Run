 

 

local RunService = game:GetService("RunService");
local CommonUtils = require(script.Parent:WaitForChild("CommonUtils"));
local u1 = CommonUtils.get("CharacterUtil");
local u2 = CommonUtils.get("ConnectionUtil");
local u3 = CommonUtils.get("EventBus");
local script_Parent = require(script.Parent);
local CameraModule = require(script.Parent:WaitForChild("CameraModule"));
local ControlModule = require(script.Parent:WaitForChild("ControlModule"));
local ServerAuthority = require(script.Parent:WaitForChild("ServerAuthority"));
local u4 = {};
u4.__index = u4;

function u4.new() -- Line: 63
    -- upvalues: script_Parent (copy), u2 (copy), u3 (copy), u4 (copy)
    local v5 = {
        data = {
            isJumping = false,
            player = nil,
            character = nil,
            isServerAuthority = false,
            playerModule = script_Parent,
            moveVector = Vector2.new(),
            worldMoveVector = Vector3.new(),
            actions = {},
            connectionUtil = u2.new(),
            eventBus = u3.new()
        }
    };

    return setmetatable(v5, u4);
end;

function u4.start(u6) -- Line: 82
    -- upvalues: u1 (copy), ServerAuthority (copy), ControlModule (copy), RunService (copy), CameraModule (copy)
    u6.data.connectionUtil:trackConnection("ONLOCALPLAYER", u1.onLocalPlayer(function(p7) -- Line: 84
        -- upvalues: u6 (copy), ServerAuthority (ref), ControlModule (ref), RunService (ref), u1 (ref), CameraModule (ref)
        u6.data.player = p7;
        ServerAuthority.initialize(u6.data);
        ControlModule:initialize(u6.data);
        RunService:BindToRenderStep("PLAYERMODULE_RENDERSTEPPED_INPUT", Enum.RenderPriority.Input.Value, function(p8) -- Line: 91
            -- upvalues: u6 (ref), u1 (ref), ControlModule (ref)
            u6.data.character = u1.getCharacter();

            if not u6.data.character then
                return;
            end;

            ControlModule:Update(u6.data, p8);
        end);
        u6.data.connectionUtil:trackBoundFunction("PLAYERMODULE_RENDERSTEPPED_INPUT", function() -- Line: 99
            -- upvalues: RunService (ref)
            RunService:UnbindFromRenderStep("PLAYERMODULE_RENDERSTEPPED_INPUT");
        end);
        RunService:BindToRenderStep("PLAYERMODULE_RENDERSTEPPED_CAMERA", Enum.RenderPriority.Camera.Value, function(p9) -- Line: 104
            -- upvalues: CameraModule (ref), u6 (ref)
            CameraModule:Update(u6.data, p9);
        end);
        u6.data.connectionUtil:trackBoundFunction("PLAYERMODULE_RENDERSTEPPED_CAMERA", function() -- Line: 107
            -- upvalues: RunService (ref)
            RunService:UnbindFromRenderStep("PLAYERMODULE_RENDERSTEPPED_CAMERA");
        end);
    end));
end;

function u4.stop(p10) -- Line: 113
    p10.data.connectionUtil:disconnectAll();
end;

return u4;