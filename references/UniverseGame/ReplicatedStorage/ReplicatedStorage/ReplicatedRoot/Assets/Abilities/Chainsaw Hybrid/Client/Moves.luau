  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
require(ReplicatedRoot.Core);
require(ReplicatedRoot.Libraries.Types.CommonTypes);
require(ReplicatedRoot.Libraries.Types.GameplayTypes);
require(ReplicatedRoot.Libraries.Utility.GameplayUtil);
require(ReplicatedRoot.Libraries.Utility.TableUtil);
require(ReplicatedRoot.Libraries.Utility.CommonUtil);
local Constructor = require(ReplicatedRoot.Libraries.Gameplay.Constructor);
require(ReplicatedRoot.Services.CombatService);
require(ReplicatedRoot.Services.Gameplay.MoveService);
require(ReplicatedRoot.Services.SequenceService);
require(ReplicatedRoot.Services.StateService);
require(ReplicatedRoot.Services.TagService);
require(ReplicatedRoot.Libraries.Classes.Promise);
require(ReplicatedRoot.Libraries.Classes.Trove);
require(ReplicatedRoot.Libraries.Classes.Timer);
require(ReplicatedRoot.Services.AnimatorService);
local InputService = require(ReplicatedRoot.Services.InputService);
require(ReplicatedRoot.Libraries.Enums);
Random.new();
local v1 = Constructor.Ability({
    Moves = {}
});
v1.Moves["Rip N\' Tear"] = Constructor.Move({
    Activate = function(p2, p3) -- Line: 37, Name: Activate
        -- upvalues: InputService (copy)
        local _ = p2.Character;
        local Humanoid = p2.Humanoid;
        local v4 = os.clock();

        while InputService.GetInputGroup("Gameplay"):IsInputActive("Jump") and os.clock() - v4 <= 0.1 do
            if p2.Humanoid.JumpPower > 0 or (Humanoid:GetState() == Enum.HumanoidStateType.Jumping or Humanoid:GetState() == Enum.HumanoidStateType.Freefall) then
                p3.Arguments.Aerial = true;
                break;
            end;

            task.wait();
        end;

        return p2:ActivateServer(p3):expect();
    end
});
v1.Moves["Wild Crash"] = Constructor.Move({
    Activate = function(p5, p6) -- Line: 55, Name: Activate
        local _ = p5.Character;
        local Humanoid = p5.Humanoid;

        if Humanoid:GetState() == Enum.HumanoidStateType.Jumping or Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
            p6.Arguments.Aerial = true;
        end;

        return p5:ActivateServer(p6):expect();
    end
});
v1.Moves["Violent Carve"] = Constructor.Move({
    Activate = function(p7, p8) -- Line: 66, Name: Activate
        local _ = p7.Character;
        local Humanoid = p7.Humanoid;

        if Humanoid:GetState() == Enum.HumanoidStateType.Jumping or Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
            p8.Arguments.Aerial = true;
        end;

        return p7:ActivateServer(p8):expect();
    end
});

return v1;