 

 

local UserFlag = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil").getUserFlag("UserControlModuleEnabledAPI");
local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 23
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2.enabled = true;

    return v2;
end;

function u1.initializeActions(u3) -- Line: 31
    u3.connectionUtil:trackConnection("SERVER_AUTHORITY_CHANGED", u3.eventBus:subscribe("SERVER_AUTHORITY_CHANGED"):Connect(function() -- Line: 33
        -- upvalues: u3 (copy)
        u3.actions = {};
    end));

    if u3.actions.MoveAction and u3.actions.JumpAction then
        return;
    end;

    if not u3.player then
        return;
    end;

    pcall(function() -- Line: 42
        -- upvalues: u3 (copy)
        local InputContexts = script.Parent.Parent.InputContexts;

        if u3.isServerAuthority then
            InputContexts = u3.player.InputContexts;
        end;

        local CharacterContext = InputContexts.CharacterContext;
        u3.actions = {
            MoveAction = CharacterContext.MoveAction,
            JumpAction = CharacterContext.JumpAction
        };
        u3.eventBus:publish("ACTIONS_RELOADED");
    end);
end;

function u1.update(p4) -- Line: 58
    -- upvalues: UserFlag (copy)
    if UserFlag then
        if not (p4.actions.MoveAction and p4.actions.JumpAction) then
            return;
        end;

        local ControlModule = p4.playerModule.ControlModule;
        p4.actions.MoveAction.Enabled = ControlModule.Enabled;
        p4.actions.JumpAction.Enabled = ControlModule.Enabled;
    end;

    p4.moveVector = p4.actions.MoveAction:GetState();
    p4.isJumping = p4.actions.JumpAction:GetState();
end;

function u1.Enable(p5: table, p6: boolean) -- Line: 74
end;

return u1;