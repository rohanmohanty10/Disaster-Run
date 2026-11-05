  

 

local LocalPlayer = game.Players.LocalPlayer;
local Debris = game:GetService("Debris");
local ReplicatedStorage = game:GetService("ReplicatedStorage");

return function(p1, p2) -- Line: 4
    -- upvalues: LocalPlayer (copy), Debris (copy), ReplicatedStorage (copy)
    if not p2 and p1 == LocalPlayer then
        return;
    end;

    local Character = p1.Character;
    local Humanoid = Character.Humanoid;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local v3 = { game.Workspace:FindFirstChild("Living"), game.Workspace:FindFirstChild("NPCS") };
    local v4 = {
        [Enum.Material.Concrete] = function() -- Line: 13
            -- upvalues: HumanoidRootPart (copy), Debris (ref)
            local Sound = Instance.new("Sound");
            Sound.SoundId = "rbxassetid://7757683859";
            Sound.Volume = 1;
            Sound.Parent = HumanoidRootPart;
            Sound.SoundGroup = game:GetService("SoundService").StandSounds;
            Sound:Play();
            Debris:AddItem(Sound, 1.5);
        end,

        [Enum.Material.Sand] = function() -- Line: 22
            -- upvalues: HumanoidRootPart (copy), Debris (ref)
            local Sound = Instance.new("Sound");
            Sound.SoundId = "rbxassetid://8116913470";
            Sound.Volume = 1;
            Sound.Parent = HumanoidRootPart;
            Sound.SoundGroup = game:GetService("SoundService").StandSounds;
            Sound:Play();
            Debris:AddItem(Sound, 1.5);
        end,

        [Enum.Material.Grass] = function() -- Line: 31
            -- upvalues: HumanoidRootPart (copy), Debris (ref)
            local Sound = Instance.new("Sound");
            Sound.SoundId = "rbxassetid://8116914395";
            Sound.Volume = 1;
            Sound.Parent = HumanoidRootPart;
            Sound.SoundGroup = game:GetService("SoundService").StandSounds;
            Sound:Play();
            Debris:AddItem(Sound, 1.5);
        end
    };
    local v5 = ReplicatedStorage["Client Assets"].Land:Clone();
    v5.Parent = workspace.Effects;
    Debris:AddItem(v5, 1);
    local BigDust = v5.Attachment.BigDust;
    local v6 = RaycastParams.new();
    v6.FilterType = Enum.RaycastFilterType.Blacklist;
    v6.FilterDescendantsInstances = { v5, workspace.Effects, v3 };
    local v7 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -3.5, 0), v6);

    if v7 then
        BigDust.Color = ColorSequence.new(v7.Instance.Color);
        v5.Position = HumanoidRootPart.Position + Vector3.new(0, -3.5, 0);
        BigDust:Emit(155);

        if v4[Humanoid.FloorMaterial] then
            v4[Humanoid.FloorMaterial]();
        end;
    end;
end;