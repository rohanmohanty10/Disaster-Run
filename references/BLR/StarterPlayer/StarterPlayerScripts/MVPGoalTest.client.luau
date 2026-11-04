  

local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
UserInputService.InputBegan:Connect(function(p1, p2) -- Line: 6
    -- upvalues: CutsceneUtils (copy)
    if p2 then
        return;
    end;

    if p1.KeyCode == Enum.KeyCode.L then
        CutsceneUtils.MVPGoal("BarouMVPCutscene");
    end;
end);