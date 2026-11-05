  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local PrimaryPart = script.Parent.Parent.Parent.Parent.Parent.PrimaryPart;
local v1 = {};

local function GetSeatWeld(p2) -- Line: 9
    local PrimaryPart2 = p2.PrimaryPart;

    if not PrimaryPart2 then
        return;
    end;

    for _, v in PrimaryPart2:GetJoints() do
        if v.Name == "SeatWeld" then
            return v;
        end;
    end;
end;

v1.Bind = Enum.KeyCode.H;

function v1.Execute(p3, p4) -- Line: 23
    -- upvalues: LocalPlayer (copy), PrimaryPart (copy)
    if p4 ~= Enum.UserInputState.Begin then
        return;
    end;

    local Character = LocalPlayer.Character;
    local v5;

    if Character then
        v5 = Character:FindFirstChildOfClass("Humanoid");
    else
        v5 = Character;
    end;

    if not v5 then
        return;
    end;

    v5:ChangeState(Enum.HumanoidStateType.GettingUp);
    local PrimaryPart2 = Character.PrimaryPart;

    if PrimaryPart2 then
        for _, v in PrimaryPart2:GetJoints() do
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

    task.defer(function() -- Line: 38
        -- upvalues: Character (copy), PrimaryPart (ref)
        Character:PivotTo(PrimaryPart.CFrame * CFrame.new(0, 5, 0));
    end);
end;

return v1;