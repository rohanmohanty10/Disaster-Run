  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local _ = PathShortcuts.ClientAssets;

return {
    Hit = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/General/Light",
                AutoSerialize = true,
                LookAt = "Attacker"
            } }
    },
    HeavyHit = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/General/Heavy",
                AutoSerialize = true,
                LookAt = "Attacker"
            } }
    },
    RushAttack1SFX = {
        SoundId = 139177618465273,
        Volume = 2
    },
    RushAttack2SFX = {
        SoundId = 74916441138902,
        Volume = 2
    },
    RushAttack3SFX = {
        SoundId = 98216989650834,
        Volume = 2
    },
    RushAttack4SFX = {
        SoundId = 114581042755387,
        Volume = 2
    },
    LightningGroundSFX = {
        SoundId = 124395028031347,
        Volume = 2
    },

    AirInvoke = function(p1) -- Line: 57, Name: AirInvoke
        -- upvalues: Knit (copy)
        local Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid");
        Knit.GetController("MoveInputController");
        Knit.GetService("MoveInputService"):FireInput(p1.RawInput, Humanoid:GetState() == Enum.HumanoidStateType.Jumping and true or Humanoid:GetState() == Enum.HumanoidStateType.Freefall):expect();
    end
};