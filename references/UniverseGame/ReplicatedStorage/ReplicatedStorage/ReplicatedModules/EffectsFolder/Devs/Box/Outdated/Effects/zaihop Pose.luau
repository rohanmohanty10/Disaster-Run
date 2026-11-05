  

 

local Debris = game:GetService("Debris");

return function(p1) -- Line: 3
    -- upvalues: Debris (copy)
    local Character = p1.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    local Explosion = Instance.new("Explosion");
    Explosion.BlastPressure = 0;
    Explosion.BlastRadius = 15;
    Explosion.Position = HumanoidRootPart.Position;
    Explosion.Parent = workspace.Effects;
    Debris:AddItem(Explosion, 1.5);
    local Sound = Instance.new("Sound");
    Sound.SoundId = "rbxasset://sounds\\Rocket shot.wav";
    Sound.Volume = 1.5;
    Sound.Parent = HumanoidRootPart;
    Sound:Play();
    Debris:AddItem(Sound, 2);
end;