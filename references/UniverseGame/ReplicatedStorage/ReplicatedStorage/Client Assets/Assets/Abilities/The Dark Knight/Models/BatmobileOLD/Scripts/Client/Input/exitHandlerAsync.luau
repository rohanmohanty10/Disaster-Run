  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local ExitLocationAttachment = script.Parent.Parent.Parent.Parent.Chassis.ExitLocationAttachment;

local function getSeatWeld(p1) -- Line: 8
    local PrimaryPart = p1.PrimaryPart;

    if not PrimaryPart then
        return nil;
    end;

    for _, v in PrimaryPart:GetJoints() do
        if v.Name == "SeatWeld" then
            return v;
        end;
    end;

    return nil;
end;

return function(p2, p3) -- Line: 22, Name: exitHandlerAsync
    -- upvalues: LocalPlayer (copy), ExitLocationAttachment (copy)
    if p3 ~= Enum.UserInputState.Begin then
        return;
    end;

    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    local v4 = Character:FindFirstChildOfClass("Humanoid");

    if not v4 then
        return;
    end;

    v4:ChangeState(Enum.HumanoidStateType.GettingUp);
    local PrimaryPart = Character.PrimaryPart;

    if PrimaryPart then
        for _, v in PrimaryPart:GetJoints() do
            if v.Name == "SeatWeld" then
                break;
            end;
        end;
    else
        local v = nil;
    end;

    if v then
        repeat
            v.AncestryChanged:Wait();
        until not v:IsDescendantOf(game);
    end;

    task.defer(function() -- Line: 46
        -- upvalues: Character (copy), ExitLocationAttachment (ref)
        Character:PivotTo(ExitLocationAttachment.WorldCFrame);
    end);
end;