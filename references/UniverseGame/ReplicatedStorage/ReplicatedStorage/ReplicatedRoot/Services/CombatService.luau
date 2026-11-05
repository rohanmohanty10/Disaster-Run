  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local Core = require(ReplicatedRoot.Core);
require(ReplicatedRoot.Libraries.Types.GameplayTypes);
local Signal = require(ReplicatedRoot.Libraries.Classes.Signal);
local BridgeNet2 = require(ReplicatedRoot.Libraries.Networking.BridgeNet2);
local u1 = {
    Name = "CombatService",
    Enums = require(Core.ReplicatedLibraries.Enums),
    Remotes = {
        Stunned = BridgeNet2.ReferenceBridge("Stunned"),
        StunEnded = BridgeNet2.ReferenceBridge("StunEnded"),
        Ragdolled = BridgeNet2.ReferenceBridge("Ragdolled"),
        RagdollEnded = BridgeNet2.ReferenceBridge("RagdollEnded"),
        ActiveChanged = BridgeNet2.ReferenceBridge("ActiveChanged"),
        Interrupted = BridgeNet2.ReferenceBridge("Interrupted"),
        Knockback = BridgeNet2.ReferenceBridge("Knockback"),
        StepVelocity = BridgeNet2.ReferenceBridge("StepVelocity"),
        StatusEffect = BridgeNet2.ReferenceBridge("StatusEffect")
    },
    Stunned = Signal.new(),
    StunEnded = Signal.new()
};
local u2 = {};

local function Load(p3) -- Line: 30
    -- upvalues: u2 (copy), Load (copy)
    for _, child in pairs(p3:GetChildren()) do
        if child:IsA("ModuleScript") then
            table.insert(u2, require(child));
        elseif not child:IsA("ModuleScript") then
            Load(child);
        end;
    end;
end;

function u1._Init(p4) -- Line: 40
    -- upvalues: Load (copy), Core (copy), u2 (copy), u1 (copy)
    Load(script);

    if Core.Context == "Server" then
        Load(Core.ServerServices.CombatService);
    end;

    for _, v in pairs(u2) do
        if v.Init then
            v.Init(u1);
        end;
    end;

    for _, v in pairs(u2) do
        if v.Start then
            v.Start(u1);
        end;
    end;
end;

return u1;