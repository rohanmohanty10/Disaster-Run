  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
require(ReplicatedRoot.Core);
require(ReplicatedRoot.Libraries.Types.CommonTypes);
require(ReplicatedRoot.Libraries.Types.GameplayTypes);
local Constructor = require(ReplicatedRoot.Libraries.Gameplay.Constructor);
require(ReplicatedRoot.Services.AnimatorService);
require(ReplicatedRoot.Services.Gameplay.MoveService);
require(ReplicatedRoot.Services.CombatService);
require(ReplicatedRoot.Services.FXService);
game:GetService("RunService");
require(ReplicatedRoot.Libraries.Classes.Trove);

return Constructor.Ability({
    From = {
        BaseAbility = {
            ["@All"] = true
        }
    },
    Import = { script:WaitForChild("Assets"), script:WaitForChild("Quotes") },
    MeterColor = Color3.new(1, 1, 1),
    Moveset = {
        Groups = {
            Passive = {
                Visible = true,
                Priority = 5
            },
            Universal = {
                Visible = true,
                Priority = 1
            }
        },
        MovesInfo = {}
    },
    Moves = {},
    Common = {}
});